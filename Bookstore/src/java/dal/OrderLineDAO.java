/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderLine;

/**
 *
 * @author Win
 */
public class OrderLineDAO extends DAO<OrderLine>{
    BookDAO dao = new BookDAO();
   @Override
    public List<OrderLine> getAll() {
        List<OrderLine> list = new ArrayList<>();
        
        String sql = "select * from OrderLine";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderLine c = new OrderLine(dao.get(rs.getInt(1)), 
                        rs.getInt(2), 
                        rs.getInt(3),
                          rs.getFloat(4));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    @Override
    public OrderLine get(int id) {
        List<OrderLine> list = new ArrayList<>();
        String sql = "select * from OrderLine where ID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new OrderLine(dao.get(rs.getInt(1)), 
                        rs.getInt(2), 
                        rs.getInt(3),
                          rs.getFloat(4));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<OrderLine> getByOrder(int id) {
        List<OrderLine> list = new ArrayList<>();
        String sql = "select * from OrderLine where orderID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderLine(dao.get(rs.getInt(1)), 
                        rs.getInt(2), 
                        rs.getInt(3),
                          rs.getFloat(4)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    @Override
    public void save(OrderLine t) {
        String sql = "insert into OrderLine(bookID, orderID, quantity, price) values (?,?,?,?)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getBook().getId());
            ps.setInt(2, t.getOrderID());
            ps.setInt(3, t.getQuantity());
            ps.setFloat(4, t.getPrice());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void update(OrderLine t) {

    }

    @Override
    public void delete(OrderLine t) {
        String sql = "delete from OrderLine where orderID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, t.getOrderID());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

}
