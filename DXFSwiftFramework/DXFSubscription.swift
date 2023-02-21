//
//  DXFSubscription.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation
@_implementationOnly import graal_builds

class DXFSubscription {
    
    var subscription = UnsafeMutablePointer<dxfg_subscription_t>.allocate(capacity: 1)
    var listener = UnsafeMutablePointer<dxfg_feed_event_listener_t>.allocate(capacity: 1)
    let env: DXFEnv
    weak var extListener: DXFSubscriptionListener? = nil
    deinit {
        dxfg_DXFeedSubscription_removeEventListener(self.env.thread.pointee, self.subscription, self.listener);
    }
    init(env: DXFEnv, feed: DXFFeed) {
        self.env = env
        let swiftCallback : @convention(c) (OpaquePointer?, UnsafeMutablePointer<dxfg_event_type_list>?, UnsafeMutableRawPointer?) -> Void = {_,list,context in
            if let context = context {
                
                let s: DXFSubscription = bridge(ptr: context)
                let size = Int(list?.pointee.size ?? 0)
                if size > 0 {
                    var events = [DXFTimeSale?](repeating: nil, count: size)
                    for i in 0..<size{
                        let element: UnsafeMutablePointer<dxfg_event_type_t>? = list?.pointee.elements[Int(i)]
                        if element?.pointee.clazz == DXFG_EVENT_TIME_AND_SALE {
                            element?.withMemoryRebound(to: dxfg_time_and_sale_t.self, capacity: 1, { pointer in
                                let v = pointer.pointee
                                let element = DXFTimeSale(event_flags: v.event_flags, index: v.index, time_nano_part: v.time_nano_part, exchange_code: v.exchange_code, price: v.price, size: v.size, bid_price: v.bid_price, ask_price: v.ask_price, exchange_sale_conditions: String.createString(pointer: v.exchange_sale_conditions), flags: v.flags, buyer: String.createString(pointer:  v.buyer), seller: String.createString(pointer:  v.seller))
                                events[i] = element
                            })
                        }
                    }
                    if let ls = s.extListener {
                        ls.received(events)
                    }
                }
            }
        }
        let voidPtr = bridge(obj: self)

        self.subscription = dxfg_DXFeed_createSubscription(self.env.thread.pointee, feed.feed, DXFG_EVENT_TIME_AND_SALE);
        self.listener =  dxfg_DXFeedEventListener_new(self.env.thread.pointee, swiftCallback, voidPtr);
        let res = dxfg_DXFeedSubscription_addEventListener(self.env.thread.pointee,
                                                           self.subscription,
                                                            self.listener);
        print("create subscription")
    }
    
 
    func addListener(_ listener: DXFSubscriptionListener) {
        self.extListener = listener
    }
    
    func subscrive(_ symbol: String) {
        let symbol = dxfg_Symbol_new(self.env.thread.pointee, symbol.toCStringRef(), STRING);
        let res = dxfg_DXFeedSubscription_addSymbol(self.env.thread.pointee, self.subscription, symbol);
        dxfg_Symbol_release(self.env.thread.pointee, symbol);

    }
}
