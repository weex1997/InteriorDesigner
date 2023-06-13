//
//  RecentMessage.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/21/21.
//

import Foundation
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    @DocumentID var id: String?
    let text: String
    let email : String?
    let fromId, toId: String
    let name : String?
    let profileImageUrl: String?
    let timestamp: Date
    let gender: String?

    
    var username: String {
        email?.components(separatedBy: "@").first ?? email!
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
