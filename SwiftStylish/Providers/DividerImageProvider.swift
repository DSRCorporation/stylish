//
//  DividerImageProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **dividerImage** value to subclasses of:
 - UISegmentedControl
 */
class DividerImageProvider: BaseProvider {}

extension DividerImageProvider: SegmentedControlProviderProtocol
{
    func applyItem(forSegmentedControl segmentedControl: UISegmentedControl, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let params : [(UIImage, UIControlState, UIControlState, UIBarMetrics)] = try value.toDividerImage()

        for( image,leftState,rightState,barMetrics)  in params
        {
            segmentedControl.setDividerImage(image, forLeftSegmentState: leftState, rightSegmentState: rightState, barMetrics: barMetrics)
        }
        
    }
}
