SwiftStylish is a Swift framework for iOS that lets you style UI elements in a convenient way using style files. 

# Requirements

* iOS 13.0+
* Xcode 11.0+
* Swift 5.0+

# Installation

## CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

`$ gem install cocoapods`

To integrate SwiftStylish into your Xcode project using CocoaPods, specify it in your Podfile:

```bash
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
target 'TargetName' do
pod 'SwiftStylish'
end 
```

Then, run the following command:

`$ pod install`

## Usage

Add `import "SwiftStylish"` to where you are going to use the framework.

Frameworks provides you with `SwiftStylisher` wrapper.

  
- Apply style class to an element:  

```
try SwiftStylisher.default.loadFile(filename: "HomeStyle", bundle: styleFileBundle)
try SwiftStylisher.default.applyStyle(className: ".nameLabel", forObject: self.usernameLabel)
```

-  Apply style class with variables:

	1. Load variables from file and load style file.
	2. Apply style.

```
try SwiftStylisher.default.loadVariablesFile(filename: "StyleVariables", bundle: styleFileBundle)
try SwiftStylisher.default.loadFile(filename: "HomeStyle", bundle: styleFileBundle)

try SwiftStylisher.default.applyStyle(className: ".nameLabel", forObject: self.usernameLabel)

```

Check [How SwiftStylish Works](https://github.com/DSRCorporation/stylish/wiki/how-stylish-works) for information about applying styles .



# Variables

Framework supports variables, stored in a separate from style classes files.
Any file type can be used.  
Variables must be split into root-level groups using keys:

- `@colors` - [Color](https://github.com/DSRCorporation/stylish/wiki/values-color)
- `@fonts` - [Font](https://github.com/DSRCorporation/stylish/wiki/values-font)
- `@numbers` - [Float](https://github.com/DSRCorporation/stylish/wiki/values-float)

Variables won't be parsed in cases:

- Variable's type doesn't match group's type.
- Parsed with class parser method.


Wrong:  
`title_font` value won't be parsed.

```
{
	"_description": "wrong colors",
    "@colors":{
        "title_font": { "name": "Arial", "size": 16 },
    }
}

```

Right:

```
{
    
    "@colors":{
        "light_background": "#6ef2d1",
        "dark_background": "#0e9a8e"
    },
    "@fonts":{
        "title_font": { "name": "Arial", "size": 16 },
        "selected_cell_font": { "name": "Arial", "size": 12 }
    },
    "@numbers":
    {
        "label_number_of_lines": 3,
        "pading": 10,
        "width": 170
    }
}

```

Commentaries and includes of other files are supported.

```
{
	"_description": "Blue theme includes.",
    "@include": ["BlueThemeColors", "BlueThemeFonts", "BlueThemeNumbers"]
}
```

# File Loader

To apply styles you first need to load them from a file. The framework provides you with loaders for JSON and Plist files.  
Loader for another file type can be created by implementing protocol `LoaderProtocol`.

### Supported File Formats

By default, SwiftStylish supports filetypes:

- JSON - `JSONLoader`
- Plist - `PlistLoader`

You can't refer to or inherit from a file with a different file type.
Recommended using one file type for a project.
Style file with different file type is allowed to use if it has no reference to files with another file type.

Example:  

JSON format is used in the project. You want to use PLIST for some screen. This Plist file can't refer to JSON file. A parser will search for a file with a similar type, which is PLIST.


# Style Repository

After parser finishes its work, all parsed values are stored in `StyleRepository`.



### Description

Commentaries can be added using `_description` key. This key doesn't affect anything. You are free to add it everywhere inside JSON body.

```
{
    "_description": "this is a description for style file.",
    "@classes": {
        "_description": "This is a base rounded button class.",
        ".roundedButton": {
        		"_description": "Red background color property.",
        		"background-color": "#ff0000"
        }
    }
}

```

## System Keys

Supported system keys:

- @classes
- @preload
- @state
- @include


### Classes (@classes)

Every style file must contain root element `@classes` with dictionary value.  
All root classes of the file are the keys in this base dictionary.

```
{  
   "_description":"this is a description for style file.",
   "@classes":{  
      "_description":"base rounded button style definition.",
      ".roundedButton":{  
         "_description":"Red background color property.",
         "background-color":"#ff0000",
         ".saveButton":{  
            "@preload":".roundedButton",
            "text":"Save"
         },
         ".deleteButton":{  
            "@preload":".roundedButton",
            "text":"Delete"
         }
      },
      ".tableView":{  
         "background-color":"#30a9f2",
         ".header":{  
            "background-color":"clear"
         }
      }
   }
}

```

### Class Inheritance(@preload & @include)
Style classes can be inherited using `@preload` key. Inheritance is supported from a single class and multiple ones.

Syntax:

```
"@preload": [ String ]

"@preload": String
```
Accepts full class path as String or an array of them.


Classes from other files can be included using `@include` key.  
Pass array of filenames with the same type of current style file.

Syntax:

```
"@include": [ String ]
```

Attributes from parent style are loaded to the repo and applied first, then other properties from child style are set. 

Example:  

```
{  
   "@include":[  
      "ParserTests1"
   ],
   "@classes":{  
      "_description":"Description for root class.",
      ".root":{  
         ".class1":{  
            "background-color":"#0000ff",
            "color":"#ff0"
         },
         ".class2":{  
            "@preload":".root.class1",
            "background-color":"#00ff00"
         },
         ".class3":{  
            "@preload":[  
               ".root.class1",
               ".root.class2"
            ],
            "background-color":"#ff0000"
         }
      }
   }
}
```

In this example the result backgrounColor value in `class3` is **#ff0000**.

### Control state (@state )

Control state can be specified using `@state` key for any UI element supporting it.

See [Control State](https://github.com/DSRCorporation/stylish/wiki/values-control-state) for details.


## Supported style keys & values

Check [Supported Keys](https://github.com/DSRCorporation/stylish/wiki/tags) for all supported style keys.

Check [Values](https://github.com/DSRCorporation/stylish/wiki/values) for all supported value types. 

# License

SwiftStylish is released under the MIT license. See `LICENSE` for details.
