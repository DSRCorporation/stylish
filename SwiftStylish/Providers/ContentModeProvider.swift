//
//  ContentModeProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **contentMode** value to subclasses of:
 - UIView
 */
class ContentModeProvider: BaseProvider {}

extension ContentModeProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.contentMode = try value.toViewContentMode()
    }
}
