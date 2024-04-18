//
//  UIImage+Ext.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni on 18/04/24.
//

import Foundation
import UIKit

extension UIImage {
    // MARK: Filter Method 
func addFilter(filter : FilterType) -> UIImage {
let filter = CIFilter(name: filter.rawValue)
// convert UIImage to CIImage and set as input
let ciInput = CIImage(image: self)
filter?.setValue(ciInput, forKey: "inputImage")
// get output CIImage, render as CGImage first to retain proper UIImage scale
let ciOutput = filter?.outputImage
let ciContext = CIContext()
let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
//Return the image
return UIImage(cgImage: cgImage!)
}
}
