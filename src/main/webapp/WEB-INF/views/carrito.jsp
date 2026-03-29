<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — Carrito</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #e0e0e0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { background-color: #16213e; border-bottom: 2px solid #c9a84c; }
        .navbar-brand { color: #c9a84c !important; font-weight: bold; letter-spacing: 1px; }

        /* Tarjetas y Contenedores */
        .card { background-color: #16213e; border: 1px solid rgba(201,168,76,0.2); border-radius: 15px; overflow: hidden; }
        h2 { color: #c9a84c; font-weight: 700; text-transform: uppercase; }

        /* Items del Carrito */
        .item-carrito { border-bottom: 1px solid rgba(201,168,76,0.1); transition: background 0.3s; }
        .item-carrito:hover { background-color: rgba(201,168,76,0.05); }
        .item-img-container { width: 80px; height: 80px; overflow: hidden; border-radius: 10px; background: white; border: 1px solid #c9a84c; }
        .item-img { width: 100%; height: 100%; object-fit: contain; padding: 5px; transition: 0.3s; image-rendering: -webkit-optimize-contrast; }
        .item-carrito:hover .item-img { transform: scale(1.2); }

        /* Tipografía y Colores */
        .nombre-producto { color: #ffffff; font-weight: 600; font-size: 1.1rem; margin-bottom: 0; }
        .nivel-tag { color: #c9a84c; font-size: 0.75rem; text-transform: uppercase; font-weight: bold; letter-spacing: 1px; }
        .precio-gold { color: #c9a84c; font-weight: bold; }

        /* Botones */
        .btn-gold { background: linear-gradient(45deg, #c9a84c, #e0c070); color: #1a1a2e; border: none; font-weight: bold; border-radius: 50px; transition: 0.3s; }
        .btn-gold:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(201,168,76,0.4); color: #1a1a2e; }
        .btn-remove { color: #ff4d4d; background: transparent; border: none; font-size: 1.2rem; transition: 0.2s; }
        .btn-remove:hover { color: #ff0000; transform: scale(1.2); }

        /* Resumen de Pago */
        .total-box { background: linear-gradient(145deg, #16213e, #0f3460); border: 1px solid #c9a84c; border-radius: 15px; padding: 25px; position: sticky; top: 20px; }
        .divider { border-color: rgba(201,168,76,0.3); opacity: 1; }
        .form-select { background-color: #1a1a2e; border: 1px solid #c9a84c; color: #e0e0e0; border-radius: 8px; }

        .empty-cart { 
            text-align: center; padding: 6rem 1rem; background: #1a1a2e; border: 1px solid rgba(201,168,76,0.3);
            border-radius: 20px;
        }
        .empty-cart .icon { font-size: 6rem; color: #c9a84c; opacity: 0.3; margin-bottom: 1.5rem; }
        .empty-cart h3 { color: #fff; font-weight: bold; margin-bottom: 1rem; }
        .empty-cart p { color: #aaa; font-size: 1.1rem; }

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
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg px-4 mb-4 sticky-top">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">🎵 OBOEMARKET</a>
    <div class="ms-auto">
        <a href="${pageContext.request.contextPath}/catalogo" class="btn btn-outline-light btn-sm" style="border-color: #c9a84c; color: #c9a84c;">
            ← Volver al Catálogo
        </a>
    </div>
</nav>

<div class="container pb-5 min-vh-100">
    <h2 class="mb-4">🛒 Resumen de Compra</h2>

    <c:choose>
        <c:when test="${empty sessionScope.carrito}">
            <div class="empty-cart shadow-lg">
                <div class="icon">🎷</div>
                <h3>Tu carrito está esperando un instrumento</h3>
                <p>Nuestra selección de oboes profesionales te está esperando.</p>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=Instrumentos" class="btn btn-gold mt-4 px-5 py-3">
                    VER INSTRUMENTOS
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <%-- LISTA DE PRODUCTOS --%>
                <div class="col-lg-8">
                    <div class="card shadow">
                        <c:forEach var="item" items="${sessionScope.carrito}">
                            <div class="d-flex align-items-center gap-3 gap-md-4 p-3 p-md-4 item-carrito">
                                <%-- Imagen --%>
                                <div class="item-img-container">
                                    <img src="${pageContext.request.contextPath}/${item.imagenUrl}" class="item-img" alt="${item.nombre}">
                                </div>

                                <%-- Info --%>
                                <div class="flex-grow-1">
                                    <div class="nivel-tag">Nivel: <c:out value="${item.nivel}"/></div>
                                    <h5 class="nombre-producto"><c:out value="${item.nombre}"/></h5>
                                    <div class="text-muted small">
                                        $<fmt:formatNumber value="${item.precio}" pattern="#,##0"/> x ${item.cantidad}
                                    </div>
                                </div>

                                <%-- Subtotal y Eliminar --%>
                                <div class="text-end">
                                    <div class="precio-gold mb-1" style="font-size: 1rem;">
                                        $<fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/>
                                    </div>
                                    <form method="post" action="${pageContext.request.contextPath}/carrito">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="productoId" value="${item.productoId}">
                                        <button type="submit" class="btn-remove" title="Eliminar producto">🗑️</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="mt-3 d-flex justify-content-start">
                        <form method="post" action="${pageContext.request.contextPath}/carrito">
                            <input type="hidden" name="accion" value="vaciar">
                            <button type="submit" class="btn btn-sm text-danger border-danger px-3">
                                Vaciar Carrito
                            </button>
                        </form>
                    </div>
                </div>

                <%-- RESUMEN DE PAGO --%>
                <div class="col-lg-4">
                    <div class="total-box shadow">
                        <c:set var="total" value="0"/>
                        <c:forEach var="item" items="${sessionScope.carrito}">
                            <c:set var="total" value="${total + item.subtotal}"/>
                        </c:forEach>

                        <div class="mb-4">
                            <label class="small text-muted mb-2 d-block">DIVISA DE PAGO</label>
                            <select id="moneda" class="form-select">
                                <option value="CLP">CLP — Pesos Chilenos</option>
                                <option value="USD">USD — Dólares</option>
                                <option value="EUR">EUR — Euros</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Ítems</span>
                            <span>${sessionScope.carrito.size()}</span>
                        </div>

                        <hr class="divider">

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="h5 mb-0">TOTAL</span>
                            <span class="h4 precio-gold mb-0 total-display" data-clp="${total}">
                                $<fmt:formatNumber value="${total}" pattern="#,##0"/>
                            </span>
                        </div>

                        <div class="d-grid gap-3">
                            <form action="${pageContext.request.contextPath}/carrito" method="POST">
                                <input type="hidden" name="accion" value="finalizar">
                                <button type="submit" class="btn btn-gold py-3 w-100">
                                    FINALIZAR COMPRA
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    <div class="container">
        <div class="row g-4">
            <div class="col-md-6">
                <h5>OboeMarket</h5>
                <p>Especialistas en oboes y accesorios de alta gama. Envíos a todo Chile y el mundo.</p>
                <p>📍 Av. Principal 123, Ciudad de la Música</p>
            </div>
            <div class="col-md-6 text-md-end">
                <h5>Contacto Directo</h5>
                <p>📞 +56 9 1234 5678</p>
                <p>📧 contacto@oboemarket.cl</p>
                <div class="mt-2">
                    <a href="#" class="me-3">Facebook</a>
                    <a href="#" class="me-3">Instagram</a>
                </div>
            </div>
        </div>
        <hr class="my-4 opacity-25">
        <div class="text-center small">
            &copy; 2024 OboeMarket. Todos los derechos reservados.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const tasas    = { CLP: 1, USD: 1/950, EUR: 1/1020 };
    const simbolos = { CLP: '$', USD: 'US$', EUR: '€' };
    const sel = document.getElementById('moneda');

    if (sel) {
        sel.addEventListener('change', function() {
            const moneda = this.value;
            document.querySelectorAll('.total-display').forEach(el => {
                const clp = parseFloat(el.getAttribute('data-clp'));
                const val = clp * tasas[moneda];
                el.textContent = simbolos[moneda] + new Intl.NumberFormat('es-CL', {
                    maximumFractionDigits: moneda === 'CLP' ? 0 : 2
                }).format(val);
            });
        });
    }
</script>
</body>
</html>