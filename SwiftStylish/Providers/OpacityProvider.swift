//
//  OpacityProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **opacity** value to subclasses of:
 - UIView
 */
class OpacityProvider: BaseProvider {}

extension OpacityProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.layer.opacity =  try value.toFloat()
    }
}

