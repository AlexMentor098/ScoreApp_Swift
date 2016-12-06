//
//  BA_NavigationController.swift
//  bahisadam
//
//  Created by ilker özcan on 23/09/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import MBProgressHUD
import BahisadamLive

class BA_NavigationController: UINavigationController {

	private var currentLoadedWebView: BA_WebViewController?
    private var currentMatchedDetailView: Match_DetailTabViewController?
	private var lastWebviewUrl: String?
    var matchDetailView: Bool = false
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.currentLoadedWebView = self.storyboard?.instantiateViewController(withIdentifier: "BA_WebViewController") as? BA_WebViewController
        self.currentMatchedDetailView = self.storyboard?.instantiateViewController(withIdentifier: "Match_DetailTabViewController") as? Match_DetailTabViewController
		
		if(self.currentLoadedWebView != nil) {
			
			self.currentLoadedWebView!.loadWebview()
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		NotificationCenter.default.addObserver(self, selector: #selector(openRootViewController(sender:)), name: BA_AppConstants.OpenRootVCNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(openWebVCFromWidget(sender:)), name: BA_AppConstants.OpenWebVCNotification, object: nil)
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		
		NotificationCenter.default.removeObserver(self, name: BA_AppConstants.OpenRootVCNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: BA_AppConstants.OpenWebVCNotification, object: nil)
		super.viewWillDisappear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
		super.viewDidAppear(animated)
		
		if(!UserDefaults.standard.bool(forKey: "com.bahisadam.bahisadam.tutorialViewDisplayed")) {
			
			let tutorialStoryboard = UIStoryboard(name: "BA_TutorialView", bundle: nil)
			if let tutorialViewController = tutorialStoryboard.instantiateViewController(withIdentifier: "BA_tutorialViewController") as? BA_TutorialViewController {
				
				UserDefaults.standard.set(true, forKey: "com.bahisadam.bahisadam.tutorialViewDisplayed")
				let _ = UserDefaults.standard.synchronize()
				tutorialViewController.currentStoryboard = tutorialStoryboard
				tutorialViewController.navigationView = self.view
				tutorialViewController.BA_presentTutorialViewController(viewControllerToPresent: tutorialViewController, navigationViewController: self)
				
			}
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
	*/
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		if let segueId = segue.identifier {
			
			if(segueId == "showWebviewVC" && self.currentLoadedWebView != nil && self.matchDetailView == false) {
				
				if let webViewVC = segue.destination as? BA_WebContainerViewController {
					
					webViewVC.embedWebview(webViewRef: self.currentLoadedWebView!, url: self.lastWebviewUrl!, displayTabBar: true)
				}
			}
            
            
            if(segueId == "showWebviewVC" && self.currentMatchedDetailView != nil && self.matchDetailView == true) {
                
                if let webViewVC = segue.destination as? BA_WebContainerViewController {
                    
                    self.getMatchDetailInfo(webView: webViewVC)

                    
                }
            }
		}
    }
    
    
    private func getMatchDetailInfo(withoutHud noHud: Bool = false, webView: BA_WebContainerViewController) {
        
        if(!noHud) {
            
            MBProgressHUD.showAdded(to: self.view, animated: false)
        }
        
        
        let urlString = self.lastWebviewUrl
        
        IO_NetworkHelper(getJSONRequest: urlString!, completitionHandler: { (status, data, error, statusCode) in
            
            if(status) {
                
                if let dataDict = data as? Dictionary<String, AnyObject> {
                    
                    Shared.shared.matchDetail = dataDict
                    self.GetStandingInfo()
                    self.GetGoalInfo()
                    webView.embedTabView(tabView: self.currentMatchedDetailView!, displayTabBar: true, data: dataDict)
                    
                }
            }
            
            if(!noHud) {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: false)
            }
        })
    }
    
    func GetStandingInfo()
    {
        if let dataObject = Shared.shared.matchDetail["league_id"] as? Dictionary<String, AnyObject>{
            let standingUrl = String(format: BA_Server.StandingApi, dataObject["_id"] as! NSNumber)
            
            IO_NetworkHelper(getJSONRequest: standingUrl, completitionHandler: { (status, data, error, statusCode) in
                
                if(status) {
                    
                    if let dataDict = data as? Dictionary<String, AnyObject> {
                        Shared.shared.standingInfo = dataDict
                    }
                }
                
            })
            
        }
    }
    
    func GetGoalInfo()
    {
        if let dataObject = Shared.shared.matchDetail["league_id"] as? Dictionary<String, AnyObject>{
            let standingUrl = String(format: BA_Server.GoalAverageApi, dataObject["_id"] as! NSNumber)
            
            IO_NetworkHelper(getJSONRequest: standingUrl, completitionHandler: { (status, data, error, statusCode) in
                
                if(status) {
                    
                    if let dataDict = data as? Dictionary<String, AnyObject> {
                        Shared.shared.goalAverageInfo = dataDict
                    }
                }
                
            })
            
        }
    }
    
//    private func configureData(data: Dictionary<String, AnyObject>) {
//        
//        if let dataObject = data["stadium"] as? Dictionary<String, AnyObject> {
//            
//            var leagues: [UnsafeMutablePointer<BA_Leagues>] = [UnsafeMutablePointer<BA_Leagues>]()
//        }
//        
//    }
	
	func popToTabBarViewController(tabBarItem: Int) {
		
		let _ = self.popViewController(animated: false)
		
		if let tabBarVC = self.viewControllers[0] as? BA_TabBarViewController {
			
			tabBarVC.selectedIndex = tabBarItem
		}
	}

	func openWebView(withUrl url: String) {
		
		self.lastWebviewUrl = url
		self.performSegue(withIdentifier: "showWebviewVC", sender: self)
	}
	
	func getLoadedWebview() -> BA_WebViewController? {
		
		return self.currentLoadedWebView
	}
	
	func openRootViewController(sender: NSNotification?) {
		
		if let senderData = sender {
			
			if let userInfo = senderData.userInfo {
				
				if let tabItem = userInfo["selectedTab"] as? Int {
					
					self.popToTabBarViewController(tabBarItem: tabItem)
				}
			}
		}
	}
	
	func openWebVCFromWidget(sender: NSNotification?) {
		
		if let senderData = sender {
			
			if let userInfo = senderData.userInfo {
				
				let matchYear = userInfo["matchYear"] as! Int
				let matchId = userInfo["matchId"] as! String
				let urlString = String(format: BA_Server.MatchApi, matchYear, matchId)
				openWebView(withUrl: urlString)
			}
		}
	}
}
