/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Win
 */
public class Genre {
    private int id;
    private String title;
    private String path;
    public Genre(int id, String title) {
        this.id = id;
        this.title = title;
        
    }

    public Genre() {
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
    
    public String getPath()
    {
        path = title.replaceAll(" ", "-");
        path = path.replace("&", "and");
        return path;
    }
    @Override
    public String toString() {
        return "Genre{" + "id=" + id + ", title=" + title + '}';
    }
    
    
}
