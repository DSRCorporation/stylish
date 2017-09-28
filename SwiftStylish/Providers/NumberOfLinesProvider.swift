//
//  NumberOfLinesProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **numberOfLines** value to subclasses of:
 - UILabel
 */
class NumberOfLinesProvider: BaseProvider {}

extension NumberOfLinesProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.numberOfLines = Int(try value.toUInt())
    }
}

