//
//  SelectableProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **isSelectable** value to subclasses of:
 - UITextView
 */
class SelectableProvider: BaseProvider {}

extension SelectableProvider: TextViewProviderProtocol
{
    func applyItem(forTextView textView: UITextView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        textView.isSelectable = try value.toBool()
    }
}
