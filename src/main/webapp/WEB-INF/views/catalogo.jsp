<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — Catálogo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; }
        
        /* SIDEBAR RESPONSIVO */
        .sidebar { 
            background-color: #16213e; 
            border-right: 1px solid rgba(201,168,76,0.2);
            padding-bottom: 2rem;
        }
        @media (min-width: 768px) {
            .sidebar { min-height: 100vh; position: sticky; top: 0; }
        }
        
        .sidebar h3 { color: #c9a84c; padding: 20px; font-weight: bold; border-bottom: 1px solid rgba(201,168,76,0.1); margin-bottom: 0; }
        .nav-link { color: #aaa; transition: 0.3s; padding: 12px 20px; }
        .nav-link:hover, .nav-link.active { color: #c9a84c; background: rgba(201,168,76,0.1); border-left: 3px solid #c9a84c; }

        /* BANNERS DINÁMICOS */
        .banner-container {
            width: 100%; height: 250px; border-radius: 15px; margin-bottom: 2rem;
            background-size: cover; background-position: center; border: 1px solid #c9a84c;
            display: flex; align-items: center; justify-content: center;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.8);
            overflow: hidden;
            position: relative;
        }
        .banner-container::after {
            content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(rgba(15,17,35,0.2), rgba(15,17,35,0.6));
        }
        .banner-title { position: relative; z-index: 1; color: #fff; font-size: 2.5rem; font-weight: bold; text-transform: uppercase; letter-spacing: 2px; }

        /* TARJETAS ELEGANTES */
        .product-card {
            background-color: #16213e; border: 1px solid rgba(201,168,76,0.1);
            border-radius: 15px; overflow: hidden; height: 100%; transition: 0.3s;
            display: flex; flex-direction: column;
        }
        .product-card:hover { transform: translateY(-10px); border-color: #c9a84c; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        
        .img-container { 
            height: 250px; background: #fff; display: flex; align-items: center; 
            justify-content: center; padding: 20px; overflow: hidden;
            position: relative;
        }
        .img-container img { 
            max-height: 100%; max-width: 100%; object-fit: contain; 
            image-rendering: -webkit-optimize-contrast;
            transition: transform 0.5s ease;
        }
        .product-card:hover .img-container img {
            transform: scale(1.35); /* Zoom más pronunciado */
        }

        .card-body { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; }
        .price { color: #c9a84c; font-size: 1.4rem; font-weight: bold; }
        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #16213e; font-weight: bold; border: none; border-radius: 25px; 
            padding: 10px; transition: 0.3s;
        }
        .btn-gold:hover { transform: scale(1.05); box-shadow: 0 0 15px rgba(201,168,76,0.4); }
        
        /* TOAST PERSONALIZADO CENTRADO */
        .toast-container { 
            position: fixed; 
            top: 50%; 
            left: 50%; 
            transform: translate(-50%, -50%); 
            z-index: 2000; 
        }
        .toast-agregado { 
            background: #1a1a2e; border: 2px solid #c9a84c; color: #fff; 
            min-width: 350px; border-radius: 15px; box-shadow: 0 0 50px rgba(0,0,0,0.8);
            backdrop-filter: blur(10px);
        }
        .toast-agregado .toast-body { padding: 25px; font-size: 1.1rem; }
        .toast-agregado .btn-view-cart { color: #c9a84c; text-decoration: none; font-weight: bold; border-left: 1px solid rgba(201,168,76,0.2); padding-left: 15px; margin-left: 15px; }

        /* FOOTER */
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
        .contact-info i { color: #c9a84c; margin-right: 10px; }

        /* MOBILE OVERRIDES */
        @media (max-width: 767px) {
            .sidebar { border-right: none; border-bottom: 1px solid rgba(201,168,76,0.2); padding-bottom: 1rem; }
            .banner-container { height: 150px; }
            .banner-title { font-size: 1.5rem; }
            .img-container { height: 200px; }
        }
    </style>
</head>
<body>

<div class="container-fluid p-0">
    <div class="row g-0">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 sidebar">
            <h3>OboeMarket</h3>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link ${empty categoria ? 'active' : ''}" href="catalogo">
                        <span class="me-2">📁</span> Todos los Productos
                    </a>
                </li>
                <c:forEach var="cat" items="${categorias}">
                    <li class="nav-item">
                        <a class="nav-link ${cat == categoria ? 'active' : ''}" href="catalogo?categoria=${cat}">
                            <span class="me-2">🏷️</span> ${cat}
                        </a>
                    </li>
                </c:forEach>
                <li class="nav-item mt-4 px-3">
                    <a href="carrito" class="btn btn-outline-light w-100 btn-sm py-2" style="border-color: #c9a84c; color: #c9a84c;">
                        🛒 Mi Carrito
                    </a>
                </li>
                <li class="nav-item mt-2 px-3">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary w-100 btn-sm py-2">
                        ⚙️ Admin
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="col-md-9 col-lg-10 p-3 p-md-5">
            <!-- Notificación de Producto Agregado -->
            <div class="toast-container">
                <div id="cartToast" class="toast toast-agregado hide" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-body d-flex align-items-center">
                        <span class="me-auto">🛒 ¡Producto añadido al carrito!</span>
                        <a href="carrito" class="btn-view-cart">VER CARRITO</a>
                        <button type="button" class="btn-close btn-close-white ms-3" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </div>

            <c:if test="${not empty categoria}">
                <c:set var="bannerImg" value="banner_default.jpg"/>
                <c:choose>
                    <c:when test="${categoria == 'Instrumentos'}"><c:set var="bannerImg" value="fondo en instrumento.png"/></c:when>
                    <c:when test="${categoria == 'Herramientas'}"><c:set var="bannerImg" value="fondo de herramientas.png"/></c:when>
                </c:choose>
                
                <div class="banner-container" style="background-image: url('assets/img/${bannerImg}');">
                    <div class="banner-title">${categoria}</div>
                </div>
            </c:if>

            <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 row-cols-xl-4 g-4">
                <c:forEach var="p" items="${lista}">
                    <div class="col">
                        <div class="product-card">
                            <div class="img-container">
                                <a href="catalogo?accion=detalle&id=${p.id}">
                                    <img src="${p.imagenUrl}" alt="${p.nombre}" loading="lazy">
                                </a>
                            </div>
                            <div class="card-body">
                                <h5 class="text-white mb-1"><a href="catalogo?accion=detalle&id=${p.id}" class="text-decoration-none text-white">${p.nombre}</a></h5>
                                <p class="small text-muted mb-3 flex-grow-1">${p.descripcion}</p>
                                <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top border-secondary">
                                    <span class="price">$<fmt:formatNumber value="${p.precio}" pattern="#,##0"/></span>
                                    <div class="d-flex gap-2">
                                        <a href="catalogo?accion=detalle&id=${p.id}" class="btn btn-outline-light btn-sm px-2" style="border-color: #c9a84c; color: #c9a84c;">🔍</a>
                                        <form action="carrito" method="POST" class="m-0">
                                            <input type="hidden" name="accion" value="agregar">
                                            <input type="hidden" name="productoId" value="${p.id}">
                                            <button class="btn btn-gold btn-sm px-3">Añadir</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty lista}">
                <div class="text-center py-5">
                    <h3 class="text-muted">No se encontraron productos en esta categoría.</h3>
                    <a href="catalogo" class="btn btn-gold mt-3">Ver todo el catálogo</a>
                </div>
            </c:if>
        </main>
    </div>
</div>

<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5>OboeMarket</h5>
                <p>Tu tienda premium especializada en oboes, cañas y herramientas para el músico profesional y en formación.</p>
                <div class="mt-3">
                    <a href="#" class="me-3">Facebook</a>
                    <a href="#" class="me-3">Instagram</a>
                    <a href="#">YouTube</a>
                </div>
            </div>
            <div class="col-md-4 contact-info">
                <h5>Contacto</h5>
                <p>📍 Av. Principal 123, Ciudad de la Música</p>
                <p>📞 +56 9 1234 5678</p>
                <p>📧 contacto@oboemarket.cl</p>
                <p>🕒 Lun - Vie: 9:00 - 18:30</p>
            </div>
            <div class="col-md-4">
                <h5>Atención al Cliente</h5>
                <ul class="list-unstyled">
                    <li><a href="#">Preguntas Frecuentes</a></li>
                    <li><a href="#">Envíos y Devoluciones</a></li>
                    <li><a href="#">Garantía de Instrumentos</a></li>
                    <li><a href="#">Términos y Condiciones</a></li>
                </ul>
            </div>
        </div>
        <hr class="my-4 border-secondary opacity-25">
        <div class="text-center small">
            &copy; 2024 OboeMarket. Todos los derechos reservados.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Mostrar Toast si el producto fue agregado con éxito
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('msg') === 'agregado') {
        const toastEl = document.getElementById('cartToast');
        const toast = new bootstrap.Toast(toastEl, { delay: 5000 });
        toast.show();
    }
</script>
</body>
</html>