//
//  BA_MatchListHeaderCollectionReusableView.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class BA_MatchListHeaderCollectionReusableView: UICollectionReusableView {
 
	@IBOutlet var sectionContentView: UIView!
	@IBOutlet var leagueNameLabel: UILabel!
	@IBOutlet var leagueImage: UIImageView!
	
	var leagueNameVal: String = ""
	var leagueImageVal: String = ""
	var leagueId: Int = 0
	
	private var delegate: BA_MatchTableDelegate?
	
	override func removeFromSuperview() {
		
		self.delegate = nil
		super.removeFromSuperview()
	}
	
	func setupHeader(leagueId: Int, leagueName: String, leagueImageURL: String, delegate: BA_MatchTableDelegate) {
		
		
		self.leagueNameVal = leagueName
		self.leagueImageVal = leagueImageURL
		self.leagueId = leagueId
		self.leagueNameLabel.text = leagueName
		self.leagueImage.image = nil
		self.delegate = delegate
		UIImage.getWebImage(imageUrl: self.leagueImageVal) { (responseImage) in
			
			self.leagueImage.image = responseImage
		}
	}
	
	func setupCorners() {
	
		let path = UIBezierPath(roundedRect:self.sectionContentView.bounds,
		                        byRoundingCorners:[.topRight, .topLeft],
		                        cornerRadii: CGSize(width: 8, height:  8))
		
		let maskLayer = CAShapeLayer()
		
		maskLayer.path = path.cgPath
		self.sectionContentView.layer.mask = maskLayer
	}
	
	@IBAction func btnLeagueDetailTapped(_ sender: UIButton) {
		
		if(self.delegate != nil) {
			self.delegate?.leagueDetailTapped(leagueId: self.leagueId)
		}
	}
}
