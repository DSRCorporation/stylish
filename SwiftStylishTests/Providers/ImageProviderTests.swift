//
//  ImageProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ImageProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.image.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForImageView()
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = nil
        imageView.highlightedImage = nil
        
        XCTAssertNil(imageView.image)
        XCTAssertNil(imageView.highlightedImage)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".image-view", forObject: imageView)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage1 = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        let testImage2 = UIImage(named: "testImage2", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        
        XCTAssertNotNil(testImage1)
        XCTAssertNotNil(testImage2)
        XCTAssertNotNil(imageView.image)
        XCTAssertNotNil(imageView.highlightedImage)
        
        XCTAssert(imageView.image!.compare(withImage: testImage1!))
        XCTAssert(imageView.highlightedImage!.compare(withImage: testImage2!))
    }
    
    func testProviderForButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        button.setImage(nil, for: .normal)
        button.setImage(nil, for: .selected)
        button.setImage(nil, for: .highlighted)
        button.setImage(nil, for: .disabled)
        
        XCTAssertNil(button.image(for: .normal))
        XCTAssertNil(button.image(for: .disabled))
        XCTAssertNil(button.image(for: .selected))
        XCTAssertNil(button.image(for: .highlighted))
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".button", forObject: button)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage1 = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage1)
        
        let testImage2 = UIImage(named: "testImage2", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage2)
        
        let testImage3 = UIImage(named: "testImage3", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage3)
        
        let testImage4 = UIImage(named: "testImage4", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage4)
        
        XCTAssertNotNil(button.image(for: .normal))
        XCTAssertNotNil(button.image(for: .highlighted))
        XCTAssertNotNil(button.image(for: .selected))
        XCTAssertNotNil(button.image(for: .disabled))
        
        XCTAssert(button.image(for: .normal)!.compare(withImage: testImage1!))
        XCTAssert(button.image(for: .highlighted)!.compare(withImage: testImage2!))
        XCTAssert(button.image(for: .selected)!.compare(withImage: testImage3!))
        XCTAssert(button.image(for: .disabled)!.compare(withImage: testImage4!))
    }
    
    func testProviderForBarButton()
    {
        let barButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: nil)
        barButtonItem.image = nil
        
        XCTAssertNil(barButtonItem.image)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: barButtonItem)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage1 = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage1)
        
        XCTAssertNotNil(barButtonItem.image)
        XCTAssert(barButtonItem.image!.compare(withImage: testImage1!))
    }
    
    
    func testValueAssetsForView()
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        XCTAssertNil(imageView.image)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".value-assets", forObject: imageView)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)
        XCTAssertNotNil(testImage)
        
        XCTAssertNotNil(imageView.image)
        XCTAssert(imageView.image!.compare(withImage: testImage!))
    }
    
    func testValueColoredForView()
    {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertNil(imageView.image)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className:  "." + self.key + ".value-color", forObject: imageView)
        }
        catch
        {
            XCTFail()
        }
        
        let testImage = UIImage(color: UIColor.red, size: CGSize(width: 1.0, height: 100.0))
        XCTAssertNotNil(testImage)
        
        XCTAssertNotNil(imageView.image)
        XCTAssert(imageView.image!.compare(withImage: testImage!))
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
