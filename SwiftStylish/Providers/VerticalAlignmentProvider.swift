//
//  ContentVerticalAlignmentProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **contentVerticalAlignment** value to subclasses of:
 - UIButton
 - UITextField
 */
class VerticalAlignmentProvider: BaseProvider {}

extension VerticalAlignmentProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.contentVerticalAlignment = try value.toContentVerticalAlignment()
        textField.setNeedsLayout()
    }
}

extension VerticalAlignmentProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.contentVerticalAlignment = try value.toContentVerticalAlignment()
        button.setNeedsLayout()
    }
}
