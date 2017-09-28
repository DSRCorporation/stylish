//
//  AttributedTextProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **attributedText** value to subclasses of:
 - UILabel
 - UITextField
 */

class AttributedTextProvider: BaseProvider {}

extension AttributedTextProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.attributedText = try value.toAttributedText()
    }
}

extension AttributedTextProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.attributedText = try value.toAttributedText()
    }
}
