//
//  BorderColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **border color** value to subclasses of:
 - UIView
 - SSButton
 - SSTextField
 */
class BorderColorProvider: BaseProvider {}

extension BorderColorProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.layer.borderColor = try value.toColor().cgColor
    }
}

extension BorderColorProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        if let ssbutton = button as? SSButton
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            ssbutton.setBorder(color: try value.toColor(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: button as UIView, item: item, variables: variables)
        }
    }
}

extension BorderColorProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        if let sstexfield = textField as? SSTextField
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            sstexfield.setBorder(color: try value.toColor(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: textField as UIView, item: item, variables: variables)
        }
    }
}
