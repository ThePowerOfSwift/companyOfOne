//
//  CommonTableViewCell.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-02.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var occurenceLabel: UILabel!
    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var isSelectedForExport:Bool = false
    
    
   // @IBOutlet var commonTableViewCell: CommonTableViewCell!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
        // Configure the view for the selected state
    }
    
}
