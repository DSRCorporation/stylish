//
//  RenderingModeProvider.swift
//  SwiftStylish
//

import UIKit

class RenderingModeProvider: BaseProvider {}

/**
 Provides **renderingMode** value to subclasses of:
 - UIImageView
 */
extension RenderingModeProvider: ImageViewProviderProtocol
{
    func applyItem(forImageView imageView: UIImageView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        imageView.image = imageView.image?.withRenderingMode(try value.toImageRenderingMode())
    }
}
