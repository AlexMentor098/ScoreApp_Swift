//
//  Marclar_SecondTableViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 16/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import BahisadamLive

class Marclar_SecondTableViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tblMain: UITableView!
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        var txtTitle: String = ""
        let data = Shared.shared.matchDetail
        if let dataObject = data["away_team"] as? Dictionary<String, AnyObject> {
            
            txtTitle = dataObject["team_name_tr"] as! String
        }
        
        return IndicatorInfo(title: txtTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5;
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tblMain.dequeueReusableCell(withIdentifier: "customHeader")! as UIView
        
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tblMain.dequeueReusableCell(withIdentifier: "customCell")! as! Maclar_CustomCell2
        
        if indexPath.section == 0{
            
            cell.setValueToFirstSection(nRow: indexPath.row)
        }
        else if indexPath.section == 1 {
            
            cell.setValueToSecondSection(nRow: indexPath.row)
        }
        else if indexPath.section == 2 {
            
            cell.setValueToThirdSection(nRow: indexPath.row)
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
