/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Win
 */
public class DataItem {
        private String category;
        private int value;

        public DataItem(String category, int value) {
            this.category = category;
            this.value = value;
        }

        public String getCategory() {
            return category;
        }

        public int getValue() {
            return value;
        }
    }
