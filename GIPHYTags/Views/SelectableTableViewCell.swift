//
//  SelectableTableViewCell.swift
//  GIPHYTags
//
//  Created by David S Reich on 16/8/17.
//  Copyright © 2017 Stellar Software Pty Ltd. All rights reserved.
//

import UIKit

class SelectableTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.accessoryType = selected ? .checkmark : .none
    }
}

extension SelectableTableViewCell {
    func setupCell(title: String, selected: Bool) {
        titleLabel.text = title
    }
}
