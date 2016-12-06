//
//  BA_TabBarViewController.swift
//  bahisadam
//
//  Created by ilker özcan on 26/09/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import BahisadamLive

class BA_TabBarViewController: UITabBarController {

	fileprivate let webviewIdx = 5
	private var currentRegion: String = "tr"
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if let region = IO_Helpers.deviceLocale {
			
			self.currentRegion = region
			if(self.currentRegion == "az") {
				
				if let currentTabBarLastTabImage = self.tabBar.items?[4] {
					
					currentTabBarLastTabImage.image = UIImage(named: "league_logo_az")
					currentTabBarLastTabImage.selectedImage = UIImage(named: "league_logo_az")
				}
			}
		}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		
		if(item.tag == webviewIdx) {
			
			if let baNavController =  self.navigationController as? BA_NavigationController {
				
				if let loadedWebviewRef = baNavController.getLoadedWebview() {
					
					if let webViewVC = self.viewControllers?.last as? BA_WebContainerViewController {
						
						if(currentRegion == "az") {
							
							webViewVC.embedWebview(webViewRef: loadedWebviewRef, url: BA_Server.PointsApi_AZ, displayTabBar: false)
							self.navigationItem.title = "Azerbeycan Premier Lig"
						}else{
							
							webViewVC.embedWebview(webViewRef: loadedWebviewRef, url: BA_Server.PointsApi, displayTabBar: false)
							self.navigationItem.title = "Türkiye Süper Ligi"
						}
					}
				}
			}
		}
	}
	
	
}
