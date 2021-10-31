//
//  Soket.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import UIKit
import SocketIO

class SoketIOManager: NSObject {
    static let shared = SoketIOManager()
    var manager = SocketManager(socketURL: URL(string: "\(ConstantURL.BASE_URL)/gs-guide-websocket")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    override init() {
        socket = self.manager.socket(forNamespace: "/7tmq")
        socket.on("7tmq") { dataArray, ack in
            print(dataArray)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(file: String, content: String, emoji: Bool, photo: Bool, calendar: Bool, text: Bool) {
        print("채팅방에 전달되는 메세지는: \(content)")
    }

    
}
