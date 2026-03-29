<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: #0f1123;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 0;
        }
        .hero-section {
            flex-grow: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: radial-gradient(circle at center, #16213e 0%, #0f1123 100%);
        }
        .splash-card {
            background-color: #16213e;
            border-radius: 20px;
            padding: 3rem 3.5rem;
            text-align: center;
            box-shadow: 0 8px 40px rgba(0,0,0,0.4);
            max-width: 450px;
            width: 100%;
            border: 1px solid rgba(201,168,76,0.2);
            transition: 0.3s;
        }
        .splash-card:hover { border-color: #c9a84c; transform: translateY(-5px); }
        .music-icon { font-size: 3rem; margin-bottom: 1rem; display: block; color: #c9a84c; }
        .brand-name { color: #c9a84c; font-size: 2.8rem; font-weight: bold; margin-bottom: 0.5rem; letter-spacing: 2px; }
        .tagline { color: #888; font-size: 0.85rem; letter-spacing: 4px; text-transform: uppercase; margin-bottom: 2.5rem; }
        .btn-entrar { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; border: none; padding: 1rem 3rem; border-radius: 50px; 
            font-weight: bold; font-size: 1rem; text-decoration: none; display: inline-block; 
            transition: 0.3s;
            box-shadow: 0 5px 15px rgba(201,168,76,0.3);
        }
        .btn-entrar:hover { transform: scale(1.05); box-shadow: 0 8px 25px rgba(201,168,76,0.5); color: #1a1a2e; }
        .links { margin-top: 2rem; display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; }
        .links a { color: #aaa; font-size: 0.9rem; text-decoration: none; transition: 0.2s; }
        .links a:hover { color: #c9a84c; }

        /* FOOTER */
        footer {
            background-color: #0a0c1a;
            color: #666;
            padding: 2rem 0;
            border-top: 1px solid rgba(201,168,76,0.1);
            text-align: center;
        }
    </style>
</head>
<body>
<div class="hero-section">
    <div class="splash-card">
        <span class="music-icon">🎶</span>
        <div class="brand-name">OboeMarket</div>
        <div class="tagline">Accesorios de Alta Gama</div>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn-entrar">
            Entrar a la Tienda
        </a>
        <div class="links">
            <a href="${pageContext.request.contextPath}/carrito">🛒 Carrito</a>
            <a href="${pageContext.request.contextPath}/admin/products">⚙️ Administración</a>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <div class="mb-2">📍 Av. Principal 123, Ciudad de la Música | 📧 contacto@oboemarket.cl</div>
        <div class="small">&copy; 2024 OboeMarket — Calidad Superior para Oboístas</div>
    </div>
</footer>
</body>
</html>
