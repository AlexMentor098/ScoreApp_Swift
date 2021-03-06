//
//  BA_StatsFooterCollectionReusableView.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit

class BA_StatsFooterCollectionReusableView: UICollectionReusableView {
	
	@IBOutlet var sectionContentView: UIView!
	
	func setupFooter() {
		
		let path = UIBezierPath(roundedRect:(self.sectionContentView.bounds),
		                        byRoundingCorners:[.bottomRight, .bottomLeft],
		                        cornerRadii: CGSize(width: 8, height:  8))
		
		let maskLayer = CAShapeLayer()
		
		maskLayer.path = path.cgPath
		self.sectionContentView.layer.mask = maskLayer
	}
}
