//
//  ProfileViewController.swift
//  CS329E_FinalProject
//
//  Created by Jennifer Lin on 11/15/22.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var changeUsernameButton: UIButton!
    
    @IBOutlet weak var namePrinted: UILabel!
    
    @IBOutlet weak var changeEmailButton: UIButton!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    
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
        
        //namePrinted.text = "New User"
        // Do any additional setup after loading the view.
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
    
    @IBAction func librarySelected(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func cameraSelected(_ sender: Any) {
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
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        present(picker, animated: true)
            
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
            present(alertVC,animated:true)
        }

    }
    
    
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
        username = newUsername

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
    
    
    @IBAction func changeEmail(_ sender: Any) {
            
        let controller = UIAlertController(
            title: "Profile Email",
            message: "Change email",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        controller.addTextField(configurationHandler: {
            (textField:UITextField!) in
            textField.placeholder = "Enter new email"
        })
        controller.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: {
                (paramAction:UIAlertAction!) in
                if let textFieldArray = controller.textFields {
                    let textFields = textFieldArray as [UITextField]
                    self.newEmail = textFields[0].text!
                }
            }))
        present(controller, animated: true)
        
        if email != newEmail {
            email = newEmail
            let controller = UIAlertController(
                title: "Success!",
                message: "Email changed",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        }
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        let controller = UIAlertController(
            title: "Profile Password",
            message: "Change password",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        controller.addTextField(configurationHandler: {
            (textField:UITextField!) in
            textField.placeholder = "Enter new password"
        })
        controller.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: {
                (paramAction:UIAlertAction!) in
                if let textFieldArray = controller.textFields {
                    let textFields = textFieldArray as [UITextField]
                    self.newPassword = textFields[0].text!
                }
            }))
        present(controller, animated: true)
        
        if password != newPassword {
            password = newPassword
            let controller = UIAlertController(
                title: "Success!",
                message: "Password changed",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        } else {
            let controller = UIAlertController(
                title: "Error",
                message: "New password can not be the same as previous password",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default
            ))
            present(controller, animated:true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
