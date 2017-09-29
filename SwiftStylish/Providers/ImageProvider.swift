//
//  ImageProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **image** value to subclasses of:
  - UIButton
  - UIImageView
  - UIBarButtonItem
 */
class ImageProvider: BaseProvider {}

extension ImageProvider: ButtonProviderProtocol
{
    func applyItem(forButton button: UIButton, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        button.setImage(try value.toImage(), for: item.state.toControlState())
    }
}

extension ImageProvider: ImageViewProviderProtocol
{
    func applyItem(forImageView imageView: UIImageView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        
        if item.state == .highlighted
        {
            imageView.highlightedImage = try value.toImage()
        }
        else
        {
            imageView.image = try value.toImage()
        }
    }
}

extension ImageProvider: BarButtonItemProviderProtocol
{
    func applyItem(forBarButtonItem barButtonItem: UIBarButtonItem, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        barButtonItem.image = try value.toImage()
    }
}

// TODO: SegmentedControlProviderProtocol
// TODO: SwitchViewProviderProtocol
