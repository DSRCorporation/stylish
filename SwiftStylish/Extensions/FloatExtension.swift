//
//  FloatExtension.swift
//  SwiftStylish
//

import Foundation

extension FloatingPoint
{
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
