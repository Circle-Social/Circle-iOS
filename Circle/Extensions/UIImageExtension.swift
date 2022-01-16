//
//  UIImageExtension.swift
//  Circle
//
//  Created by Sharvil Kekre on 1/3/22.
//

import UIKit
import SwiftUI


extension UIImage {
    
    func resize(withPercentage percentage: CGFloat, isOpaque: Bool = false) -> UIImage {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
