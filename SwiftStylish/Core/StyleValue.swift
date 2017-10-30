//
//  StyleValue.swift
//  SwiftStylish
//

import UIKit

typealias Params = [String: Any]
typealias ParamsSet = [Params]

// Base

public class StyleValue
{
    var value: AnyObject
    var variables: StyleVariables?
    private(set) var bundle: Bundle
    
    required public init(value: Any, bundle: Bundle, variables: StyleVariables?)
    {
        self.value = value as AnyObject
        self.bundle = bundle
        self.variables = variables
    }
}

// MARK: - Float

extension StyleValue
{
    func toFloat() throws -> Float
    {
        if let stringValue = self.value as? String
        {
            if let value = variables?.findNumber(by: stringValue)
            {
                return value
            }
            
            return try self.floatValueFromString()
        }
        else
        {
            return try self.floatValueFromNumber()
        }
    }
    
    func toCGFloat() throws -> CGFloat
    {
        if let stringValue = self.value as? String
        {
            if let value = variables?.findNumber(by: stringValue)
            {
                return CGFloat(value)
            }
        }
        return try CGFloat(self.toFloat())
    }
    
    private func floatValueFromString() throws -> Float
    {
        let stringValue = try self.stringValue()
        return (stringValue as NSString).floatValue
    }
    
    private func floatValueFromNumber() throws -> Float
    {
        guard let floatValue = self.value as? NSNumber else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: NSNumber.self)
        }
        
        return Float(truncating: floatValue)
    }
}

// MARK: - Int

extension StyleValue
{
    func toUInt() throws -> UInt
    {
        if let stringValue = self.value as? String
        {
            if let value = variables?.findNumber(by: stringValue)
            {
                guard let result = UInt(exactly: value) else
                {
                    throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: NSNumber.self)
                }
                
                return result
            }
        }
        guard let intValue = self.value as? UInt else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: NSNumber.self)
        }
            
        return intValue
    }
}

// MARK: - Bool

extension StyleValue
{
    func toBool() throws -> Bool
    {
        guard let boolValue = self.value as? Bool else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: NSNumber.self)
        }
        
        return boolValue
    }
}

// MARK: - Color

extension StyleValue
{
    func toColor() throws -> UIColor
    {
        let stringValue = try self.stringValue()
        
        if let value = variables?.findColor(by: stringValue)
        {
            return value
        }
        
        if stringValue.lowercased() == "clear"
        {
            return UIColor.clear
        }
        
        return UIColor(stringValue) ?? UIColor.purple
    }
}

// MARK: - Bar Metrics

extension StyleValue
{
    func toBarMetrics() throws -> UIBarMetrics
    {
        let stringValue = try self.stringValue()
        
        switch stringValue
        {
        case "compact": return .compact
        case "default-prompt": return .defaultPrompt
        case "compact-prompt": return .compactPrompt
        case "default": return .default
        default: throw StyleValueError.invalidParameterValue(parameter: "BarMetrics", currentValue: stringValue, possibleValues: "compact, default-prompt, compact-prompt, default")
        }
    }
}

// MARK: - Transform

extension StyleValue
{
    func toTransform() throws -> CGAffineTransform
    {
        let params = try parameters()
        
        guard let type = params["type"] as? String else
        {
            throw StyleValueError.missingRequiredParameter(name: "type", forTypeValue: "Transform")
        }
        
        if type == "scale"
        {
            guard let x = params["x"] as? Float else
            {
                throw StyleValueError.missingRequiredParameter(name: "x", forTypeValue: "Transform (scale)")
            }
            
            guard let y = params["y"] as? Float else
            {
                throw StyleValueError.missingRequiredParameter(name: "y", forTypeValue: "Transform (scale)")
            }
            
            let xValue = StyleValue(value: x, bundle: self.bundle, variables: self.variables)
            let yValue = StyleValue(value: y, bundle: self.bundle, variables: self.variables)
            
            return CGAffineTransform.identity.scaledBy(x: try xValue.toCGFloat(), y: try yValue.toCGFloat())
        }
        else if type == "rotate"
        {
            guard let angle = params["angle"] as? Float else
            {
                throw StyleValueError.missingRequiredParameter(name: "a", forTypeValue: "Transform (rotate)")
            }
            
            let angleValue = StyleValue(value: angle, bundle: self.bundle, variables: self.variables)
            
            return CGAffineTransform.identity.rotated(by: try angleValue.toCGFloat().degreesToRadians)
        }
        else if type == "translate"
        {
            guard let x = params["x"] as? Float else
            {
                throw StyleValueError.missingRequiredParameter(name: "x", forTypeValue: "Transform (transalte)")
            }
            
            guard let y = params["y"] as? Float else
            {
                throw StyleValueError.missingRequiredParameter(name: "y", forTypeValue: "Transform (transalte)")
            }
            
            let xValue = StyleValue(value: x, bundle: self.bundle, variables: self.variables)
            let yValue = StyleValue(value: y, bundle: self.bundle, variables: self.variables)
            
            return CGAffineTransform.identity.translatedBy(x: try xValue.toCGFloat(), y: try yValue.toCGFloat())
        }
        else
        {
            throw StyleValueError.invalidParameterValue(parameter: "type", currentValue: type, possibleValues: "scale, translate, rotate")
        }
    }
}

// MARK: - Shadow

extension StyleValue
{
    func toShadowValues() throws -> (shadow: NSShadow, opacity: Float)
    {
        let params = try self.parameters()
        
        guard let offsetX = params["offsetX"] as? Float else
        {
            throw StyleValueError.missingRequiredParameter(name: "offsetX", forTypeValue: "Shadow")
        }
        
        guard let offsetY = params["offsetY"] as? Float else
        {
            throw StyleValueError.missingRequiredParameter(name: "offsetY", forTypeValue: "Shadow")
        }
        
        guard let opacity = params["opacity"] as? Float else
        {
            throw StyleValueError.missingRequiredParameter(name: "opacity", forTypeValue: "Shadow")
        }
        
        guard let radius = params["radius"] as? Float else
        {
            throw StyleValueError.missingRequiredParameter(name: "radius", forTypeValue: "Shadow")
        }
        
        guard let color = params["color"] as? String else
        {
            throw StyleValueError.missingRequiredParameter(name: "color", forTypeValue: "Shadow")
        }
        
        let offsetXValue = StyleValue(value: offsetX, bundle: self.bundle, variables: self.variables)
        let offsetYValue = StyleValue(value: offsetY, bundle: self.bundle, variables: self.variables)
        let radiusValue  = StyleValue(value: radius, bundle: self.bundle, variables: self.variables)
        let opacityValue = StyleValue(value: opacity, bundle: self.bundle, variables: self.variables)
        let colorValue = StyleValue(value: color, bundle: self.bundle, variables: self.variables)
        
        let offset = CGSize(width: try offsetXValue.toCGFloat(), height: try offsetYValue.toCGFloat())
        
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = try radiusValue.toCGFloat()
        shadow.shadowColor = try colorValue.toColor().withAlphaComponent(try opacityValue.toCGFloat())
        
        return (shadow, try opacityValue.toFloat())
    }
}

// MARK: - String

public extension StyleValue
{
    func toLocalizedString() throws -> String
    {
        func _localized(_ string: String) -> String
        {
            return NSLocalizedString(string, tableName: nil, bundle: self.bundle, value: "", comment: "")
        }
        
        let stringValue = try self.stringValue()
        
        return _localized(stringValue)
    }
    
    func toString() throws -> String
    {
        return try self.stringValue()
    }
}

// MARK: - URL

public extension StyleValue
{
    func toNSURL() throws -> NSURL
    {
        let stringValue = try self.stringValue()
        
        guard let URL = NSURL(string: stringValue) else
        {
            throw StyleValueError.invalidParameterValue(parameter: "URL", currentValue: stringValue, possibleValues: "URL String")
        }
        
        return URL
    }
}

// MARK: - Alignment

extension StyleValue
{
    func toAlignment() throws -> NSTextAlignment
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "left": return .left
        case "right": return .right
        case "center": return .center
        case "justified": return .justified
        case "natural": return .natural
        default: throw StyleValueError.invalidParameterValue(parameter: "ViewContentMode", currentValue: stringValue, possibleValues: "see NSTextAlignment")
        }
    }
    
    func toContentVerticalAlignment() throws -> UIControlContentVerticalAlignment
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "top": return .top
        case "bottom": return .bottom
        case "center": return .center
        default:
            throw StyleValueError.invalidParameterValue(parameter: "ContentVertivalAlignment", currentValue: stringValue, possibleValues: "see UIControlContentVerticalAlignment")
        }
    }
    
    func toContentHorizontalAlignment() throws -> UIControlContentHorizontalAlignment
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "left": return .left
        case "right": return .right
        case "center": return .center
        case "fill": return .fill
        default:
            throw StyleValueError.invalidParameterValue(parameter: "ContentHorizontalAlignment", currentValue: stringValue, possibleValues: "see UIControlContentHorizontalAlignment")
        }
    }
}

// MARK: - Image

extension StyleValue
{
    func toImage() throws -> UIImage?
    {
            if let stringValue = self.value as? String
            {
                return try self.image(byNamed: stringValue)
            }
        
            let params = try parameters()
            
            func _generate(_ params: Params) throws -> UIImage?
            {
                if let named = params["named"] as? String
                {
                    return try self.image(byNamed: named)
                }
                
                if let color = params["color"] as? String
                {
                    guard let width = params["width"] as? Float else
                    {
                        throw StyleValueError.missingRequiredParameter(name: "width", forTypeValue: "ColorImage")
                    }
                    
                    guard let height = params["height"] as? Float else
                    {
                        throw StyleValueError.missingRequiredParameter(name: "height", forTypeValue: "ColorImage")
                    }
                    
                    return try self.image(fromColor: color, w: CGFloat(width), h: CGFloat(height))!
                }
                
                throw StyleValueError.missingRequiredParameter(name: "named or color", forTypeValue: "Image")
            }
            
            func _modify(_ image: UIImage) throws -> UIImage?
            {
                var finallyImage = image
                
                if let renderingMode = params["rendering-mode"] as? String
                {
                    let modeValue = StyleValue(value: renderingMode, bundle: self.bundle, variables: self.variables)
                    finallyImage = image.withRenderingMode(try modeValue.toImageRenderingMode())
                }
                
                return finallyImage
            }
            
            guard let image = try _generate(params) else
            {
                return nil
            }
            
            return try _modify(image)
    }
    
    private func image(fromColor color: String, w: CGFloat, h: CGFloat) throws -> UIImage?
    {
        let colorValue = StyleValue(value: color, bundle: self.bundle, variables: self.variables)
        return UIImage(color: try colorValue.toColor(), size: CGSize(width: w, height: h))
    }
    
    private func image(byNamed named: String) throws -> UIImage
    {
        guard let image = UIImage(named: named, in: self.bundle, compatibleWith: nil) else
        {
            throw StyleValueError.invalidParameterValue(parameter: "Image", currentValue: named, possibleValues: "Image in assets")
        }
        
        return image
    }
}

extension StyleValue
{
    func toBarImage() throws -> (UIImage?, UIBarMetrics)
    {
        let params = try parameters()
        
        guard let metrics = params["bar-metrics"] as? String else
        {
            throw StyleValueError.missingRequiredParameter(name: "bar-metrics", forTypeValue: "BarImage")
        }
        
        guard let image = params["image"] else
        {
            throw StyleValueError.missingRequiredParameter(name: "image", forTypeValue: "NavigationBarImage")
        }

        let imageValue = StyleValue(value: image, bundle: self.bundle, variables: self.variables)
        let metricsValue = StyleValue(value: metrics, bundle: self.bundle, variables: self.variables)
        
        return (try imageValue.toImage(), try metricsValue.toBarMetrics())
    }
}

// MARK: - Font

extension StyleValue
{
    func toFont() throws -> UIFont
    {
        if let stringValue = self.value as? String
        {
            if let font = self.variables?.findFont(by: stringValue)
            {
                return font
            }
        }
        
        let params = try self.parameters()
        
        guard let name = params["name"] as? String else
        {
            throw StyleValueError.missingRequiredParameter(name: "family", forTypeValue: "Font")
        }
        
        guard let sizeValue = params["size"] as? Float else
        {
            throw StyleValueError.missingRequiredParameter(name: "size", forTypeValue: "Font")
        }
        
        let size = try StyleValue(value: sizeValue, bundle: self.bundle, variables: self.variables).toCGFloat()
    
        var font = UIFont()
        
        if name.lowercased() == "system"
        {
            if let weightValue = params["weight"]
            {
                let weight = try StyleValue(value: weightValue, bundle: self.bundle, variables: self.variables).toFontWeight()
                font = UIFont.systemFont(ofSize: size, weight: weight)
            }
            else
            {
                font = UIFont.systemFont(ofSize: size)
            }
        }
        else
        {
            guard let newFont = UIFont(name: name, size: size) else
            {
                 throw CommonError.commonError(message: "Failed to create UIFont with name: \(name), size: \(size)")
            }
            
            font = newFont
        }

        // Apply descriptor traits
        guard let descriptorParams = params["descriptor"] as? [String: Any] else
        {
            return font
        }

        var descriptor = font.fontDescriptor

        if let symbolicTraitsValue = descriptorParams["symbolic-traits"] as? [String]
        {
            let symbolicTraits = try StyleValue(value: symbolicTraitsValue,
                                                bundle: self.bundle,
                                                variables: self.variables).toFontDescriptorSymbolicTraits()

            guard let newDescriptor = descriptor.withSymbolicTraits(symbolicTraits) else
            {
                throw StyleValueError.invalidParameterValue(parameter: "symbolic-traits",
                                                            currentValue: String(describing: symbolicTraitsValue),
                                                            possibleValues: "Check that symbolicTraits are compatible with font.")
            }
            descriptor = newDescriptor
        }

        return UIFont(descriptor: descriptor, size: size)
    }
    
    /**
     Returns UIFontWeightRegular if fails.
     */
    func toFontWeight() throws -> UIFont.Weight
    {
        let weightString = try self.stringValue()
        
        switch weightString
        {
        case "ultraLight":
            return UIFont.Weight.ultraLight
        case "thin":
            return UIFont.Weight.thin
        case "light":
            return UIFont.Weight.light
        case "regilar":
            return UIFont.Weight.regular
        case "medium":
            return UIFont.Weight.medium
        case "semi-bold":
            return UIFont.Weight.semibold
        case "bold":
            return UIFont.Weight.bold
        case "heavy":
            return UIFont.Weight.heavy
        case "black":
            return UIFont.Weight.black
        default:
            return UIFont.Weight.regular
        }
    }
    
    func toFontDescriptorSymbolicTraits() throws -> UIFontDescriptorSymbolicTraits
    {
        var traits = UIFontDescriptorSymbolicTraits()
        
        guard let traitStrings = self.value as? [String] else
        {
            throw StyleValueError.invalidVariable(value: self.value, forVariable: "symbolic-traits")
        }
        
        for trait in traitStrings
        {
            switch trait
            {
            case "traitBold":
                traits.insert(.traitBold)
            case "traitItalic":
                traits.insert(.traitItalic)
            case "traitExpanded":
                traits.insert(.traitExpanded)
            case "traitVertical":
                traits.insert(.traitVertical)
            case "traitCondensed":
                traits.insert(.traitCondensed)
            case "traitMonoSpace":
                traits.insert(.traitMonoSpace)
            case "traitUIOptimized":
                traits.insert(.traitUIOptimized)
            case "traitLooseLeading":
                traits.insert(.traitLooseLeading)
            case "traitTightLeading":
                traits.insert(.traitTightLeading)
            case "classMask":
                traits.insert(.classMask)
            case "classScripts":
                traits.insert(.classScripts)
            case "classClarendonSerifs":
                traits.insert(.classClarendonSerifs)
            case "classTransitionalSerifs":
                traits.insert(.classTransitionalSerifs)
            case "classSymbolic":
                traits.insert(.classSymbolic)
            case "classSansSerif":
                traits.insert(.classSansSerif)
            case "classSlabSerifs":
                traits.insert(.classSlabSerifs)
            case "classOrnamentals":
                traits.insert(.classOrnamentals)
            default:
                continue
            }
        }
        
        return traits
    }
}

// MARK: - UIViewContentMode

extension StyleValue
{
    func toViewContentMode() throws -> UIViewContentMode
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "scale-to-fill": return .scaleToFill
        case "aspect-fit": return .scaleAspectFit
        case "aspect-fill": return .scaleAspectFill
        case "redraw": return .redraw
        case "center": return .center
        case "top": return .top
        case "bottom": return .bottom
        case "left": return .left
        case "right": return .right
        case "topLeft": return .topLeft
        case "topRight": return .topRight
        case "bottomLeft": return .bottomLeft
        case "bottomRight": return .bottomRight
        default: throw StyleValueError.invalidParameterValue(parameter: "ViewContentMode", currentValue: stringValue, possibleValues: "see UIViewContentMode")
        }
    }
}

// MARK: - Rendering Mode

extension StyleValue
{
    func toImageRenderingMode() throws -> UIImageRenderingMode
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "automatic": return .automatic
        case "always-original": return .alwaysOriginal
        case "always-template": return .alwaysTemplate
        default: throw StyleValueError.invalidParameterValue(parameter: "ControlState", currentValue: stringValue, possibleValues: "see UIImageRenderingMode")
        }
    }
}

// MARK: - DividerImage

extension StyleValue
{
    func toDividerImage() throws -> [(UIImage, UIControlState, UIControlState, UIBarMetrics)]
    {
        var images = [(UIImage, UIControlState, UIControlState, UIBarMetrics)]()
        
        let params = try parametersSet()
        
        for elem in params
        {
            guard let leftState = elem["leftSegmentState"] as? String else
            {
                throw StyleValueError.missingRequiredParameter(name: "leftSegmentState", forTypeValue: "SegmentedControlDividerImage")
                
            }
            guard let rightState = elem["rightSegmentState"] as? String else
            {
                throw StyleValueError.missingRequiredParameter(name: "rightSegmentState", forTypeValue: "SegmentedControlDividerImage")
            }
            
            guard let metricsValue: String = elem["bar-metrics"] as? String else
            {
                throw StyleValueError.missingRequiredParameter(name: "bar-metrics", forTypeValue: "SegmentedControlDividerImage")
            }
            
            guard let image = elem["image"] else
            {
                throw StyleValueError.missingRequiredParameter(name: "image", forTypeValue: "SegmentedControlDividerImage")
            }

            let imageValue = StyleValue(value: image, bundle: self.bundle, variables: self.variables)
            images.append( (try imageValue.toImage()!,
                              try StyleValue(value: leftState, bundle: self.bundle, variables: self.variables).toControlState(),
                              try StyleValue(value: rightState, bundle: self.bundle, variables: self.variables).toControlState(),
                              try StyleValue(value: metricsValue, bundle: self.bundle, variables: self.variables).toBarMetrics()))
        }
        
        return images
    }
    
    func toControlState() throws -> UIControlState
    {
        let stringValue = try self.stringValue()
        switch stringValue
        {
        case "normal": return .normal
        case "selected": return .selected
        case "disabled": return .disabled
        case "highlighted": return .highlighted
        default: throw StyleValueError.invalidParameterValue(parameter: "ControlState", currentValue: stringValue, possibleValues: "normal, selected, disabled, highlighted")
        }
    }
}

// MARK: - TextAtributes

extension StyleValue
{
    func toTextAttributes() throws -> [NSAttributedStringKey : Any]
    {
        let params = try self.parameters()
        
        var textAttributes: [NSAttributedStringKey: Any] = [:]
        
        for (key, value) in params
        {
            if key == "font"
            {
                let fontValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try fontValue.toFont(), forKey: NSAttributedStringKey.font)
            }
            else if key == "paragraph-style"
            {
                let paragraphStyleValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try paragraphStyleValue.toParagraphStyle(), forKey: NSAttributedStringKey.paragraphStyle)
            }
            else if key == "text-color"
            {
                let textColorValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try textColorValue.toColor(), forKey: NSAttributedStringKey.foregroundColor)
            }
            else if key == "background-color"
            {
                let backgroundColorValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try backgroundColorValue.toColor(), forKey: NSAttributedStringKey.backgroundColor)
            }
            else if key == "ligature"
            {
                let ligatureValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try ligatureValue.toBool(), forKey: NSAttributedStringKey.ligature)
            }
            else if key == "kern"
            {
                let kernValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try kernValue.toFloat(), forKey: NSAttributedStringKey.kern)
            }
            else if key == "strike-through"
            {
                let strikeThroughValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try strikeThroughValue.toUInt(), forKey: NSAttributedStringKey.strikethroughStyle)
            }
            else if key == "underline"
            {
                let underlineValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try underlineValue.toUInt(), forKey: NSAttributedStringKey.underlineStyle)
            }
            else if key == "stroke-color"
            {
                let strokeColorValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try strokeColorValue.toColor(), forKey: NSAttributedStringKey.strokeColor)
            }
            else if key == "stroke-width"
            {
                let strokeWidthValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try strokeWidthValue.toFloat(), forKey: NSAttributedStringKey.strokeWidth)
            }
            else if key == "shadow"
            {
                let shadowValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                let (shadow, _) = try shadowValue.toShadowValues()
                textAttributes.updateValue( shadow, forKey: NSAttributedStringKey.shadow)
            }
            else if key == "text-effect"
            {
                let textEffectValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try textEffectValue.toString(), forKey: NSAttributedStringKey.textEffect)
            }
            else if key == "link"
            {
                let linkValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try linkValue.toNSURL(), forKey: NSAttributedStringKey.link)
            }
            else if key == "baseline-offset"
            {
                let baselineOffsetValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try baselineOffsetValue.toCGFloat(), forKey: NSAttributedStringKey.baselineOffset)
            }
            else if key == "underline-color"
            {
                let underlineColorValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try underlineColorValue.toColor(), forKey: NSAttributedStringKey.underlineColor)
            }
            else if key == "strike-through-color"
            {
                let strikeThroughColorValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try strikeThroughColorValue.toColor(), forKey: NSAttributedStringKey.strikethroughColor)
            }
            else if key == "obliqueness"
            {
                let obliquenessValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try obliquenessValue.toFloat(), forKey: NSAttributedStringKey.obliqueness)
            }
            else if key == "expansion"
            {
                let expansionValue = StyleValue(value: value, bundle: self.bundle, variables: self.variables)
                textAttributes.updateValue(try expansionValue.toFloat(), forKey: NSAttributedStringKey.expansion)
            }
            else
            {
                throw StyleValueError.invalidParameterValue(parameter: "", currentValue: key, possibleValues: "see TextAttributes")
            }
        }
        
        return textAttributes
    }
    
    func toAttributedText() throws -> NSAttributedString
    {
        
        let params = try self.parameters()
        
        guard let text = params["text"] as? String else
        {
            throw StyleValueError.missingRequiredParameter(name: "text", forTypeValue: "attributed-string")
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        
        guard let attrs = params["attributes"] else
        {
            throw StyleValueError.missingRequiredParameter(name: "attributes", forTypeValue: "attributed-string")
        }
        
        let attrValue = StyleValue(value: attrs, bundle: self.bundle, variables: self.variables)
        let attrsItems = try attrValue.parametersSet()
        
        for attrItem in attrsItems
        {
            
            guard let attributeValue = attrItem["attributes"] else
            {
                throw StyleValueError.missingRequiredParameter(name: "attributes", forTypeValue: "attributed-text")
            }
            
            guard let substringValue = attrItem["substring"] as? String else
            {
                throw StyleValueError.missingRequiredParameter(name: "substring", forTypeValue: "attributed-text")
            }

            var range: NSRange
            var attrs: [NSAttributedStringKey : Any] = [:]
            let textValue = StyleValue(value: text, bundle: self.bundle, variables: self.variables)
            
            if substringValue.lowercased() == "all"
            {
                range = (try textValue.toLocalizedString() as NSString).range(of: try textValue.toLocalizedString())
            }
            else
            {
                let substrValue = StyleValue(value: substringValue, bundle: self.bundle, variables: self.variables)
                range = (try textValue.toLocalizedString() as NSString).range(of: try substrValue.toLocalizedString())
            }
            
            let attrsValue = StyleValue(value: attributeValue, bundle: self.bundle, variables: self.variables)
            attrs = try attrsValue.toTextAttributes()
            
            attributedString.addAttributes(attrs, range:range)
        }
        
        return attributedString
    }
    
    func toParagraphStyle() throws -> NSParagraphStyle
    {
        let paragraphStyle = NSMutableParagraphStyle()
        let params: Params = try parameters()
        
        if let lineSpacing = params["line-spacing"] as? Float
        {
            let lineSpacingValue = StyleValue(value: lineSpacing, bundle: self.bundle, variables: self.variables)
            paragraphStyle.lineSpacing = try lineSpacingValue.toCGFloat()
        }
        
        if let paragraphSpacing = params["paragraph-spacing"] as? Float
        {
            let paragraphSpacingValue = StyleValue(value: paragraphSpacing, bundle: self.bundle, variables: self.variables)
            paragraphStyle.paragraphSpacing = try paragraphSpacingValue.toCGFloat()
        }
        
        if let alignment = params["alignment"] as? String
        {
            let alignmentValue = StyleValue(value: alignment, bundle: self.bundle, variables: self.variables)
            paragraphStyle.alignment = try alignmentValue.toAlignment()
        }
        
        if let firstLineHeadIndent = params["first-line-head-indent"] as? Float
        {
            let firstLineHeadIndentValue = StyleValue(value: firstLineHeadIndent, bundle: self.bundle, variables: self.variables)
            paragraphStyle.firstLineHeadIndent = try firstLineHeadIndentValue.toCGFloat()
        }
        
        if let headIndent = params["head-indent"] as? Float
        {
            let headIndentValue = StyleValue(value: headIndent, bundle: self.bundle, variables: self.variables)
            paragraphStyle.headIndent = try headIndentValue.toCGFloat()
        }
        
        if let tailIndent = params["tail-indent"] as? Float
        {
            let tailIndentValue = StyleValue(value: tailIndent, bundle: self.bundle, variables: self.variables)
            paragraphStyle.tailIndent = try tailIndentValue.toCGFloat()
        }
        
        if let lineBreakMode = params["line-break-mode"] as? String
        {
            let lineBreakModeValue = StyleValue(value: lineBreakMode, bundle: self.bundle, variables: self.variables)
            paragraphStyle.lineBreakMode = try lineBreakModeValue.toLineBreakMode()
        }
        
        if let minimumLineHeight = params["minimum-line-height"] as? Float
        {
            let minimumLineHeightValue = StyleValue(value: minimumLineHeight, bundle: self.bundle, variables: self.variables)
            paragraphStyle.minimumLineHeight = try minimumLineHeightValue.toCGFloat()
        }
        
        if let maximumLineHeight = params["maximum-line-height"] as? Float
        {
            let maximumLineHeightValue = StyleValue(value: maximumLineHeight, bundle: self.bundle, variables: self.variables)
            paragraphStyle.maximumLineHeight = try maximumLineHeightValue.toCGFloat()
        }
        
        if let baseWritingDirection = params["base-writing-direction"] as? String
        {
            let baseWritingDirectionValue = StyleValue(value: baseWritingDirection, bundle: self.bundle, variables: self.variables)
            paragraphStyle.baseWritingDirection = try baseWritingDirectionValue.toWritingDirection()
        }
        
        if let lineHeightMultiple = params["line-height-multiple"] as? Float
        {
            let lineHeightMultipleValue = StyleValue(value: lineHeightMultiple, bundle: self.bundle, variables: self.variables)
            paragraphStyle.lineHeightMultiple = try lineHeightMultipleValue.toCGFloat()
        }
        
        if let paragraphSpacingBefore = params["paragraph-spacing-before"] as? Float
        {
            let paragraphSpacingBeforeValue = StyleValue(value: paragraphSpacingBefore, bundle: self.bundle, variables: self.variables)
            paragraphStyle.paragraphSpacingBefore = try paragraphSpacingBeforeValue.toCGFloat()
        }
        
        if let hyphenationFactor = params["hyphenation-factor"] as? Float
        {
            let hyphenationFactorValue = StyleValue(value: hyphenationFactor, bundle: self.bundle, variables: self.variables)
            paragraphStyle.hyphenationFactor = try hyphenationFactorValue.toFloat()
        }
        
        if let defaultTabInterval = params["default-tab-interval"] as? Float
        {
            let defaultTabIntervalValue = StyleValue(value: defaultTabInterval, bundle: self.bundle, variables: self.variables)
            paragraphStyle.defaultTabInterval = try defaultTabIntervalValue.toCGFloat()
        }
        
        if let allowsDefaultTighteningForTruncation = params["allows-default-tightening-for-truncation"] as? Bool
        {
            let allowsDefaultTighteningForTruncationValue = StyleValue(value: allowsDefaultTighteningForTruncation, bundle: self.bundle, variables: self.variables)
            
            if #available(iOS 9.0, *)
            {
                paragraphStyle.allowsDefaultTighteningForTruncation = try allowsDefaultTighteningForTruncationValue.toBool()
            }
        }
        
        return paragraphStyle as NSParagraphStyle
    }
    
    func toLineBreakMode() throws -> NSLineBreakMode
    {
        let stringValue = try self.stringValue()
        
        switch stringValue
        {
        case "by-wording-wrapping": return .byWordWrapping
        case "by-char-wrapping": return .byCharWrapping
        case "by-clipping": return .byClipping
        case "by-truncating-head": return .byTruncatingHead
        case "by-truncating-tail": return .byTruncatingTail
        case "by-truncating-middle": return .byTruncatingMiddle
        default: throw StyleValueError.invalidParameterValue(parameter: "LineBreakMode", currentValue: stringValue, possibleValues: "see NSLineBreakMode")
        }
    }
    
    func toWritingDirection() throws -> NSWritingDirection
    {
        let stringValue = try self.stringValue()
        
        switch stringValue
        {
        case "natural": return .natural
        case "left-to-right": return .leftToRight
        case "right-to-left": return .rightToLeft
        default: throw StyleValueError.invalidParameterValue(parameter: "WritingDirection", currentValue: stringValue, possibleValues: "see NSWritingDirection")
        }
    }
}

// MARK: - Titles
// TODO: simple array?

extension StyleValue
{
    func toTitles() throws -> [String]
    {
        guard let values = self.value as? [String] else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: [String].self as! AnyClass)
        }
        
        return values
    }
}

// MARK: - Private

extension StyleValue
{
    func parameters() throws -> Params
    {
        guard let paramValue = self.value as? Params else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: Params.self as! AnyClass)
        }
        
        return paramValue
    }
    
    func parametersSet() throws -> ParamsSet
    {
        guard self.value is ParamsSet else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: ParamsSet.self as! AnyClass)
        }
        
        return self.value as! ParamsSet
    }
    
    func stringValue() throws -> String
    {
        guard let stringValue = self.value as? String else
        {
            throw StyleValueError.invalidParameterType(type: type(of: self.value), requiredTypes: String.self as! AnyClass)
        }
        
        return stringValue
    }
}

