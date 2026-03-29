package com.ejemplo.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

    private static final String URL      = "jdbc:mysql://localhost:3306/oboemarket_db?serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String USUARIO  = "root";
    private static final String PASSWORD = "Leobo32$";

    private static Connection instancia = null;

    private ConexionDB() {}

    public static Connection getConexion() throws SQLException {
        if (instancia == null || instancia.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                instancia = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            } catch (ClassNotFoundException e) {
                throw new SQLException("Driver MySQL no encontrado", e);
            }
        }
        return instancia;
    }
}