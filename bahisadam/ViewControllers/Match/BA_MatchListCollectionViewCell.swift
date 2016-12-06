//
//  BA_MatchListCollectionViewCell.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

class BA_MatchListCollectionViewCell: UICollectionViewCell {
 
	@IBOutlet var team1Name: UILabel!
	@IBOutlet var team1FormLeft: UIImageView!
	@IBOutlet var team1FormRight: UIImageView!
	@IBOutlet var team2Name: UILabel!
	@IBOutlet var team2FormLeft: UIImageView!
	@IBOutlet var team2FormRight: UIImageView!
	@IBOutlet var bet1: UILabel!
	@IBOutlet var bet2: UILabel!
	@IBOutlet var bet3: UILabel!
	@IBOutlet var matchDateButton: UIButton!
	@IBOutlet var halfTimeScoreButton: UIButton!
	@IBOutlet var currentTimeButton: UIButton!
	@IBOutlet var homeTeamGoals: UILabel!
	@IBOutlet var awayTeamGoals: UILabel!
	
	private var delegate: BA_MatchTableDelegate?
	private var matchId = ""
	private var matchYear = 0
	private var tapGestureRecognizer: UITapGestureRecognizer?
	private var matchType: BA_Matc.MATCH_TYPES?
	
	fileprivate let halfTimeScoreTextFormat = "I.Y.(%d-%d)"
	fileprivate let currentMatchTimeFormat = "%d dk.\nDetay\n﹀"
	
	override func removeFromSuperview() {
		
		self.delegate = nil
		super.removeFromSuperview()
	}
	
	func setupView(matchData: BA_Matc, delegate: BA_MatchTableDelegate) {
		
		self.team1Name.text = matchData.homeTeam.teamName
		self.team2Name.text = matchData.awayTeam.teamName
		self.team1FormLeft.tintColor = matchData.homeTeam.color1
		self.team1FormRight.tintColor = matchData.homeTeam.color2
		self.team2FormLeft.tintColor = matchData.awayTeam.color1
		self.team2FormRight.tintColor = matchData.awayTeam.color2
		self.delegate = delegate
		self.matchId = matchData.matchId
		self.matchYear = matchData.matchYear
		self.matchType = matchData.matchType
		
		if(matchData.matchType == .NotPlayed) {
			
			let bet1Val: Float = (matchData.bets.count > 0) ? Float(matchData.bets[0])! : 0.0
			let bet2Val: Float = (matchData.bets.count > 1) ? Float(matchData.bets[1])! : 0.0
			let bet3Val: Float = (matchData.bets.count > 2) ? Float(matchData.bets[2])! : 0.0
			
			self.bet1.text = String(format: "%.2f", bet1Val)
			self.bet2.text = String(format: "%.2f", bet2Val)
			self.bet3.text = String(format: "%.2f", bet3Val)
			
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd'.'MM'.'yyyy'\n'HH':'mm"
			self.matchDateButton.titleLabel?.textAlignment = .center
			self.matchDateButton.setTitle(dateFormatter.string(from: matchData.matchDate!), for: UIControlState.normal)
			
		}else if(matchData.matchType == .Played) {
			
			self.homeTeamGoals.text = "\(matchData.homeGoals)"
			self.awayTeamGoals.text = "\(matchData.awayGoals)"
			
			let halfTimeScoreText = String(format: self.halfTimeScoreTextFormat, matchData.halfTimeHomeGoals, matchData.halfTimeAwayGoals)
			self.halfTimeScoreButton.setTitle(halfTimeScoreText, for: UIControlState.normal)
			
		}else if(matchData.matchType == .Playing) {
			
			self.homeTeamGoals.text = "\(matchData.homeGoals)"
			self.awayTeamGoals.text = "\(matchData.awayGoals)"
			self.currentTimeButton.titleLabel?.textAlignment = .center
			let minutesText = String(format: self.currentMatchTimeFormat, matchData.currentMinutes)
			self.currentTimeButton.setTitle(minutesText, for: UIControlState.normal)
			
		}
		
		self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureTriggered(_:)))
		self.contentView.addGestureRecognizer(self.tapGestureRecognizer!)
	}
	
	@IBAction func btnDetailTapped(_ sender: UIButton) {
		
		if(self.delegate != nil) {
			
			delegate?.matchDetailTapped(matchYear: self.matchYear, matchId: self.matchId, matchType: self.matchType!)
		}
	}
	
	@objc private func tapGestureTriggered(_ sender: UITapGestureRecognizer) {
		
		if(self.delegate != nil) {
			
			delegate?.matchDetailTapped(matchYear: self.matchYear, matchId: self.matchId, matchType: self.matchType!)
		}
	}
}
