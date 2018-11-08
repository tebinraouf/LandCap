//
//  Extensions.swift
//  LandCapApp
//
//  Created by Tebin on 9/10/18.
//  Copyright © 2018 Tebin. All rights reserved.
//

import Foundation
import UIKit

///UIColor utility extension
public extension UIColor {
    
    ///convenience initializer
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    ///App mainColor
    public class var mainColor: UIColor {
        return UIColor(r: 33, g: 147, b: 176, a: 1)
    }
    
    ///App secondary color
    public class var secondaryColor: UIColor {
        return UIColor(r: 109, g: 213, b: 237, a: 1)
    }
    
    ///App text color
    public class var textColor: UIColor {
        return .white
    }
    
    ///App black color
    public class var blackColor: UIColor {
        return .black
    }
    
    ///App white color
    public class var whiteColor: UIColor {
        return .white
    }
    
    ///App main light gray color
    public class var mainLightGray: UIColor {
        return UIColor(r: 245, g: 245, b: 245, a: 1)
    }
}

///UIImage utility extension
extension UIImage {
    
    ///Crop an image by size
    /// - Parameter width: image width
    /// - Parameter height: image height
    ///
    /// - Returns: a new `UIImage` image
    func cropToBounds(width: Double, height: Double) -> UIImage {
        
        let cgimage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
    ///Resize an image by width
    /// - Parameter width: the total image width
    ///
    /// - Returns: a new `UIImage` image
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
