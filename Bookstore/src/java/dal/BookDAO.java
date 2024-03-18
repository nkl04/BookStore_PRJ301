/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Book;

/**
 *
 * @author Win
 */
public class BookDAO extends DAO<Book>{

    @Override
    public List<Book> getAll() {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID";
        try
        {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    public List<Book> getBookByGenre(String path) {
        // convert the path to the title of genre
        String title = path.replaceAll("-", " ").replace("and", "&");
        
        // declare the list to store the all of book; 
        List<Book> list = new ArrayList<>();
        
        
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID" +
                    "where Genre.title = ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    public List<Book> searchBookByName(String txt)
    {
        // declare the list to store the all of book; 
        List<Book> list = new ArrayList<>();
        
        
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID where Book.title like ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" +txt+"%");
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    
    public List<Book> getBookByMinMaxPrice(float minprice, float maxprice)
    {
        // declare the list to store the all of book; 
        List<Book> list = new ArrayList<>();
        
        
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID where Book.price between ? and ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setFloat(1 ,minprice);
            ps.setFloat(2 ,maxprice);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    @Override
    public Book get(int id) {
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID where Book.ID = ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13));
            }
        }
        catch (Exception e)
        {    
            System.out.println(e);
        }
        return null;
    }
    public int getTotalAmountBook()
    {
        String sql = "select count(*) from Book;";
        try
        {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return rs.getInt(1);
            }
        }
        catch (Exception e)
        {    
        }
        return 0;
    }
    public int getAmountBookByGenre(String path)
    {
                String title = path.replaceAll("-", " ").replace("and", "&");
        String sql = "select count(*) from Book\n" +
"join BookGenre on Book.ID = BookGenre.bookID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"where Genre.title = ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1,title);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return rs.getInt(1);
            }
        }
        catch (Exception e)
        {    
        }
        return 0;
    }
    
    public List<Book> pagingBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.ID\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    public List<Book> pagingBookByGenre(String path, int index)
    {
                String title = path.replaceAll("-", " ").replace("and", "&");
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID" +
"                    where Genre.title = ?\n" +
"					order by Book.ID\n" +
"					offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    public List<Book> sortTitleAscBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.title\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
     public List<Book> sortTitleDescBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.title desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
      public List<Book> sortPriceAscBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.price\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
       public List<Book> sortPriceDescBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.price desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
     public List<Book> sortDateAscBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.publication_date\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
      public List<Book> sortDateDescBook(int index)
    {
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
"order by Book.publication_date desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
      public List<Book> sortTitleAscBookByGenre(String path,int index)
    {
        String title = path.replaceAll("-", " ").replace("and", "&");
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                "                    where Genre.title = ?\n" +
"order by Book.title\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
     public List<Book> sortTitleDescBookByGenre(String path, int index)
    {
        String title = path.replaceAll("-", " ").replace("and", "&");        
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                                "                    where Genre.title = ?\n" +
"order by Book.title desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
      public List<Book> sortPriceAscBookByGenre(String path,int index)
    {
        String title = path.replaceAll("-", " ").replace("and", "&");        
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                                "                    where Genre.title = ?\n" +
"order by Book.price\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
       public List<Book> sortPriceDescBookByGenre(String path, int index)
    {
        String title = path.replaceAll("-", " ").replace("and", "&");        
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                                "                    where Genre.title = ?\n" +
"order by Book.price desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
     public List<Book> sortDateAscBookByGenre(String path,int index)
    {
        String title = path.replaceAll("-", " ").replace("and", "&");        
        List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                                "                    where Genre.title = ?\n" +
"order by Book.publication_date\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
      public List<Book> sortDateDescBookByGenre(String path,int index)
      {
                  String title = path.replaceAll("-", " ").replace("and", "&");
          List<Book> list = new ArrayList<>();
        String sql = "select Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID\n" +
                                "                    where Genre.title = ?\n" +
"order by Book.publication_date desc\n" +
"offset ? rows fetch next 10 rows only;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setInt(2,(index - 1) * 10);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
      }
    public boolean checkExist(String title)
    {
        String sqlCheck = "select * from Book where title = ?";
        try
        {
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, title);
            rs = ps.executeQuery();
            if(rs.next())
            {
                return true;
            }
        }
        catch (Exception e)
        {    
        }
        return false;
    }
    @Override
    public void save(Book t) {
        String sqlCheck = "";
        String sql = "";
        // handle insert publiser first
        sqlCheck = "select * from Publisher where name = ?";
        sql = "insert into Publisher values (?)";
        try
        {
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, t.getPublisher());
            rs = ps.executeQuery();
            if(!rs.next())
            {
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getPublisher());
                ps.executeUpdate();
            }
        }
        catch (Exception e)
        {    
        }
        
        // handle insert book 
        sql = "insert into Book SELECT ?, ?, ?, ?, ?, ?, ?, ?, ID\n" +
"FROM Publisher\n" +
"WHERE name = ?";
        try
        {          
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getTitle());
                ps.setString(2, t.getDescription());
            ps.setString(3, t.getLanguage());
            ps.setString(4, t.getPublicationDate());
            ps.setString(5, t.getBookImage());
            ps.setInt(6, t.getQtyInStock());
            ps.setFloat(7, t.getPrice());
            ps.setInt(8, t.getPages());
            ps.setString(9, t.getPublisher());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        
        // handle insert BookGenre
        sql = "insert into BookGenre \n" +
"SELECT b.ID, g.ID\n" +
"FROM Book b\n" +
"JOIN Genre g ON g.title = ?\n" +
"WHERE b.title = ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(2, t.getTitle());
            ps.setString(1, t.getGenre());
            ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        
        // handle insert Author
        sqlCheck = "select * from Author where name = ?";
        sql = "insert into Author values (?)";
        try
        {
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, t.getAuthor());
            rs = ps.executeQuery();
            if(!rs.next())
            {
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getAuthor());
                ps.executeUpdate();
            }
        }
        catch (Exception e)
        {    
        }
        
        // handle insert BookAuthor
        sql = "insert into BookAuthor \n" +
"SELECT b.ID, a.ID\n" +
"FROM Book b\n" +
"JOIN Author a ON a.name = ?\n" +
"WHERE b.title = ?;";
        try
        {
            System.out.println(t.getAuthor() + " " + t.getTitle());
            ps = connection.prepareStatement(sql);
            ps.setString(2, t.getTitle());
            ps.setString(1, t.getAuthor());
            ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }

    }

    @Override
    public void update(Book t) {
        String sqlCheck = "";
        String sql = "";
        
        // handle update publiser first
        sqlCheck = "select * from Publisher where name = ?";
        sql = "insert into Publisher values (?)";
        try
        {
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, t.getPublisher());
            rs = ps.executeQuery();
            if(!rs.next())
            {
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getPublisher());
                ps.executeUpdate();
            }
        }
        catch (Exception e)
        {    
        }
        
        // handle update book 
        sql = "update Book\n" +
"set title = ?, description = ?, language = ?, publication_date = ?, qtyInStock = ?, price = ?, pages = ?, publisherID = (SELECT ID FROM Publisher WHERE name = ?)\n" +
"where ID = ?;";
        try
        {
            
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getTitle());
                ps.setString(2, t.getDescription());
            ps.setString(3, t.getLanguage());
            ps.setString(4, t.getPublicationDate());
            ps.setInt(5, t.getQtyInStock());
            ps.setFloat(6, t.getPrice());
            ps.setInt(7, t.getPages());
            ps.setString(8, t.getPublisher());
            ps.setInt(9, t.getId());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        
        if(t.getBookImage().trim().length() > 0)
        {
 
            sql = "update Book\n" +
"set bookImage = ?\n" +
"where ID = ?;";
            try
        {
            
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getBookImage());
                ps.setInt(2, t.getId());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        }
        
        
        // handle update BookGenre
        sql = "UPDATE BookGenre\n" +
"SET genreID = (SELECT ID FROM Genre WHERE title = ?)\n" +
"WHERE bookID = ?;";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getGenre());
            ps.setInt(2, t.getId());
            ps.executeUpdate();
            System.out.println("update book gerne");
        }
        catch (Exception e)
        {    
        }
        
        // handle update Author
        sqlCheck = "select * from Author where name = ?";
        sql = "insert into Author values ?";
        try
        {
            ps = connection.prepareStatement(sqlCheck);
            ps.setString(1, t.getAuthor());
            rs = ps.executeQuery();
            if(!rs.next())
            {
                ps = connection.prepareStatement(sql);
                ps.setString(1, t.getAuthor());
                ps.executeUpdate();
            }
        }
        catch (Exception e)
        {    
        }
        
        // handle insert BookAuthor
        sql = "UPDATE BookAuthor\n" +
"SET authorID = (SELECT ID FROM Author WHERE name = ?)\n" +
"WHERE bookID = ?;";
        try
        {
            System.out.println(t.getAuthor() + " " + t.getTitle());
            ps = connection.prepareStatement(sql);
            ps.setInt(2, t.getId());
            ps.setString(1, t.getAuthor());
            ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
    }

    @Override
    public void delete(Book t) {
        String sqlCheck = "";
        String sql = "";
        
        
        // delete BookGenre
        sql = "delete from BookGenre\n" +
"where bookID = ?;";
        try
        {
            
                ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getId());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        
        // delete BookGenre
        sql = "delete from BookAuthor\n" +
"where bookID = ?;";
        try
        {
            
                ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getId());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
        // handle delete book 
        sql = "delete from Book\n" +
"where ID = ?;";
        try
        {
            
                ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getId());
                ps.executeUpdate();
        }
        catch (Exception e)
        {    
        }
    }
    
    public List<Book> getLatestBook(){
        List<Book> list = new ArrayList<>();
        String sql = "select top 8 Book.*, Publisher.name, Author.name, Genre.title from Book\n" +
"join BookAuthor on BookAuthor.bookID = Book.ID\n" +
"join Author on authorID = Author.ID\n" +
"join BookGenre on BookGenre.bookID = Book.ID\n" +
"join Genre on Genre.ID = BookGenre.genreID\n" +
"join Publisher on Publisher.ID = Book.publisherID order by Book.ID desc";
        try
        {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(new Book(rs.getInt(1),
                                rs.getString(2),
                                rs.getString(3),
                                rs.getString(4),
                                rs.getString(5),
                                rs.getString(6),
                                rs.getInt(7),
                                rs.getFloat(8),
                                rs.getInt(9),
                        rs.getString(11),
                rs.getString(12),
                rs.getString(13)));
            }
        }
        catch (Exception e)
        {    
        }
        return list;
    }
    
    public static void main(String[] args) {
        BookDAO dao = new BookDAO();
        Book t = dao.get(1);
        t.setAuthor("lmao123");
        t.setBookImage("test");
        t.setDescription("test");
        t.setGenre("Horror");
        t.setLanguage("English");
        t.setPages(200);
        t.setPrice(29.20f);
        t.setPublicationDate("2021-01-21");
        t.setQtyInStock(20);
        t.setTitle("House of Flame and Shadow 2");
        t.setPublisher("ManhDuc123");
        t.setId(52);
//        dao.delete(t);
        List<Book> list = dao.getBookByMinMaxPrice(12,50);
        for(Book b : list)
        {
            System.out.println(b);
        }
    }
}
