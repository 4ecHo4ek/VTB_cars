//
//  ViewController.swift
//  VTB_cars
//
//  Created by Сергей Цыганков on 09.10.2020.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    var imageData = UIImage()
    
    @IBOutlet weak var image: UIImageView! // удалить
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func useCamera(_ sender: UIButton) {
       
            
                let cameraIcon = UIImage(systemName: "camera")
                let photoIcon = UIImage(systemName: "photo")
                
                let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let camera = UIAlertAction(title: "Камера", style: .default) { _ in
                    self.chooseImagePicker(fromSource: .camera)
                }
                camera.setValue(cameraIcon, forKey: "image")
                camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
                let photo = UIAlertAction(title: "Библиотека фото", style: .default) { _ in
                    self.chooseImagePicker(fromSource: .photoLibrary)
                }
                photo.setValue(photoIcon, forKey: "image")
                photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                
                actionSheet.addAction(camera)
                actionSheet.addAction(photo)
                actionSheet.addAction(cancel)
                
                present(actionSheet, animated: true)
    }
    
}



extension ViewController: UIImagePickerControllerDelegate {
    func chooseImagePicker(fromSource source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            imagePicker.accessibilityLanguage = "ru_RU"
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]){
    
        imageData = info[.editedImage] as! UIImage
        
        image.image = imageData // удалить
        dismiss(animated: true, completion: nil)
    }
}
