package main

import (
	"booklibraryapi/internal/handlers"
	"booklibraryapi/internal/repositories"
	"booklibraryapi/internal/services"
	"net/http"

	"github.com/gorilla/mux"
)

func main() {
	// Initialize repositories, services, and handlers
	bookRepo := repositories.NewBookRepository()
	bookService := &services.BookService{Repo: bookRepo}
	bookHandler := &handlers.BookHandler{Service: bookService}

	// Setup routes using Gorilla Mux router
	router := mux.NewRouter()
	router.HandleFunc("/books", bookHandler.GetAllBooks).Methods("GET")
	router.HandleFunc("/books/{id}", bookHandler.GetBookByID).Methods("GET")
	router.HandleFunc("/books", bookHandler.CreateBook).Methods("POST")
	router.HandleFunc("/books/{id}", bookHandler.UpdateBook).Methods("PUT")
	router.HandleFunc("/books/{id}", bookHandler.DeleteBook).Methods("DELETE")

	// Start server
	http.ListenAndServe(":8080", router)
}
