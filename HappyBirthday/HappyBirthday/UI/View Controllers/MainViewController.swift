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
    private var homeViewModel: MainViewModel { return viewModel as! MainViewModel }
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var sharableView: UIView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var numberImageView: UIImageView!
    @IBOutlet private weak var numberDescriptionLabel: UILabel!
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal override func imageReadyFromCameraOrLibrary(image: UIImage) {
        homeViewModel.imageValueChanged(withNewValue: image)
    }
    
    internal override func setupUI() {
        super.setupUI()
        view.backgroundColor = homeViewModel.backgroundColor()
        sharableView.backgroundColor = view.backgroundColor
        backgroundImageView.image = homeViewModel.backgroundImage()
        titleLabel.text = homeViewModel.titleText()
        cameraButton.setImage(homeViewModel.cameraImage(), for: .normal)
        
        mainImageView.layer.borderWidth = 5
        mainImageView.layer.borderColor = homeViewModel.darkColor().cgColor
        mainImageView.layer.cornerRadius = mainImageView.frame.size.width / 2
        
        let numbersData = homeViewModel.getNumberImageAndString()
        numberImageView.image = numbersData.0
        numberDescriptionLabel.text = numbersData.1
        
        switch homeViewModel.logoLocation() {
        case .left:
            NSLayoutConstraint.activate([logoImageView.leadingAnchor.constraint(equalTo: sharableView.leadingAnchor, constant: HBConstants.UI.defaultPadding)])
        case .right:
            NSLayoutConstraint.activate([logoImageView.trailingAnchor.constraint(equalTo: sharableView.trailingAnchor, constant: -HBConstants.UI.defaultPadding)])
        case .middle:
            NSLayoutConstraint.activate([logoImageView.centerXAnchor.constraint(equalTo: sharableView.centerXAnchor)])
        }
        
        updateUI()
    }
    
    internal override func initViewModel() -> BaseViewModel {
        return MainViewModel()
    }
    
    override internal func updateUI() {
        mainImageView.image = homeViewModel.babyImage
    }
    
    //MARK: - Action functions
    @IBAction func shareTapped(_ sender: UIButton) {
        let activityViewController = UIActivityViewController(activityItems: [sharableView.asImage()] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction private func cameraButtonTapped(_ sender: UIButton) {
        showPhotoMethodPicker()
    }
    
    @IBAction private func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
