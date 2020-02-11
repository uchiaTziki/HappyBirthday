//
//  BaseViewModel.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {

    //MARK: - Public variables
    var nameCurrentValue: String? { return HBUserDefaults.babyName }
    var birthdayCurrentValue: Date? { return HBUserDefaults.babyBirthdayDate }
    var babyImage: UIImage? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = url.appendingPathComponent(HBConstants.Files.imageFileName)
        guard let imageData = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: imageData)
    }
    
    //MARK: - Public functions
    func imageValueChanged(withNewValue value: UIImage) {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = url.appendingPathComponent(HBConstants.Files.imageFileName)
        try? value.pngData()?.write(to: fileURL, options: .atomic)
    }
}
