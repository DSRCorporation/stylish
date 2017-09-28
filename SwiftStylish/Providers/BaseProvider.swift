//
//  BaseProvider.swift
//  SwiftStylish
//

import UIKit

open class BaseProvider: ApplyItemProviderProtocol
{
    var bundle: Bundle = Bundle.main

    func applyItem(forAnyObject anyObject: AnyObject, item: StyleItem, variables: StyleVariables?) throws
    {
        
        if let object = anyObject as? UITextView, let provider = self as? TextViewProviderProtocol
        {
            try provider.applyItem(forTextView: object, item: item, variables: variables)
                return
        }
        
        if let object = anyObject as? UITextField, let provider = self as? TextFieldProviderProtocol
        {
            try provider.applyItem(forTextField: object, item: item, variables: variables)
                return
        }
        
        if let object = anyObject as? UITableView, let provider = self as? TableViewProviderProtocol
        {
            try provider.applyItem(forTableView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UILabel, let provider = self as? LabelProviderProtocol
        {
            try provider.applyItem(forLabel: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIImageView, let provider = self as? ImageViewProviderProtocol
        {
            try provider.applyItem(forImageView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIButton, let provider = self as? ButtonProviderProtocol
        {
            try provider.applyItem(forButton: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UICollectionView, let provider = self as? CollectionViewProviderProtocol
        {
            try provider.applyItem(forCollectionView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UITableViewCell, let provider = self as? TableViewCellProviderProtocol
        {
            try provider.applyItem(forTableViewCell: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UICollectionViewCell, let provider = self as? CollectionViewCellProviderProtocol
        {
            try provider.applyItem(forCollectionViewCell: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UISegmentedControl, let provider = self as? SegmentedControlProviderProtocol
        {
            try provider.applyItem(forSegmentedControl: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIPageControl, let provider = self as? PageControlProviderProtocol
        {
            try provider.applyItem(forPageControl: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UISwitch, let provider = self as? SwitchViewProviderProtocol
        {
            try provider.applyItem(forSwitch: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIBarButtonItem, let provider = self as? BarButtonItemProviderProtocol
        {
            try provider.applyItem(forBarButtonItem: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIPickerView, let provider = self as? PickerViewProviderProtocol
        {
            try provider.applyItem(forPickerView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIProgressView, let provider = self as? ProgressViewProviderProtocol
        {
            try provider.applyItem(forProgressView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UISlider, let provider = self as? SliderProviderProtocol
        {
            try provider.applyItem(forSlider: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UITabBar, let provider = self as? TabBarProviderProtocol
        {
            try provider.applyItem(forTabBar: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UITabBarItem, let provider = self as? TabBarItemProviderProtocol
        {
            try provider.applyItem(forTabBarItem: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UINavigationBar, let provider = self as? NavigationBarProviderProtocol
        {
            try provider.applyItem(forNavigationBar: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIScrollView, let provider = self as? ScrollViewProviderProtocol
        {
            try provider.applyItem(forScrollView: object, item: item, variables: variables)
            return
        }
        
        if let object = anyObject as? UIView, let provider = self as? ViewProviderProtocol
        {
            try provider.applyItem(forView: object, item: item, variables: variables)
            return
        }
        
         throw ApplyItemError.keyNotSupported(key: item.key ?? "nil",
                                              forType: type(of: self),
                                              message: "")
    }
}

// MARK: - Protocols

protocol ApplyItemProviderProtocol
{
    func applyItem(forAnyObject: AnyObject, item: StyleItem, variables: StyleVariables?) throws
}

protocol ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
}

protocol ScrollViewProviderProtocol
{
    func applyItem(forScrollView scrollView: UIScrollView, item: StyleItem, variables: StyleVariables?) throws
}

protocol NavigationBarProviderProtocol
{
    func applyItem(forNavigationBar navigationBar: UINavigationBar, item: StyleItem, variables: StyleVariables?) throws
}

protocol TextViewProviderProtocol
{
    func applyItem(forTextView textView: UITextView, item: StyleItem, variables: StyleVariables?) throws
}

protocol TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
}

protocol TableViewProviderProtocol
{
    func applyItem(forTableView tableView: UITableView, item: StyleItem, variables: StyleVariables?) throws
}

protocol LabelProviderProtocol
{
    func applyItem(forLabel label: UILabel, item: StyleItem, variables: StyleVariables?) throws
}

protocol ImageViewProviderProtocol
{
    func applyItem(forImageView imageView: UIImageView, item: StyleItem, variables: StyleVariables?) throws
}

protocol ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
}

protocol CollectionViewProviderProtocol
{
    func applyItem(forCollectionView collectionView: UICollectionView, item: StyleItem, variables: StyleVariables?) throws
}

protocol TableViewCellProviderProtocol
{
    func applyItem(forTableViewCell tableViewCell: UITableViewCell, item: StyleItem, variables: StyleVariables?) throws
}

protocol CollectionViewCellProviderProtocol
{
    func applyItem(forCollectionViewCell collectionViewCell: UICollectionViewCell, item: StyleItem, variables: StyleVariables?) throws
}

protocol SegmentedControlProviderProtocol
{
    func applyItem(forSegmentedControl segmentedControl: UISegmentedControl, item: StyleItem, variables: StyleVariables?) throws
}

protocol PageControlProviderProtocol
{
    func applyItem(forPageControl pageControl: UIPageControl, item: StyleItem, variables: StyleVariables?) throws
}

protocol SwitchViewProviderProtocol
{
    func applyItem(forSwitch sw: UISwitch, item: StyleItem, variables: StyleVariables?) throws
}

protocol BarButtonItemProviderProtocol
{
    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
}

protocol PickerViewProviderProtocol
{
    func applyItem(forPickerView pickerView: UIPickerView, item: StyleItem, variables: StyleVariables?) throws
}

protocol ProgressViewProviderProtocol
{
    func applyItem(forProgressView progressView: UIProgressView, item: StyleItem, variables: StyleVariables?) throws
}

protocol SliderProviderProtocol
{
    func applyItem(forSlider slider: UISlider, item: StyleItem, variables: StyleVariables?) throws
}

protocol TabBarProviderProtocol
{
    func applyItem(forTabBar tabBar: UITabBar, item: StyleItem, variables: StyleVariables?) throws
}

protocol TabBarItemProviderProtocol
{
    func applyItem(forTabBarItem tabBarItem: UITabBarItem, item: StyleItem, variables: StyleVariables?) throws
}
