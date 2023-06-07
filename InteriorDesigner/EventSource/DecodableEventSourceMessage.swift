//
//  DecodableEventSourceMessage.swift
//  Alamofire
//
//  Created by Hajar Alruqi on 07/06/2023.
//

import Foundation

public struct DecodableEventSourceMessage<T: Decodable> {
    
    public var event: String?
    public var id: String?
    public var data: T?
    public var retry: String?
    
}
