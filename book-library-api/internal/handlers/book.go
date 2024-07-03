package handlers

import (
	"booklibraryapi/internal/models"
	"booklibraryapi/internal/services"
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

type BookHandler struct {
	Service *services.BookService
}

func (h *BookHandler) GetAllBooks(w http.ResponseWriter, r *http.Request) {
	books := h.Service.GetAll()
	respondWithJSON(w, http.StatusOK, books)
}

func (h *BookHandler) GetBookByID(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid book ID")
		return
	}

	book, err := h.Service.GetByID(id)
	if err != nil {
		respondWithError(w, http.StatusNotFound, "Book not found")
		return
	}

	respondWithJSON(w, http.StatusOK, book)
}

func (h *BookHandler) CreateBook(w http.ResponseWriter, r *http.Request) {
	var book models.Book
	err := json.NewDecoder(r.Body).Decode(&book)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid request payload")
		return
	}

	createdBook := h.Service.Create(book.Title, book.Author, book.Description)
	respondWithJSON(w, http.StatusCreated, createdBook)
}

func (h *BookHandler) UpdateBook(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid book ID")
		return
	}

	var book models.Book
	err = json.NewDecoder(r.Body).Decode(&book)
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid request payload")
		return
	}

	err = h.Service.Update(id, book.Title, book.Author, book.Description)
	if err != nil {
		respondWithError(w, http.StatusNotFound, "Book not found")
		return
	}

	respondWithJSON(w, http.StatusOK, map[string]string{"message": "Book updated successfully"})
}

func (h *BookHandler) DeleteBook(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		respondWithError(w, http.StatusBadRequest, "Invalid book ID")
		return
	}

	err = h.Service.Delete(id)
	if err != nil {
		respondWithError(w, http.StatusNotFound, "Book not found")
		return
	}

	respondWithJSON(w, http.StatusOK, map[string]string{"message": "Book deleted successfully"})
}

func respondWithError(w http.ResponseWriter, code int, message string) {
	respondWithJSON(w, code, map[string]string{"error": message})
}

func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
	response, _ := json.Marshal(payload)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}
