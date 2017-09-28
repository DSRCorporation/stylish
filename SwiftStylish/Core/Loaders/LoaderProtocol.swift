//
//  LoaderProtocol.swift
//  SwiftStylish
//

import Foundation

typealias StyleData = [String: AnyObject]

protocol LoaderProtocol
{
    var bundle: Bundle {get}
    init(filename: String, bundle: Bundle?)
    func load() throws -> StyleData
}
