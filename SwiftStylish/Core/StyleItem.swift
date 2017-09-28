//
//  StyleItem.swift
//  SwiftStylish
//

import UIKit

protocol ApplyStyleForObjectProtocol
{
    func apply(forObject: AnyObject, repository: StyleRepository, variables: StyleVariables?) throws
}

enum StyleItemState: String
{
    case normal = "normal"
    case selected = "selected"
    case disabled = "disabled"
    case highlighted = "highlighted"
    
    func toControlState() -> UIControlState
    {
        switch self
        {
        case .normal: return .normal
        case .selected: return .selected
        case .disabled: return .disabled
        case .highlighted: return .highlighted
        }
    }
}

extension StyleItemState: Equatable {}

func ==(lhs: StyleItem, rhs: StyleItem) -> Bool
{
    return lhs.hashValue == rhs.hashValue
}

struct StyleItem
{
    var key: StyleItemKey?
    var value: AnyObject
    var state: StyleItemState
    
    init(key: StyleItemKey, value: AnyObject, state: StyleItemState)
    {
        self.key = key
        self.value = value
        self.state = state
    }
}

extension StyleItem: Hashable
{
    public var hashValue: Int { get {
        return "\(String(describing: key))\(value.hashValue)\(state.rawValue)".hashValue
    }}
}
// MARK: - ApplyStyleForObjectProtocol

extension StyleItem: ApplyStyleForObjectProtocol
{
    func apply(forObject: AnyObject, repository: StyleRepository, variables: StyleVariables?) throws
    {
        guard let providerObject = repository.providerManager.provider(forKey: self.key!) else
        {
            assertionFailure("For key \(String(describing: self.key)) ")
            return
        }
        
        providerObject.bundle = repository.bundle
        
        try providerObject.applyItem(forAnyObject: forObject, item: self, variables: variables)
    }
}


