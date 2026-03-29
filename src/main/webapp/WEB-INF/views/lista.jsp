<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #16213e; border-bottom: 2px solid #c9a84c; }
        .navbar-brand { color: #c9a84c !important; font-weight: bold; letter-spacing: 1px; }
        
        .card { background-color: #16213e; border: 1px solid rgba(201,168,76,0.2); border-radius: 15px; }
        
        /* TABLA MODERNA */
        .table { color: #e0e0e0; border-collapse: separate; border-spacing: 0 8px; }
        .table thead th { 
            background-color: transparent; 
            color: #c9a84c; 
            border: none; 
            text-transform: uppercase; 
            font-size: 0.8rem; 
            letter-spacing: 1px;
            padding: 15px;
        }
        .table tbody tr { 
            background-color: #1a1a2e; 
            transition: 0.3s; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .table tbody tr:hover { transform: scale(1.01); background-color: #1f1f3a; }
        .table td { border: none; padding: 15px; vertical-align: middle; }
        .table td:first-child { border-top-left-radius: 10px; border-bottom-left-radius: 10px; }
        .table td:last-child { border-top-right-radius: 10px; border-bottom-right-radius: 10px; }

        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; border: none; font-weight: bold; border-radius: 50px; 
            transition: 0.3s;
        }
        .btn-gold:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(201,168,76,0.4); color: #1a1a2e; }
        
        .search-input { 
            background-color: #0f1123; 
            border: 1px solid rgba(201,168,76,0.3); 
            color: #e0e0e0; 
            border-radius: 10px;
        }
        .search-input:focus { background-color: #0f1123; border-color: #c9a84c; color: #fff; box-shadow: none; }
        
        .form-select { 
            background-color: #0f1123; 
            border: 1px solid rgba(201,168,76,0.3); 
            color: #e0e0e0; 
            border-radius: 10px;
        }

        h2 { color: #c9a84c; font-weight: bold; }
        .precio-gold { color: #c9a84c; font-weight: bold; font-size: 1.1rem; }
        
        .tag { font-size: 0.75rem; padding: 4px 12px; border-radius: 50px; font-weight: 600; }
        .tag-inst { background: rgba(201,168,76,0.1); color: #c9a84c; border: 1px solid rgba(201,168,76,0.3); }
        .tag-herr { background: rgba(52,152,219,0.1); color: #54a0ff; border: 1px solid rgba(52,152,219,0.3); }
        .tag-acc  { background: rgba(46,204,113,0.1); color: #2ecc71; border: 1px solid rgba(46,204,113,0.3); }
        
        .product-img-mini { width: 45px; height: 45px; object-fit: contain; background: white; border-radius: 8px; padding: 3px; }

        @media (max-width: 768px) {
            .table thead { display: none; }
            .table tbody tr { display: block; margin-bottom: 1rem; border-radius: 15px; padding: 10px; }
            .table td { display: flex; justify-content: space-between; align-items: center; text-align: right; padding: 8px 15px; }
            .table td::before { content: attr(data-label); font-weight: bold; color: #c9a84c; text-align: left; }
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg px-4 mb-4 sticky-top">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">🎵 OBOEMARKET ADMIN</a>
    <div class="ms-auto">
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-outline-light btn-sm" style="border-color: #c9a84c; color: #c9a84c;">
            Ver Tienda
        </a>
    </div>
</nav>

<div class="container-fluid px-4">

    <c:if test="${not empty sessionScope.mensaje}">
        <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" style="background-color: #2ecc71; color: white;">
            <c:out value="${sessionScope.mensaje}"/>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="mensaje" scope="session"/>
    </c:if>

    <div class="row mb-4 align-items-center">
        <div class="col-md-6">
            <h2>Panel de Gestión</h2>
            <p class="text-muted small">Administra el inventario de productos y categorías.</p>
        </div>
        <div class="col-md-6 text-md-end">
            <a href="${pageContext.request.contextPath}/admin/products?accion=nuevo"
               class="btn btn-gold px-4 py-2">+ REGISTRAR PRODUCTO</a>
        </div>
    </div>

    <!-- Filtros -->
    <div class="card p-4 mb-4 border-0 shadow-sm">
        <form method="get" action="${pageContext.request.contextPath}/admin/products" class="row g-3">
            <div class="col-md-5">
                <label class="small text-muted mb-1">Buscar por nombre</label>
                <input type="text" name="nombre" class="form-control search-input"
                       placeholder="Ej: Oboe, Caña, Estuche..."
                       value="<c:out value='${nombre}'/>">
            </div>
            <div class="col-md-4">
                <label class="small text-muted mb-1">Categoría</label>
                <select name="categoria" class="form-select">
                    <option value="">-- Todas --</option>
                    <c:forEach var="cat" items="${categorias}">
                        <option value="${cat}" ${cat == categoria ? 'selected' : ''}><c:out value="${cat}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 d-flex align-items-end gap-2">
                <button type="submit" class="btn btn-gold w-100">FILTRAR</button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">✖</a>
            </div>
        </form>
    </div>

    <!-- Tabla -->
    <div class="table-responsive">
        <table class="table align-middle">
            <thead>
                <tr>
                    <th width="80">ID</th>
                    <th>Producto</th>
                    <th>Categoría</th>
                    <th class="d-none d-lg-table-cell">Subcategoría</th>
                    <th class="text-end">Precio</th>
                    <th class="text-center" width="150">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${lista}">
                    <tr>
                        <td data-label="ID" class="text-muted">#${p.id}</td>
                        <td data-label="Producto">
                            <div class="d-flex align-items-center gap-3">
                                <img src="${pageContext.request.contextPath}/${p.imagenUrl}" class="product-img-mini" alt="">
                                <div class="fw-bold"><c:out value="${p.nombre}"/></div>
                            </div>
                        </td>
                        <td data-label="Categoría">
                            <c:choose>
                                <c:when test="${p.categoria == 'Instrumentos'}"><span class="tag tag-inst">Instrumento</span></c:when>
                                <c:when test="${p.categoria == 'Herramientas'}"><span class="tag tag-herr">Herramienta</span></c:when>
                                <c:otherwise><span class="tag tag-acc"><c:out value="${p.categoria}"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="Subcategoría" class="d-none d-lg-table-cell text-muted small">
                            <c:out value="${p.subcategoria}"/>
                        </td>
                        <td data-label="Precio" class="text-end precio-gold">
                            $<fmt:formatNumber value="${p.precio}" pattern="#,##0"/>
                        </td>
                        <td data-label="Acciones" class="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <a href="${pageContext.request.contextPath}/admin/products?accion=editar&id=${p.id}"
                                   class="btn btn-sm btn-outline-warning" title="Editar">✏️</a>
                                <a href="${pageContext.request.contextPath}/admin/products?accion=eliminar&id=${p.id}"
                                   class="btn btn-sm btn-outline-danger" title="Eliminar">🗑️</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty lista}">
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <div class="text-muted">No se encontraron productos con los filtros aplicados.</div>
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-link text-gold">Ver todos</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
