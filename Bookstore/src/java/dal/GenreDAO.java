/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.Account;
import model.DataItem;
import model.Genre;

/**
 *
 * @author Win
 */
public class GenreDAO extends DAO<Genre>{

    @Override
    public List<Genre> getAll() {
        List<Genre> list = new ArrayList<>();
        String sql = "select * from Genre";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Genre c = new Genre(rs.getInt(1), 
                        rs.getString(2));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    @Override
    public Genre get(int id) {
        return null;
    }
    
    public boolean checkExist(String title)
    {
        String sql = "select * from Genre where title = ?";
        try
        {
            ps = connection.prepareStatement(sql);
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
    public void save(Genre t) {
        String sql = "insert into Genre values (?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getTitle());
            ps.executeUpdate();

        }
        catch (Exception e)
        {    
        }
    }

    @Override
    public void update(Genre t) {
        String sql = "update Genre set title = ? where ID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getTitle());
            ps.setInt(2, t.getId());
            ps.executeUpdate();

        }
        catch (Exception e)
        {    
        }
    }
    
    public List<DataItem> chartData()
    {
        List<DataItem> list = new ArrayList<>();
        String sql = "SELECT G.title AS GenreTitle, COALESCE(SUM(OL.quantity), 0) AS TotalQuantityPerGenre\n" +
"FROM Genre G\n" +
"LEFT JOIN BookGenre BG ON G.ID = BG.genreID\n" +
"LEFT JOIN OrderLine OL ON BG.bookID = OL.bookID\n" +
"GROUP BY G.title\n" +
"ORDER BY TotalQuantityPerGenre DESC;";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new DataItem(rs.getString(1), rs.getInt(2)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    @Override
    public void delete(Genre t) {
        // do not allow delete genre
    }
    
//    public static void main(String[] args) {
//        GenreDAO dao = new GenreDAO();
//        Genre g = new Genre();
//        g.setTitle("Action");
//        g.setId(8);
//        System.out.println(dao.checkExist("Action"));
//        
//    }
}
