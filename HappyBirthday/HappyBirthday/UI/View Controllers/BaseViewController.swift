//
//  BaseViewController.swift
//  HappyBirthday
//
//  Created by Sion Sasson on 11/02/2020.
//  Copyright © 2020 Sion Sasson. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class BaseViewController: UIViewController {

    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Internal functions
    internal func setupUI() {}
        
    internal func showPhotoMethodPicker() {
        let menuController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuController.addAction(UIAlertAction(title: "Take photo", style: .default) { [weak self] (action) in
            self?.requestAccessToCamera()
        })
        menuController.addAction(UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            self?.requestAccessToPhotoLibrary()
        })
        menuController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(menuController, animated: true, completion: nil)
    }
    
    internal func imageReadyFromCameraOrLibrary(image: UIImage) {
        
    }
    
    //MARK: - Private functions
    private func requestAccessToCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                showImagePicker(withSourceType: .camera)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    guard granted else {
                        self?.showCameraErrorAlert()
                        return
                    }
                    
                    self?.showImagePicker(withSourceType: .camera)
                }
            case .denied, .restricted:
                showCameraErrorAlert()
        @unknown default:
            return
        }
    }

    private func requestAccessToPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization({ [weak self] (status) in
            switch status {
            case .authorized:
                self?.showImagePicker(withSourceType: .photoLibrary)
            case .denied, .restricted:
                self?.showPhotoLibraryErrorAlert()
            case .notDetermined:
                return
            @unknown default:
                return
            }
        })
    }
    
    private func showCameraErrorAlert() {
        let alert = UIAlertController(title: "Sorry", message: "You can't use the camera, please check the camera permissions", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showPhotoLibraryErrorAlert() {
        let alert = UIAlertController(title: "Sorry", message: "You can't access the photo library, please check the library permissions", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showImagePicker(withSourceType type: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            guard UIImagePickerController.isSourceTypeAvailable(type) else {
                return
            }
            
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = type
            self.present(controller, animated: true, completion: nil)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension BaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        imageReadyFromCameraOrLibrary(image: image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
