//
//  TextColorProvider.swift
//  SwiftStylish
//

import UIKit
/**
 Provides **textColor** value to subclasses of:
 - UILabel
 - UITextField
 - UITextView
 
 Provides **titleColor** value to subclasses of:
 - UIButton
*/
class TextColorProvider: BaseProvider {}

extension TextColorProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.textColor = try value.toColor()
    }
}

extension TextColorProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.textColor = try value.toColor()
    }
}

extension TextColorProvider: TextViewProviderProtocol
{
    func applyItem(forTextView textView: UITextView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textView.textColor = try value.toColor()
    }
}

extension TextColorProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.setTitleColor(try value.toColor(), for: item.state.toControlState())
    }
}

