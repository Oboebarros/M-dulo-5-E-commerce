<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — ${empty producto || producto.id == 0 ? 'Nuevo' : 'Editar'} Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #16213e; border-bottom: 2px solid #c9a84c; }
        .navbar-brand { color: #c9a84c !important; font-weight: bold; letter-spacing: 1px; }
        .card { background-color: #16213e; border: 1px solid rgba(201,168,76,0.2); border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .form-label { color: #c9a84c; font-weight: 600; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; }
        .form-control, .form-select { 
            background-color: #1a1a2e; 
            color: #e0e0e0; 
            border: 1px solid rgba(201,168,76,0.3); 
            border-radius: 10px;
            padding: 10px 15px;
        }
        .form-control:focus, .form-select:focus { 
            background-color: #1a1a2e; 
            color: #fff; 
            border-color: #c9a84c; 
            box-shadow: 0 0 10px rgba(201,168,76,0.2); 
        }
        h1 { color: #c9a84c; font-weight: bold; }
        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; 
            border: none; 
            font-weight: bold; 
            border-radius: 50px;
            padding: 12px 30px;
            transition: 0.3s;
        }
        .btn-gold:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(201,168,76,0.4); color: #1a1a2e; }
        .btn-outline-secondary { border-radius: 50px; padding: 12px 30px; border-color: #888; color: #888; }
        .preview-img-container {
            background: #fff;
            border-radius: 15px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 200px;
            border: 1px solid rgba(201,168,76,0.3);
            margin-top: 10px;
        }
        .preview-img { max-height: 180px; max-width: 100%; object-fit: contain; }
        .section-title { 
            border-bottom: 1px solid rgba(201,168,76,0.2); 
            padding-bottom: 10px; 
            margin-bottom: 20px; 
            color: #c9a84c; 
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>

<nav class="navbar px-4 mb-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">🎵 OBOEMARKET</a>
    <a href="${pageContext.request.contextPath}/admin/products"
       class="btn btn-sm btn-outline-light" style="border-color: #c9a84c; color: #c9a84c;">
       ← Volver al Panel
    </a>
</nav>

<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-12 col-lg-10">

            <h1 class="mb-4 text-center">
                ${empty producto || producto.id == 0 ? '➕ Registrar Nuevo Producto' : '✏️ Editar Información del Producto'}
            </h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    <c:out value="${error}"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card p-4 p-md-5">
                <form method="post" action="${pageContext.request.contextPath}/admin/products">
                    <input type="hidden" name="accion"
                           value="${empty producto || producto.id == 0 ? 'crear' : 'actualizar'}">
                    <c:if test="${not empty producto && producto.id != 0}">
                        <input type="hidden" name="id" value="${producto.id}">
                    </c:if>

                    <!-- Información Básica -->
                    <div class="section-title">📦 Información Básica</div>
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label class="form-label">Nombre del Producto *</label>
                            <input type="text" name="nombre" class="form-control"
                                   placeholder="Ej: Oboe Buffet Crampon Orfeo"
                                   value="<c:out value='${producto.nombre}'/>" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Precio (CLP) *</label>
                            <input type="number" name="precio" class="form-control"
                                   min="1" step="1" placeholder="Ej: 5000000"
                                   value="${producto.precio > 0 ? producto.precio : ''}" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Categoría *</label>
                            <select name="categoria" class="form-select" required>
                                <option value="">-- Selecciona --</option>
                                <option value="Instrumentos"   ${producto.categoria == 'Instrumentos'   ? 'selected' : ''}>Instrumentos</option>
                                <option value="Herramientas"   ${producto.categoria == 'Herramientas'   ? 'selected' : ''}>Herramientas</option>
                                <option value="Accesorios"     ${producto.categoria == 'Accesorios'     ? 'selected' : ''}>Accesorios</option>
                                <option value="Almacenamiento" ${producto.categoria == 'Almacenamiento' ? 'selected' : ''}>Almacenamiento</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Subcategoría</label>
                            <input type="text" name="subcategoria" class="form-control"
                                   placeholder="Ej: Profesional, Estudiante, etc."
                                   value="<c:out value='${producto.subcategoria}'/>">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Resumen (Descripción corta)</label>
                        <textarea name="descripcion" class="form-control" rows="2" 
                                  placeholder="Breve resumen para el catálogo..."><c:out value="${producto.descripcion}"/></textarea>
                    </div>

                    <!-- Detalles Técnicos -->
                    <div class="section-title mt-4">🔍 Detalles Técnicos</div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Material</label>
                            <input type="text" name="material" class="form-control"
                                   placeholder="Ej: Madera de Granadilla, Resina, etc."
                                   value="<c:out value='${producto.material}'/>">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nivel Recomendado</label>
                            <select name="nivel" class="form-select">
                                <option value="">-- Selecciona Nivel --</option>
                                <option value="Principiante" ${producto.nivel == 'Principiante' ? 'selected' : ''}>Principiante</option>
                                <option value="Intermedio"   ${producto.nivel == 'Intermedio'   ? 'selected' : ''}>Intermedio</option>
                                <option value="Avanzado"     ${producto.nivel == 'Avanzado'     ? 'selected' : ''}>Avanzado</option>
                                <option value="Profesional"  ${producto.nivel == 'Profesional'  ? 'selected' : ''}>Profesional</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Descripción Detallada</label>
                        <textarea name="descripcion_larga" class="form-control" rows="5" 
                                  placeholder="Especificaciones técnicas, historia, que incluye..."><c:out value="${producto.descripcionLarga}"/></textarea>
                    </div>

                    <!-- Multimedia -->
                    <div class="section-title mt-4">🖼️ Multimedia</div>
                    <div class="row align-items-center">
                        <div class="col-md-7 mb-3">
                            <label class="form-label">URL de la Imagen</label>
                            <input type="text" name="imagenUrl" id="imagenUrl" class="form-control"
                                   placeholder="assets/img/nombre-imagen.png"
                                   value="<c:out value='${producto.imagenUrl}'/>"
                                   oninput="previewImg(this.value)">
                            <p class="small text-muted mt-2">Recomendado: Imágenes PNG con fondo transparente.</p>
                        </div>
                        <div class="col-md-5 mb-3">
                            <label class="form-label d-block text-center">Vista Previa</label>
                            <div id="preview-container" class="preview-img-container">
                                <c:choose>
                                    <c:when test="${not empty producto.imagenUrl}">
                                        <img id="img-preview" class="preview-img"
                                             src="${pageContext.request.contextPath}/${producto.imagenUrl}"
                                             alt="Preview">
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted small">Sin imagen seleccionada</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-3 mt-5 justify-content-center">
                        <button type="submit" class="btn btn-gold px-5 py-3">
                            ${empty producto || producto.id == 0 ? '🚀 CREAR PRODUCTO' : '💾 GUARDAR CAMBIOS'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/products"
                           class="btn btn-outline-secondary px-5 py-3">CANCELAR</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewImg(url) {
        const container = document.getElementById('preview-container');
        if (!url) { 
            container.innerHTML = '<span class="text-muted small">Sin imagen seleccionada</span>'; 
            return; 
        }
        
        // Si la URL no empieza con http o assets, asumimos que falta el path relativo
        let fullUrl = url;
        if (!url.startsWith('http') && !url.startsWith('/')) {
            fullUrl = '${pageContext.request.contextPath}/' + url;
        }

        container.innerHTML = `<img id="img-preview" class="preview-img" src="${fullUrl}" alt="Preview" onerror="this.parentElement.innerHTML='<span class=\"text-danger small\">Error al cargar imagen</span>'">`;
    }
</script>
</body>
</html>
