//
//  BackIndicatorImageProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class BackIndicatorImageProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.backIndicatorImage.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForNavigationBar()
    {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        navBar.backIndicatorImage = nil
        XCTAssertNil(navBar.backIndicatorImage, "navBar.backIndicatorImage is not nil!")
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: navBar)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        let testImage1 = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)!
        
        XCTAssertNotNil(navBar.backIndicatorImage)
        XCTAssert(navBar.backIndicatorImage!.compare(withImage: testImage1))
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
