//
//  BorderWidthProvider.swift
//  SwiftStylish
//
import UIKit

/**
 Provides **border width** value to subclasses of:
 - UIView
 - SSButton
 - SSTextField
 */
class BorderWidthProvider: BaseProvider {}

extension BorderWidthProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.layer.borderWidth = try value.toCGFloat()
    }
}

extension BorderWidthProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        if let ssbutton = button as? SSButton
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            ssbutton.setBorder(width: try value.toCGFloat(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: button as UIView, item: item, variables: variables)
        }
    }
}

extension BorderWidthProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        if let sstexfield = textField as? SSTextField
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            sstexfield.setBorder(width: try value.toCGFloat(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: textField as UIView, item: item, variables: variables)
        }
    }
}
