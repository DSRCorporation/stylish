//
//  SelectedImageProvider.swift
//  SwiftStylish
//

import Foundation
import UIKit

/**
 Provides **selectedImage** value to subclasses of:
 - UITabBarItem
 */
class SelectedImageProvider: BaseProvider {}

extension SelectedImageProvider: TabBarItemProviderProtocol
{
    func applyItem(forTabBarItem tabBarItem: UITabBarItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        tabBarItem.selectedImage = try value.toImage()
    }
}
