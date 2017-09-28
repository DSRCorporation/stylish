//
//  TransformProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class TransformProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.transform.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForView()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.transform = CGAffineTransform.identity
        XCTAssert(view.transform == CGAffineTransform.identity)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key, forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(view.transform != CGAffineTransform.identity)
    }
    
    func testScaleTransform()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.transform = CGAffineTransform.identity
        XCTAssert(view.transform == CGAffineTransform.identity)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".scale", forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        let transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 3.0)
        XCTAssert(view.transform == transform)
    }
    
    func testRotateTransform()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.transform = CGAffineTransform.identity
        XCTAssert(view.transform == CGAffineTransform.identity)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".rotate", forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        XCTAssert(round(view.transform.b) == 1)
        XCTAssert(round(view.transform.c) == -1)
    }
    
    func testTranslateTransform()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.transform = CGAffineTransform.identity
        XCTAssert(view.transform == CGAffineTransform.identity)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: "." + self.key + ".translate", forObject: view)
        }
        catch
        {
            XCTFail()
        }
        
        let transform = CGAffineTransform.identity.translatedBy(x: 2.0, y: 3.0)
        XCTAssert(view.transform == transform)
    }
    
    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
