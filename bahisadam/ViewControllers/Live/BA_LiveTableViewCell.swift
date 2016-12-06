//
//  BA_LiveTableViewCell.swift
//  bahisadam
//
//  Created by ilker özcan on 25/09/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

protocol BA_LiveTableViewCellDelegate {
	
	func BA_LiveTableViewCellDelegate(matchTapped matchId: String, matchYear: String)
}

class BA_LiveTableViewCell: UITableViewCell {

	@IBOutlet var team1Name: UILabel!
	@IBOutlet var team2Name: UILabel!
	@IBOutlet var homeGoals: UILabel!
	@IBOutlet var awayGoals: UILabel!
	@IBOutlet var currentTimeLabel: UILabel!
	@IBOutlet var isPlayingView: UIView!
	
	private var delegate: BA_LiveTableViewCellDelegate?
	private var tapGestureRecognizer: UITapGestureRecognizer!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func removeFromSuperview() {
		
		self.delegate = nil
		super.removeFromSuperview()
	}

	func setupView(matchData: BA_Matc, delegate: BA_LiveTableViewCellDelegate?) {
	
		self.team1Name.text = matchData.homeTeam.teamName
		self.team2Name.text = matchData.awayTeam.teamName
		self.homeGoals.text = "\(matchData.homeGoals)"
		self.awayGoals.text = "\(matchData.awayGoals)"
		self.delegate = delegate
		
		if(matchData.matchType == .Playing) {
			
			self.isPlayingView.isHidden = false
			self.currentTimeLabel.text = "\(matchData.currentLiveMinutes!)'"
		}else{
			self.isPlayingView.isHidden = true
			
			if(matchData.currentLiveMinutes == "Des") {
				
				self.currentTimeLabel.text = "I.Y."
			}else{
				
				self.currentTimeLabel.text = "M.S."
			}
		}
		
		self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapGestureTapped(sender:)))
		self.contentView.addGestureRecognizer(self.tapGestureRecognizer)
	}
	
	/**
	* @TODO: update delegate method
	*/
	public func cellTapGestureTapped(sender: UITapGestureRecognizer?) -> Void {
		
		guard self.delegate != nil else {
			return
		}
		
	}
}
