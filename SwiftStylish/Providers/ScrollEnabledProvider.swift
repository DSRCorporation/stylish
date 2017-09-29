//
//  ScrollEnabledProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **isScrollEnabled** value to subclasses of:
 - UIScrollView
 */
class ScrollEnabledProvider: BaseProvider {}

extension ScrollEnabledProvider: ScrollViewProviderProtocol
{
    func applyItem(forScrollView scrollView: UIScrollView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        scrollView.isScrollEnabled = try value.toBool()
    }
}
