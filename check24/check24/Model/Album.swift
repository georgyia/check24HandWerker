//
//  Album.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//

import SwiftUI
// MARK: Album Model And Sample Data
struct Album: Identifiable{
var id = UUID().uuidString
var albumName: String
var albumImage: String
var isLiked: Bool = false
}
var albums: [Album] = [
    
]
