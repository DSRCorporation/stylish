//
//  TitlesProvider.swift
//  SwiftStylish
//

import Foundation
import UIKit

class TitlesProvider: BaseProvider {}

/**
 Provides **title** value to subclasses of:
 - UISegmentedControl
 */
extension TitlesProvider: SegmentedControlProviderProtocol
{
    func applyItem(forSegmentedControl segmentedControl: UISegmentedControl, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        
        let titles = try value.toTitles()
        var index = 0
        
        for title in titles
        {
            segmentedControl.setTitle(title, forSegmentAt: index)
            index = index + 1
        }
    }
}
