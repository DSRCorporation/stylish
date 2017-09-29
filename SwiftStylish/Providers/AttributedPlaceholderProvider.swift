//
//  AttributedPlaceholderProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **attributedPlaceholder** value to subclasses of:
 - UITextField
 */

class AttributedPlaceholderProvider: BaseProvider {}


extension AttributedPlaceholderProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.attributedPlaceholder = try value.toAttributedText()
    }
}
