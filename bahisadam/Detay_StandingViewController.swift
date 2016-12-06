//
//  Detay_StandingViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 14/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class Detay_StandingViewController: UIViewController {
    
    @IBOutlet weak var tblMain: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblMain.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.reloadData()
    }
    
    func reloadData()
    {
        if Shared.shared.standingInfo.count != 0 {
            tblMain.reloadData()
        }
        else
        {
            let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                
                self.reloadData()
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tblMain.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! Detay_StandingTabCell
        cell.SetVal(index: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var count: Int = 0
        if let dataObject = Shared.shared.standingInfo["standings"] as? Dictionary<String, AnyObject>{
            
            if let data = dataObject["1"] as? NSArray{
                
                count = data.count
                
            }
        }
        return count;
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tblMain.dequeueReusableCell(withIdentifier: "customHeader")! as UIView
        
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
