//
//  Prospects.swift
//  HotProspects
//
//  Created by Rishav Gupta on 28/06/23.
//

import Foundation

class Prospect: Identifiable, Codable { // purposely kept a class as we can change its instance in any in its projects
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] // published here works if the array is appended or deleted but if the properties is changed then it wont reflect - part 1
//    let savedKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaced")
    
    init() {
//        if let data = UserDefaults.standard.data(forKey: savedKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
        
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: savedKey)
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() // this will now render it properly - part 2
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
