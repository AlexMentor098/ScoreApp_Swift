//
//  Detay_StadiumCellView.swift
//  bahisadam
//
//  Created by GreenRose926 on 09/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

@IBDesignable
class Detay_StadiumCellView: UIView {
    
    
    @IBOutlet weak var lblStadiumName: UILabel!
    @IBOutlet weak var lblStadiumCapacity: UILabel!
    @IBOutlet weak var lblStadiumAttendance: UILabel!
    
    @IBOutlet weak var imgStadium: UIImageView!
    @IBOutlet weak var lblStadiumYearBuilt: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
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
        let nib = UINib(nibName: "Detay_StadiumCellView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func showStadiumInfo()
    {
        let data = Shared.shared.matchDetail
        if let dataObject = data["stadium"] as? Dictionary<String, AnyObject> {
            
            UIImage.getWebImage(imageUrl: dataObject["image"] as! String) { (responseImage) in
                
                self.imgStadium.image = responseImage
            }
            
            self.lblStadiumName.text = dataObject["name"] as! String?
            
            if let title = dataObject["capacity"] as? String
            {
                self.lblStadiumCapacity.text = "Kapasite : " + title
            }
            else
            {
                self.lblStadiumCapacity.text = "Kapasite : "
            }
            
            if let title = dataObject["attendance"] as? String
            {
                self.lblStadiumAttendance.text = "Doluluk : " + title
            }
            else
            {
                self.lblStadiumAttendance.text = "Doluluk : "
            }
            
            if let title = dataObject["yearBuilt"] as? String
            {
                self.lblStadiumYearBuilt.text = "İnşa Tarihi : " + title
            }
            else
            {
                self.lblStadiumYearBuilt.text = "İnşa Tarihi : "
            }
            
        }
    }
    
}
