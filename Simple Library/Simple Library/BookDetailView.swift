//
//  BookDetailView.swift
//  Simple Library
//
//  Created by Felipe González on 04/07/24.
//

import SwiftUI

struct BookDetailView: View {
    @State var book: Book
    @State private var isEditing = false
    @State private var title: String
    @State private var author: String
    @State private var description: String
    @State private var notes: String
    @State private var pages: String

    init(book: Book) {
        self.book = book
        _title = State(initialValue: book.title)
        _author = State(initialValue: book.author)
        _description = State(initialValue: book.description)
        _notes = State(initialValue: book.notes)
        _pages = State(initialValue: book.pages)
    
    }

    var body: some View {
            VStack(spacing: 20) {
                if isEditing {
                    VStack(spacing: 10) {
                        TextField("Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Author", text: $author)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Notes", text: $notes)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Pages", text: $pages)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        Button(action: saveChanges) {
                            Text("Save")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Button(action: cancelEdit) {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)

                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(book.title)
                            .font(.largeTitle)
                            .bold()
                        Text("Author: \(book.author)")
                            .font(.title2)
                        Text(book.description)
                            .font(.body)
                        Text(book.notes)
                            .font(.body)
                        Text("Current page: \(book.pages)")
                            .font(.body)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text("Edit")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Button(action: deleteBook) {
                            Text("Delete")
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                }
            }
            .padding()
        }
        
    

    func saveChanges() {
        NetworkService.shared.updateBook(id: book.id, title: title, author: author, description: description, notes: notes, pages: pages) { success in
            if success {
                self.book = Book(id: self.book.id, title: self.title, author: self.author, description: self.description, notes: self.notes, pages: self.pages)
                isEditing.toggle()
            } else {
                // Handle update failure
                print("Failed to update book")
            }
        }
    }

    func cancelEdit() {
        // Revert changes and exit edit mode
        title = book.title
        author = book.author
        description = book.description
        notes = book.notes
        pages = book.pages
        isEditing.toggle()
    }

    func deleteBook() {
        NetworkService.shared.deleteBook(id: book.id) { success in
            if success {
                // Successfully deleted the book, dismiss the view or show a confirmation
                print("Book deleted successfully")
            } else {
                // Handle delete failure
                print("Failed to delete book")
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(id: 1, title: "Sample Book", author: "John Doe", description: "This is a sample book description.", notes: "The character is fucked up", pages: "56"))
    }
}
