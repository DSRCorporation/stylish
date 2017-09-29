//
//  StyleRepositoryTests.swift
//  SwiftStylish
//
//  Created by Zamogilin Andrey on 10/6/16.
//  Copyright © 2016 DSR. All rights reserved.
//

import XCTest

class StyleRepositoryTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testRepositoryAddClassCount()
    {
        let repo = StyleRepository(bundle: Bundle.main)
        XCTAssert(repo.classes.count == 0)
        
        let style = StyleClass(key: ".test", parent: nil)
        
        repo.addClass(cls: style)
        XCTAssert(repo.classes.count == 1)
    }
    
    func testRepositoryFindClassCount()
    {
        let repo = StyleRepository(bundle: Bundle.main)
        let style = StyleClass(key: ".test", parent: nil)
        repo.addClass(cls: style)
        
        XCTAssert(repo.classes.count == 1)
        
        let findedStyle1 = repo.findClass(name: ".test")
        XCTAssertNotNil(findedStyle1)
        
        let findedStyle2 = repo.findClass(name: ".no-class")
        XCTAssertNil(findedStyle2)
    }
    
    func testRepositoryGetStyleMofication()
    {
        let repo = StyleRepository(bundle: Bundle.main)
        let style = StyleClass(key: ".test", parent: nil)
        repo.addClass(cls: style)
        
        XCTAssert(style.preloads.count == 0)
    
        let findedStyle = repo.findClass(name: ".test")
        XCTAssertNotNil(findedStyle)
        findedStyle?.preloads = [".root"]
        
        let findedStyle2 = repo.findClass(name: ".test")
        XCTAssertNotNil(findedStyle2)
        
        XCTAssert(findedStyle2!.preloads.count == 1)
    }
}
