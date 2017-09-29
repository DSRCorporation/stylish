//
//  SwiftStylishTests.swift
//  SwiftStylish
//
//  Created by Andrey on 06.10.16.
//  Copyright © 2016 DSR. All rights reserved.
//

import XCTest

class SwiftStylishTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        SwiftStylisher.default.forceClear()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testSwiftStylishLoadFewFiles()
    {
        do
        {
            try SwiftStylisher.default.loadFile(filename: "TestStylish", bundle: Bundle(for: SwiftStylishTests.self))
            XCTAssert(SwiftStylisher.default.loadedFiles.count == 1)
            
            try SwiftStylisher.default.loadFile(filename: "ParserTests", bundle: Bundle(for: SwiftStylishTests.self))
            XCTAssert(SwiftStylisher.default.loadedFiles.count == 2)
        }
        catch
        {
            XCTFail()
        }
    }
    
    func testPreloadsFromOtherFiles()
    {
        do
        {
            try SwiftStylisher.default.loadFile(filename: "PreloadsTests1", bundle: Bundle(for: SwiftStylishTests.self))
            XCTAssert(SwiftStylisher.default.loadedFiles.count == 1)
            
            try SwiftStylisher.default.loadFile(filename: "PreloadsTests2", bundle: Bundle(for: SwiftStylishTests.self))
            XCTAssert(SwiftStylisher.default.loadedFiles.count == 2)
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            view.backgroundColor = UIColor.black
            XCTAssert(view.backgroundColor == UIColor.black)
            
            try SwiftStylisher.default.applyStyle(className: ".child", forObject: view)
            XCTAssert(view.backgroundColor == UIColor.green)
            
            XCTAssert(true)
        }
        catch
        {
            XCTFail()
        }
    }
}
