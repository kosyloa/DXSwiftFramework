//
//  DXFSubscriptionListener.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

public protocol DXFSubscriptionListener: AnyObject {
    func received(_ events: [DXFTimeSale?])
}
