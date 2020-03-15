//
//  SwiftStylishControl.swift
//  SwiftStylish
//

import UIKit

open class SSButton: UIButton
{
    private var ss_borderColor = [UInt: UIColor]()
    private var ss_borderWidth = [UInt: CGFloat]()
    private var ss_cornerRadius = [UInt: CGFloat]()
    
    public override var isEnabled: Bool
    {
        willSet(newValue)
        {
            let state = newValue == false ? UIControl.State.disabled : UIControl.State.normal
            self.update(withState: state)
        }
    }
    
    public override var isHighlighted: Bool
    {
        willSet(newValue)
        {
            let state = newValue == false ? UIControl.State.normal : UIControl.State.highlighted
            self.update(withState: state)
        }
    }
    
     // MARK: - Init
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setup()
    }
    
    deinit
    {
        self.removeTarget(self, action: #selector(highlightedBorder), for: .allEvents)
        self.removeTarget(self, action: #selector(unHighlightedBorder), for: .allEvents)
    }
    
    public func setup()
    {
        self.addTarget(self, action: #selector(highlightedBorder), for: [.touchDown, .touchDownRepeat, .touchDragInside, .touchDragEnter])
        self.addTarget(self, action: #selector(unHighlightedBorder), for: [.touchDragOutside, .touchDragExit, .touchUpInside, .touchDragOutside, .touchCancel])
        self.update(withState: self.state)
    }
    
    // MARK: - Setters
    
    public func setBorder(color: UIColor, forControlState state: UIControl.State)
    {
        self.ss_borderColor[state.rawValue] = color
        self.update(withState: self.state)
    }
    
    public func setBorder(width: CGFloat, forControlState state: UIControl.State)
    {
        self.ss_borderWidth[state.rawValue] = width
        self.update(withState: self.state)
    }
    
    public func setCornerRadius(radius: CGFloat, forControlState state: UIControl.State)
    {
        self.ss_cornerRadius[state.rawValue] = radius
        self.update(withState: self.state)
    }
    
    // MARK: - Getters
    
    public func borderColor(atControlState state: UIControl.State) -> UIColor?
    {
        return self.ss_borderColor[state.rawValue]
    }
    
    public func borderWidth(atControlState state: UIControl.State) -> CGFloat?
    {
        return self.ss_borderWidth[state.rawValue]
    }
    
    public func cornerRadius(atControlState state: UIControl.State) -> CGFloat?
    {
        return self.ss_cornerRadius[state.rawValue]
    }
    
    // MARK: - Actions
    
    @objc func highlightedBorder()
    {
        let state = self.isEnabled == false ? UIControl.State.disabled : UIControl.State.highlighted
        self.update(withState: state)
    }
    
    @objc func unHighlightedBorder()
    {
        let state = self.isEnabled == false ? UIControl.State.disabled : UIControl.State.normal
        self.update(withState: state)
    }
    
    // MARK: - private
    
    private func update(withState state: UIControl.State)
    {
        self.setupBorder(forState: state)
    }
    
    private func setupBorder(forState state: UIControl.State)
    {
        let color = self.borderColor(forState: state)
        let width = self.borderWidth(forState: state)
        let cornerRadius = self.cornerRadius(forState: state)
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
    }
    
    private func borderColor(forState state: UIControl.State) -> UIColor
    {
        if let stateColor = self.ss_borderColor[state.rawValue]
        {
            return stateColor
        }
        else if let normalStateColor = self.ss_borderColor[UIControl.State.normal.rawValue]
        {
            return normalStateColor
        }
        else
        {
            return UIColor.clear
        }
    }
    
    private func borderWidth(forState state: UIControl.State) -> CGFloat
    {
        if let stateWidth = self.ss_borderWidth[state.rawValue]
        {
            return stateWidth
        }
        else if let normalStateWidth = self.ss_borderWidth[state.rawValue]
        {
            return normalStateWidth
        }
        else
        {
            return 0.0
        }
    }
    
    private func cornerRadius(forState state: UIControl.State) -> CGFloat
    {
        if let stateWidth = self.ss_cornerRadius[state.rawValue]
        {
            return stateWidth
        }
        else if let normalStateWidth = self.ss_cornerRadius[state.rawValue]
        {
            return normalStateWidth
        }
        else
        {
            return 0.0
        }
    }
}
