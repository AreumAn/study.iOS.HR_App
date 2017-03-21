//
//  EmpTableViewCell.swift
//  myFirstAssignMent
//
//  Created by Areum on 2016-11-27.
//  Copyright © 2016 Areum. All rights reserved.
//

import UIKit

class EmpTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateOfBirthday: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
