//
//  ChatLogView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/18/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift


class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessages = [ChatMessage]()
    
    var chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    var firestoreListener: ListenerRegistration?
    
    func fetchMessages() {
        guard let fromId = Auth.auth().currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        firestoreListener?.remove()
        chatMessages.removeAll()
        firestoreListener = Firestore.firestore()
            .collection(FirebaseConstants.messages)
            .document(fromId)
            .collection(toId)
            .order(by: FirebaseConstants.timestamp)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print(error)
                    return
                }
                
//                querySnapshot?.documentChanges.forEach({ change in
//                    if change.type == .added {
//                        do {
//                            if let cm = try change.document.data(as: ChatMessage.self) {
//                                self.chatMessages.append(cm)
//                                print("Appending chatMessage in ChatLogView: \(Date())")
//                            }
//                        } catch {
//                            print("Failed to decode message: \(error)")
//                        }
//                    }
//                })
                
                DispatchQueue.main.async {
                    self.count += 1
                }
            }
    }
    
    func handleSend() {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            guard let fromId = Auth.auth().currentUser?.uid else { return }
            print(fromId)
            print("fromId")


           //
            guard let toId = chatUser?.uid else { return }
            print(toId)
            print("toId")
            let newMessage = ChatMessage(id: nil, fromId: fromId, toId: toId, text: chatText, timestamp: Date())
            print(newMessage)
//            (id: "\(UUID())", text: chatText, received: false, timestamp: Date())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try Firestore.firestore().collection("messages").document(fromId).collection(toId).document().setData(from: newMessage)
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)+lllllll")
        }
    }
//    {
//        print(chatText)
//        guard let fromId = Auth.auth().currentUser?.uid else { return }
//
//        guard let toId = chatUser?.uid else { return }
//
//        let document = Firestore.firestore().collection(FirebaseConstants.messages)
//            .document(fromId)
//            .collection(toId)
//            .document()
//
//        let msg = ChatMessage(id: nil, fromId: fromId, toId: toId, text: chatText, timestamp: Date())
//
//        try? document.setData(from: msg) { error in
//            if let error = error {
//                print(error)
//                self.errorMessage = "Failed to save message into Firestore: \(error)"
//                return
//            }
//
//            print("Successfully saved current user sending message")
//
//            self.persistRecentMessage()
//
//            self.chatText = ""
//            self.count += 1
//        }
//
//        let recipientMessageDocument = Firestore.firestore().collection("messages")
//            .document(toId)
//            .collection(fromId)
//            .document()
//
//        try? recipientMessageDocument.setData(from: msg) { error in
//            if let error = error {
//                print(error)
//                self.errorMessage = "Failed to save message into Firestore: \(error)"
//                return
//            }
//
//            print("Recipient saved message as well")
//        }
//    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let toId = self.chatUser?.uid else { return }
        
        let document = Firestore.firestore()
            .collection(FirebaseConstants.recentMessages)
            .document(uid)
            .collection(FirebaseConstants.messages)
            .document(toId)
        
        let data = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
//            FirebaseConstants.profileImageUrl: chatUser.profileImageUrl,
            FirebaseConstants.email: chatUser.email
        ] as [String : Any]
        
        // you'll need to save another very similar dictionary for the recipient of this message...how?
        
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                print("Failed to save recent message: \(error)")
                return
            }
        }
        
        guard let currentUser = Auth.auth().currentUser else { return }
        let recipientRecentMessageDictionary = [
            FirebaseConstants.timestamp: Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId,
//            FirebaseConstants.profileImageUrl: currentUser.profileImageUrl,
            FirebaseConstants.email: currentUser.email
        ] as [String : Any]
        
        Firestore.firestore()
            .collection(FirebaseConstants.recentMessages)
            .document(toId)
            .collection(FirebaseConstants.messages)
            .document(currentUser.uid)
            .setData(recipientRecentMessageDictionary) { error in
                if let error = error {
                    print("Failed to save recipient recent message: \(error)")
                    return
                }
            }
    }
    
    @Published var count = 0
}

struct ChatLogView: View {
    
    let chatUser: ChatUser?

    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationTitle(vm.chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            vm.firestoreListener?.remove()
        }
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(vm.chatMessages) { message in
                                MessageView(message: message)
                            }
                            
                            HStack{ Spacer() }
                            .id(Self.emptyScrollToString)
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                        }
                    }
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Button(action: {}) {
                Image(systemName: "plus.viewfinder")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.purple)
                    .padding()
            }
            
            // Custom text field created below
            CustomTextField(placeholder: Text("Enter your message here"), text: $vm.chatText)
                .frame(height: 52)
                .disableAutocorrection(true)

            //$vm.chatText
            //                vm.handleSend()

            Button {
                vm.handleSend()
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color.purple)
                    .padding()
            }
//            .padding(.horizontal)
//            .padding(.vertical, 8)
//            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack {
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.purple)
                    }
                    .padding()
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
//            ChatLogView(chatUser: .init(data: ["uid": "R8ZrxIT4uRZMVZeWwWeQWPI5zUE3", "email": "waterfall1@gmail.com"]))
//        }
        MainMessagesView()
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
