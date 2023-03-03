//
//  DXFPublicEnv.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

public class DXFPublicEnv {
//    let env: DXFEnv
//    let connection: DXEndpoint
//    let feed: DXFFeed
//    let subscr: DXFeedSubscription
//    var listener: DXFSubscriptionListener? = nil
    public init() {
        
//        env = DXFEnv()
        
        let endpoint = DXEndpoint.builder()
            .withPropery("dxfeed.address", "demo.dxfeed.com:7300")
            .build()
        let subscription = endpoint.getFeed().createSubscription(.Quote)
        subscription.addListener { events in
            events.forEach { print($0) }
        }
        subscription.addSymbols("AAPL")
        
        _ = subscription.getFeed()
        

//        feed = DXFFeed(connection: connection, env: env)
        print("created ")
    }
    
    public func addListener(_ listener: DXFSubscriptionListener) {
       
//        self.listener = listener
//        if let ls = self.listener  {
//            subscr.addListener(ls)
//        }
//        subscr.subscrive("ETH/USD:GDAX")
    }
}
