//
//  PublicFile.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

public class PublicFile {
    var ls: Int
    
    public init(ls: Int) {
        self.ls = ls
    }
    
    static func print123() {
        print("HEllo!!! from framework")
    }
}
