//
//  TitleProviderTests.swift
//  SwiftStylish
//

import XCTest
import UIKit
import Foundation

@testable import SwiftStylish

class SelectedImageProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.selectedImage.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testSelectedImageProviderForTabBarItem()
    {
        let testImage2 = UIImage(named: "testImage2", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage2)
        
        let tabBarItem = UITabBarItem(title: "no string", image: testImage2, tag: 0)

        XCTAssertNotNil(tabBarItem.selectedImage)
        XCTAssert(tabBarItem.selectedImage!.compare(withImage: testImage2!) == true)

        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: tabBarItem)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage1 = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage1)
       
        XCTAssertNotNil(tabBarItem.selectedImage)
        XCTAssert(tabBarItem.selectedImage!.compare(withImage: testImage1!) == true)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
