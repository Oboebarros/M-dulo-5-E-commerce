package com.ejemplo.servlet;

import com.ejemplo.dao.ProductoDAO;
import com.ejemplo.modelo.ItemCarrito;
import com.ejemplo.modelo.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Simplemente mostramos la vista del carrito
        req.getRequestDispatcher("/WEB-INF/views/carrito.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");

        // Centralizamos las acciones del carrito
        switch (accion != null ? accion : "") {
            case "agregar"   -> agregar(req, resp);
            case "eliminar"  -> eliminar(req, resp);
            case "vaciar"    -> vaciar(req, resp);
            case "finalizar" -> finalizar(req, resp);
            default -> resp.sendRedirect(req.getContextPath() + "/carrito");
        }
    }

    private void finalizar(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession();
        List<ItemCarrito> carrito = obtenerCarrito(session);
        
        if (carrito.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrito");
            return;
        }

        // Simular procesamiento de pago y vaciar el carrito
        session.removeAttribute("carrito");
        req.setAttribute("mensaje", "¡Gracias por su compra! Su pedido ha sido procesado con éxito.");
        req.getRequestDispatcher("/WEB-INF/views/exito.jsp").forward(req, resp);
    }

    private void agregar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            String idStr = req.getParameter("productoId");
            if (idStr == null) idStr = req.getParameter("id");
            
            // Leemos la cantidad (si viene del detalle.jsp)
            String cantStr = req.getParameter("cantidad");
            int cantidadAAgregar = (cantStr != null) ? Integer.parseInt(cantStr) : 1;

            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Producto p = dao.buscarPorId(id);

                if (p != null) {
                    HttpSession session = req.getSession();
                    List<ItemCarrito> carrito = obtenerCarrito(session);

                    boolean encontrado = false;
                    for (ItemCarrito item : carrito) {
                        if (item.getProductoId() == id) {
                            item.setCantidad(item.getCantidad() + cantidadAAgregar);
                            encontrado = true;
                            break;
                        }
                    }

                    if (!encontrado) {
                        carrito.add(new ItemCarrito(
                                p.getId(),
                                p.getNombre(),
                                p.getPrecio(),
                                cantidadAAgregar,
                                p.getImagenUrl(),
                                p.getNivel()
                        ));
                    }
                    session.setAttribute("carrito", carrito);
                }
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/catalogo?msg=agregado");
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        try {
            String idStr = req.getParameter("productoId");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                HttpSession session = req.getSession();
                List<ItemCarrito> carrito = obtenerCarrito(session);

                carrito.removeIf(item -> item.getProductoId() == id);
                session.setAttribute("carrito", carrito);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/carrito");
    }

    private void vaciar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        req.getSession().removeAttribute("carrito");
        resp.sendRedirect(req.getContextPath() + "/carrito");
    }

    @SuppressWarnings("unchecked")
    private List<ItemCarrito> obtenerCarrito(HttpSession session) {
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }
        return carrito;
    }
}