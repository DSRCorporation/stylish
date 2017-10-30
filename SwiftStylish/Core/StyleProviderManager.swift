//
//  StyleProviderManager.swift
//  SwiftStylish
//

import Foundation

typealias StyleItemKey = String

class StyleProviderManager
{
    private var keys = [String: BaseProvider]()
    
    func registerKey(key: StyleItemKey, withProvider: BaseProvider, force: Bool = false) // if force is true, then provider will be override
    {
        guard provider(forKey: key) == nil && !force else
        {
            assertionFailure("For key \(key) provider already exists. Use force = true, if you confident in your actions.")
            return
        }
        
        self.keys[key] = withProvider
    }
    
    func provider(forKey key: StyleItemKey) -> BaseProvider?
    {
        return self.keys[key]
    }
}

enum StyleItemKeys: StyleItemKey
{
    case backgroundColor = "background-color"               // BackgroundColorProvider
    case backgroundImage = "background-image"               // BackgroundImageProvider
    case dividerImage = "divider-image"                     // DividerImageProvider
    case image = "image"                                    // ImageProvider
    case selectedImage = "selected-image"                   // SelectedImageProvider
    case shadowImage = "shadow-image"                       // ShadowImageProvider
    case alpha = "alpha"                                    // AlphaProvider
    case opacity = "opacity"                                // OpacityProvider
    case textColor = "text-color"                           // TextColorProvider
    case textAlignment = "text-alignment"                   // TextAlignmentProvider
    case text = "text"                                      // TextProvider
    case textAttributes = "text-attributes"                 // TextAttributesProvider
    case titles = "titles"                                  // TitleAttributesProvider
    case attributedText = "attributed-text"                 // AttributedTextProvider
    case attributedPlaceholder = "attributed-placeholder"   // AttributedPlaceholderProvider
    case placeholder = "placeholder"                        // PlaceholderProvider
    case numberOfLines = "number-of-lines"                  // NumberOfLinesProvider
    case font = "font"                                      // FontProvider
    case shadow = "shadow"                                  // ShadowProvider
    case tintColor = "tint-color"                           // TintColorProvider
    case barTintColor = "bar-tint-color"                    // BarTintColorProvider
    case backIndicatorImage = "back-indicator-image"        // BackIndicatorImageProviderTests
    case trackTintColor = "track-tint-color"                // ProgressViewProviderProtocol
    case progressTintColor = "progress-tint-color"          // ProgressViewProviderProtocol
    case translucent = "translucent"                        // TranslucentProvider
    case dataDetectorType = "data-detector-type"            // DataDetectorTypeProvider
    case linkTextAttributes = "link-text-attributes"        // LinkTextAttributesProvider
    case editable = "editable"                              // EditableProvider
    case contentInset = "content-inset"                     // ContentInsetProvider
    case contentMode = "content-mode"                       // ContentModeProvider
    
    case scrollEnabled = "scroll-enabled"                   // ScrollEnabledProvider
    case selectable = "selectable"                          // SelectableProvider
    case color = "color"                                    // ColorProvider
    
    case borderColor = "border-color"                       // BorderColorProvider
    case separatorColor = "separator-color"                 // SeparatorColorProvider
    case borderWidth = "border-width"                       // BorderWidthProvider
    case cornerRadius = "corner-radius"                     // CornerRadiusProvider
    
    case renderingMode = "rendering-mode"                   // RenderingModeProvider
    
    // Behavior
    
    case hidden = "hidden"                                  // HiddenProvider
    case clipsToBounds = "clips-to-bounds"                  // ClipsToBoundsProvider
    case transform = "transform"                            // TransformProvider
    case userInteractionEnabled = "user-interaction-enabled"    // UserInteractionEnabled
    
    // Layout
    case verticalAlignment = "vertical-alignment"           // VerticalAlignmentProvider
    case horizontalAlignment = "horizontal-alignment"       // HorizontalAlignmentProvider
}

extension StyleProviderManager
{
    final func registerBaseProviders()
    {
        registerKey(key: StyleItemKeys.backgroundColor.rawValue, withProvider: BackgroundColorProvider())
        registerKey(key: StyleItemKeys.alpha.rawValue, withProvider: AlphaProvider())
        registerKey(key: StyleItemKeys.tintColor.rawValue, withProvider: TintColorProvider())
        registerKey(key: StyleItemKeys.barTintColor.rawValue, withProvider: BarTintColorProvider())
        registerKey(key: StyleItemKeys.contentInset.rawValue, withProvider: ContentInsetProvider())
        registerKey(key: StyleItemKeys.contentMode.rawValue, withProvider: ContentModeProvider())
        registerKey(key: StyleItemKeys.scrollEnabled.rawValue, withProvider: ScrollEnabledProvider())
        registerKey(key: StyleItemKeys.backgroundImage.rawValue, withProvider: BackgroundImageProvider())
        registerKey(key: StyleItemKeys.dividerImage.rawValue, withProvider: DividerImageProvider())
        registerKey(key: StyleItemKeys.image.rawValue, withProvider: ImageProvider())
        registerKey(key: StyleItemKeys.selectedImage.rawValue, withProvider: SelectedImageProvider())
        registerKey(key: StyleItemKeys.shadowImage.rawValue, withProvider: ShadowImageProvider())
        registerKey(key: StyleItemKeys.titles.rawValue, withProvider: TitlesProvider())
    }
    
    final func registerLayoutProviders()
    {
        registerKey(key: StyleItemKeys.verticalAlignment.rawValue, withProvider: VerticalAlignmentProvider())
        registerKey(key: StyleItemKeys.horizontalAlignment.rawValue, withProvider: HorizontalAlignmentProvider())
    }
    
    final func registerBehaviorProvider()
    {
        registerKey(key: StyleItemKeys.hidden.rawValue, withProvider: HiddenProvider())
        registerKey(key: StyleItemKeys.clipsToBounds.rawValue, withProvider: ClipsToBoundsProvider())
        registerKey(key: StyleItemKeys.transform.rawValue, withProvider: TransformProvider())
        registerKey(key: StyleItemKeys.userInteractionEnabled.rawValue, withProvider: UserInteractionEnabled())
    }
    
    final func registerLayerProviders()
    {
        registerKey(key: StyleItemKeys.shadow.rawValue, withProvider: ShadowProvider())
        registerKey(key: StyleItemKeys.borderColor.rawValue, withProvider: BorderColorProvider())
        registerKey(key: StyleItemKeys.separatorColor.rawValue, withProvider: SeparatorColorProvider())
        registerKey(key: StyleItemKeys.borderWidth.rawValue, withProvider: BorderWidthProvider())
        registerKey(key: StyleItemKeys.cornerRadius.rawValue, withProvider: CornerRadiusProvider())
        registerKey(key: StyleItemKeys.opacity.rawValue, withProvider: OpacityProvider())
    }
    
    final func registerTextProviders()
    {
        registerKey(key: StyleItemKeys.textColor.rawValue, withProvider: TextColorProvider())
        registerKey(key: StyleItemKeys.textAlignment.rawValue, withProvider: TextAlignmentProvider())
        registerKey(key: StyleItemKeys.text.rawValue, withProvider: TextProvider())
        registerKey(key: StyleItemKeys.textAttributes.rawValue, withProvider: TextAttributesProvider())
        registerKey(key: StyleItemKeys.attributedText.rawValue, withProvider: AttributedTextProvider())
        registerKey(key: StyleItemKeys.attributedPlaceholder.rawValue, withProvider: AttributedPlaceholderProvider())
        registerKey(key: StyleItemKeys.placeholder.rawValue, withProvider: PlaceholderProvider())
        registerKey(key: StyleItemKeys.numberOfLines.rawValue, withProvider: NumberOfLinesProvider())
        registerKey(key: StyleItemKeys.font.rawValue, withProvider: FontProvider())
        registerKey(key: StyleItemKeys.dataDetectorType.rawValue, withProvider: DataDetectorTypeProvider())
        registerKey(key: StyleItemKeys.linkTextAttributes.rawValue, withProvider: LinkTextAttributesProvider())
        registerKey(key: StyleItemKeys.editable.rawValue, withProvider: EditableProvider())
        registerKey(key: StyleItemKeys.selectable.rawValue, withProvider: SelectableProvider())
        registerKey(key: StyleItemKeys.color.rawValue, withProvider: ColorProvider())
    }
    
    final func registerBarProviders()
    {
        registerKey(key: StyleItemKeys.translucent.rawValue, withProvider: TranslucentProvider())
        registerKey(key: StyleItemKeys.backIndicatorImage.rawValue, withProvider: BackIndicatorImageProvider())
    }
    
    final func registerImageProviders()
    {
        registerKey(key: StyleItemKeys.renderingMode.rawValue, withProvider: RenderingModeProvider())
    }
    
    final func registerColorProviders()
    {
        registerKey(key: StyleItemKeys.progressTintColor.rawValue, withProvider: ProgressTintColorProvider())
        registerKey(key: StyleItemKeys.trackTintColor.rawValue, withProvider: TrackTintColorProvider())
    }
}
