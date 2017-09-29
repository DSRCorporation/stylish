//
//  ParserTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class ParserTests: XCTestCase
{
    let loader = JSONLoader(filename: "ParserTests", bundle: Bundle(for: ParserTests.self))
    var data: StyleData?
    var parser: Parser?
    
    override func setUp()
    {
        super.setUp()
        
        data = try? loader.load()
        XCTAssertNotNil(data)
        parser = try? Parser(loader: loader)
        XCTAssertNotNil(parser)
        let _ = try? parser!.parse()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testParserCountOfStyles()
    {
        XCTAssert(parser!.styleRepository.classes.count == 6)
    }
    
    func testParserCountOfItems()
    {
        let style = parser!.styleRepository.findClass(name: ".root.class1")
        XCTAssert(style?.items.count == 5)
    }
    
    func testParserEqualsItems()
    {
        let style = parser!.styleRepository.findClass(name: ".root.class1")
        XCTAssertNotNil(style)
        let item1 = style!.items[0] as StyleItem
        XCTAssert(item1.key == StyleItemKeys.color.rawValue || item1.key == StyleItemKeys.backgroundColor.rawValue)
    }

    func testParserIncludes()
    {
        let rootStyle = parser!.styleRepository.findClass(name: ".additional.class2")
        XCTAssertNotNil(rootStyle)
    }
    
    func testParserClassesInheritance()
    {
        let style = parser!.styleRepository.findClass(name: ".root.class1")
        XCTAssertNotNil(style)
        let rootStyle = parser!.styleRepository.findClass(name: ".root")
        XCTAssert(style!.parent == rootStyle)
        XCTAssert(rootStyle?.parent == nil)
    }
    
    func testParserStringPreloads()
    {
        let style = parser!.styleRepository.findClass(name: ".root.class2")
        XCTAssert(style?.preloads.count == 1)
    }
    
    func testParserArrayPreloads()
    {
        let style = parser!.styleRepository.findClass(name: ".root.class3")
        XCTAssert(style?.preloads.count == 2)
    }
}
