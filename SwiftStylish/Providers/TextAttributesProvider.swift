//
//  TextAttributesProvider.swift
//  SwiftStylish
//
import UIKit
/**
  Provides **textAttributes** value to subclasses of:
 - UISegmentedControl
 - UINavigationBar
 - UIBarButtonItem
*/
class TextAttributesProvider: BaseProvider
{
    fileprivate func merged(current: [String: Any], new: [String: Any]) -> [String: Any]
    {
        var merged: [String: Any] = current
        
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
        let newTextAttributes = self.merged(current: currentTextAttributes as! [String : Any], new: textAttributes)
        segmentedControl.setTitleTextAttributes(newTextAttributes, for: item.state.toControlState())
    }
}

extension TextAttributesProvider: NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
    {
        guard item.state.toControlState() == .normal else
        {
            return
        }
        
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let textAttributes = try value.toTextAttributes()
        let currentTextAttributes = navigationBar.titleTextAttributes ?? [:]
        let newTextAttributes = self.merged(current: currentTextAttributes, new: textAttributes)
        navigationBar.titleTextAttributes = newTextAttributes
    }
}

extension TextAttributesProvider: BarButtonItemProviderProtocol
{
    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let textAttributes = try value.toTextAttributes()
        let currentTextAttributes = barButtonItem.titleTextAttributes(for: item.state.toControlState()) ?? [:]
        let newTextAttributes = self.merged(current: currentTextAttributes, new: textAttributes)
        barButtonItem.setTitleTextAttributes(newTextAttributes, for: item.state.toControlState())
    }
}
