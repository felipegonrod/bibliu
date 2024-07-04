//
//  Book.swift
//  Simple Library
//
//  Created by Felipe González on 02/07/24.
//

class Book: Identifiable, Codable {
    var id: Int
    var title: String
    var author: String
    var description: String

    init(id: Int, title: String, author: String, description: String) {
        self.id = id
        self.title = title
        self.author = author
        self.description = description
    }
}

