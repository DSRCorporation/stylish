//
//  Parser.swift
//  SwiftStylish
//


import UIKit

class Parser
{
    var styleRepository: StyleRepository

    fileprivate var data = StyleData()
    fileprivate var rootElement = StyleData()
    fileprivate var loader: LoaderProtocol

    init(loader: LoaderProtocol) throws
    {
        self.loader = loader
        self.data = try self.loader.load()
        self.rootElement = self.data
        self.styleRepository = StyleRepository(bundle: loader.bundle)
    }
}

// MARK: - Parse Classes
extension Parser
{
    func loadIncludes(files: [String]) throws -> StyleRepository
    {
        let preloadRepository = StyleRepository(bundle: self.loader.bundle)

        for filename in files
        {
            let loader = type(of: self.loader).init(filename: filename, bundle: self.loader.bundle)
            let parser = try Parser(loader: loader)
            let currentRepository = try parser.parse()
            preloadRepository.mergeWith(repository: currentRepository)
        }

        return preloadRepository
    }
    
    func parse() throws -> StyleRepository
    {
        if let includesData = self.data[SystemKeys.includes.rawValue] as? [String]
        {
            let preloadRepository = try loadIncludes(files: includesData)
            self.styleRepository.mergeWith(repository: preloadRepository)
        }

        if let classesData = self.data[SystemKeys.classes.rawValue] as? StyleData
        {
            try parse(root: classesData, parent: nil, state: .normal)
        }
    
        return self.styleRepository
    }
    
    private func parse(root: StyleData, parent: StyleClass?, state: StyleItemState) throws
    {
        func _processClass(forClass: StyleClass?, key: String, value: StyleData) throws
        {
            let styleClass = styleRepository.findOrCreateClass(key: key, parent: forClass)
            try parse(root: value, parent: styleClass, state: .normal)
        }
        
        func _processItem(forClass: StyleClass, key: String, value: AnyObject) throws
        {
            let item = StyleItem(key: key, value: value, state: state)
            forClass.addItem(item: item)
        }
        
        func _processPreloads(forClass: StyleClass, key: String, value: AnyObject) throws
        {
            if let stringValue = value as? String
            {
                forClass.preloads = [stringValue]
            }
            else if let arrayValue = value as? [String]
            {
                forClass.preloads = arrayValue
            }
            else
            {
                throw ParserError.incorrectPreloadsTypeValue(forClass: forClass.name)
            }
        }
        
        func _processState(forClass: StyleClass, key: String, value: StyleData) throws
        {
            
            guard value.count > 0 else
            {
                throw ParserError.emptyState(forClass: forClass.name, state: state.rawValue)
            }
            
            let stateString = (key.components(separatedBy: ":")[1]).trimmingCharacters(in: .whitespaces)
            guard let stateValue = StyleItemState(rawValue: stateString.lowercased()) else
            {
                throw ParserError.emptyState(forClass: forClass.name, state: stateString )
            }
            
            try parse(root: value, parent: forClass, state: stateValue)
        }
        
        let keys = Array(root.keys)
        
        for key in keys
        {
            guard let value = root[key] else
            {
                continue
            }
            
            let type = ItemType.fromKey(key: key)
            
            switch type
            {
            case .xclass:
                if let value = value as? StyleData
                {
                    try _processClass(forClass: parent, key: key, value: value)
                }
                
            case .item:
                if let parent = parent
                {
                    try _processItem(forClass: parent, key: key, value: value)
                }
            case .preload:
                if let parent = parent
                {
                    try _processPreloads(forClass: parent, key: key, value: value)
                }
            case .state:
                if let parent = parent, let value = value as? StyleData
                    
                {
                    try _processState(forClass: parent, key: key, value: value)
                }
            case .ignored:
                break
            }
        }
    }
}

// MARK: - Parse Variables
extension Parser
{
    func parse(variables: StyleVariables) throws -> StyleVariables
    {
        var parsedVariables = variables
        
        if let includesData = self.data[SystemKeys.includes.rawValue] as? [String]
        {
            parsedVariables = try loadVariablesIncludes(files: includesData, variables: parsedVariables)
        }
        
        return try parseVariables(root: self.data, loader: self.loader, variables: parsedVariables)
    }
    
    func loadVariablesIncludes(files: [String], variables: StyleVariables) throws -> StyleVariables
    {
        var parsedVariables = variables
        
        for filename in files
        {
            let loader = type(of: self.loader).init(filename: filename, bundle: self.loader.bundle)
            let parser = try Parser(loader: loader)
            parsedVariables = try parser.parse(variables: parsedVariables)
        }
        
        return parsedVariables
    }
    
    
    private func parseVariables(root: StyleData, loader: LoaderProtocol, variables: StyleVariables) throws -> StyleVariables
    {
        
        func _parse(data: StyleData, variableType: VariableKeys, variables: StyleVariables) throws -> StyleVariables
        {
            for (key, value) in data
            {
                guard ItemType.fromKey(key: key) != .ignored else
                {
                    continue
                }
                
                let value = StyleValue(value: value, bundle: loader.bundle, variables: nil)
                
                switch variableType
                {
                case .colors:
                    if let colorValue = try? value.toColor()
                    {
                        variables.setColor(colorValue, withKey: key)
                        continue
                    }
                case .fonts:
                    if let fontValue = try? value.toFont()
                    {
                        variables.setFont(fontValue, withKey: key)
                        continue
                    }
                case .numbers:
                    if let numberValue = try? value.toFloat()
                    {
                        variables.setNumber(numberValue, withKey: key)
                        continue
                    }
                }
                
                throw StyleValueError.invalidVariable(value: value, forVariable: key)
            }
            
            return variables
        }
        
        let keys = Array(root.keys)
        
        var processedVariables = variables
        
        for key in keys
        {
            guard ItemType.fromKey(key: key) != .ignored else
            {
                continue
            }
            
            guard let value = root[key] as? StyleData else
            {
                continue
            }
            
            guard let type = VariableKeys(rawValue: key) else
            {
                continue
            }
            
            processedVariables = try _parse(data: value, variableType: type, variables: processedVariables)
        }
        
        return processedVariables
    }
}

// MARK: - Enums
extension Parser
{
    enum ItemType
    {
        case item
        case xclass
        case preload
        case state
        case ignored
        
        static func fromKey(key: String) -> ItemType
        {
            if key.hasPrefix("_description")
            {
                return .ignored
            }
            
            if key.hasPrefix(".")
            {
                return .xclass
            }
            
            if key.hasPrefix(SystemKeys.preload.rawValue)
            {
                return preload
            }
            
            if key.hasPrefix(SystemKeys.state.rawValue)
            {
                return state
            }
            
            return .item
        }
    }
    
    enum SystemKeys: String
    {
        case classes = "@classes"
        case preload = "@preload"
        case state = "@state"
        case includes = "@include"
    }
    
    enum VariableKeys: String
    {
        case colors = "@colors"
        case fonts = "@fonts"
        case numbers = "@numbers"
    }
}
