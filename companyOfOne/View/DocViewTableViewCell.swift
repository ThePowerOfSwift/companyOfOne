//
//  DocViewTableViewCell.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-02.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class DocViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var occurenceLabel: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
