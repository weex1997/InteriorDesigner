//
//  ChatViewModel.swift
//  ChatGPTApp
//
//  Created by Mazen Kourouche on 31/3/2023.
//

import Foundation
extension ChatGPT3View {
    class GPTViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: "first-message", role: .system, content: "You are an interior design assistant. You will help me understand how to design home. You do not have enough information about other fields  ​​to give advice so avoid doing so at ALL times", createAt: Date())]
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        
        func sendMessage()  {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
//            Task {
//                let response = await openAIService.sendMessage(messages: messages)
//                guard let receivedOpenAIMessage = response?.choices.first?.message else {
//                    print("Had no received message")
//                    return
//                }
//                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
//                await MainActor.run {
//                    messages.append(receivedMessage)
//                }
//            }
            
            openAIService.sendStreamMessage(messages: messages).responseStreamString { [weak self] stream in
                guard let self = self else { return }
                switch stream.event {
                case .stream(let response):
                    switch response {
                    case .success(let string):
                        let streamResponse = self.parseStreamData(string)
                        
                        streamResponse.forEach { newMessageResponse in
                            guard let messageContent = newMessageResponse.choices.first?.delta.content else {
                                return
                            }
                            guard let existingMessageIndex = self.messages.lastIndex(where: {$0.id == newMessageResponse.id}) else {
                                let newMessage = Message(id: newMessageResponse.id, role: .assistant, content: messageContent, createAt: Date())
                                self.messages.append(newMessage)
                                return
                            }
                            let newMessage = Message(id: newMessageResponse.id, role: .assistant, content: self.messages[existingMessageIndex].content + messageContent, createAt: Date())
                            self.messages[existingMessageIndex] = newMessage
                        }
                    case .failure(_):
                        print("Something failes")
                    }
                    print(response)
                case .complete(_):
                    print("COMPLETE")
                }
            }
        }
        
        
        func parseStreamData(_ data: String) ->[ChatStreamCompletionResponse] {
            let responseStrings = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
            let jsonDecoder = JSONDecoder()
            
            return responseStrings.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8), let streamResponse = try? jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData) else {
                    return nil
                }
                return streamResponse
            }
        }
        
    }
}

struct Message: Decodable, Hashable {
    let id: String
    let role: SenderRole
    let content: String
    let createAt: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}

struct ChatStreamChoice: Decodable {
    let delta: ChatStreamContent
}

struct ChatStreamContent: Decodable {
    let content: String
}
