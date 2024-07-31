package models

type Book struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Author      string `json:"author"`
	Description string `json:"description"`
	Notes       string `json:"notes"`
	Pages       string `json:"pages"`
}
