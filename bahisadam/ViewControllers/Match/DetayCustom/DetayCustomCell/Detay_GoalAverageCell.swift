//
//  Detay_GoalAverageCell.swift
//  bahisadam
//
//  Created by GreenRose926 on 14/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class Detay_GoalAverageCell: UITableViewCell {

    @IBOutlet weak var goalAverageView: Detay_GameResult2CellView!
    
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
        if Shared.shared.goalAverageInfo.count != 0{
            goalAverageView.SetVal()
        }
        else
        {
            let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                
                self.SetVal()
                
            })
        }
        
    }

}
