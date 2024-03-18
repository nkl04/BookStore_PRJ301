/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
/**
 *
 * @author Win
 */
public abstract class DAO<T> extends DBContext{
    protected PreparedStatement ps = null;
    protected ResultSet rs = null;
    
    public abstract List<T> getAll();

    public abstract T get(int id);

    public abstract void save(T t);

    public abstract void update(T t);

    public abstract void delete(T t);
}
