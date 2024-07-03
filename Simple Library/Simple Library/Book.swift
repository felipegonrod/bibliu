//
//  Book.swift
//  Simple Library
//
//  Created by Felipe González on 02/07/24.
//

struct Book: Identifiable, Codable {
    let id: Int
    let title: String
    let author: String
    let description: String
}

struct MockData {
    static let books = [
        Book(id: 1, title: "Book 1", author: "Si", description: "Si"),
        Book(id: 2, title: "Book 2", author: "No", description: "Si"),
        Book(id: 3, title: "Book 3", author: "Gonzalo", description: "Si"),
    ]
}
