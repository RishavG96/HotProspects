//
//  Prospects.swift
//  HotProspects
//
//  Created by Rishav Gupta on 28/06/23.
//

import Foundation

class Prospect: Identifiable, Codable { // purposely kept a class as we can change its instance in any if its projects
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
}
