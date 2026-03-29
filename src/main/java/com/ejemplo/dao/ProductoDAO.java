package com.ejemplo.dao;

import com.ejemplo.modelo.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    private Producto mapear(ResultSet rs) throws SQLException {
        return new Producto(
                rs.getInt("id"),
                rs.getString("nombre"),
                rs.getString("descripcion"),
                rs.getString("descripcion_larga"), // Nuevo campo
                rs.getDouble("precio"),
                rs.getString("categoria"),
                rs.getString("subcategoria"),
                rs.getString("imagen_url"),
                rs.getString("material"),          // Nuevo campo
                rs.getString("nivel")              // Nuevo campo
        );
    }

    public List<Producto> listar() throws SQLException {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos ORDER BY categoria, nombre";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        }
        return lista;
    }

    public List<Producto> buscar(String nombre, String categoria) throws SQLException {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos WHERE nombre LIKE ? AND categoria LIKE ? ORDER BY nombre";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + (nombre != null ? nombre : "") + "%");
            ps.setString(2, "%" + (categoria != null ? categoria : "") + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        }
        return lista;
    }

    public Producto buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM productos WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    public void agregar(Producto p) throws SQLException {
        String sql = "INSERT INTO productos (nombre, descripcion, descripcion_larga, precio, categoria, subcategoria, imagen_url, material, nivel) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getDescripcionLarga());
            ps.setDouble(4, p.getPrecio());
            ps.setString(5, p.getCategoria());
            ps.setString(6, p.getSubcategoria());
            ps.setString(7, p.getImagenUrl());
            ps.setString(8, p.getMaterial());
            ps.setString(9, p.getNivel());
            ps.executeUpdate();
        }
    }

    public void actualizar(Producto p) throws SQLException {
        String sql = "UPDATE productos SET nombre=?, descripcion=?, descripcion_larga=?, precio=?, categoria=?, subcategoria=?, imagen_url=?, material=?, nivel=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getDescripcionLarga());
            ps.setDouble(4, p.getPrecio());
            ps.setString(5, p.getCategoria());
            ps.setString(6, p.getSubcategoria());
            ps.setString(7, p.getImagenUrl());
            ps.setString(8, p.getMaterial());
            ps.setString(9, p.getNivel());
            ps.setInt(10, p.getId());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM productos WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<String> listarCategorias() throws SQLException {
        List<String> cats = new ArrayList<>();
        String sql = "SELECT DISTINCT categoria FROM productos ORDER BY categoria";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) cats.add(rs.getString("categoria"));
        }
        return cats;
    }
}