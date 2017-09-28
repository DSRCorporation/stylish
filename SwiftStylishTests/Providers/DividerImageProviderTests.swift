//
//  DividerImageProviderTests.swift
//  SwiftStylish
//

import XCTest

@testable import SwiftStylish

class DividerImageProviderTests: BaseProviderTests
{
    override func setUp()
    {
        super.setUp()
        self.key = StyleItemKeys.dividerImage.rawValue
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testProviderForSegmentedControlForImage()
    {
        let styledImage = UIImage(named: "testImage1", in:Bundle(for: BackgroundColorProviderTests.self), compatibleWith: nil)!
        runTestForSegmentedControlFor(style: ".divider-image-with-image", styledImage: styledImage);
    }
    
    private func runTestForSegmentedControlFor( style: String, styledImage: UIImage )
    {
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let prevImage = UIImage(color: UIColor.red)
        
        segmentedControl.setDividerImage(prevImage,
                                         forLeftSegmentState: .selected,
                                         rightSegmentState: .normal,
                                         barMetrics: .default)
        
        let dividerImage = segmentedControl.dividerImage(forLeftSegmentState: .selected,
                                                         rightSegmentState: .normal,
                                                         barMetrics: .default)
        let result = dividerImage?.compare(withImage:prevImage!)
        XCTAssert(result == true)
        
        do
        {
            try SwiftStylisher.default.applyStyle(className: style, forObject: segmentedControl)
        }
        catch
        {
            XCTFail()
        }
        
        let dividerImageStyled = segmentedControl.dividerImage(forLeftSegmentState: .selected,
                                                               rightSegmentState: .normal,
                                                               barMetrics: .default)
        let result2 = styledImage.compare(withImage:dividerImageStyled!)
        XCTAssert(result2 == true)
    }

    override func testProviderForObject()
    {
        super.testProviderForObject()
    }
}
