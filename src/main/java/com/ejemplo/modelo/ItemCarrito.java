package com.ejemplo.modelo;

public class ItemCarrito {

    private int productoId;
    private String nombre;
    private double precio;
    private int cantidad;
    private String imagenUrl;
    private String nivel;

    public ItemCarrito() {}

    public ItemCarrito(int productoId, String nombre, double precio,
                       int cantidad, String imagenUrl, String nivel) {
        this.productoId = productoId;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
        this.imagenUrl = imagenUrl;
        this.nivel = nivel;
    }

    public double getSubtotal() {
        return precio * cantidad;
    }

    public int getProductoId() { return productoId; }
    public void setProductoId(int productoId) { this.productoId = productoId; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }
    public String getNivel() { return nivel; }
    public void setNivel(String nivel) { this.nivel = nivel; }
}