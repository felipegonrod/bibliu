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
        NavigationView {
            VStack {
                List(books, id: \.id) { book in
                    Text(book.title)
                }
                .listStyle(PlainListStyle())
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            }
            .onAppear {
                fetchBooks()
            }
        .navigationTitle("Your Books")
        }
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

#Preview {
    BookListView()
}
