//
//  Loader.swift
//  SwiftStylish
//

import UIKit

class JSONLoader: LoaderProtocol
{
    private var filename: String
    var bundle: Bundle
    
    required init(filename: String, bundle: Bundle?)
    {
        self.filename = filename
        self.bundle = bundle ?? Bundle.main
    }
    
    func load() throws -> StyleData
    {
        guard let path = self.bundle.path(forResource: filename, ofType: "json") else
        {
            throw LoaderError.invalidFile(name: filename)
        }
        
        let pathUrl = URL(fileURLWithPath: path)
        let jsonData = try Data(contentsOf: pathUrl, options: .dataReadingMapped)

        guard let jsonValue = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? StyleData else
        {
            throw LoaderError.incorrectDataInFile(message: "incorrect JSON format")
        }

        return jsonValue
    }
}
