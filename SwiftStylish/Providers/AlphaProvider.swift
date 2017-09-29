//
//  AlphaProvider.swift
//  SwiftStylish
//

import UIKit

class AlphaProvider: BaseProvider {}

/**
  Provides **alpha** value to subclasses of:
 - UIView
 */
extension AlphaProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.alpha = try value.toCGFloat()
    }
}
