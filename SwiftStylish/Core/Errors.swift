//
//  Errors.swift
//  SwiftStylish
//

import Foundation

public enum LoaderError: Error
{
    case invalidFile(name: String)
    case incorrectDataInFile(message: String)
}

public enum ApplyItemError: Error
{
    case keyNotSupported(key:String, forType:AnyClass, message: String)
    case classNotFound(className: String)
}

public enum StyleValueError: Error
{
    case missingRequiredParameter(name: String, forTypeValue: String)
    case invalidParameterType(type:AnyClass, requiredTypes: AnyClass)
    case invalidParameterValue(parameter: String, currentValue: String, possibleValues: String)
    case invalidVariable(value: AnyObject?, forVariable: String)
}

public enum ParserError: Error
{
    case notContainsNecessaryKey(key: String)
    case unknownKey(forClass: String, key: String)
    case incorrectPreloadsTypeValue(forClass: String)
    case emptyState(forClass: String, state: String)
}

public enum CommonError: Error
{
    case commonError(message: String)
}
