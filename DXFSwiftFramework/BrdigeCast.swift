//
//  BrdigeCast.swift
//  DXFSwiftFramework
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import Foundation

func bridge<T : AnyObject>(obj : T) -> UnsafeMutableRawPointer {
    return Unmanaged.passUnretained(obj).toOpaque() as UnsafeMutableRawPointer
}

func bridge<T : AnyObject>(ptr : UnsafeMutableRawPointer) -> T {
    return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue()
}

func bridgeRetained<T : AnyObject>(obj : T) -> UnsafeRawPointer {
    return UnsafeRawPointer(Unmanaged.passRetained(obj).toOpaque())
}

func bridgeTransfer<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
    return Unmanaged<T>.fromOpaque(ptr).takeRetainedValue()
}
