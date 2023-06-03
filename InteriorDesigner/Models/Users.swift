//
//  Users.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 15/05/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Users: Identifiable {
    
    var id : String
//    var userId = UUID()
    var name: String?
    var email: String?
    var phoneNumber: String?
    var favorite: [String]?
    var desinger : Bool?
    var brief : String?
    var field : String?
    var styles : String?
    var rate : [String : Int32]?

}
