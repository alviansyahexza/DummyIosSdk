//
//  File.swift
//  DummyIosSdk
//
//  Created by single on 24/05/23.
//

import Foundation

public protocol ReadseeAPIProtocol {
    func event(eventName: String, eventData: [String: Any])
    func profile(profileData: [String: Any])
    func logout()
}
