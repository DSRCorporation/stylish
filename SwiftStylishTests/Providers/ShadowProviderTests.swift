//
//  ShadowProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ShadowProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.shadow.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.shadowOpacity = 0.0
        view.layer.shadowRadius = 0.0
        view.layer.shadowColor = UIColor.clear.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        XCTAssert(view.layer.shadowOpacity == 0.0)
        XCTAssert(view.layer.shadowRadius == 0.0)
        XCTAssert(view.layer.shadowColor == UIColor.clear.cgColor)
        XCTAssert(view.layer.shadowOffset == CGSize(width: 0.0, height: 0.0))
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.layer.shadowOpacity == 0.8)
        XCTAssert(view.layer.shadowRadius == 10.0)
        XCTAssert(view.layer.shadowColor == UIColor.red.cgColor)
        XCTAssert(view.layer.shadowOffset == CGSize(width: 2.0, height: 3.0))
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
