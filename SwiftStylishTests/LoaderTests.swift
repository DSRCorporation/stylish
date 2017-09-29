//
//  LoaderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class LoaderTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testIncorrectFilename()
    {
        let loader = JSONLoader(filename: "incorrect_filename", bundle: nil)
    
        do
        {
            let _ = try loader.load()
        }
        catch LoaderError.invalidFile(_)
        {
            XCTAssert(true)
        }
        catch
        {
            XCTAssert(false, "Incorrect error throws")
        }
    }
    
    func testIncorrectDataInFile()
    {
        let loader = JSONLoader(filename: "testIncorrectDataInFile", bundle: Bundle(for: LoaderTests.self))
        
        do
        {
            let _ = try loader.load()
        }
        catch LoaderError.incorrectDataInFile(_)
        {
            XCTAssert(true)
        }
        catch
        {
            XCTAssert(true)
        }
    }
    
    func testCorrectDataInFile()
    {
        let loader = JSONLoader(filename: "testCorrectDataInFile", bundle: Bundle(for: LoaderTests.self))
        var result: StyleData?
        
        do
        {
            result = try loader.load()
        }
        catch
        {
            XCTAssert(false, "Incorrect error throws")
        }
        
        XCTAssertNotNil(result)
        XCTAssert(result!["key"] != nil)
    }
}
