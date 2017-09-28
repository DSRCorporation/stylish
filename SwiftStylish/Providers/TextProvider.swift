//
//  TextProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **text** value to subclasses ofo:
 - UILabel
 - UITextField
 - UITextView
 
 Provides **title** value to subclasses of:
 - UIButton
 - UIBarButtonItem
 - UITabBarItem
 */

class TextProvider: BaseProvider {}

extension TextProvider: LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        label.text = try value.toLocalizedString()
    }
}

extension TextProvider: ButtonProviderProtocol
{
    /**
     Applies **title** text value for UIButton
     */
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.setTitle(try value.toLocalizedString(), for: item.state.toControlState())
    }
}

extension TextProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textField.text = try value.toLocalizedString()
    }
}

extension TextProvider: TextViewProviderProtocol
{
    func applyItem(forTextView textView: UITextView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textView.text = try value.toLocalizedString()
    }
}

extension TextProvider: BarButtonItemProviderProtocol
{
    /**
     Applies **title** text value for UIBarButtonItem
     */

    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        barButtonItem.title = try value.toLocalizedString()
    }
}

extension TextProvider: TabBarItemProviderProtocol
{
    /**
     Applies **title** text value for UITabBarItem
     */
    func applyItem(forTabBarItem tabBarItem: UITabBarItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        tabBarItem.title = try value.toLocalizedString()
    }
}

