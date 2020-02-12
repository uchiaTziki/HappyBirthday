//
//  DetailsViewController.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {

    //MARK: - Private variables
    private var viewModel: DetailsViewModel = DetailsViewModel()
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    @IBOutlet private weak var personImageView: UIImageView!
    @IBOutlet private weak var showNextScreenButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        endEditing()
    }
    
    internal override func imageReadyFromCameraOrLibrary(image: UIImage) {
        viewModel.imageValueChanged(withNewValue: image)
    }
    
    internal override func setupUI() {
        personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        personImageView.layer.borderColor = UIColor(named: "hb_red")!.cgColor
        personImageView.layer.borderWidth = 1
        
        datePicker.maximumDate = Date()
        
        if let date = viewModel.birthdayCurrentValue { datePicker.date = date }
        updateUI()
    }
    
    //MARK: - Actions
    @IBAction private func nameValueChanged(_ sender: UITextField) {
        viewModel.nameValueChanged(withNewValue: sender.text)
    }
    
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        endEditing()
        showPhotoMethodPicker()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        viewModel.birthdayValueChanged(withNewValue: sender.date)
    }
    
    //MARK: - Private functions
    private func updateUI() {
        nameTextField.text = viewModel.nameCurrentValue
        birthdayTextField.text = viewModel.birthdayCurrentStringValue
        personImageView.image = viewModel.babyImage
    }
    
    private func endEditing() {
        view.endEditing(true)
        datePicker.alpha = 0
    }
}

//MARK: - UITextFieldDelegate
extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            return true
        default:
            endEditing()
            datePicker.alpha = 1
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}

//MARK: - DetailsViewModelDelegate
extension DetailsViewController: DetailsViewModelDelegate {
    func detailsViewModelDataUpdated(_ viewModel: DetailsViewModel) {
        updateUI()
    }
    
    func detailsViewModel(_ viewModel: DetailsViewModel, validationStateChangedTo isValid: Bool) {
        showNextScreenButton.isEnabled = isValid
    }
}
