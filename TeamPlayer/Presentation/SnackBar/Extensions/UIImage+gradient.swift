//
//  UIImage+gradient.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 21.04.2024.
//

import UIKit

extension UIImage {
    static func gImage(frame: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.6)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.6)
        
        let render = UIGraphicsImageRenderer(bounds: frame)
        
        return render.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
