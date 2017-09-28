//
//  UserInteractionEnabled.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **isUserInteractionEnabled** value to subclasses of:
 - UIView
 */
class UserInteractionEnabled: BaseProvider {}

extension UserInteractionEnabled: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.isUserInteractionEnabled = try value.toBool()
    }
}
