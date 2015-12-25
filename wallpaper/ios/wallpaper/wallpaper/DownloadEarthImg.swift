//
//  DownloadEarthImg.swift
//  wallpaper
//
//  Created by marquis on 15/12/24.
//  Copyright © 2015年 marquis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DownloadEarthImg {
    
    var now: NSTimeInterval = NSDate().timeIntervalSince1970
    
    func stringFromTimeInterval(interval: NSTimeInterval)-> String{
        return NSString(format: "%f", interval) as String
    }
    
    func earthImg()-> String{
        let jsonUrl:String = "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/latest.json?uid="+stringFromTimeInterval(now)
        var dateDictionary = Dictionary<String, String>()
        Alamofire.request(.GET, jsonUrl)
            .responseJSON { response in
                var json = JSON(response.result.value!)
                var date:String
                date = json["date"].stringValue
                dateDictionary = [
                    "year": date[0...3],
                    "month": date[5...6],
                    "day": date[8...9],
                    "hour": date[11...12],
                    "minute": date[14...15],
                    "second": date[17...18]
                ]
                //dowmload
                self.downloadEarthImg(dateDictionary)
            }
        return "Download..."
    }
    
    func downloadEarthImg(date:Dictionary<String, String>)-> String{
        if (date["year"] != nil){
            let dateDictionary = date
            //新建相册，并获取相册路径

            let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
            let downloadUrl = "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/1d/550/\(dateDictionary["year"]!)/\(dateDictionary["month"]!)/\(dateDictionary["day"]!)/\(dateDictionary["hour"]!)\(dateDictionary["minute"]!)\(dateDictionary["second"]!)_0_0.png"
            Alamofire.download(.GET, downloadUrl, destination: destination)
                .response{  _, _, _, error in
                    if let error = error {
                        print("Failed with error: \(error)")
                    } else {
                        print("Downloaded file successfully")
                        self.saveImgInAlbum("\(dateDictionary["hour"]!)\(dateDictionary["minute"]!)\(dateDictionary["second"]!)_0_0.png")
                    }
                }
            return "Success"
        }else{
            print("Get Earth Date Fail:\(date["year"])")
            return "Fail"
        }
    }
    
    func saveImgInAlbum(ImgName:String){
        
    }
    
}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}