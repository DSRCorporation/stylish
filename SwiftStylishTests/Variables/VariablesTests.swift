//
//  VariablesTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class VariablesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
      
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        SwiftStylisher.default.forceClear()
        super.tearDown()
    }
    
    func testVariablesIncludeFile()
    {
        do
        {
            try SwiftStylisher.default.loadFile(filename: "VariablesTest", bundle: Bundle(for: VariablesTests.self))
        }
        catch
        {
            print("\(error.localizedDescription)")
        }
        
        let label = UILabel()
        label.backgroundColor = UIColor.red
        XCTAssert(label.backgroundColor == UIColor.red)
        
        do
        {
            try SwiftStylisher.default.loadVariablesFile(filename: "StyleVariablesInclude", bundle: Bundle(for: VariablesTests.self))
            try SwiftStylisher.default.loadFile(filename: "VariablesTest", bundle: Bundle(for: VariablesTests.self))
            try SwiftStylisher.default.applyStyle(className: ".label", forObject: label)
        }
        catch
        {
            print("\(error.localizedDescription)")
            XCTFail()
        }
        
        let font = UIFont(name: "Arial", size: 16)
        let color = UIColor("#6ef2d1")
        XCTAssert(label.backgroundColor == color)
        XCTAssert(label.font == font)
        XCTAssert(label.numberOfLines == 3)

    }
}
