//
//  AlphaProviderTests.swift
//  SwiftStylish
//
import XCTest

@testable import SwiftStylish

class AlphaProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.alpha.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.alpha = 1.0
        XCTAssert(view.alpha == 1.0)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch let error
        {
            XCTFail(error.localizedDescription)
        }
        
        let roundedAlphaString = String(format: "%.2f", view.alpha)
        XCTAssert(roundedAlphaString == "0.15");
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
