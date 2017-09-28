//
//  TintColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **tintColor** value to subclasses of:
 - UIView
 - UIImageView
 - UISwitch
 - UIPageControl
 */
class TintColorProvider: BaseProvider {}

extension TintColorProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.tintColor = try value.toColor()
    }
}

extension TintColorProvider: ImageViewProviderProtocol
{
    func applyItem(forImageView imageView: UIImageView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = try value.toColor()
    }
}

extension TintColorProvider: SwitchViewProviderProtocol
{
    func applyItem(forSwitch sw: UISwitch, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        
        if item.state == .selected
        {
            sw.onTintColor = try value.toColor()
        }
        else
        {
            sw.tintColor = try value.toColor()
        }
    }
}

extension TintColorProvider: PageControlProviderProtocol
{
    func applyItem(forPageControl pageControl: UIPageControl, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        
        if item.state == .selected || item.state == .highlighted
        {
            pageControl.currentPageIndicatorTintColor = try value.toColor()
        }
        else
        {
            pageControl.pageIndicatorTintColor = try value.toColor()
        }
    }
}

extension TintColorProvider: BarButtonItemProviderProtocol
{
    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        barButtonItem.tintColor = try value.toColor()
    }
}
