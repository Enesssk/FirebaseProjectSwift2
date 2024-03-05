//
//  UploadViewController.swift
//  FireBaseProjectSwift2
//
//  Created by Enes Kala on 5.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var comment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chosenImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chosenImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageView.image = info[.originalImage] as! UIImage
        self.dismiss(animated: true)
    }


    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let makeFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = makeFolder.child("\(uuid).jpeg")
            
            imageReference.putData(data, metadata: nil) { metaData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { url, error in
                        let imageUrl = url?.absoluteString
                        // url yi stringe çevirdik ki kaydedebilelim.
                        
                        let firestoreDatabase = Firestore.firestore()
                        var firestoreReference : DocumentReference? = nil
                        
                        let firestorePost = ["email" : Auth.auth().currentUser!.email!, "comment" : self.comment.text!, "imageUrl" : imageUrl, "date" : FieldValue.serverTimestamp(),"like" : 0] as! [String : Any]
                        
                        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                            if error != nil {
                                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                            } else {
                                self.tabBarController?.selectedIndex = 0
                            }
                        })
                        
                    }
                    
                }
            }
            
        }
        
        
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
        
    }
    
    
}
