//
//  DisplayTableViewCell.swift
//  companyOfOne
//
//  Created by Jamie on 2018-11-01.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DisplayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTagLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleTagLabel.text = "Rent Cheque"
        categoryLabel.text = "Rental"
        subCategoryLabel.text = "Income"
        dateLabel.text = "Dec 21, 2018"
        docImageView.image = #imageLiteral(resourceName: "testDoc")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
