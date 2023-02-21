//
//  DXFPublicEnv.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

public class DXFPublicEnv {
    let env: DXFEnv
    let connection: DXFConnection
    let feed: DXFFeed
    let subscr: DXFSubscription
    var listener: DXFSubscriptionListener? = nil
    public init() {
        env = DXFEnv()
        connection = DXFConnection(address: "localhost:6666", env: env)
        _ = connection.connect()
        feed = DXFFeed(connection: connection, env: env)
        subscr = DXFSubscription(env: env, feed: feed)
        print("created ")
    }
    
    public func addListener(_ listener: DXFSubscriptionListener) {
       
        self.listener = listener
        if let ls = self.listener  {
            subscr.addListener(ls)
        }
        subscr.subscrive("ETH/USD:GDAX")
    }
}
