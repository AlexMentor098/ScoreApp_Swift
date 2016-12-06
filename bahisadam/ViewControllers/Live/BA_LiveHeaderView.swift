//
//  BA_LiveHeaderView.swift
//  bahisadam
//
//  Created by ilker özcan on 25/09/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class BA_LiveHeaderView: UITableViewHeaderFooterView {

	@IBOutlet var sectionContentView: UIView!
	@IBOutlet var leagueNameLabel: UILabel!
	@IBOutlet var leagueImage: UIImageView!
	
	var leagueNameVal: String = ""
	var leagueImageVal: String = ""
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
	override func removeFromSuperview() {
		
		super.removeFromSuperview()
	}

	func setupHeader(leagueName: String, leagueImageURL: String) {
		
		self.leagueNameVal = leagueName
		self.leagueImageVal = leagueImageURL
		self.leagueNameLabel.text = leagueName
		UIImage.getWebImage(imageUrl: self.leagueImageVal) { (responseImage) in
			
			self.leagueImage.image = responseImage
		}
	}
	
	func setupBorderMask() {
		
		let path = UIBezierPath(roundedRect:self.sectionContentView.bounds,
		                        byRoundingCorners:[.topLeft, .topRight],
		                        cornerRadii: CGSize(width: 8, height:  8))
		
		let maskLayer = CAShapeLayer()
		
		maskLayer.path = path.cgPath
		self.sectionContentView.layer.mask = maskLayer
	}
}
