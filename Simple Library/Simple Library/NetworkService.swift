//
//  NetworkService.swift
//  Simple Library
//
//  Created by Felipe González on 02/07/24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    private let baseURL = URL(string: "https://65c3-187-188-17-78.ngrok-free.app")!

    func fetchBooks(completion: @escaping ([Book]?) -> Void) {
        let url = baseURL.appendingPathComponent("/books")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching books: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                completion(books)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }

    func saveBook(title: String, author: String, description: String, completion: @escaping (Bool) -> Void) {
        let url = baseURL.appendingPathComponent("/books")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let newBook = [
            "title": title,
            "author": author,
            "description": description
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: newBook)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error saving book: \(error.localizedDescription)")
                completion(false)
                return
            }

            // Check response status code if necessary
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }.resume()
    }
}
