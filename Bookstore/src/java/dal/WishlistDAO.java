/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Wishlist;

/**
 *
 * @author Win
 */
public class WishlistDAO extends DAO<Wishlist>{

    @Override
    public List<Wishlist> getAll() {
        return null;
    }

    @Override
    public Wishlist get(int id) {
        return null;
    }
    
    public List<Wishlist> getByUser(int id)
    {
        BookDAO bdao = new BookDAO();
        AccountDAO adao = new AccountDAO();
        List<Wishlist> list = new ArrayList<>();
        String sql = "select * from Wishlist where userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Wishlist c = new Wishlist(adao.get(rs.getInt(1)), 
                        bdao.get(rs.getInt(2)));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    @Override
    public void save(Wishlist t) {
        String sql = "insert into Wishlist(userID, bookID) values (?,?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getUser().getId());
            ps.setInt(2, t.getBook().getId());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void update(Wishlist t) {
    }

    @Override
    public void delete(Wishlist t) {
        String sql = "delete from Wishlist where bookID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getBook().getId());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    
}
