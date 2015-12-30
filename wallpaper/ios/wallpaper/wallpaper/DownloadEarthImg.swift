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
import Photos
import AlamofireImage

class DownloadEarthImg {
    
    var now: NSTimeInterval = NSDate().timeIntervalSince1970
    
    var assetCollection: PHAssetCollection!
    var albumFound : Bool = false
    var photosAsset: PHFetchResult!
    var collection: PHAssetCollection!
    var assetCollectionPlaceholder: PHObjectPlaceholder!
    let albumName = "Earth"
    
    func stringFromTimeInterval(interval: NSTimeInterval)-> String{
        return NSString(format: "%f", interval) as String
    }
    
    func earthImg(){
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
    }
    
    func downloadEarthImg(date:Dictionary<String, String>)-> String{
        if (date["year"] != nil){
            let dateDictionary = date
            //新建相册，并获取相册路径
            self.createAlbum()
            let downloadUrl = "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/1d/550/\(dateDictionary["year"]!)/\(dateDictionary["month"]!)/\(dateDictionary["day"]!)/\(dateDictionary["hour"]!)\(dateDictionary["minute"]!)\(dateDictionary["second"]!)_0_0.png"
            Alamofire.request(.GET, downloadUrl)
                .responseImage { response in
                    debugPrint(response)
                    
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    
                    if let image = response.result.value {
                        self.saveImgInAlbum(image)
                    }
            }
            return "Success"
        }else{
            print("Get Earth Date Fail")
            return "Fail"
        }
    }
    
    func createAlbum(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title= %@", albumName)
        let collection: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject{
            self.albumFound = true
            assetCollection = collection.firstObject as! PHAssetCollection
        }else{
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAblumRequest: PHAssetCollectionChangeRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(self.albumName)
                self.assetCollectionPlaceholder = createAblumRequest.placeholderForCreatedAssetCollection
                }, completionHandler: { success, error in
                    self.albumFound = (success ? true : false)
                    
                    if(success){
                        let collectionFetchResult = PHAssetCollection.fetchAssetCollectionsWithLocalIdentifiers([self.assetCollectionPlaceholder.localIdentifier], options: nil)
                        print(collectionFetchResult)
                   self.assetCollection = collectionFetchResult.firstObject as! PHAssetCollection
                    }
            })
        }
    }
    func saveImgInAlbum(image: UIImage){
        if self.assetCollection != nil{
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                    let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                    let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
                    let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.assetCollection)
                    albumChangeRequest?.addAssets([assetPlaceholder!])
                }, completionHandler: nil)
        }
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