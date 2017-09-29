//
//  PlaceholderProvider.swift
//  SwiftStylish
//

import UIKit

class PlaceholderProvider: BaseProvider {}

/**
 Provides **placeholder** value to subclasses of:
 - UITextField
 */
extension PlaceholderProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.placeholder = try value.toLocalizedString()
    }
}
