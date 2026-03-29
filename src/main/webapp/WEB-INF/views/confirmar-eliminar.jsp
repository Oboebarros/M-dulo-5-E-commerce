<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — Confirmar Eliminación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #16213e; border-bottom: 2px solid #c9a84c; }
        .navbar-brand { color: #c9a84c !important; font-weight: bold; letter-spacing: 1px; }
        .card { background-color: #16213e; border: 1px solid rgba(220,53,69,0.3); border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { color: #dc3545; font-weight: bold; }
        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; border: none; font-weight: bold; border-radius: 50px; 
            transition: 0.3s;
        }
        .btn-gold:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(201,168,76,0.4); color: #1a1a2e; }
        .btn-danger { border-radius: 50px; padding: 10px 25px; font-weight: bold; }
        .dato { color: #c9a84c; font-weight: bold; }
        .product-img-container { 
            background: #fff; 
            border-radius: 15px; 
            padding: 20px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin-bottom: 20px;
            border: 1px solid rgba(220,53,69,0.2);
        }
        .product-img { max-height: 180px; max-width: 100%; object-fit: contain; }
        .table { color: #e0e0e0; margin-bottom: 2rem; }
        .table td { border: none; padding: 8px 0; }
    </style>
</head>
<body>

<nav class="navbar px-4 mb-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">🎵 OBOEMARKET</a>
    <a href="${pageContext.request.contextPath}/admin/products"
       class="btn btn-sm btn-outline-light" style="border-color: #c9a84c; color: #c9a84c;">← Volver al Panel</a>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6 text-center">
            <h1 class="mb-4">🗑️ Confirmar Eliminación</h1>
            <div class="card p-4 p-md-5">
                <div class="product-img-container">
                    <img src="${pageContext.request.contextPath}/${producto.imagenUrl}"
                         class="product-img"
                         alt="<c:out value='${producto.nombre}'/>">
                </div>
                
                <h4 class="mb-4 text-white">¿Estás seguro que deseas eliminar este producto?</h4>
                <p class="text-muted mb-4">Esta acción no se puede deshacer y el producto desaparecerá del catálogo.</p>
                
                <div class="text-start mx-auto" style="max-width: 300px;">
                    <table class="table">
                        <tr><td class="text-muted small">ID:</td>        <td class="dato">#${producto.id}</td></tr>
                        <tr><td class="text-muted small">Nombre:</td>    <td class="dato"><c:out value="${producto.nombre}"/></td></tr>
                        <tr><td class="text-muted small">Categoría:</td> <td class="dato"><c:out value="${producto.categoria}"/></td></tr>
                        <tr><td class="text-muted small">Precio:</td>    <td class="dato">$<fmt:formatNumber value="${producto.precio}" pattern="#,##0"/></td></tr>
                    </table>
                </div>

                <div class="d-flex gap-3 justify-content-center mt-4">
                    <form method="post" action="${pageContext.request.contextPath}/admin/products">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id" value="${producto.id}">
                        <button type="submit" class="btn btn-danger px-4 py-2">SÍ, ELIMINAR</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/admin/products"
                       class="btn btn-gold px-4 py-2">CANCELAR</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
