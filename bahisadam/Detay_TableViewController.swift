//
//  Detay_TableViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 09/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Detay_TableViewController: UIViewController, IndicatorInfoProvider  {

    var itemInfo: IndicatorInfo = "Detay"

    @IBOutlet weak var tbl_main: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tbl_main.dequeueReusableCell(withIdentifier: "StadiumCell")! as! UITableViewCell
        
        return cell
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Detay")
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
