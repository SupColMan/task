//
//  TodoCell.swift
//  Todos
//
//  Created by apple on 2020/3/16.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todo: UILabel!
    @IBOutlet weak var checkMark: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
