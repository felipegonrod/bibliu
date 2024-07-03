//
//  BookListView.swift
//  Simple Library
//
//  Created by Felipe González on 02/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var title = ""
    @State private var author = ""
    @State private var description = ""
    @State private var books: [Book] = []

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Add a Book")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Description", text: $description)
                    Button(action: saveBook) {
                        Text("Save")
                    }
                }
            }

            Spacer()

            NavigationLink(destination: BookListView()) {
                Text("See all books")
            }
            .padding()
        }
        .padding()
        .navigationTitle("Book Library")
    }

    func saveBook() {
        NetworkService.shared.saveBook(title: title, author: author, description: description) { success in
            if success {
                // Optionally handle success scenario (e.g., show alert, refresh book list)
                print("Book saved successfully!")
            } else {
                // Optionally handle failure scenario
                print("Failed to save book")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
