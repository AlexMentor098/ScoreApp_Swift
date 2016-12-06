//
//  Constants.swift
//  bahisadam
//
//  Created by ilker özcan on 21/09/16.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import Foundation

public struct BA_Server {

	private static let BaseUrl = "http://www.bahisadam.com"
	public static let StaticBaseUrl = "http://static.bahisadam.com"
	
	public static let InitialWebviewUrl = BaseUrl + "/bahisadam-ios"
	public static let MatchesApi = BaseUrl + "/api/matches/%@/%@/500"
    public static let GoalAverageApi = BaseUrl + "/api/standings/homeaway/%@"
    public static let StandingApi = BaseUrl + "/api/standings/%@"
	public static let MatchApi = "/futbol/lig/lig-ios/%d-sezonu/t1-vs-t2/mac-detayi?match_id=%@"
	public static let MatchStatsApi = "/futbol/lig/lig-ios/%d-sezonu/t1-vs-t2/istatistikler?match_id=%@"
	public static let LiveApi = BaseUrl + "/api/live-scores"
	public static let PointsApi = "/lig/stsl-superlig/puan-durumu?league_id=1"
	public static let PointsApi_AZ = "/lig/stsl-superlig/puan-durumu?league_id=81"
	public static let StatsApi = BaseUrl + "/api/league/list"
	public static let StatsDetail = "/lig/lig-ios/ios-istatistikler?league_id=%d"
	public static let PointsDetail = "/lig/lig-ios/puan-durumu?league_id=%d"
	public static let RegisterForPushes = BaseUrl + "/ios/registerforpushes"
    public static let MatchDetailApi = BaseUrl + "/api/match/detail/%@"
    public static let GetImageUrlApi = StaticBaseUrl + "%@"
}
