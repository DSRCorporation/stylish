//
//  StyleRepository.swift
//  SwiftStylish
//

import UIKit

class StyleRepository
{
    var bundle: Bundle = Bundle.main
    var classes: [String: StyleClass] = [:]
    let providerManager: StyleProviderManager = StyleProviderManager()
    
    func findOrCreateClass(key: String, parent: StyleClass?) -> StyleClass
    {
        let styleClass = StyleClass(key: key, parent: parent)
        
        if let findedClass = self.findClass(name: styleClass.name)
        {
            return findedClass
        }

        self.addClass(cls: styleClass)

        return styleClass
    }
    
    func findClass(name: String) -> StyleClass?
    {
        return self.classes[name]
    }
    
    func addClass(cls: StyleClass)
    {
        self.classes[cls.name] = cls
    }
    
    func mergeWith(repository: StyleRepository)
    {
        for (k,v) in repository.classes
        {
            if self.classes[k] == nil
            {
                self.classes.updateValue(v, forKey: k)
            }
        }
    }
    
    func clear()
    {
        self.classes.removeAll()
    }
    
    // MARK: - Static
    
    required init(bundle: Bundle)
    {
        self.bundle = bundle
        self.providerManager.registerBaseProviders()
        self.providerManager.registerLayoutProviders()
        self.providerManager.registerBarProviders()
        self.providerManager.registerTextProviders()
        self.providerManager.registerLayerProviders()
        self.providerManager.registerBehaviorProvider()
        self.providerManager.registerImageProviders()
        self.providerManager.registerColorProviders()
    }
}
