//
//  BarTintColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **barTintColor** value to subclasses of:
 - UITabBar
 - UINavigationBarAppearance
 */
class BarTintColorProvider: BaseProvider {}

extension BarTintColorProvider: TabBarProviderProtocol
{
    func applyItem(forTabBar tabBar: UITabBar, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        tabBar.barTintColor = try value.toColor()
    }
}

extension BarTintColorProvider: NavigationBarAppearanceProviderProtocol
{
    func applyItem(forNavigationBarAppearance appearance: UINavigationBarAppearance, item: StyleItem, variables: StyleVariables?) throws {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        appearance.backgroundColor = try value.toColor()
    }
}
