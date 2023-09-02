//
//  PassData+Protocol.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/09/03.
//

import Foundation

protocol PassDataDelegate: AnyObject {
    func receiveData(string: String)
}
