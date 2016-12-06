//
//  Detay_StadiumCell.swift
//  bahisadam
//
//  Created by GreenRose926 on 13/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class Detay_StadiumCell: UITableViewCell {

    @IBOutlet weak var detayStadiumView: Detay_StadiumCellView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetVal()
    {
        detayStadiumView.showStadiumInfo()
    }

}
