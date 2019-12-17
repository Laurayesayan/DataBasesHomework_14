//
//  CoreDataTableViewCell.swift
//  DataBasesHomework_14
//
//  Created by Лаура Есаян on 17.12.2019.
//  Copyright © 2019 LY. All rights reserved.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coreDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
