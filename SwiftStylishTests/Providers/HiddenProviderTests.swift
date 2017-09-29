//
//  HiddenProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class HiddenProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.hidden.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.isHidden = false
        XCTAssert(view.isHidden == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }

        XCTAssert(view.isHidden == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
