//
//  BarTintColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **barTintColor** value to subclasses of:
 - UITabBar
 - UINavigationBar
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

extension BarTintColorProvider: NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        navigationBar.barTintColor = try value.toColor()
    }
}
