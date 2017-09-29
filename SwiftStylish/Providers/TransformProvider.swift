//
//  TransformProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **tramsform** value to subclasses of:
 - UIView
 */
class TransformProvider: BaseProvider {}

extension TransformProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.transform = try value.toTransform()
    }
}
