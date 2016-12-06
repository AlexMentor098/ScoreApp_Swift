//
//  Detay_GameResult2CellView.swift
//  bahisadam
//
//  Created by GreenRose926 on 10/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

@IBDesignable
class Detay_GameResult2CellView: UIView {

    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    @IBOutlet weak var lblTeam1_HomeAG: UILabel!
    @IBOutlet weak var lblTeam1_HomeYG: UILabel!
 
    @IBOutlet weak var lblTeam1_AwayAG: UILabel!
    @IBOutlet weak var lblTeam1_AwayYG: UILabel!
    @IBOutlet weak var lblTeam2_HomeAG: UILabel!
    @IBOutlet weak var lblTeam2_HomeYG: UILabel!
    @IBOutlet weak var lblTeam2_AwayAG: UILabel!
    @IBOutlet weak var lblTeam2_AwayYG: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    @IBOutlet weak var viewTab: UIView!
    
    var view:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "Detay_GameResult2CellView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func SetVal()
    {
        if Shared.shared.goalAverageInfo.count != 0{
            self.SetVal2()
        }
        else
        {
            let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                
                self.SetVal()
                
            })
        }
        
        
    }
    
    func SetVal2()
    {
        
        if let dataObject = Shared.shared.goalAverageInfo["home"] as? Dictionary<String, AnyObject>
        {
            if let data_home = dataObject["1"] as? NSArray
            {
                if let data_home1 = data_home[0] as? Dictionary<String, AnyObject>
                {
                    self.lblTeam1_HomeAG.text = (data_home1["AG"] as! NSNumber?)?.stringValue
                    self.lblTeam1_HomeYG.text = (data_home1["YG"] as! NSNumber?)?.stringValue
                    self.lblTeam1.text = data_home1["team_name_tr"] as! String?
                }
                
                if let data_home2 = data_home[1] as? Dictionary<String, AnyObject>
                {
                    self.lblTeam2_HomeAG.text = (data_home2["AG"] as! NSNumber?)?.stringValue
                    self.lblTeam2_HomeYG.text = (data_home2["YG"] as! NSNumber?)?.stringValue
                    self.lblTeam2.text = data_home2["team_name_tr"] as! String?
                }
            }
        }
        
        if let dataObject = Shared.shared.goalAverageInfo["away"] as? Dictionary<String, AnyObject>
        {
            if let data_away = dataObject["1"] as? NSArray
            {
                if let data_away1 = data_away[0] as? Dictionary<String, AnyObject>
                {
                    self.lblTeam1_AwayAG.text = (data_away1["AG"] as! NSNumber?)?.stringValue
                    self.lblTeam1_AwayYG.text = (data_away1["YG"] as! NSNumber?)?.stringValue
                }
                
                if let data_away2 = data_away[1] as? Dictionary<String, AnyObject>
                {
                    self.lblTeam2_AwayAG.text = (data_away2["AG"] as! NSNumber?)?.stringValue
                    self.lblTeam2_AwayYG.text = (data_away2["YG"] as! NSNumber?)?.stringValue
                    
                }
            }
        }
    }

}
