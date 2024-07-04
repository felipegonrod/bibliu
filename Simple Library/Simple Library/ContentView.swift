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
    @State private var saveMessage = ""

    var body: some View {
        NavigationView() {
            VStack(spacing: 20) {
                Form {
                    Section(header: Text("Add a Book 📖").bold().font(.title2)) {
                        TextField("Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        TextField("Author", text: $author)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        TextField("Description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        Button(action: saveBook) {
                            Text("Save")
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 44)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                .padding(.horizontal)

                if !saveMessage.isEmpty {
                    Text(saveMessage)
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .transition(.opacity)
                }

                Spacer()

                NavigationLink(destination: BookListView()) {
                    Text("See your books")
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Text("Bibliu")
                    .bold()
            }
            .padding()
            .navigationTitle("Hello Felipe!")
        }
    }

    func saveBook() {
        NetworkService.shared.saveBook(title: title, author: author, description: description) { success in
            if success {
                // Show success message
                withAnimation {
                    saveMessage = "Saved"
                }
                // Hide message after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        saveMessage = ""
                    }
                }
                // Optionally clear form fields
                title = ""
                author = ""
                description = ""
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
