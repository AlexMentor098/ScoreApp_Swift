//
//  BA_MatchListCollectionViewController.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import MBProgressHUD
import BahisadamLive

fileprivate let reuseIdentifierPlayedCell = "matchCellPlayed"
fileprivate let reuseIdentifierPlayingdCell = "matchCellPlaying"
fileprivate let reuseIdentifierdCell = "matchCell"
fileprivate let resueIdentifierHeaderView = "matchListHeaderView"
fileprivate let resueIdentifierFooterView = "matchListFooterView"

class BA_MatchListCollectionViewController: UICollectionViewController, BA_MatchTableDelegate {

	private var sectionCount = 0
	private var rowCounts = [Int]()
	private var allLeagueData: [BA_Leagues]?
	private var startDate: Date?
	private var refreshControl: UIRefreshControl?
	private var progmaticallyRefresh = false
	private var isFirstLoad = true
	
    override func viewDidLoad() {
		
		self.isFirstLoad = true
		super.viewDidLoad()
		
		rowCounts.append(0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
		
		self.refreshControl = UIRefreshControl()
		refreshControl?.tintColor = UIColor.gray
		refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
		self.collectionView?.addSubview(refreshControl!)
		self.collectionView?.alwaysBounceVertical = true
	
		self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		self.tabBarController?.navigationItem.title = ""
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if(isFirstLoad) {
			
			isFirstLoad = false
		}else{
			
			self.progmaticallyRefresh = true
			self.collectionView?.setContentOffset(CGPoint(x: 0, y: (-1 * (self.refreshControl?.frame.size.height)!)), animated: true)
			self.refreshControl?.beginRefreshing()
			self.handleRefresh(refreshControl: nil)
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sectionCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.rowCounts[section]
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let leagueData = self.allLeagueData![indexPath.section]
		let matchData = leagueData.matches[indexPath.row]
		
		let cell: BA_MatchListCollectionViewCell
		if(matchData.matchType == .Played) {
			
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPlayedCell, for: indexPath) as! BA_MatchListCollectionViewCell
		}else if(matchData.matchType == .Playing) {
			
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierPlayingdCell, for: indexPath) as! BA_MatchListCollectionViewCell
		}else{
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierdCell, for: indexPath) as! BA_MatchListCollectionViewCell
		}
    
        // Configure the cell
		cell.setupView(matchData: matchData, delegate: self)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
		case UICollectionElementKindSectionHeader:
			
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resueIdentifierHeaderView, for: indexPath) as! BA_MatchListHeaderCollectionReusableView
			let leagueData = self.allLeagueData![indexPath.section]
			headerView.setupHeader(leagueId: leagueData.leagueId, leagueName: leagueData.leagueName, leagueImageURL: leagueData.logoUrl, delegate: self)
			return headerView
		case UICollectionElementKindSectionFooter:
			
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resueIdentifierFooterView, for: indexPath) as! BA_MatchListFooterCollectionReusableView
			return footerView
		default:
			abort()
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
		
		switch elementKind {
		case UICollectionElementKindSectionHeader:
			
			if let headerView = view as? BA_MatchListHeaderCollectionReusableView {
				
				headerView.setupCorners()
			}
			break
		case UICollectionElementKindSectionFooter:
			
			if let footerView = view as? BA_MatchListFooterCollectionReusableView {
				
				footerView.setupCorners()
			}
			
			break
		default:
			assert(false, "Unexpected element kind")
		}
	}
	
	private func loadData(withoutHud noHud: Bool = false) {
		
		if(!noHud) {
			
			MBProgressHUD.showAdded(to: self.view, animated: false)
		}
		
		let currentStartDate = BA_getStartDate(date: startDate)
		let startDateStr = BA_DateFormat(date: currentStartDate)
		
		// + 24 hours
		let endDate = currentStartDate.addingTimeInterval(86400)
		let endDateStr = BA_DateFormat(date: endDate)
		let urlString = String(format: BA_Server.MatchesApi, startDateStr!, endDateStr!)
		
		IO_NetworkHelper(getJSONRequest: urlString, completitionHandler: { (status, data, error, statusCode) in
			
			if(status) {
				
				if let dataDict = data as? Dictionary<String, AnyObject> {
					
					if(self.progmaticallyRefresh) {
						
						self.refreshControl?.endRefreshing()
					}
					self.configureData(data: dataDict)
				}
			}
			
			if(!noHud) {
				MBProgressHUD.hideAllHUDs(for: self.view, animated: false)
			}else{
				self.refreshControl?.endRefreshing()
			}
		})
	}
	
	public func handleRefresh(refreshControl: UIRefreshControl?) {
		
		self.loadData(withoutHud: true)
	}
	
	func changeDate(startDate: Date) {
		
		self.startDate = startDate
		self.loadData()
	}
	
	func leagueDetailTapped(leagueId: Int) {
		
		
		if let baNavController =  self.tabBarController?.navigationController as? BA_NavigationController {
			
			let leagueDetailUrl = String(format: BA_Server.PointsDetail, leagueId)
			baNavController.openWebView(withUrl: leagueDetailUrl)
		}
	}
	
	func matchDetailTapped(matchYear: Int, matchId: String, matchType: BA_Matc.MATCH_TYPES) {
		
		if let baNavController =  self.tabBarController?.navigationController as? BA_NavigationController {
			
			let matchDetailUrl: String
			if(matchType == .Played || matchType == .Playing) {
				
				matchDetailUrl = String(format: BA_Server.MatchStatsApi, matchYear, matchId)
			}else{
				matchDetailUrl = String(format: BA_Server.MatchApi, matchYear, matchId)
			}
            
//            matchDetailUrl = String(format: BA_Server.MatchDetailApi, matchId)
//            baNavController.matchDetailView = true;
			baNavController.openWebView(withUrl: matchDetailUrl)
		}
	}

	private func configureData(data: Dictionary<String, AnyObject>) {
		
		if let dataObject = data["data"] as? Dictionary<String, AnyObject> {
			
			if let matches = dataObject["matches"] as? [Dictionary<String, AnyObject>] {
				
				var leagues: [UnsafeMutablePointer<BA_Leagues>] = [UnsafeMutablePointer<BA_Leagues>]()
				
				for match in matches  {
					
					if let leagueData = match["league_id"] as? Dictionary<String, AnyObject> {
						
						let leagueId = leagueData["_id"] as? Int ?? 0
						let leagueDataIndex = leagues.index { (data) -> Bool in
							
							if(data.pointee.leagueId == leagueId) {
								
								return true
							}else{
								return false
							}
						}
						
						let leagueDataPointerPP: UnsafeMutablePointer<BA_Leagues>
						if(leagueDataIndex != nil) {
							
							leagueDataPointerPP = leagues[leagueDataIndex!]
						}else{
							let leagueOrder = leagueData["order"] as? Int ?? 0
							let leagueName = leagueData["league_name_tr"] as? String ?? ""
							let newLeague = BA_Leagues(leagueName: leagueName, leagueId: leagueId, leagueOrder: leagueOrder)
							leagueDataPointerPP = UnsafeMutablePointer<BA_Leagues>.allocate(capacity: MemoryLayout<BA_Leagues>.size)
							leagueDataPointerPP.initialize(to: newLeague)
							leagues.append(leagueDataPointerPP)
						}
						
						let homeTeamData: BA_Team
						if let homeTeam = match["home_team"] as? Dictionary<String, AnyObject> {
							
							let teamName = homeTeam["team_name_tr"] as? String ?? ""
							let teamId = homeTeam["id"] as? Int ?? 0
							let color1 = homeTeam["color1"] as? String ?? ""
							let color2 = homeTeam["color2"] as? String ?? ""
							
							homeTeamData = BA_Team(teamName: teamName, teamId: teamId, color1: color1, color2: color2)
							
						}else{
							homeTeamData = BA_Team(teamName: "", teamId: 0, color1: "", color2: "")
						}
						
						let awayTeamData: BA_Team
						if let awayTeam = match["away_team"] as? Dictionary<String, AnyObject> {
							
							let teamName = awayTeam["team_name_tr"] as? String ?? ""
							let teamId = awayTeam["id"] as? Int ?? 0
							let color1 = awayTeam["color1"] as? String ?? ""
							let color2 = awayTeam["color2"] as? String ?? ""
							
							awayTeamData = BA_Team(teamName: teamName, teamId: teamId, color1: color1, color2: color2)
							
						}else{
							awayTeamData = BA_Team(teamName: "", teamId: 0, color1: "", color2: "")
						}
						
						let matchDate = match["match_date"] as? String ?? BA_DateFormat(date: nil)
						var bets = [String]()
						if let odds = match["odds"] as? Dictionary<String, AnyObject> {
							
							if let iddaa = odds["iddaa"] as? Dictionary<String, AnyObject> {
								
								if let tx1 = iddaa["1"] as? String {
									
									bets.append(tx1)
									
								}else if let tx1 = iddaa["1"] as? Float {
									
									bets.append("\(tx1)")
									
								}else if let tx1 = iddaa["1"] as? Int {
									
									bets.append("\(tx1)")
								}
								
								if let tx2 = iddaa["X"] as? String {
									
									bets.append(tx2)
								}else if let tx2 = iddaa["X"] as? Float {
									
									bets.append("\(tx2)")
									
								}else if let tx2 = iddaa["X"] as? Int {
									
									bets.append("\(tx2)")
								}
								
								if let tx3 = iddaa["2"] as? String {
									
									bets.append(tx3)
									
								}else if let tx3 = iddaa["2"] as? Float {
									
									bets.append("\(tx3)")
									
								}else if let tx3 = iddaa["2"] as? Int {
									
									bets.append("\(tx3)")
								}
							}
						}
						
						let resultType = match["result_type"] as? String ?? "NotPlayed"
						let homeGoals = match["home_goals"] as? Int ?? 0
						let awayGoals = match["away_goals"] as? Int ?? 0
						let matchId = match["_id"] as? String ?? ""
						let matchYear = match["year"] as? Int ?? 2017
						let halfTimeHomeGoals = match["half_time_home_score"] as? Int ?? 0
						let halfTimeAwayGoals = match["half_time_away_score"] as? Int ?? 0
						let currentMinutes = match["live_minute"] as? Int ?? 0
						let matchData = BA_Matc(homeTeam: homeTeamData, awayTeam: awayTeamData, matchDateStr: matchDate!, bets: bets, resultType: resultType, homeGoals: homeGoals, awayGoals: awayGoals, matchId: matchId, matchYear: matchYear, halfTimeHomeGoals: halfTimeHomeGoals, halfTimeAwayGoals: halfTimeAwayGoals, currentMinutes: currentMinutes)
						
						leagueDataPointerPP.pointee.addMatch(match: matchData)
					}
				}
				
				let sortedLeagueData = leagues.sorted { (d1, d2) -> Bool in
					
					if(d1.pointee.leagueOrder < d2.pointee.leagueOrder) {
						return true
					}else{
						return false
					}
				}
				
				self.allLeagueData = sortedLeagueData.map({ (league) -> BA_Leagues in
					
					let leagueMapped = league.pointee
					
					defer {
						league.deallocate(capacity: MemoryLayout<BA_Leagues>.size)
						league.deinitialize()
					}
					
					return leagueMapped
				})
				
				
				self.sectionCount = self.allLeagueData!.count
				self.rowCounts = [Int]()
				
				for leagueData in self.allLeagueData! {
					
					self.rowCounts.append(leagueData.matches.count)
				}
				
				self.collectionView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
				self.collectionView?.reloadData()
			}
		}
	}
}
