//
//  TextAttributesProvider.swift
//  SwiftStylish
//
import UIKit
/**
  Provides **textAttributes** value to subclasses of:
 - UISegmentedControl
 - UINavigationBarAppearance
 - UIBarButtonItem
*/
class TextAttributesProvider: BaseProvider
{
    fileprivate func merged(current: [NSAttributedString.Key: Any], new: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any]
    {
        var merged: [NSAttributedString.Key: Any] = current
        
        for (k,v) in new
        {
            merged.updateValue(v, forKey: k)
        }
        
        return merged
    }
}

extension TextAttributesProvider: SegmentedControlProviderProtocol
{
    func applyItem(forSegmentedControl segmentedControl: UISegmentedControl, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let textAttributes = try value.toTextAttributes()
        let currentTextAttributes = segmentedControl.titleTextAttributes(for:item.state.toControlState()) ?? [:]
        let newTextAttributes = self.merged(current: currentTextAttributes, new: textAttributes)
        segmentedControl.setTitleTextAttributes(newTextAttributes, for: item.state.toControlState())
    }
}

extension TextAttributesProvider: NavigationBarAppearanceProviderProtocol
{
    func applyItem(forNavigationBarAppearance appearance: UINavigationBarAppearance, item: StyleItem, variables: StyleVariables?) throws {
        guard item.state.toControlState() == .normal else
        {
            return
        }
        
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let textAttributes = try value.toTextAttributes()
        let currentTextAttributes = appearance.titleTextAttributes
        let newTextAttributes = self.merged(current: currentTextAttributes, new: textAttributes)
        appearance.titleTextAttributes = newTextAttributes
    }
}

extension TextAttributesProvider: BarButtonItemProviderProtocol
{
    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let textAttributes = try value.toTextAttributes()
        let currentTextAttributes = barButtonItem.titleTextAttributes(for: item.state.toControlState()) ?? [:]


        var converted = [NSAttributedString.Key: Any]()

        currentTextAttributes.forEach { (key, value) in
            converted[key] = value
        }
        
        let newTextAttributes = self.merged(current: converted, new: textAttributes)
        barButtonItem.setTitleTextAttributes(newTextAttributes, for: item.state.toControlState())
    }
}
