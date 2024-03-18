/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;

/**
 *
 * @author Win
 */
public class AccountDAO extends DAO<Account>{
    public Account login(String email, String password)
    {
        String sql = "select * from Account\n" +
                     "where email = ?\n" +
                     "and password = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return new Account(rs.getInt(1), 
                        rs.getString(2), 
                        rs.getString(3),
                          rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                rs.getInt(8));
            }
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return null;
    }

    @Override
    public List getAll() {
        List<Account> list = new ArrayList<>();
        String sql = "select * from Account";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account c = new Account(rs.getInt(1), 
                        rs.getString(2), 
                        rs.getString(3),
                          rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                rs.getInt(8));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    @Override
    public Account get(int id) {
        String sql = "select * from Account\n" +
                     "where userID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return new Account(rs.getInt(1), 
                        rs.getString(2), 
                        rs.getString(3),
                          rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                rs.getInt(8));
            }
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return null;
    }
    
    public Account getUserByEmail(String email) {
        String sql = "select * from Account\n" +
                     "where email = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while(rs.next())
            {
                return new Account();
            }
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return null;
    }
    @Override
    public void save(Account t) {
        String sql = "insert into Account(firstName, lastname, email, password, address, isAdmin) values (?,?,?,?,?,0)";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getFirstName());
            ps.setString(2, t.getLastName());
            ps.setString(3, t.getEmail());
            ps.setString(4, t.getPassword());
            ps.setString(5, t.getAddress());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void update(Account t) {
        System.out.println(t);
        String sql = "update Account \n" +
"set firstName = ?, lastname = ?, email = ?, image = ? \n" +
"where userID = ?";
        try
        {
            ps = connection.prepareStatement(sql);
            ps.setString(1, t.getFirstName());
            ps.setString(2, t.getLastName());
            ps.setString(3, t.getEmail());
            ps.setString(4, t.getImage());
            ps.setInt(5, t.getId());
            ps.executeUpdate();
        } 
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void delete(Account t) {
    }
}
