//
//  Bet_FirstTblViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 11/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Bet_FirstTblViewController: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tblMain: UITableView!
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Bak Kazan")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tblMain.dequeueReusableCell(withIdentifier: "cell3", for: indexPath as IndexPath) as UITableViewCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 11;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tblMain.dequeueReusableCell(withIdentifier: "customheader")! as UIView
        
        return headerCell
        
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
