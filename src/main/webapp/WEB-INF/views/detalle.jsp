<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — <c:out value="${p.nombre}"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #16213e; border-bottom: 2px solid #c9a84c; }
        .navbar-brand { color: #c9a84c !important; font-weight: bold; letter-spacing: 1px; }
        
        .product-container { margin-top: 3rem; margin-bottom: 5rem; }
        
        .img-card { 
            background: #fff; 
            border-radius: 20px; 
            padding: 40px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 450px;
            border: 1px solid rgba(201,168,76,0.2);
            overflow: hidden; /* Evita que la imagen se salga del contenedor */
            position: relative;
        }
        .img-card img { 
            max-width: 100%; 
            max-height: 400px; 
            object-fit: contain; 
            image-rendering: -webkit-optimize-contrast;
            transition: transform 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
            transform-origin: center center;
            cursor: zoom-in;
        }
        
        /* LIGHTBOX PARA ZOOM CENTRADO */
        #lightbox {
            display: none;
            position: fixed;
            z-index: 9999;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(15, 17, 35, 0.95);
            backdrop-filter: blur(10px);
            align-items: center;
            justify-content: center;
            cursor: zoom-out;
        }
        #lightbox img {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
            border-radius: 10px;
            box-shadow: 0 0 50px rgba(0,0,0,0.5);
            animation: zoomIn 0.3s ease-out;
            background: white;
            padding: 20px;
        }
        @keyframes zoomIn {
            from { transform: scale(0.5); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .detail-card { 
            background-color: #16213e; 
            border-radius: 20px; 
            padding: 40px; 
            height: 100%;
            border: 1px solid rgba(201,168,76,0.15);
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
        }
        
        .cat-tag { 
            display: inline-block; 
            background: rgba(201,168,76,0.15); 
            color: #c9a84c; 
            padding: 6px 18px; 
            border-radius: 50px; 
            font-size: 0.85rem; 
            font-weight: bold; 
            margin-bottom: 1.2rem;
            text-transform: uppercase;
            border: 1px solid rgba(201,168,76,0.2);
        }
        
        h1 { color: #fff; font-weight: 800; margin-bottom: 0.5rem; letter-spacing: -0.5px; }
        .price-display { color: #c9a84c; font-size: 2.8rem; font-weight: 800; margin: 1.5rem 0; text-shadow: 0 2px 10px rgba(0,0,0,0.3); }
        
        .spec-item { margin-bottom: 1.5rem; border-bottom: 1px solid rgba(255,255,255,0.08); padding-bottom: 12px; }
        .spec-label { color: #888; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 4px; }
        .spec-value { color: #fff; font-weight: 600; font-size: 1.1rem; }

        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; border: none; font-weight: 800; border-radius: 50px; 
            padding: 18px 40px; font-size: 1.1rem;
            transition: 0.3s;
            width: 100%;
            letter-spacing: 1px;
        }
        .btn-gold:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(201,168,76,0.5); color: #1a1a2e; }
        
        .description-text { line-height: 1.8; color: #ccc; margin: 2.5rem 0; padding: 20px; background: rgba(0,0,0,0.2); border-radius: 15px; border-left: 4px solid #c9a84c; }
        .description-text h5 { color: #c9a84c; font-weight: bold; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 15px; }
        
        footer {
            background-color: #16213e;
            color: #aaa;
            padding: 3rem 0;
            margin-top: 5rem;
            border-top: 1px solid rgba(201,168,76,0.2);
        }
        footer h5 { color: #c9a84c; font-weight: bold; margin-bottom: 1.5rem; }
        footer a { color: #aaa; text-decoration: none; transition: 0.3s; }
        footer a:hover { color: #c9a84c; }
        .contact-info p { margin-bottom: 8px; }
    </style>
</head>
<body>

<!-- Contenedor para el zoom centrado -->
<div id="lightbox" onclick="this.style.display='none'">
    <img src="${pageContext.request.contextPath}/${p.imagenUrl}" alt="Zoom">
</div>

<nav class="navbar px-4 mb-4 sticky-top">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">🎵 OBOEMARKET</a>
    <div class="ms-auto">
        <a href="catalogo" class="btn btn-outline-light btn-sm" style="border-color: #c9a84c; color: #c9a84c;">
            ← Volver al Catálogo
        </a>
    </div>
</nav>

<div class="container product-container">
    <div class="row g-5">
        <!-- Imagen -->
        <div class="col-lg-6">
            <div class="img-card" onclick="document.getElementById('lightbox').style.display='flex'">
                <img src="${pageContext.request.contextPath}/${p.imagenUrl}" alt="${p.nombre}">
                <div class="position-absolute bottom-0 end-0 p-3">
                    <span class="badge bg-dark opacity-75">🔍 Clic para ampliar</span>
                </div>
            </div>
        </div>
        
        <!-- Detalles -->
        <div class="col-lg-6">
            <div class="detail-card shadow">
                <span class="cat-tag">${p.categoria}</span>
                <h1><c:out value="${p.nombre}"/></h1>
                <p class="text-muted"><c:out value="${p.descripcion}"/></p>
                
                <div class="price-display">
                    $<fmt:formatNumber value="${p.precio}" pattern="#,##0"/>
                </div>

                <div class="row mb-4">
                    <c:if test="${not empty p.material}">
                        <div class="col-6 spec-item">
                            <div class="spec-label">Material</div>
                            <div class="spec-value"><c:out value="${p.material}"/></div>
                        </div>
                    </c:if>
                    <c:if test="${not empty p.nivel}">
                        <div class="col-6 spec-item">
                            <div class="spec-label">Nivel</div>
                            <div class="spec-value"><c:out value="${p.nivel}"/></div>
                        </div>
                    </c:if>
                    <c:if test="${not empty p.subcategoria}">
                        <div class="col-6 spec-item">
                            <div class="spec-label">Línea</div>
                            <div class="spec-value"><c:out value="${p.subcategoria}"/></div>
                        </div>
                    </c:if>
                </div>

                <form action="carrito" method="POST" class="mt-auto">
                    <input type="hidden" name="accion" value="agregar">
                    <input type="hidden" name="productoId" value="${p.id}">
                    <div class="d-flex gap-3 align-items-center">
                        <input type="number" name="cantidad" value="1" min="1" class="form-control" style="width: 80px; background: #1a1a2e; border-color: #c9a84c; color: #fff;">
                        <button class="btn btn-gold">AÑADIR AL CARRITO</button>
                    </div>
                </form>

                <div class="description-text">
                    <h5 class="text-white mb-3">Descripción Detallada</h5>
                    <p>${not empty p.descripcionLarga ? p.descripcionLarga : 'No hay una descripción detallada disponible para este producto.'}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5>OboeMarket</h5>
                <p>Tu tienda premium especializada en oboes, cañas y herramientas para el músico profesional y en formación.</p>
                <div class="mt-3">
                    <a href="#" class="me-3 text-decoration-none">Facebook</a>
                    <a href="#" class="me-3 text-decoration-none">Instagram</a>
                    <a href="#" class="text-decoration-none">YouTube</a>
                </div>
            </div>
            <div class="col-md-4 contact-info">
                <h5>Contacto</h5>
                <p>📍 Caupolican 889, Ciudad de la Música</p>
                <p>📞 +56 9 1234 5678</p>
                <p>📧 contacto@oboemarket.cl</p>
                <p>🕒 Lun - Vie: 9:00 - 18:30</p>
            </div>
            <div class="col-md-4">
                <h5>Atención al Cliente</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-decoration-none text-muted">Preguntas Frecuentes</a></li>
                    <li><a href="#" class="text-decoration-none text-muted">Envíos y Devoluciones</a></li>
                    <li><a href="#" class="text-decoration-none text-muted">Garantía de Instrumentos</a></li>
                    <li><a href="#" class="text-decoration-none text-muted">Términos y Condiciones</a></li>
                </ul>
            </div>
        </div>
        <hr class="my-4 border-secondary opacity-25">
        <div class="text-center small text-muted">
            &copy; 2024 OboeMarket. Todos los derechos reservados.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
