//
//  BackgroundColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides backgroundColor value to subclasses of:
 - UIView
 
 Specific implementation is provided for subclasses of:
 - UITextField - color is set depending on controlState
 - UITableViewCell - color is applied to cell and its contentView
 */
class BackgroundColorProvider: BaseProvider {}

extension BackgroundColorProvider: ViewProviderProtocol
{
    func applyItem(forView view: UIView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        view.backgroundColor = try value.toColor()
    }
}

extension BackgroundColorProvider: TableViewCellProviderProtocol
{
    func applyItem(forTableViewCell tableViewCell: UITableViewCell, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        tableViewCell.backgroundColor = try value.toColor()
        tableViewCell.contentView.backgroundColor = try value.toColor()
    }
}

extension BackgroundColorProvider: TextFieldProviderProtocol
{
    func applyItem(forTextField textField: UITextField, item: StyleItem, variables: StyleVariables?) throws
    {
        if let sstexfield = textField as? SSTextField
        {
            let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
            sstexfield.setBackground(color: try value.toColor(), forControlState: item.state.toControlState())
        }
        else
        {
            try applyItem(forView: textField as UIView, item: item, variables: variables)
        }
    }
}
