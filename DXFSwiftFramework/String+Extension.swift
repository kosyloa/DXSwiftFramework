//
//  String+Extension.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

extension String {
    func toCStringRef() -> UnsafeMutablePointer<CChar> {
        return UnsafeMutablePointer<CChar>(mutating: (self as NSString).utf8String!)
    }
    
    static func createString(pointer: UnsafePointer<CChar>?)-> String{
        if let pointer = pointer {
            return String(cString: pointer)
        } else {
            return ""
        }
    }
    
    
}
