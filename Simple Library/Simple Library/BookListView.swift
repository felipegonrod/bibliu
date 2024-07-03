//
//  BookListView.swift
//  Simple Library
//
//  Created by Felipe González on 02/07/24.
//

import SwiftUI

struct BookListView: View {
    @State private var books: [Book] = []

    var body: some View {
        List(books, id: \.id) { book in
            Text(book.title)
        }
        .onAppear {
            fetchBooks()
        }
        .navigationTitle("Books")
    }

    func fetchBooks() {
        NetworkService.shared.fetchBooks { books in
            if let books = books {
                self.books = books
            } else {
                // Handle error scenario
                print("Failed to fetch books")
            }
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
