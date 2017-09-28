//
//  SwiftStylish.swift
//  SwiftStylish
//

import Foundation

public class SwiftStylisher
{
    public static let `default` : SwiftStylisher = {
        let instance = SwiftStylisher()
        return instance
    }()

    private var cacheRepositories:[String: StyleRepository] = [:]
    
    public var bundle = Bundle.main
    public var loadedFiles: [String]
    {
        get
        {
            return Array(self.cacheRepositories.keys)
        }
    }
    
    public var variables: StyleVariables?
    
    // MARK: - Setup
    
    public func forceClear()
    {
        self.cacheRepositories = [:]
        self.variables = nil
        self.bundle = Bundle.main
    }
    
    // MARK: - Load
    
    public func loadFile(filename: String, bundle: Bundle) throws
    {
        if cacheRepositories[filename] == nil
        {
            try realLoadRepository(fromFile: filename, bundle: bundle)
        }
    }
    
    public func loadVariablesFile(filename: String, bundle: Bundle) throws
    {
        try realLoadVariables(fromFile: filename, bundle: bundle)
    }
    
    // MARK: - Apply style
    
    public func applyStyle(className name: String, forObject object: NSObject) throws
    {
        let compositeRepo = StyleRepository(bundle: self.bundle)
        
        for (_, repo) in self.cacheRepositories
        {
            compositeRepo.mergeWith(repository: repo)
        }
        
        guard let styleClass = compositeRepo.findClass(name: name) else
        {
            throw ApplyItemError.classNotFound(className: name)
        }
        
        try styleClass.apply(forObject: object, repository: compositeRepo, variables: self.variables)
    }
    
    // MARK: - Private
    
    private func realLoadVariables(fromFile filename: String, bundle: Bundle) throws
    {
        let loader = JSONLoader(filename: filename, bundle: bundle)
        let parser = try Parser(loader: loader)
        
        if self.variables == nil
        {
            self.variables = StyleVariables()
        }
        
        self.variables = try parser.parse(variables: self.variables!)
    }
    
    private func realLoadRepository(fromFile filename: String, bundle: Bundle) throws
    {
        let loader = JSONLoader(filename: filename, bundle: bundle)
        let parser = try Parser(loader: loader)
        
        let loadedRepository = try parser.parse()
            
        let repository = StyleRepository(bundle: bundle)
        repository.mergeWith(repository: loadedRepository)
        
        if repository.bundle != self.bundle
        {
            self.bundle = repository.bundle
        }
            
        self.cacheRepositories[filename] = repository
    }
}
