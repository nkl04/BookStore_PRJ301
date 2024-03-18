/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Book;
import model.Order;

/**
 *
 * @author Win
 */
public class OrderDAO extends DAO<Order>{

    @Override
    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();
        AccountDAO adao = new AccountDAO();
        String sql = "select * from ShopOrder order by ID desc";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order c = new Order(rs.getInt(1), 
                        rs.getString(2), 
                          rs.getString(3),
                        adao.get(rs.getInt(4)));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public List<Order> getByUser(int userId) {
        List<Order> list = new ArrayList<>();
        AccountDAO adao = new AccountDAO();
        String sql = "select * from ShopOrder where userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order c = new Order(rs.getInt(1), 
                        rs.getString(2), 
                          rs.getString(3),
                        adao.get(rs.getInt(4)));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    @Override
    public Order get(int id) {
        List<Order> list = new ArrayList<>();
        AccountDAO adao = new AccountDAO();
        String sql = "select * from ShopOrder where ID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Order(rs.getInt(1), 
                        rs.getString(2), 
                          rs.getString(3),
                        adao.get(rs.getInt(4)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Book> getBestsellingBook()
    {
        List<Book> list = new ArrayList<>();
        BookDAO bdao = new BookDAO();
        String sql = """
                     SELECT TOP 5 ol.bookID, SUM(ol.quantity) AS totalQuantitySold
                     FROM ShopOrder so
                     INNER JOIN OrderLine ol ON so.ID = ol.orderID
                     WHERE so.orderStatus = 'Done'
                     GROUP BY ol.bookID
                     ORDER BY totalQuantitySold DESC;""";
        try
        {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next())
            {
                list.add(bdao.get(rs.getInt(1)));
            }
        }
        catch (SQLException e)
        {    
            System.out.println(e);
        }
        return list;
    }
    @Override
    public void save(Order t) {
        String sql = "insert into ShopOrder(orderDate, orderStatus, userID) values (?,?,?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getOrderDate());
            ps.setString(2, t.getOrderStatus());
            ps.setInt(3, t.getUser().getId());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    public int saveAndReturnID(Order t) {
        AccountDAO adao = new AccountDAO();
        String sql = "insert into ShopOrder(orderDate, orderStatus, userID) values (?,?,?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getOrderDate());
            ps.setString(2, t.getOrderStatus());
            ps.setInt(3, t.getUser().getId());
            ps.executeUpdate();
            System.out.println("insert order");
        } 
        catch(SQLException e)
        {
            
        }
        
        sql = "select top 1 * from ShopOrder order by ID desc";
        try
        {
            ps = connection.prepareStatement(sql);            
            rs = ps.executeQuery();
            while(rs.next())
            {
                return rs.getInt(1);
            }
            System.out.println(rs);
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return 0;
    }
    @Override
    public void update(Order t) {

    }

    @Override
    public void delete(Order t) {
        String sql = "delete from ShopOrder where ID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getID());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    public static void main(String[] args) {
        OrderDAO odao = new OrderDAO();
        List<Book> listB = odao.getBestsellingBook();
        for (Book book : listB) {
            System.out.println(book);
        }
    }
}
