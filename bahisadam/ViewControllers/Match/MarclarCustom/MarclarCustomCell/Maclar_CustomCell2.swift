//
//  Maclar_CustomCell2.swift
//  bahisadam
//
//  Created by GreenRose926 on 16/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

class Maclar_CustomCell2: UITableViewCell {

    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var lblGameResult: UILabel!
    @IBOutlet weak var lblGameDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValueToFirstSection(nRow: Int)
    {
        let data = Shared.shared.matchDetail
        if let dataObject = data["away_team"] as? Dictionary<String, AnyObject> {
            if let allMatches = dataObject["allMatches"] as? NSArray{
                
                if let match = allMatches[nRow] as? Dictionary<String, AnyObject>
                {
                    if let home_team = match["home_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam1.text = home_team["team_name_tr"] as! String?
                        
                        if let teamLogos = home_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam1.image = responseImage
                            }
                            
                        }
                    }
                    
                    if let away_team = match["away_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam2.text = away_team["team_name_tr"] as! String?
                        
                        if let teamLogos = away_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam2.image = responseImage
                            }
                            
                        }
                    }
                    
                    lblGameResult.text = match["result"] as! String
                    let strDate = match["match_date"] as! String
                    lblGameDate.text = strDate.substring(with: strDate.startIndex..<strDate.index(strDate.startIndex, offsetBy: 10))
                }
            }
        }
    }
    
    func setValueToSecondSection(nRow: Int)
    {
        let data = Shared.shared.matchDetail
        if let dataObject = data["away_team"] as? Dictionary<String, AnyObject> {
            if let allMatches = dataObject["homeMatches"] as? NSArray{
                
                if let match = allMatches[nRow] as? Dictionary<String, AnyObject>
                {
                    if let home_team = match["home_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam1.text = home_team["team_name_tr"] as! String?
                        
                        if let teamLogos = home_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam1.image = responseImage
                            }
                            
                        }
                    }
                    
                    if let away_team = match["away_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam2.text = away_team["team_name_tr"] as! String?
                        
                        if let teamLogos = away_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam2.image = responseImage
                            }
                            
                        }
                    }
                    
                    lblGameResult.text = match["result"] as! String
                    let strDate = match["match_date"] as! String
                    lblGameDate.text = strDate.substring(with: strDate.startIndex..<strDate.index(strDate.startIndex, offsetBy: 10))
                }
            }
        }
    }
    
    func setValueToThirdSection(nRow: Int)
    {
        let data = Shared.shared.matchDetail
        if let dataObject = data["away_team"] as? Dictionary<String, AnyObject> {
            if let allMatches = dataObject["awayMatches"] as? NSArray{
                
                if let match = allMatches[nRow] as? Dictionary<String, AnyObject>
                {
                    if let home_team = match["home_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam1.text = home_team["team_name_tr"] as! String?
                        
                        if let teamLogos = home_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam1.image = responseImage
                            }
                            
                        }
                    }
                    
                    if let away_team = match["away_team"] as? Dictionary<String, AnyObject>{
                        
                        lblTeam2.text = away_team["team_name_tr"] as! String?
                        
                        if let teamLogos = away_team["team_logos"] as? NSArray {
                            
                            let logoUrl: String
                            logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                            
                            UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                                
                                self.imgTeam2.image = responseImage
                            }
                            
                        }
                    }
                    
                    lblGameResult.text = match["result"] as! String
                    let strDate = match["match_date"] as! String
                    lblGameDate.text = strDate.substring(with: strDate.startIndex..<strDate.index(strDate.startIndex, offsetBy: 10))
                }
            }
        }
    }

}
