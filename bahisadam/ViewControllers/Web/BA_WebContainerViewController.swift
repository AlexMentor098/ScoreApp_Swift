//
//  BA_WebContainerViewController.swift
//  bahisadam
//
//  Created by ilker özcan on 04/10/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

class BA_WebContainerViewController: UIViewController, UITabBarDelegate {
	
	@IBOutlet var webContainerView: UIView!
	@IBOutlet var currentTabBar: UITabBar!
	@IBOutlet var currentTabBarBottomConstraints: NSLayoutConstraint!
	@IBOutlet var currentTabBarLastTabImage: UITabBarItem!
	
	private var containerViewController: BA_WebViewController?
    private var matchDetailViewController: Match_DetailTabViewController?
	private var currentRegion: String = "tr"
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if let region = IO_Helpers.deviceLocale {
			
			self.currentRegion = region
			if(self.currentRegion == "az") {
				
				currentTabBarLastTabImage.image = UIImage(named: "league_logo_az")
				currentTabBarLastTabImage.selectedImage = UIImage(named: "league_logo_az")
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		
		self.containerViewController?.willMove(toParentViewController: nil)
		self.containerViewController?.removeFromParentViewController()
		self.containerViewController?.view.removeFromSuperview()
		self.containerViewController = nil
        
        self.matchDetailViewController?.willMove(toParentViewController: nil)
        self.matchDetailViewController?.removeFromParentViewController()
        self.matchDetailViewController?.view.removeFromSuperview()
        self.matchDetailViewController = nil
		
		super.viewDidDisappear(animated)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func embedTabView(tabView: Match_DetailTabViewController, displayTabBar: Bool, data: Dictionary<String, AnyObject>)
    {
        if(self.isViewLoaded)
        {
            self.showHideTabBar(show: displayTabBar)
            tabView.willMove(toParentViewController: self)
            self.webContainerView.addSubview(tabView.view)
            self.addChildViewController(tabView)
            tabView.didMove(toParentViewController: self)
            
            self.matchDetailViewController = tabView
            tabView.view.frame = self.view.frame
            tabView.view.layoutIfNeeded()
            
            showMatchDetailInfo(data: data)
            
        }
        else{
            
            let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
            DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
                
                self.embedTabView(tabView: tabView, displayTabBar: displayTabBar, data: data)
            })
        }
        
    }

	func embedWebview(webViewRef: BA_WebViewController, url: String, displayTabBar: Bool) {
		
		if(self.isViewLoaded) {
			
			self.showHideTabBar(show: displayTabBar)
			webViewRef.willMove(toParentViewController: self)
			self.webContainerView.addSubview(webViewRef.view)
			self.addChildViewController(webViewRef)
			webViewRef.didMove(toParentViewController: self)
		
			// keep reference of viewController which may be useful when you need to remove it from container view, lets consider you have a property name as containerViewController
			self.containerViewController = webViewRef
			webViewRef.view.frame = self.view.frame
			webViewRef.view.layoutIfNeeded()
			loadUrl(url: url)
		}else{
			
			let afterTime = DispatchTime(uptimeNanoseconds: UInt64(NSEC_PER_MSEC * 25))
			DispatchQueue.main.asyncAfter(deadline: afterTime, execute: {
				
				self.embedWebview(webViewRef: webViewRef, url: url, displayTabBar: displayTabBar)
			})
		}
	}
	
	private func showHideTabBar(show: Bool) {
		
		
		if(show) {
			
			if(currentTabBarBottomConstraints.constant != 0) {
				
				currentTabBarBottomConstraints.constant = 0
				self.webContainerView.layoutIfNeeded()
			}
		}else{
			
			let tabBarHeight = self.currentTabBar.frame.size.height
			
			if(currentTabBarBottomConstraints.constant != -tabBarHeight) {
				
				currentTabBarBottomConstraints.constant = -tabBarHeight
				self.webContainerView.layoutIfNeeded()
			}
		}
	}
	
	private func loadUrl(url: String) {
		
		guard self.containerViewController != nil else {
			return
		}
		
		self.containerViewController?.loadUrl(url: url)
	}
    
    private func showMatchDetailInfo(data: Dictionary<String, AnyObject>)
    {
        self.matchDetailViewController?.showTopBarInfo(data: data)
    }
	
	func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		
		if let navController = self.navigationController as? BA_NavigationController {
			
			navController.popToTabBarViewController(tabBarItem: item.tag)
		}
	}
	
	@IBAction func btnBackTapped(_ sender: UIBarButtonItem) {
		
		guard self.containerViewController != nil else {
			return
		}
		
		if(!self.containerViewController!.goBack()) {
			
			let _ = self.navigationController?.popViewController(animated: true)
		}
	}
}
