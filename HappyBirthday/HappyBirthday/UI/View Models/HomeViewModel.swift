//
//  HomeViewModel.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

enum HomeVariant: Int {
    case green = 0
    case blue = 1
    case yellow = 2
    
    //MARK: - Public functions
    func suffix() -> String {
        switch self {
        case .blue:
            return "blue"
        case .green:
            return "green"
        case .yellow:
            return "yellow"
        }
    }
}

enum IconLocation: Int {
    case middle = 0
    case left = 1
    case right = 2
}

class HomeViewModel: BaseViewModel {

    //MARK: - Override variables
    override var babyImage: UIImage? {
        if let image = super.babyImage { return image }
        else { return UIImage(named: "hb_placeholder_\(variant.suffix())")! }
    }
    
    //MARK: - Private variables
    private let variant: HomeVariant = HomeVariant(rawValue: Int.random(in: 0...2))!
    
    //MARK: - Public functions
    func logoLocation() -> IconLocation {
        switch variant {
        case .blue:
            return .left
        case .green:
            return .middle
        case .yellow:
            return .right
        }
    }
    
    func backgroundColor() -> UIColor {
        return UIColor(named: "hb_\(variant.suffix())")!
    }
    
    func darkColor() -> UIColor {
        return UIColor(named: "hb_dark_\(variant.suffix())")!
    }
    
    func backgroundImage() -> UIImage {
        return UIImage(named: "hb_background_image_\(variant.suffix())")!
    }
    
    func titleText() -> String {
        return "Today \(nameCurrentValue ?? String()) is".uppercased()
    }
    
    func cameraImage() -> UIImage {
        return UIImage(named: "hb_camera_\(variant.suffix())")!
    }
}
