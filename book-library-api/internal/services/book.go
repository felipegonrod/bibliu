package services

import (
	"booklibraryapi/internal/models"
	"booklibraryapi/internal/repositories"
)

type BookService struct {
	Repo *repositories.BookRepository
}

func (s *BookService) Create(title, author, description string) *models.Book {
	book := &models.Book{
		Title:       title,
		Author:      author,
		Description: description,
	}
	s.Repo.Create(book)
	return book
}

func (s *BookService) GetAll() []models.Book {
	return s.Repo.GetAll()
}

func (s *BookService) GetByID(id int) (*models.Book, error) {
	return s.Repo.GetByID(id)
}

func (s *BookService) Update(id int, title, author, description string) error {
	book, err := s.Repo.GetByID(id)
	if err != nil {
		return err
	}
	book.Title = title
	book.Author = author
	book.Description = description
	return s.Repo.Update(book)
}

func (s *BookService) Delete(id int) error {
	return s.Repo.Delete(id)
}
