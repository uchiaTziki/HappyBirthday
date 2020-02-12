//
//  MainViewController.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    //MARK: - Private variables
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var sharableView: UIView!
    @IBOutlet private weak var logoImageView: UIImageView!
    private var viewModel: HomeViewModel = HomeViewModel()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal override func imageReadyFromCameraOrLibrary(image: UIImage) {
        viewModel.imageValueChanged(withNewValue: image)
    }
    
    internal override func setupUI() {
        super.setupUI()
        view.backgroundColor = viewModel.backgroundColor()
        sharableView.backgroundColor = view.backgroundColor
        backgroundImageView.image = viewModel.backgroundImage()
        titleLabel.text = viewModel.titleText()
        cameraButton.setImage(viewModel.cameraImage(), for: .normal)
        
        mainImageView.layer.borderWidth = 5
        mainImageView.layer.borderColor = viewModel.darkColor().cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.size.width / 2
        
        switch viewModel.logoLocation() {
        case .left:
            NSLayoutConstraint.activate([logoImageView.leadingAnchor.constraint(equalTo: sharableView.leadingAnchor, constant: HBConstants.UI.defaultPadding)])
        case .right:
            NSLayoutConstraint.activate([logoImageView.trailingAnchor.constraint(equalTo: sharableView.trailingAnchor, constant: -HBConstants.UI.defaultPadding)])
        case .middle:
            NSLayoutConstraint.activate([logoImageView.centerXAnchor.constraint(equalTo: sharableView.centerXAnchor)])
        }
        
        updateUI()
    }
    
    //MARK: - Action functions
    @IBAction private func cameraButtonTapped(_ sender: UIButton) {
        showPhotoMethodPicker()
    }
    
    @IBAction private func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private functions
    private func updateUI() {
        mainImageView.image = viewModel.babyImage
    }
}
