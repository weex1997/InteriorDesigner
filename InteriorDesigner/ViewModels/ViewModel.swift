//
//  ViewModels.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 15/05/2023.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Users]()
    
    //----------------------------------
    
    func updateData(UsersUpdate: Users) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to update
        db.collection("Users").document(UsersUpdate.id).setData(["name":UsersUpdate.name], merge: true) { error in
            
            // Check for errors
            if error == nil {
                // Get the new data
                self.getData()
            }
        }
    }
    
    //----------------------------------
    
    func deleteData(UsersDelete: Users) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Users").document(UsersDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { Users in
                        
                        // Check for the todo to remove
                        return Users.id == UsersDelete.id
                    }
                }
                
                
            }
        }
        
    }
    
    //----------------------------------
    
    func addData(name: String, email: String) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("Users").addDocument(data: ["name":name, "email":email]) { error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                // Call get data to retrieve latest data
                self.getData()
            }
            else {
                // Handle the error
            }
        }
    }
    
    //----------------------------------
    
    func getData() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("Users").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create a Todo item for each document returned
                            return Users(id: d.documentID,
                                         name: d["name"] as? String ?? "",
                                         email: d["email"] as? String ?? "",
                                         phoneNumber: d["phoneNumber"] as? String ?? "",
                                         favorite: d["favorite"] as? [String] ?? [""],
                                         desinger: d["desinger"] as? Bool ?? false,
                                         brief: d["brief"] as? String ?? "",
                                         field: d["field"] as? String ?? "",
                                         experiance: d["experiance"] as? String ?? "",
                                         rate_number: d["rate_number"] as? Int32 ?? 0,
                                         rate_value: d["rate_value"] as? Int32 ?? 0)
                        }
                    }
                    
                    
                }
            }
            else {
                // Handle the error
            }
        }
    }
    
}
