//
//  Detay_TestViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 09/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Detay_TestViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tbl_main: UITableView!
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Detay")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        cell = UITableViewCell()
        
        if(indexPath.row == 0)
        {
            let stadiumCell = tbl_main.dequeueReusableCell(withIdentifier: "StadiumCell")! as! Detay_StadiumCell
            stadiumCell.SetVal()
            return stadiumCell
        }
        else if( indexPath.row == 1)
        {
            cell = tbl_main.dequeueReusableCell(withIdentifier: "GameChartCell")! as! UITableViewCell
        }
        else if( indexPath.row == 2)
        {
            let standingCell = tbl_main.dequeueReusableCell(withIdentifier: "GameResult1")! as! Detay_StandingCell
            standingCell.SetVal()
            return standingCell
        }
        else if( indexPath.row == 3)
        {
            let goalAverageCell = tbl_main.dequeueReusableCell(withIdentifier: "GameResult2")! as! Detay_GoalAverageCell
            goalAverageCell.SetVal()
            return goalAverageCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight: CGFloat
        
        if(indexPath.row == 0)
        {
            rowHeight = 165
        }
        else if(indexPath.row == 1)
        {
            rowHeight = 235
        }
        else if(indexPath.row == 2)
        {
            rowHeight = 310
        }
        else if(indexPath.row == 3)
        {
            rowHeight = 180
        }
        else
        {
            rowHeight = 50
        }
        
        return rowHeight
        
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
