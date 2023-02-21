//
//  DXFSwiftFrameworkTests.swift
//  DXFSwiftFrameworkTests
//
//  Created by Aleksey Kosylo on 20.02.2023.
//

import XCTest
@testable import DXFSwiftFramework
class TestListener: NSObject, DXFSubscriptionListener {
    @objc dynamic var count = 0
    func received(_ events: [DXFTimeSale?]) {
        count += events.count
        print(count)
    }
}
class DXFSwiftFrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let env = DXFEnv()
        let connection = DXFConnection(address: "localhost:6666", env: env)
        let res = connection.connect()
        let feed = DXFFeed(connection: connection, env: env)
        let subscr = DXFSubscription(env: env, feed: feed)
        let testListener = TestListener()
        subscr.addListener(testListener)
        subscr.subscrive("ETH/USD:GDAX")
        
        print("connected")
        let expectation = keyValueObservingExpectation(for: testListener, keyPath: "count") { (value, value1) in
            return testListener.count >= 30
        }
        
        wait(for: [expectation], timeout: 210)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
