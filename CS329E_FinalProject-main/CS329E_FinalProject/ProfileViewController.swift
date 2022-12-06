//
//  ProfileViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/15/22.
//

import UIKit
import AVFoundation
import FirebaseAuth

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var changeUsernameButton: UIButton!
    
    @IBOutlet weak var namePrinted: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var addLibrary: UIButton!
    
    @IBOutlet weak var addCamera: UIButton!
    
    let picker = UIImagePickerController()
    var username: String = ""
    var newUsername: String = ""
    var email: String = ""
    var newEmail: String = ""
    var password: String = ""
    var newPassword: String = ""
    var selectedPicture: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        //profilePicture.image = UIImage(named: "startProfilePic")
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.borderColor = UIColor.black.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        setColor()
        //namePrinted.text = "New User"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(false)
        setColor()
    }
    
    func setColor() {
        if darkModeSetting {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedPicture = info[.originalImage] as! UIImage
        profilePicture.image = selectedPicture
//        items.append(chosenImage)
//        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let controller = UIAlertController(
            title: "Change Profile Picture",
            message: "Choose source for image",
            preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: {
                (action) in print("Cancel action")
            })
        controller.addAction(cancelAction)
        
        let galleryAction = UIAlertAction(
            title: "Choose from Library",
            style: .default,
            handler: {_ in
//                (action) in print("Accept data")
                self.picker.allowsEditing = false
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true)
            })
        controller.addAction(galleryAction)
        
        let cameraAction = UIAlertAction(
            title: "Camera",
            style: .default,
            handler: {_ in
                if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                    // use the rear camera
                    switch AVCaptureDevice.authorizationStatus(for: .video) {
                    case .notDetermined:
                        // we don't know
                        AVCaptureDevice.requestAccess(for: .video) {
                            accessGranted in
                            guard accessGranted == true else { return }
                        }
                    case .authorized:
                        // we have permission already
                        break
                    default:
                        // we know we don't have access
                        print("Access denied")
                        return
                    }
                
                //picker.delegate = self
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker, animated: true)
                    
                } else {
                    // no rear camera is available
                    
                    let alertVC = UIAlertController(
                        title: "No camera",
                        message: "Sorry, this device has no rear camera",
                        preferredStyle: .alert)
                    let okAction = UIAlertAction(
                        title: "OK",
                        style: .default)
                    alertVC.addAction(okAction)
                    self.present(alertVC,animated:true)
                }

//                (action) in print("Accept data")
            })
        controller.addAction(cameraAction)
        
//        let destroyAction = UIAlertAction(
//            title: "Delete",
//            style: .destructive,
//            handler: {
//                (action) in print("Destroy data")
//            })
//        controller.addAction(destroyAction)
        
        present(controller, animated: true)
    }
    
//    @IBAction func librarySelected(_ sender: Any) {
//        picker.allowsEditing = false
//        picker.sourceType = .photoLibrary
//        present(picker, animated: true)
//    }
//
//    @IBAction func cameraSelected(_ sender: Any) {
//        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
//            // use the rear camera
//            switch AVCaptureDevice.authorizationStatus(for: .video) {
//            case .notDetermined:
//                // we don't know
//                AVCaptureDevice.requestAccess(for: .video) {
//                    accessGranted in
//                    guard accessGranted == true else { return }
//                }
//            case .authorized:
//                // we have permission already
//                break
//            default:
//                // we know we don't have access
//                print("Access denied")
//                return
//            }
//
//        //picker.delegate = self
//        picker.allowsEditing = false
//        picker.sourceType = .camera
//        picker.cameraCaptureMode = .photo
//        present(picker, animated: true)
//
//        } else {
//            // no rear camera is available
//
//            let alertVC = UIAlertController(
//                title: "No camera",
//                message: "Sorry, this device has no rear camera",
//                preferredStyle: .alert)
//            let okAction = UIAlertAction(
//                title: "OK",
//                style: .default)
//            alertVC.addAction(okAction)
//            present(alertVC,animated:true)
//        }
//
//    }
//
    
    func CameraPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedPicture = info[.originalImage] as! UIImage
        profilePicture.image = selectedPicture
//        items.append(selectedPicture)
//        collectionView.reloadData()
        dismiss(animated: true)
    }

    func CameraPickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @IBAction func changeUsername(_ sender: Any) {
        let controller = UIAlertController(
            title: "Profile Username",
            message: "Change username",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        controller.addTextField(configurationHandler: {
            (textField:UITextField!) in
            textField.placeholder = "Enter new username"
        })
        controller.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: {
                (paramAction:UIAlertAction!) in
                if let textFieldArray = controller.textFields {
                    let textFields = textFieldArray as [UITextField]
                    self.newUsername = textFields[0].text!
                    self.namePrinted.text = self.newUsername
//                    print(enteredText!)
                }
            }))
        present(controller, animated: true)
        
        //if username != newUsername {
        self.username = self.newUsername

        let newController = UIAlertController(
            title: "Success!",
            message: "Username changed",
            preferredStyle: .alert)
        newController.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))
        present(newController, animated:true)
        //namePrinted.text = "NewUser"
            //viewDidLoad()
        //}
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign out error")
        }      }
}
