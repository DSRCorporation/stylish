//
//  ClipsToBoundsProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **clipToBounds** value to subclasses of:
 - UIView
 */
class ClipsToBoundsProvider: BaseProvider {}

extension ClipsToBoundsProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.clipsToBounds = try value.toBool()
        view.layer.masksToBounds = try value.toBool()
    }
}
