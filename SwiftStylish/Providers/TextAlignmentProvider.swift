//
//  TextAlignmentProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **textAlignment** value to subclasses of:
 - UILabel
 - UITextField
 - UITextView
*/
class TextAlignmentProvider: BaseProvider {}

extension TextAlignmentProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.textAlignment = try value.toAlignment()
    }
}

extension TextAlignmentProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.textAlignment = try value.toAlignment()
    }
}

extension TextAlignmentProvider: TextViewProviderProtocol
{
    func applyItem(forTextView textView: UITextView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textView.textAlignment = try value.toAlignment()
    }
}

