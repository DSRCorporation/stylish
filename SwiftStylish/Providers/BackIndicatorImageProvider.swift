//
//  BackIndicatorImageProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **backIndicatorImage** value to subclasses of:
 - UINavigationBar
 */
class BackIndicatorImageProvider: BaseProvider {}

extension BackIndicatorImageProvider: NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        
        if navigationBar.backIndicatorTransitionMaskImage == nil
        {
            navigationBar.backIndicatorTransitionMaskImage = try value.toImage()
        }
        
        navigationBar.backIndicatorImage = try value.toImage()
    }
}
