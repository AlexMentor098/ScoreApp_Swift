//
//  Detay_StandingCell.swift
//  bahisadam
//
//  Created by GreenRose926 on 14/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class Detay_StandingCell: UITableViewCell {

    @IBOutlet weak var gameResultView: Detay_GameResult1CellView!
    
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
        gameResultView.SetVal()
    }

}
