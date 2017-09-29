//
//  TranslucentProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **isTranslucent** value to subclasses of:
 - UINavigationBar
 */
class TranslucentProvider: BaseProvider {}

extension TranslucentProvider: NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        navigationBar.isTranslucent = try value.toBool()
    }
}
