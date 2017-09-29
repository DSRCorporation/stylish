//
//  HiddenProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **isHidden** value to subclasses of:
 - UIView
 */
class HiddenProvider: BaseProvider {}

extension HiddenProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.isHidden = try value.toBool()
    }
}

