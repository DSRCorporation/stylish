//
//  SeparatorColorProvider.swift
//  SwiftStylish
//

import UIKit

/**
 Provides **sepratorColor** value to subclasses of:
 - UITableView
 */
class SeparatorColorProvider: BaseProvider {}

extension SeparatorColorProvider: TableViewProviderProtocol
{
    func applyItem(forTableView tableView: UITableView, item: StyleItem, variables: StyleVariables?) throws
    {
        let value = StyleValue(value: item.value, bundle: self.bundle, variables: variables)
        tableView.separatorColor = try value.toColor()
    }
}

