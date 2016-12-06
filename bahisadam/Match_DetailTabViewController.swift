//
//  Match_DetailTabViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 09/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import MBProgressHUD
import BahisadamLive

class Match_DetailTabViewController: UIViewController {
    
    private var matchDetailInfo: Dictionary<String, AnyObject> = [:]
    private var detayViewController: Detay_TestViewController?

    @IBOutlet weak var imgHomeTeam: UIImageView!
    @IBOutlet weak var lblHomeTeamName: UILabel!
    @IBOutlet weak var imgAwayTeam: UIImageView!
    @IBOutlet weak var lblAwayTeamName: UILabel!
    @IBOutlet weak var lblLeagueName: UILabel!
    @IBOutlet weak var lblScoreResult: UILabel!
    @IBOutlet weak var lblScoreStatus: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        self.detayViewController = self.storyboard?.instantiateViewController(withIdentifier: "MatchDetailViewController") as? Detay_TestViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTopBarInfo(data: Dictionary<String, AnyObject>)
    {
        self.matchDetailInfo = data
        
        
        if let dataObject = data["home_team"] as? Dictionary<String, AnyObject> {
            
            if let teamLogos = dataObject["team_logos"] as? NSArray {
                
                let logoUrl: String
                logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                
                UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                    
                    self.imgHomeTeam.image = responseImage
                }
                
            }
            
            self.lblHomeTeamName.text = dataObject["team_name_tr"] as! String?
            
        }
        
        if let dataObject = data["away_team"] as? Dictionary<String, AnyObject> {
            
            if let teamLogos = dataObject["team_logos"] as? NSArray {
                
                let logoUrl: String
                logoUrl = String(format: BA_Server.GetImageUrlApi, teamLogos[0] as! String)
                
                UIImage.getWebImage(imageUrl: logoUrl) { (responseImage) in
                    
                    self.imgAwayTeam.image = responseImage
                }
                
            }
            
            self.lblAwayTeamName.text = dataObject["team_name_tr"] as! String?
            
        }
        
        if let dataObject = data["league_id"] as? Dictionary<String, AnyObject> {
            self.lblLeagueName.text = dataObject["league_name_tr"] as! String?
        }
        
        self.lblScoreResult.text = data["half_time_result"] as! String?
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let segueId = segue.identifier {
//            
//            if(segueId == "showMatchDetailView" && self.detayViewController != nil) {
//                
//                if let detayView = segue.destination as? Detay_TestViewController {
//                    
//                    
//                }
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
