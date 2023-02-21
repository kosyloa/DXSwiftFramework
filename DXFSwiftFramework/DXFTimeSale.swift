//
//  DXFTimeSale.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

public class DXFTimeSale {
    let event_flags: Int32
    let index: Int64
    let time_nano_part: Int32
    let exchange_code: Int16
    let price: Double
    let size: Double
    let bid_price:Double
    let ask_price: Double
    let exchange_sale_conditions: String
    let flags: Int32
    let buyer: String
    let seller: String
    
    init(event_flags: Int32, index: Int64, time_nano_part: Int32, exchange_code: Int16, price: Double, size: Double, bid_price: Double, ask_price: Double, exchange_sale_conditions: String, flags: Int32, buyer: String, seller: String) {
        self.event_flags = event_flags
        self.index = index
        self.time_nano_part = time_nano_part
        self.exchange_code = exchange_code
        self.price = price
        self.size = size
        self.bid_price = bid_price
        self.ask_price = ask_price
        self.exchange_sale_conditions = exchange_sale_conditions
        self.flags = flags
        self.buyer = buyer
        self.seller = seller
    }
}
