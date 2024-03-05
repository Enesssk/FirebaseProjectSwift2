//
//  FeedViewController.swift
//  FireBaseProjectSwift2
//
//  Created by Enes Kala on 5.03.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    var userEmail = [String] ()
    var userComment = [String] ()
    var userImage = [String] ()
    var likeArray = [String] ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData() {
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date",descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        
                        if let email = document.get("email") as? String {
                            self.userEmail.append(email)
                        }
                        if let comment = document.get("comment") as? String {
                            self.userComment.append(comment)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImage.append(imageUrl)
                        }
                        if let like = document.get("like") as? Int {
                            self.likeArray.append("\(like)")
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.emailLabel.text = userEmail[indexPath.row]
        cell.commentLabel.text = userComment[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImage[indexPath.row]))
        cell.likeLabel.text = likeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmail.count
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
        
    }
    

}
