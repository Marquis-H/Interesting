//
//  TodayViewController.swift
//  Earth
//
//  Created by marquis on 15/12/24.
//  Copyright © 2015年 marquis. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var earthControl: UISegmentedControl!
    
    var downloadEarthImg = DownloadEarthImg()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        print("# of Segments = \(earthControl.selectedSegmentIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func earthControlAction(sender: UISegmentedControl) {
        switch earthControl.selectedSegmentIndex{
            case 0:
                timer = NSTimer.scheduledTimerWithTimeInterval(1200, target: self, selector: "earthImg", userInfo: nil, repeats: true)
                break
            case 1:
                timer.invalidate()
                break
            default:
                break
        }
        
    }
    
    func earthImg(){
        downloadEarthImg.earthImg()
    }
}
