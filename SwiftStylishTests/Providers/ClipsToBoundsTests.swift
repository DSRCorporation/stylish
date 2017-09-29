//
//  ClipsToBoundsTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ClipsToBoundsTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.clipsToBounds.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        
        XCTAssert(view.clipsToBounds == false)
        XCTAssert(view.layer.masksToBounds == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssertTrue(view.clipsToBounds, "view.clipsToBounds is false!")
        XCTAssertTrue(view.layer.masksToBounds, "view.layer.masksToBounds is false!")
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
