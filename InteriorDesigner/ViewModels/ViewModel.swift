//
//  ViewModels.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 15/05/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import CryptoKit

class ViewModel: ObservableObject {
    @State var userIDE = Auth.auth().currentUser?.uid
    @Published var user = User(id: (Auth.auth().currentUser?.uid.description) ?? "")
    @Published var designers = [Users]()
    private var db = Firestore.firestore()

   
    //----------------------------------
    
    func updateData(id: String) {
        
        let db = Firestore.firestore()
            db.collection("Users").whereField("id", isEqualTo: id).getDocuments { (result, error) in
                if error == nil{
                    for document in result!.documents{
                        //document.setValue("1", forKey: "isolationDate")
                        db.collection("Users").document(document.documentID).setData([
                            "name": self.user.name ?? "",
                            "phoneNumber": self.user.phoneNumber ?? "",
                            "desinger": self.user.desinger ?? false,
                            "brief": self.user.brief ?? "",
                            "field": self.user.field ?? "",
                            "styles": self.user.styles ?? "",
                            "rate": self.user.rate ?? 0], merge: true)
                    }
                }
            }
    }
    
    //----------------------------------
    
    func deleteData(UsersDelete: Users) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Users").document(user.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
//                    self.Users.removeAll { Users in
//
//                        // Check for the todo to remove
//                        return Users.id == UsersDelete.id
//                    }
                }
                
                
            }
        }
        
    }
    
    //----------------------------------
    
    func addData(id: String,
                 email: String?,
                 name : String?) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Users").document(id).setData([ "id": id,
                                                                  "email": email ?? "",
                                                                  "name":name ?? ""]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getData(id: id)
            }
            else {
                // Handle the error
            }
        }
    }
    
    //----------------------------------
    
    func getData(id : String) {
        let docRef = db.collection("Users").document(id)

          docRef.getDocument { document, error in
              if let error = error {
                  print("error!:\(error.localizedDescription)")
              }
            else {
              if let document = document {
                  let id =  document.documentID
                  let data = document.data()
                  let name = data?["name"] as? String ?? ""
                  let email = data?["email"] as? String ?? ""
                  let phoneNumber = data?["phoneNumber"] as? String ?? ""
                  let favorite = data?["favorite"] as? String ?? ""
                  let desinger = data?["desinger"] as? Bool ?? false
                  let brief = data?["brief"] as? String ?? ""
                  let field = data?["field"] as? String ?? ""
                  let styles = data?["styles"] as? String ?? ""
                  let rate = data?["rate"] as? String ?? ""
                  
                  
//                  UserDefaults.standard.set(name, forKey: "name")
//                  UserDefaults.standard.set(email, forKey: "email")
//                  UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
//                  UserDefaults.standard.set(favorite, forKey: "favorite")
//                  UserDefaults.standard.set(desinger, forKey: "desinger")
//                  UserDefaults.standard.set(brief, forKey: "brief")
//                  UserDefaults.standard.set(field, forKey: "field")
//                  UserDefaults.standard.set(rate, forKey: "rate")
                 
                  
                  self.user = User(id: id, name: name ,email: email ,phoneNumber: phoneNumber ,desinger: desinger , brief: brief ,field: field ,styles: styles , rate: rate )
                  print(self.user.name ?? "" )
              }
            }
          }
    }
    
    //----------------------------------
    
    func signOut() {
        do{
            try Auth.auth().signOut();
        } catch let logoutError {
            print(logoutError)
        }
        
        let user1 = Auth.auth().currentUser;
        
        if ((user1) != nil) {
            // User is signed in.
            print("User is signed in.")
        } else {
            // No user is signed in.
            print("No user is signed in.")
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        }
        
    }
    
    //----------------------------------

    func addFavoriteArray(otherUserID : String) {
        let db = Firestore.firestore()
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically add a new region to the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayUnion([otherUserID])
        ])

      }
    
    //----------------------------------

    func removeFavoriteArray(otherUserID : String) {
        let washingtonRef = db.collection("Users").document(user.id)

        // Atomically remove a region from the "regions" array field.
        washingtonRef.updateData([
            "favorite": FieldValue.arrayRemove([otherUserID])
        ])
      }
//    func Rate(otherUserID : String, rateingValue : Int32) {
//
//        //        var count = 0
//        //        var rating = 0
//        //
//        //        for (key, value) in users.rate! {
//        //            count += 1
//        //            rating += value
//        //        }
//        //
//        //        rating /= count
//        //
//        //        let user = User(name: "john doe", rating: rating)
//
//        //        let db = Firestore.firestore()
//        //        let washingtonRef = db.collection("Users").document(otherUserID)
//        //
//        //        // Atomically add a new region to the "regions" array field.
//        //        washingtonRef.updateData([
//        //            "rate": FieldValue.arrayUnion([otherUserID,rateingValue])
//        //        ])
//
//
//
//        let db = Firestore.firestore()
//        let washingtonRef = db.collection("Users").document(users.id)
////
////        let ref = self.washingtonRef.child("uid_0").child("playlist")
////        let songArray = ["Us and Them", "Get Back", "Children of the Sun"]
////        ref.setValue(songArray)
//
//        // Atomically add a new region to the "regions" array field.
//        washingtonRef.updateData([
//            "favorite": FieldValue.arrayUnion([otherUserID])
//        ])
//
//
//    }
    
    
    func fetchData() {
        db.collection("Users").getDocuments { doucments, error in

            if let error = error {
                print("error!:\(error.localizedDescription)")
            } else {
                guard let documents = doucments?.documents else {
                    print("No documents")
                    return
                }
                for document in documents {
                
                    let id =  document.data()["id"] as? String
//                    let userId =  document.data()["userId"] as? UUID
                    let name = document.data()["name"] as? String
                    let email = document.data()["email"] as? String
                    let phoneNumber = document.data()["name"] as? String
                    let favorite = document.data()["phoneNumber"] as? String
                    let desinger = document.data()["desinger"] as? Bool
                    let brief = document.data()["brief"] as? String
                    let field = document.data()["field"] as? String
                    let styles = document.data()["styles"] as? String
                    let rate = document.data()["rate"] as? String

                    
                    let user = Users(id: id ?? "", name: name ?? "",email: email ?? "" ,phoneNumber: phoneNumber ?? "",desinger: desinger ?? false , brief: brief ?? "",field: field ?? "" ,styles: styles ?? "", rate: rate ?? "" )
                    self.designers.append(user)
                    print("SSSS:\(self.designers.count)")
                    print("MMM:\(self.designers[0].name)")
                    print("Hello")

                
                }
                
            }
            
        }
}
}
