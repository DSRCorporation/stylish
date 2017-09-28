//
//  ContentHorizontalAlignmentProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **contentHorizontalAlignment** value to subclasses of:
 - UIButton
 - UITextField
 */
class HorizontalAlignmentProvider: BaseProvider {}

extension HorizontalAlignmentProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.contentHorizontalAlignment = try value.toContentHorizontalAlignment()
        textField.setNeedsLayout()
    }
}

extension HorizontalAlignmentProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.contentHorizontalAlignment = try value.toContentHorizontalAlignment()
        button.setNeedsLayout()
    }
}
