//
//  BaseProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BaseProviderTests: XCTestCase
{
    var key = ""
    
    override func setUp()
    {
        super.setUp()
        
        do
        {
            SwiftStylisher.default.bundle = Bundle(for: BackgroundColorProviderTests.self)
            try SwiftStylisher.default.loadFile(filename: "DefaultProviders",
                                                bundle: Bundle(for: BackgroundColorProviderTests.self))
        }
        catch
        {
            XCTFail()
        }
    }
    
    override func tearDown()
    {
        super.tearDown()
        SwiftStylisher.default.forceClear()
    }
    
    func testProviderForObject()
    {
        let object = NSObject()
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: object)
            XCTFail()
        }
        catch
        {
            return
        }
    }
}
