//
//  Statistic_ViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 10/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Statistic_ViewController: ButtonBarPagerTabStripViewController, IndicatorInfoProvider {
    
    var isReload = false
    
    let graySpotifyColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = graySpotifyColor
        settings.style.buttonBarItemBackgroundColor = graySpotifyColor
        settings.style.selectedBarBackgroundColor = UIColor(red: 33/255.0, green: 174/255.0, blue: 67/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
            newCell?.label.textColor = .black
        }
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "İstatistik")
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let childOneVC = storyboard.instantiateViewController(withIdentifier: "statisticFirstTblViewController")
        
        let child_1 = ChildExampleViewController(itemInfo: "Detay")
        let child_2 = ChildExampleViewController(itemInfo: "View1")
        let child_3 = ChildExampleViewController(itemInfo: "Kadrolar")
        
        return [childOneVC, child_2]
    }
    
    
    override func reloadPagerTabStripView() {
        isReload = true
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        }
        else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
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

}
