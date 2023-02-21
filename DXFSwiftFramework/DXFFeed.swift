//
//  DXFFeed.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation
@_implementationOnly import graal_builds

class DXFFeed {
    let connection: DXFConnection
    let env: DXFEnv
    let feed: UnsafeMutablePointer<dxfg_feed_t>
    init(connection: DXFConnection, env: DXFEnv) {
        self.connection = connection
        self.env = env
        self.feed = dxfg_DXEndpoint_getFeed(self.env.thread.pointee, self.connection.endpoint)
    }
}
