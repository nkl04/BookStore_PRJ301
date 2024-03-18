/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Win
 */
public class Book {
//    ID int IDENTITY(1,1) PRIMARY KEY,
//	title nvarchar(80) not null,
//	description nvarchar(2000) not null,
//	language nvarchar(20) not null,
//	publication_date date not null,
//	bookImage nvarchar(100) not null,
//	qtyInStock int not null,
//	price float not null,
//	pages int not null,
//	publisherID int foreign key references Publisher(ID),
    private int id;
    private String title;
    private String description;
    private String language;
    private String publicationDate;
    private String bookImage;
    private int qtyInStock;
    private float price;
    private int pages;
    private String publisher;

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    private String author;
    private String genre;

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Book() {
    }

    public Book(int id, String title, String description, String language, String publicationDate, String bookImage, int qtyInStock, float price, int pages, String publisher, String author, String genre) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.language = language;
        this.publicationDate = publicationDate;
        this.bookImage = bookImage;
        this.qtyInStock = qtyInStock;
        this.price = price;
        this.pages = pages;
        this.publisher = publisher;
        this.author = author;
        this.genre = genre;
    }



    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(String publicationDate) {
        this.publicationDate = publicationDate;
    }

    public String getBookImage() {
        return bookImage;
    }

    public void setBookImage(String bookImage) {
        this.bookImage = bookImage;
    }

    public int getQtyInStock() {
        return qtyInStock;
    }

    public void setQtyInStock(int qtyInStock) {
        this.qtyInStock = qtyInStock;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    @Override
    public String toString() {
        return "Book{" + "id=" + id + ", title=" + title + ", description=" + description + ", language=" + language + ", publicationDate=" + publicationDate + ", bookImage=" + bookImage + ", qtyInStock=" + qtyInStock + ", price=" + price + ", pages=" + pages + ", author=" + author + ", genre=" + genre + '}';
    }


    
}
