//
//  RenderingModeProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class RenderingModeProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.renderingMode.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(color: .red)
        
        XCTAssertNotNil(imageView.image)
        XCTAssert(imageView.image!.renderingMode == .automatic)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: imageView)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertNotNil(imageView.image)
        XCTAssert(imageView.image!.renderingMode == .alwaysTemplate)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
