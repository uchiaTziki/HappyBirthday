//
//  DetailsViewModel.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

@objc protocol DetailsViewModelDelegate: BaseViewModelDelegate {
    func detailsViewModel(_ viewModel: DetailsViewModel, validationStateChangedTo isValid: Bool)
}

class DetailsViewModel: BaseViewModel {

    //MARK: - Public variables
    var birthdayCurrentStringValue: String? {
        guard let date = HBUserDefaults.babyBirthdayDate else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    override weak var delegate: BaseViewModelDelegate? {
        didSet {
            checkValidation()
        }
    }

    //MARK: - Public functions
    func nameValueChanged(withNewValue value: String?) {
        HBUserDefaults.babyName = value
        checkValidation()
    }
    
    func birthdayValueChanged(withNewValue value: Date?) {
        HBUserDefaults.babyBirthdayDate = value
        NotificationCenter.default.post(name: .baseViewModelShouldUpdateDataNotification, object: nil)
        checkValidation()
    }
    
    //MARK: - Private functions
    private func checkValidation() {
        let isValid = (HBUserDefaults.babyName?.count ?? 0) > 0 && HBUserDefaults.babyBirthdayDate != nil
        (delegate as? DetailsViewModelDelegate)?.detailsViewModel(self, validationStateChangedTo: isValid)
    }
}
