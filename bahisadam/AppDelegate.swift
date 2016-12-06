//
//  AppDelegate.swift
//  bahisadam
//
//  Created by ilker özcan on 19/07/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import BahisadamLive
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		IO_NetworkHelper.deviceIsConnectedToInternet { (status) in
		
			if(!status) {
				
				let alertMessage = IO_Helpers.getErrorMessageFromCode(9002)
				let alertview = UIAlertView(title: alertMessage.0, message: alertMessage.1, delegate: nil, cancelButtonTitle: alertMessage.2)
				alertview.show()
			}
		}
		Fabric.with([Crashlytics.self])

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		
		if #available(iOS 10.0, *) {
			
			UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (granted, error) in
				// Do something here
			}
			application.registerForRemoteNotifications()
			
		}else{
		
			self.registerForPushes()
		}
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}

	func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
		
		if let urlHost = url.host {
			
			if(urlHost == "openLiveTab") {
				
				NotificationCenter.default.post(name: BA_AppConstants.OpenRootVCNotification, object: nil, userInfo: ["selectedTab": 2])
				
			}else if(urlHost == "openMatchDetail") {
				
				let matchYear = Int(url.pathComponents[1])
				let matchId = url.pathComponents[2]
				
				NotificationCenter.default.post(name: BA_AppConstants.OpenWebVCNotification, object: nil, userInfo: ["matchYear": matchYear ?? 2016, "matchId": matchId])
			}
		}
		
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		
		let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
		let deviceTokenTrimmed = deviceTokenString.trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
		let deviceTokenReplaced = deviceTokenTrimmed.replacingOccurrences(of: " ", with: "")
			
		#if DEBUG
			print("Device token string: \(deviceTokenString) \n trimmed: \(deviceTokenTrimmed) \n replaced \(deviceTokenReplaced)\n")
		#endif
		
		var postData = Dictionary<String, AnyObject>()
		postData["deviceToken"] = deviceTokenReplaced as AnyObject
		postData["bundleId"] = IO_Helpers.bundleID as AnyObject
		postData["appVersion"] = IO_Helpers.applicationVersion as AnyObject
		postData["deviceName"] = IO_Helpers.deviceName as AnyObject
		postData["devicModel"] = IO_Helpers.devicModel as AnyObject
		postData["deviceVersion"] = IO_Helpers.deviceVersion as AnyObject
		postData["deviceOS"] = IO_Helpers.deviceOS as AnyObject
		postData["deviceId"] = IO_Helpers.deviceUUID as AnyObject
		
		IO_NetworkHelper(postJSONRequest: BA_Server.RegisterForPushes, postData: postData) { (status, data, error, responseCode) in
			
			// pass
			#if DEBUG
			print("Register for pushes status \(status) \(responseCode)")
			#endif
		}
	}
	
	func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
		//register to receive notifications
		application.registerForRemoteNotifications()
	}
	
	func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
		// Tells the app delegate to perform the custom action specified by a push notification.
		if(identifier == "declineAction")
		{
			// pass
		}else if(identifier == "answerAction") {
			
			// pass
		}
	}
	
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		// Sent to the delegate when Apple Push Service cannot successfully complete the registration process.
		print("Failed to get token, error: \(error.localizedDescription)")
	}
	
	internal func registerForPushes() {
			
		// register device for apple remote push notification service
		let userNotificationSettings = UIUserNotificationSettings(types: [UIUserNotificationType.badge, UIUserNotificationType.alert], categories: nil)
		UIApplication.shared.registerUserNotificationSettings(userNotificationSettings)
	}
}

