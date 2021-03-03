//
//  UserTableViewCell.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var frstNameLabel : UILabel!
    @IBOutlet weak var mailIdLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
