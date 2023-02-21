//
//  DXFEnv.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation
@_implementationOnly import graal_builds

class DXFEnv {
    private let isolate = UnsafeMutablePointer<OpaquePointer?>.allocate(capacity: 1)
    private let params = UnsafeMutablePointer<graal_create_isolate_params_t>.allocate(capacity: 1)
    internal let thread = UnsafeMutablePointer<OpaquePointer?>.allocate(capacity: 1)

    deinit {
        
    }
    
    init() {
        let ret = graal_create_isolate(self.params, self.isolate, thread)
        if ret != 0 {
            print("error creating isolate")
            exit(0)
        }

    }
}
