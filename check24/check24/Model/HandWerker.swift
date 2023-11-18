//
//  HandWerker.swift
//  check24
//
//  Created by Georgy Chomakhashvili on 18.11.23.
//

import SwiftUI

struct HandWerker: Identifiable{
    var id = UUID().uuidString
    var handWerkerName: String
    var handWerkerImage: String
    var isLiked: Bool = false
    var rating: Double
    var distance: Double
}
