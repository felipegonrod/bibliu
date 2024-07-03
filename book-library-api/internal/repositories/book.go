package repositories

import (
	"booklibraryapi/internal/models"
	"errors"
)

type BookRepository struct {
	books  []models.Book
	nextID int
}

func NewBookRepository() *BookRepository {
	return &BookRepository{
		books:  []models.Book{},
		nextID: 1,
	}
}

func (r *BookRepository) Create(book *models.Book) {
	book.ID = r.nextID
	r.nextID++
	r.books = append(r.books, *book)
}

func (r *BookRepository) GetAll() []models.Book {
	return r.books
}

func (r *BookRepository) GetByID(id int) (*models.Book, error) {
	for _, book := range r.books {
		if book.ID == id {
			return &book, nil
		}
	}
	return nil, errors.New("book not found")
}

func (r *BookRepository) Update(book *models.Book) error {
	for i, b := range r.books {
		if b.ID == book.ID {
			r.books[i] = *book
			return nil
		}
	}
	return errors.New("book not found")
}

func (r *BookRepository) Delete(id int) error {
	for i, book := range r.books {
		if book.ID == id {
			r.books = append(r.books[:i], r.books[i+1:]...)
			return nil
		}
	}
	return errors.New("book not found")
}
