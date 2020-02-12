//
//  UIView+Extension.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 12/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
