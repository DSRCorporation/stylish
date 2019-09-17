//
//  TrackTintColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **track-tint-color** value to subclasses of:
 - UIProgressView
 */
class TrackTintColorProvider: BaseProvider {}

extension TrackTintColorProvider: ProgressViewProviderProtocol
{
    func applyItem(forProgressView progressView: UIProgressView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let trackTintColor = try value.toColor()
        
        progressView.trackTintColor = trackTintColor
    }
}
