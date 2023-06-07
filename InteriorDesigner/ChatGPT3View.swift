//
//  ContentView.swift
//  ChatGPTApp
//
//  Created by Mazen Kourouche on 31/3/2023.
//

import SwiftUI

struct ChatGPT3View: View {
    @ObservedObject var gptViewModel = GPTViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(gptViewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $gptViewModel.currentInput)

                    
                Button {
                    gptViewModel.sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(Color.purple)
                }

            }
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user { Spacer()}
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.purple : Color.purple.opacity(0.2))
                .foregroundColor(message.role == .user ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            if message.role == .assistant { Spacer()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPT3View()
    }
}
