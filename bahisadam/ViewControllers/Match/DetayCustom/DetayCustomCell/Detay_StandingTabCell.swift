//
//  Detay_StandingTabCell.swift
//  bahisadam
//
//  Created by GreenRose926 on 16/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

class Detay_StandingTabCell: UITableViewCell {

    @IBOutlet weak var lblNum: UILabel!
    @IBOutlet weak var imgTeamLogo: UIImageView!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var lblOM: UILabel!
    @IBOutlet weak var lblG: UILabel!
    @IBOutlet weak var lblB: UILabel!
    @IBOutlet weak var lblM: UILabel!
    @IBOutlet weak var lblPTS: UILabel!

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetVal(index: Int)
    {
        if let dataObject = Shared.shared.standingInfo["standings"] as? Dictionary<String, AnyObject>{
            
            if let data = dataObject["1"] as? NSArray{
                
                if let teamInfo = data[index] as? Dictionary<String, AnyObject>{
                    
                    let logoUrl: String
                    logoUrl = String(format: BA_Server.GetImageUrlApi, teamInfo["team_logo"] as! String)
                    
                    UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                        
                        self.imgTeamLogo.image = responseImage
                    }
                    
                    self.lblNum.text = String(index)
                    self.lblTeamName.text = teamInfo["team_name_tr"] as! String?
                    self.lblOM.text = (teamInfo["OM"] as! NSNumber?)?.stringValue
                    self.lblG.text = (teamInfo["G"] as! NSNumber?)?.stringValue
                    self.lblB.text = (teamInfo["B"] as! NSNumber?)?.stringValue
                    self.lblM.text = (teamInfo["M"] as! NSNumber?)?.stringValue
                    self.lblPTS.text = (teamInfo["PTS"] as! NSNumber?)?.stringValue
                    
                }
            }
        }
    }

}
