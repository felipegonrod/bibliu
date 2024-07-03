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
