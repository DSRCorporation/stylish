//
//  UserInteractionEnabledTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class UserInteractionEnabledTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.userInteractionEnabled.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.isUserInteractionEnabled = false
        XCTAssert(view.isUserInteractionEnabled == false)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.isUserInteractionEnabled == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
