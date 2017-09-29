//
//  CornerRadiusProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **cornerRadius** value to subclasses of:
 - SSView
 - SSButton
 - SSTextField
 */
class CornerRadiusProvider: BaseProvider {}

extension CornerRadiusProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.layer.cornerRadius = try value.toCGFloat()
    }
}

extension CornerRadiusProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        if let ssbutton = button as? SSButton
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            ssbutton.setCornerRadius(radius: try value.toCGFloat(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: button as UIView, item: item, variables: variables)
        }
    }
}

extension CornerRadiusProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        if let sstexfield = textField as? SSTextField
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            sstexfield.setCornerRadius(radius: try value.toCGFloat(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: textField as UIView, item: item, variables: variables)
        }
    }
}
