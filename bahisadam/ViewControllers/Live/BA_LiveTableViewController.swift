//
//  BA_LiveTableViewController.swift
//  bahisadam
//
//  Created by ilker özcan on 25/09/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import MBProgressHUD
import BahisadamLive

class BA_LiveTableViewController: UITableViewController, BA_LiveTableViewCellDelegate {
	
	private var sectionCount = 0
	private var rowCounts = [Int]()
	private var allLeagueData: [BA_Leagues]?
	//private var startDate: Date?
	private var noMatchesViewIsActive = false
	private var firstDataLoaded = false
	private var progmaticallyRefresh = false
	private var isFirstLoad = true
	
    override func viewDidLoad() {
		
		self.isFirstLoad = true
		super.viewDidLoad()
		
		rowCounts.append(0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		//let tableInset = UIEdgeInsetsMake(20, 0, 0, 0)
		//self.tableView.contentInset = tableInset
		self.refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
		
		self.tableView.register(UINib(nibName: "BA_LiveHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "liveTableSectionHeaderView")
		self.tableView.register(UINib(nibName: "BA_LiveFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "liveTableSectionFooterView")
		
		self.loadData()
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		self.tabBarController?.navigationItem.title = "Canlı Sonuçlar"
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if(isFirstLoad) {
			
			isFirstLoad = false
		}else{
			
			self.progmaticallyRefresh = true
			self.tableView?.setContentOffset(CGPoint(x: 0, y: (-1 * (self.refreshControl?.frame.size.height)!)), animated: true)
			self.refreshControl?.beginRefreshing()
			self.handleRefresh(refreshControl: nil)
		}
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
		
		if(self.sectionCount == 0 && firstDataLoaded) {
			
			noMatchesViewIsActive = true
			return 1
		}else{
			noMatchesViewIsActive = false
		}
		
        return self.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		
		if(noMatchesViewIsActive) {
			
			return 1
		}
		
        return self.rowCounts[section]
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if(noMatchesViewIsActive) {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "liveScoreDoesNotHaveMatchView", for: indexPath) as! BA_NoMatchTableViewCell
			cell.setupCell()
			return cell
		}else{
			
			let leagueData = self.allLeagueData![indexPath.section]
			let matchData = leagueData.matches[indexPath.row]
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "liveScoreView", for: indexPath) as! BA_LiveTableViewCell
			cell.setupView(matchData: matchData, delegate: self)
			return cell
		}
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		if(noMatchesViewIsActive) {
			return 1.0
		}
		
		return 36.0
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		
		if(noMatchesViewIsActive) {
			return 1.0
		}
		
		return 32.0
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		if(noMatchesViewIsActive) {
			
			return nil
		}else{
			
			let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "liveTableSectionHeaderView") as! BA_LiveHeaderView
			let leagueData = self.allLeagueData![section]
			headerView.setupHeader(leagueName: leagueData.leagueName, leagueImageURL: leagueData.logoUrl)
			return headerView
		}
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		
		if(noMatchesViewIsActive) {
			
			return nil
		}else{
			
			let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "liveTableSectionFooterView") as! BA_LiveFooterView
			return footerView
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		if let headerView = view as? BA_LiveHeaderView {
			
			headerView.setupBorderMask()
		}
	}
	
	override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
		
		if let footerView = view as? BA_LiveFooterView {
			
			footerView.setupFooter()
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		if(noMatchesViewIsActive) {
			return 82.0
		}else{
			return 51.0
		}
	}
	
	private func loadData(withoutHud noHud: Bool = false) {
		
		if(!noHud) {
			
			MBProgressHUD.showAdded(to: self.view, animated: false)
		}
		
		IO_NetworkHelper(getJSONRequest: BA_Server.LiveApi, completitionHandler: { (status, data, error, statusCode) in
			
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
	
	private func configureData(data: Dictionary<String, AnyObject>) {
	
		let liveData = ConfigureLiveData(data: data)
		self.sectionCount = liveData.sectionCount
		self.rowCounts = liveData.rowCounts
		self.allLeagueData = liveData.allLeagueData
		
		firstDataLoaded = true
		self.tableView.reloadData()
	}
	
	/**
	* @TODO: implement delegate method
	*/
	func BA_LiveTableViewCellDelegate(matchTapped matchId: String, matchYear: String) {
		
		print("BA_LiveTableViewCellDelegate \(matchId) \(matchYear)")
	}
	
}
