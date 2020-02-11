//
//  DetailsViewModel.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

@objc protocol DetailsViewModelDelegate {
    func detailsViewModel(_ viewModel: DetailsViewModel, validationStateChangedTo isValid: Bool)
    func detailsViewModelDataUpdated(_ viewModel: DetailsViewModel)
}

class DetailsViewModel: BaseViewModel {

    //MARK: - Public variables
    var birthdayCurrentStringValue: String? {
        guard let date = HBUserDefaults.babyBirthdayDate else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    weak var delegate: DetailsViewModelDelegate? {
        didSet {
            checkValidation()
        }
    }
    
    //MARK: - Override functions
    override func imageValueChanged(withNewValue value: UIImage) {
        super.imageValueChanged(withNewValue: value)
        delegate?.detailsViewModelDataUpdated(self)
    }
    
    //MARK: - Public functions
    func nameValueChanged(withNewValue value: String?) {
        HBUserDefaults.babyName = value
        checkValidation()
    }
    
    func birthdayValueChanged(withNewValue value: Date?) {
        HBUserDefaults.babyBirthdayDate = value
        delegate?.detailsViewModelDataUpdated(self)
        checkValidation()
    }
    
    //MARK: - Private functions
    private func checkValidation() {
        let isValid = (HBUserDefaults.babyName?.count ?? 0) > 0 && HBUserDefaults.babyBirthdayDate != nil
        delegate?.detailsViewModel(self, validationStateChangedTo: isValid)
    }
}