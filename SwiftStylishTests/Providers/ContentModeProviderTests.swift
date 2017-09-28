//
//  ContentModeProvider.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ContentModeProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.contentMode.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.contentMode = .scaleToFill
        XCTAssert(view.contentMode == .scaleToFill)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.contentMode == .scaleAspectFill)
    }
    
    func testProviderForImageView()
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleToFill
        XCTAssert(imageView.contentMode == .scaleToFill)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: imageView)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(imageView.contentMode == .scaleAspectFill)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
