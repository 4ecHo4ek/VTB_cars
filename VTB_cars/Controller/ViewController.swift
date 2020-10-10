//
//  ViewController.swift
//  VTB_cars
//
//  Created by Сергей Цыганков on 09.10.2020.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    var imageData: UIImage? {
        didSet {
            
           imageData = UIImage(named: "solaris-2")
            
            var imageToSend = imageData?.pngData()?.base64EncodedString() as Any
           
                        let headers = [
              "x-ibm-client-id": "d38ab26eb05b9a9c8c8312093bb8e4ea",
              "content-type": "application/json",
              "accept": "application/json"
            ]
            
            let parameters = ["content": imageToSend] as [String : Any]

           
            let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
           
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/car-recognize")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData!
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil) {
                print(error!)
              } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
              }
            })

            dataTask.resume()
            
        }
    }
    
    @IBOutlet weak var image: UIImageView! // удалить
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func useCamera(_ sender: UIButton) {
       
        showCamera()

       
                
    }
    
   func showCamera() {
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
        imageData = info[.editedImage] as? UIImage
    }
}
