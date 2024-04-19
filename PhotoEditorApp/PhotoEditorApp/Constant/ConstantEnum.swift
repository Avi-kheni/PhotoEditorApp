//
//  ConstantEnum.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni on 17/04/24.
//

import Foundation
import UIKit

enum StoryBoardEnum {
    static func getMainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
  
}

enum IdentifierName : String {
    case tabbarVC = "TabbarVC"
    case  filterXibCell = "FilterCollectionCell"
    case editVC = "EditVC"
}


enum FilterType : String , CaseIterable {
case Chrome = "CIPhotoEffectChrome"
case Fade = "CIPhotoEffectFade"
case Instant = "CIPhotoEffectInstant"
case Mono = "CIPhotoEffectMono"
case Noir = "CIPhotoEffectNoir"
case Process = "CIPhotoEffectProcess"
case Tonal = "CIPhotoEffectTonal"
case Transfer =  "CIPhotoEffectTransfer"
    
    func caseName() -> String {
           switch self {
           case .Chrome:
               return "Chrome"
           case .Fade:
               return "Fade"
           case .Instant:
               return "Instant"
           case .Mono:
               return "Mono"
           case .Noir:
               return "Noir"
           case .Process:
               return "Process"
           case .Tonal:
               return "Tonal"
           case .Transfer:
               return "Transfer"
           }
       }
}

enum BackgroundImageName : String, CaseIterable {
    case flash  = "flashBg"
    case happyHolidayBG  = "HappyHolidayBG"
    case happyHolidayOverlay  = "HappyHolidayOverlay"
    case yellowBg = "yellowBg"
    
}

public func makeImageFrom(_ desiredView: UIView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(desiredView.bounds.size, false, 0.0)
    defer { UIGraphicsEndImageContext() }
    if let context = UIGraphicsGetCurrentContext() {
        desiredView.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let writePath = documentsDir.appendingPathComponent("convertedImage.png")
        try! image!.pngData()!.write(to: writePath)
        print("Saved image to:", writePath)
        if let imageData = NSData(contentsOf: writePath) {
            let newimage = UIImage(data: imageData as Data) // Here you can attach image to UIImageView
            return newimage!
        }
        
    }
    return  UIImage.init(named: "m1")!
}



