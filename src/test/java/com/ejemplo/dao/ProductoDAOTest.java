package com.ejemplo.dao;

// 1. IMPORTAMOS la clase que ya existe en otro lado
import com.ejemplo.modelo.Producto;
import org.junit.jupiter.api.Test;
import java.sql.SQLException;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class ProductoDAOTest {

    private final ProductoDAO dao = new ProductoDAO();

    @Test
    void testListar() throws SQLException {
        // CAMBIO: El método listar() de tu DAO no recibe parámetros.
        List<Producto> lista = dao.listar();

        assertNotNull(lista, "La lista no debería ser nula");
        if (!lista.isEmpty()) {
            Producto p = lista.get(0);
            assertTrue(p.getPrecio() > 0, "El precio debe ser mayor a cero");
            assertNotNull(p.getNombre());
        }
    }
}