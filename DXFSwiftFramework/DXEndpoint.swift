//
//  DXFConnection.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation
@_implementationOnly import graal_builds

class DXEndpoint {
    let address: String
    let env: DXFEnv
    public var endpoint = UnsafeMutablePointer<dxfg_endpoint_t>.allocate(capacity: 1)
    private let executor = UnsafeMutablePointer<dxfg_executor_t>.allocate(capacity: 1)
    private var listener = UnsafeMutablePointer<dxfg_endpoint_state_change_listener_t>.allocate(capacity: 1)
    
    deinit {
        dxfg_DXEndpoint_removeStateChangeListener(self.env.thread.pointee, self.endpoint, self.listener)
        print("dealloc")
    }
    
    static func builder() -> DXEndpoint {
        return DXEndpoint(address: "", env: DXFEnv())
    }
    
    
    func getFeed() -> DXEndpoint {
        return self
    }
    
    func withPropery(_ a: String, _ b: String) -> DXEndpoint {
        
        return self;
    }
    
    func createSubscription(_ type: FeedType ) -> DXEndpoint {
        return self
    }
    
    func addSymbols(_ str: String) {
        
    }
    
    func addListener(_ listener: ([String])->()) {
        
    }
    
    
    
    func build() -> DXEndpoint {
        return self
    }
    
    init(address: String, env: DXFEnv) {
        self.address = address
        self.env = env
    }
  
    func connect() -> Bool {
        self.endpoint = dxfg_DXEndpoint_create(self.env.thread.pointee);
        let swiftCallback : @convention(c) (OpaquePointer?, dxfg_endpoint_state_t, dxfg_endpoint_state_t, UnsafeMutableRawPointer?) -> Void = {_,_,newState,context in
//            let s = bridge(ptr: context123)
            if let context = context {
                let s: DXEndpoint = bridge(ptr: context)
                s.print123()
                print("state changed \(newState.rawValue) \(context)")
            }
        }
        let voidPtr = bridge(obj: self)

        self.listener = dxfg_PropertyChangeListener_new(self.env.thread.pointee, swiftCallback, voidPtr);
        dxfg_DXEndpoint_addStateChangeListener(self.env.thread.pointee, self.endpoint, self.listener);
        
        return dxfg_DXEndpoint_connect(self.env.thread.pointee, self.endpoint, self.address.toCStringRef()) == 0;
    }
    func print123() {
        print("pidor")
    }
}



