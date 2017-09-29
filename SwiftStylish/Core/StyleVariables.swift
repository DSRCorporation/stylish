//
//  ColorScheme.swift
//  SwiftStylish
//

import UIKit


public class StyleVariables
{
    private var colors = [String: UIColor]()
    private var fonts = [String: UIFont]()
    private var numbers = [String: Float]()
    
    // MARK: - Set
    
    func setColor(_ color: UIColor, withKey key: String)
    {
        self.colors[key] = color
    }
    
    func setFont(_ font: UIFont, withKey key: String)
    {
        self.fonts[key] = font
    }
    
    func setNumber(_ number: Float, withKey key: String)
    {
        self.numbers[key] = number
    }
    
    
    // MARK: - Find
    
    func findColor(by key: String) -> UIColor?
    {
        return self.colors[key]
    }
    
    func findFont(by key: String) -> UIFont?
    {
        return self.fonts[key]
    }
    
    func findNumber(by key: String) -> Float?
    {
        return self.numbers[key]
    }
}
