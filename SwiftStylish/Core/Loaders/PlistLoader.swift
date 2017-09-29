//
//  PlistLoader.swift
//  SwiftStylish
//

import Foundation

class PlistLoader: LoaderProtocol
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
        guard let path = self.bundle.path(forResource: filename, ofType: "plist") else
        {
            throw LoaderError.invalidFile(name: filename)
        }

        let pathUrl = URL(fileURLWithPath: path)
        let plistData = try Data(contentsOf: pathUrl)

        guard let dictValue = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? StyleData else
        {
            throw LoaderError.incorrectDataInFile(message: "incorrect Plist format")
        }

        return dictValue
    }
}
