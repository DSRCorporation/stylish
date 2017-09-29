//
//  StyleClass.swift
//  SwiftStylish
//

import UIKit

class StyleClass
{
    var name: String
    {
        get
        {
            guard let parentName = self.parent?.name else
            {
                return self.key
            }

            return parentName + self.key
        }
    }// it's a full name, for example .root.parent-class.class, should be unique
    
    let key: String // this a short name, shouldn't be unique, for example .my-class
    let parent: StyleClass? // link on parent class, parent class must be single
    var items: [StyleItem]// list of items
    var preloads: [String] // preloads styles
    
    init(key: String, parent: StyleClass?)
    {
        self.key = key
        self.parent = parent
        self.items = []
        self.preloads = []
    }
    
    func addItem(item: StyleItem)
    {
        items.append(item)
    }
}

extension StyleClass: Equatable {}

func ==(lhs: StyleClass, rhs: StyleClass) -> Bool
{
    return lhs.hashValue == rhs.hashValue
}

extension StyleClass: Hashable
{
    public var hashValue: Int { get {
        return self.name.hashValue
    }}
}

// MARK: - ApplyStyleForObjectProtocol

extension StyleClass: ApplyStyleForObjectProtocol
{
    func apply(forObject: AnyObject, repository: StyleRepository, variables: StyleVariables?) throws
    {
        try applyPreloads(forObject: forObject, repository: repository, variables: variables)
        try applyItems(forObject: forObject, repository: repository, variables: variables)
    }
    
    private func applyPreloads(forObject: AnyObject, repository: StyleRepository, variables: StyleVariables?) throws
    {
        for preloadString in preloads
        {
            guard let preloadStyleClass = repository.findClass(name: preloadString) else
            {
                throw ApplyItemError.classNotFound(className: preloadString)
            }
            
            try preloadStyleClass.apply(forObject: forObject, repository: repository, variables: variables)
        }
    }
    
    private func applyItems(forObject: AnyObject, repository: StyleRepository, variables: StyleVariables?) throws
    {
        for item in items
        {
            try item.apply(forObject: forObject, repository: repository, variables: variables)
        }
    }
}
