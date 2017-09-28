//
//  FontProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **font** value to subclasses of:
 - UILabel
 - UIButton
 - UITextField
 */
class FontProvider: BaseProvider {}

extension FontProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.font = try value.toFont()
    }
}

extension FontProvider: ButtonProviderProtocol
{
    /**
     Applies **font** attribute value to UIButton's titleLabel
    */
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.titleLabel?.font = try value.toFont()
    }
}

extension FontProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.font = try value.toFont()
    }
}
