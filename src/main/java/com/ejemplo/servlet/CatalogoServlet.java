package com.ejemplo.servlet;

import com.ejemplo.dao.ProductoDAO;
import com.ejemplo.modelo.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        
        try {
            if ("detalle".equals(accion)) {
                mostrarDetalle(req, resp);
            } else {
                listar(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String q = req.getParameter("nombre");
        String cat = req.getParameter("categoria");

        List<Producto> lista = (q != null || cat != null)
                ? dao.buscar(q, cat)
                : dao.listar();

        req.setAttribute("lista", lista);
        req.setAttribute("categorias", dao.listarCategorias());
        req.setAttribute("nombre", q);
        req.setAttribute("categoria", cat);

        req.getRequestDispatcher("/WEB-INF/views/catalogo.jsp").forward(req, resp);
    }

    private void mostrarDetalle(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            Producto p = dao.buscarPorId(id);
            if (p != null) {
                req.setAttribute("p", p);
                req.getRequestDispatcher("/WEB-INF/views/detalle.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect("catalogo");
    }
}