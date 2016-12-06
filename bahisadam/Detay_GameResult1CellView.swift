//
//  Detay_GameResult1CellView.swift
//  bahisadam
//
//  Created by GreenRose926 on 10/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

@IBDesignable
class Detay_GameResult1CellView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 20
    
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
    
    func SetVal()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: Detay_GameResul1TabViewController = storyboard.instantiateViewController(withIdentifier: "gameResult1TabViewCtrl") as! Detay_GameResul1TabViewController
        controller.view.frame = viewTab.bounds
        viewTab.addSubview(controller.view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "Detay_GameResult1CellView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
