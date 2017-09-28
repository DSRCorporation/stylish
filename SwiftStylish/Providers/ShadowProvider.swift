//
//  ShadowProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **shadow** value to subclasses of:
 - UIView
 */
class ShadowProvider: BaseProvider {}

extension ShadowProvider: ViewProviderProtocol
{
    /**
     Applies shadow values to UIView:
        - shadowOffset
        - shadowColor
        - shadowRadius
        - shadowOpacity
     */
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        let (shadow, opacity) = try value.toShadowValues()
        
        let color = shadow.shadowColor as? UIColor
        
        view.layer.shadowOffset = shadow.shadowOffset
        view.layer.shadowColor = color?.withAlphaComponent(1.0).cgColor
        view.layer.shadowRadius = shadow.shadowBlurRadius
        view.layer.shadowOpacity = opacity
    }
}
