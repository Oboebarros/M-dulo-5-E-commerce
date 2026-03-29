# 🎵 OboeMarket — E-commerce (Módulo 5)

Este proyecto es una aplicación web Java (Jakarta EE) desarrollada para el **Módulo 5** del Bootcamp. Implementa un sistema de gestión de inventario (Admin) para una tienda especializada en oboes y accesorios, siguiendo el patrón de diseño **MVC** (Modelo-Vista-Controlador) y utilizando **DAO** (Data Access Object) para la persistencia de datos.

---

## 🚀 Requisitos de Ejecución

- **JDK 17** o superior.
- **Apache Tomcat 10.1** o superior.
- **MySQL 8.0** o superior.
- **Maven 3.8+** (incluido en el IDE).

---

## 🛠️ Instrucciones de Instalación

1.  **Configurar Base de Datos**:
    - Ejecuta el script `schema.sql` en tu servidor MySQL para crear la base de datos `oboemarket_db` y las tablas necesarias.
    - Revisa y ajusta las credenciales en la clase `com.ejemplo.dao.ConexionDB.java` si es necesario.

2.  **Compilar el Proyecto**:
    - Ejecuta el siguiente comando Maven para generar el archivo WAR:
      ```bash
      mvn clean package
      ```

3.  **Desplegar en Tomcat**:
    - Copia el archivo `target/OboeMarket.war` en la carpeta `webapps/` de tu servidor Tomcat.
    - Inicia Tomcat y accede a `http://localhost:8080/OboeMarket`.

---

## 🛣️ Rutas Principales

### 🛒 Área de Cliente (Catálogo)
- **Inicio**: `/index.jsp` (Landing page moderna).
- **Catálogo**: `/catalogo` (Vista de productos con búsqueda y filtros).
- **Detalle de Producto**: `/catalogo?accion=detalle&id=X` (Vista técnica con zoom).
- **Carrito**: `/carrito` (Gestión de compras).

### 🛠️ Área de Administración (CRUD)
- **Listado**: `/admin/products` (Panel con búsqueda por nombre y categoría).
- **Nuevo**: `/admin/products?accion=nuevo` (Formulario con pre-visualización de imagen).
- **Editar**: `/admin/products?accion=editar&id=X` (Edición de datos existentes).
- **Eliminar**: `/admin/products?accion=eliminar&id=X` (Confirmación antes de borrar).

---

## 📋 Cumplimiento de Rúbrica

- ✅ **Vistas JSP**: Uso extensivo de JSTL (`c:forEach`, `c:if`, `c:out`, `fmt:formatNumber`).
- ✅ **Servlets**: Controladores robustos para GET/POST, manejo de sesiones y navegación.
- ✅ **JDBC/DAO**: Conexión Singleton, `PreparedStatement` y cierre automático de recursos (`try-with-resources`).
- ✅ **MVC**: Clara separación entre modelos (DTO), lógica de datos (DAO), controladores (Servlets) y vistas (JSP).
- ✅ **CRUD Completo**: Implementación de listar, buscar, filtrar, crear, editar y eliminar con validaciones.
- ✅ **Validaciones**: Servidor (Java) y cliente (HTML5/Bootstrap) para campos obligatorios y precios positivos.
- ✅ **Despliegue**: Proyecto empaquetado como WAR compatible con Tomcat 10.

---

## 📝 Repositorio GitHub
[https://github.com/TuUsuario/OboeMarket](https://github.com/TuUsuario/OboeMarket)

---

> **Nota**: Este proyecto forma parte del entregable MVP enfocado en las capacidades del **Administrador**. El flujo de compra completo y roles de usuario se profundizarán en el siguiente módulo.
