//
//  ProgressTintColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **progress-tint-color** value to subclasses of:
 - UIProgressView
 */
class ProgressTintColorProvider: BaseProvider {}

extension ProgressTintColorProvider: ProgressViewProviderProtocol
{
    func applyItem(forProgressView progressView: UIProgressView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let progressTintColor = try value.toColor()
        
        progressView.progressTintColor = progressTintColor
    }
}
