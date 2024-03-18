/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;

/**
 *
 * @author Win
 */
public class CartDAO extends DAO<Cart>{

    @Override
    public List<Cart> getAll() {
        return null;
    }

    @Override
    public Cart get(int userID) {
        List<Cart> list = new ArrayList<>();
        AccountDAO adao = new AccountDAO();
        BookDAO bdao = new BookDAO();
        String sql = "select * from Cart where userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Cart(adao.get(rs.getInt(1)), 
                        bdao.get(rs.getInt(2)), 
                        rs.getInt(3));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Cart> getCart(int userID) {
        List<Cart> list = new ArrayList<>();
        AccountDAO adao = new AccountDAO();
        BookDAO bdao = new BookDAO();
        String sql = "select * from Cart where userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Cart(adao.get(rs.getInt(1)), 
                        bdao.get(rs.getInt(2)), 
                        rs.getInt(3)));
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    @Override
    public void save(Cart t) {
        String sql = "insert into Cart(userID, bookID, quantity) values (?,?,?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getUser().getId());
            ps.setInt(2, t.getBook().getId());
            ps.setInt(3, t.getQuantity());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void update(Cart t) {
        String sql = "update Cart set quantity = ? where userID = ? and bookID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(2, t.getUser().getId());
            ps.setInt(3, t.getBook().getId());
            ps.setInt(1, t.getQuantity());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void delete(Cart t) {
        String sql = "delete from Cart where userID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getUser().getId());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    public void deleteCartItem(Cart t)
    {
        String sql = "delete from Cart where userID = ? and bookID = ?";
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
}
