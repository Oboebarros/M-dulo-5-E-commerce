package com.ejemplo.servlet;

import com.ejemplo.dao.ProductoDAO;
import com.ejemplo.modelo.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductosServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null) accion = "listar";
        try {
            switch (accion) {
                case "nuevo"    -> mostrarFormulario(req, resp, null);
                case "editar"   -> mostrarEditar(req, resp);
                case "eliminar" -> mostrarConfirmar(req, resp);
                default         -> listar(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");
        try {
            switch (accion != null ? accion : "") {
                case "crear"      -> crear(req, resp);
                case "actualizar" -> actualizar(req, resp);
                case "eliminar"   -> eliminar(req, resp);
                default -> resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        String nombre    = req.getParameter("nombre");
        String categoria = req.getParameter("categoria");
        List<Producto> lista = (nombre != null || categoria != null)
                ? dao.buscar(nombre, categoria)
                : dao.listar();
        req.setAttribute("lista",      lista);
        req.setAttribute("categorias", dao.listarCategorias());
        req.setAttribute("nombre",     nombre);
        req.setAttribute("categoria",  categoria);
        req.getRequestDispatcher("/WEB-INF/views/lista.jsp").forward(req, resp);
    }

    private void mostrarFormulario(HttpServletRequest req, HttpServletResponse resp, Producto producto)
            throws SQLException, ServletException, IOException {
        req.setAttribute("producto",   producto);
        req.setAttribute("categorias", dao.listarCategorias());
        req.getRequestDispatcher("/WEB-INF/views/formulario.jsp").forward(req, resp);
    }

    private void mostrarEditar(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Producto p = dao.buscarPorId(id);
        mostrarFormulario(req, resp, p);
    }

    private void mostrarConfirmar(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Producto p = dao.buscarPorId(id);
        req.setAttribute("producto", p);
        req.getRequestDispatcher("/WEB-INF/views/confirmar-eliminar.jsp").forward(req, resp);
    }

    private void crear(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        Producto p = extraerProducto(req, 0);
        String error = validar(p);
        
        if (error != null) {
            req.setAttribute("error", error);
            mostrarFormulario(req, resp, p);
            return;
        }

        dao.agregar(p);
        req.getSession().setAttribute("mensaje", "Producto '" + p.getNombre() + "' creado exitosamente.");
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void actualizar(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Producto p = extraerProducto(req, id);
        String error = validar(p);

        if (error != null) {
            req.setAttribute("error", error);
            mostrarFormulario(req, resp, p);
            return;
        }

        dao.actualizar(p);
        req.getSession().setAttribute("mensaje", "Producto '" + p.getNombre() + "' actualizado exitosamente.");
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private String validar(Producto p) {
        if (p.getNombre() == null || p.getNombre().trim().isEmpty()) {
            return "El nombre del producto es obligatorio.";
        }
        if (p.getCategoria() == null || p.getCategoria().trim().isEmpty()) {
            return "La categoría es obligatoria.";
        }
        if (p.getPrecio() <= 0) {
            return "El precio debe ser un número mayor a 0.";
        }
        return null;
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        dao.eliminar(id);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private Producto extraerProducto(HttpServletRequest req, int id) {
        Producto p = new Producto();
        p.setId(id);
        p.setNombre(req.getParameter("nombre"));
        p.setDescripcion(req.getParameter("descripcion"));
        p.setDescripcionLarga(req.getParameter("descripcion_larga"));
        p.setCategoria(req.getParameter("categoria"));
        p.setSubcategoria(req.getParameter("subcategoria"));
        p.setImagenUrl(req.getParameter("imagenUrl"));
        p.setMaterial(req.getParameter("material"));
        p.setNivel(req.getParameter("nivel"));
        try {
            p.setPrecio(Double.parseDouble(req.getParameter("precio")));
        } catch (Exception e) {
            p.setPrecio(0);
        }
        return p;
    }
}