//
//  Match_DetailRealTabViewController.swift
//  bahisadam
//
//  Created by GreenRose926 on 09/11/2016.
//  Copyright © 2016 ilkerozcan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Match_DetailRealTabViewController: ButtonBarPagerTabStripViewController {
    
    var isReload = false
    
    let graySpotifyColor = UIColor(red: 0/255.0, green: 103/255.0, blue: 102/255.0, alpha: 1.0)
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
            newCell?.label.textColor = .white
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
// 
//        let child_1 = ChildExampleViewController(itemInfo: "Detay")
//        let child_2 = ChildExampleViewController(itemInfo: "View1")
//        let child_3 = ChildExampleViewController(itemInfo: "Kadrolar")
//        let child_4 = ChildExampleViewController(itemInfo: "İstatistik")
//        let child_5 = ChildExampleViewController(itemInfo: "İddaa")
//        
//        
//        
//        return [Detay_TestViewController(), child_2, child_3, child_4, child_5]
//        
//        guard isReload else {
//            return [child_1, child_2, child_3, child_4, child_5]
//        }
//        
//        var childViewControllers = [child_1, child_2, child_3, child_4, child_5]
//        
//        for (index, _) in childViewControllers.enumerated(){
//            let nElements = childViewControllers.count - index
//            let n = (Int(arc4random()) % nElements) + index
//            if n != index{
//                swap(&childViewControllers[index], &childViewControllers[n])
//            }
//        }
//        let nItems = 1 + (arc4random() % 5)
//        return Array(childViewControllers.prefix(Int(nItems)))
//    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let childOneVC = storyboard.instantiateViewController(withIdentifier: "childOneVC")
        let childTwoVC = storyboard.instantiateViewController(withIdentifier: "childTwoVC")
        let childThreeVC = storyboard.instantiateViewController(withIdentifier: "Kadrolar")
        let childFourVC = storyboard.instantiateViewController(withIdentifier: "childFourVC")
        let childFiveVC = storyboard.instantiateViewController(withIdentifier: "childFiveVC")
        return [childOneVC, childTwoVC, childThreeVC, childFourVC, childFiveVC]
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
