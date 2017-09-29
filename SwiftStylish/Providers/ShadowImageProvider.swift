//
//  ShadowImageProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **shadowImage** value to subclasses of:
 - UINavigationBar
 */
class ShadowImageProvider: BaseProvider {}

// Untested
extension ShadowImageProvider: NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        navigationBar.shadowImage = try value.toImage()
    }
}
