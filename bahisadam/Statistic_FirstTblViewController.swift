//
//  Statistic_FirstTblViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 11/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Statistic_FirstTblViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tblMain: UITableView!
    @IBOutlet weak var lblHomeTeam: UILabel!
    @IBOutlet weak var lblAwayTeam: UILabel!
    @IBOutlet weak var viewHomeTeam: UIView!
    @IBOutlet weak var viewAwayTeam: UIView!
    @IBOutlet weak var lblHomeTeamPercent: UILabel!
    @IBOutlet weak var lblAwayTeamPercent: UILabel!
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Maç İstatistikleri")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData()
    {
        if Shared.shared.matchDetail.count != 0 {
            
            self.InitCircleView()
            tblMain.reloadData()
        }
        else
        {
            let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                
                self.loadData()
                
            })
        }
    }
    
    func InitCircleView()
    {
        var nPercent1: CGFloat = 0.0
        var nPercent2: CGFloat = 0.0
        if let dataObject = Shared.shared.matchDetail["analysis"] as? Dictionary<String, AnyObject>
        {
            if let n = NumberFormatter().number(from: (dataObject["home"] as? String)!) {
                nPercent1 = CGFloat(n)
            }
            
            if let n = NumberFormatter().number(from: (dataObject["away"] as? String)!) {
                nPercent2 = CGFloat(n)
            }
        }
        
        self.lblHomeTeamPercent.text = String(Int(nPercent1)) + "%"
        self.lblAwayTeamPercent.text = String(Int(nPercent2)) + "%"
        
        let newToValue1 : CGFloat = (nPercent1 / 100) as CGFloat
        let newToValue2 : CGFloat = (nPercent2 / 100) as CGFloat
        
        addCircleView(viewHomeTeam, isForeground: false, duration: 0.0, fromValue: 0.0,  toValue: 1.0)
        addCircleView(viewHomeTeam, isForeground: true, duration: 0.5, fromValue: 0.0,  toValue: newToValue1)
        
        addCircleView(viewAwayTeam, isForeground: false, duration: 0.0, fromValue: 0.0,  toValue: 1.0)
        addCircleView(viewAwayTeam, isForeground: true, duration: 0.5, fromValue: 0.0,  toValue: newToValue2)
    }
    
    func addCircleView( _ myView : UIView, isForeground : Bool, duration : TimeInterval, fromValue: CGFloat, toValue : CGFloat ) {
        var circleWidth = CGFloat(myView.frame.size.width)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleHeight))
        
        //Setting the color.
        if (isForeground == true) {
            circleView.setStrokeColor(UIColor.red.cgColor)
        } else {
            // circleLayer.strokeColor = UIColor.grayColor().CGColor
            //Chose to use hexes because it's much easier.
            circleView.setStrokeColor(UIColor.gray.cgColor)
        }
        
        myView.addSubview(circleView)
        
        //Rotate the circle so it starts from the top.
        circleView.transform = CGAffineTransform(rotationAngle: -1.56)
        
        // Animate the drawing of the circle
        circleView.animateCircleTo(duration, fromValue: fromValue, toValue: toValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tblMain.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as UITableViewCell
        
        return cell
        
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
