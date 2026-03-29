<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OboeMarket — Compra Exitosa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f1123; color: #e0e0e0; font-family: 'Segoe UI', sans-serif; height: 100vh; display: flex; align-items: center; }
        .success-card { 
            background-color: #16213e; 
            border-radius: 20px; 
            padding: 4rem 2rem; 
            text-align: center; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.4);
            max-width: 600px;
            margin: auto;
            border: 1px solid rgba(201,168,76,0.2);
        }
        .success-icon { font-size: 5rem; color: #c9a84c; margin-bottom: 2rem; display: block; }
        h1 { color: #fff; font-weight: bold; margin-bottom: 1.5rem; }
        p { color: #fff; font-size: 1.2rem; line-height: 1.6; margin-bottom: 2.5rem; }
        .btn-gold { 
            background: linear-gradient(45deg, #c9a84c, #e0c070); 
            color: #1a1a2e; border: none; padding: 1.2rem 3.5rem; border-radius: 50px; 
            font-weight: bold; text-decoration: none; display: inline-block; transition: 0.3s;
            font-size: 1.1rem;
        }
        .btn-gold:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(201,168,76,0.5); color: #1a1a2e; }
        .small-info { color: #aaa; font-size: 0.9rem; margin-top: 1rem; }
    </style>
</head>
<body>

<div class="container">
    <div class="success-card shadow-lg">
        <span class="success-icon">✨</span>
        <h1>¡Pedido Confirmado!</h1>
        <p>${mensaje}</p>
        <div class="small-info mb-4">
            Un resumen de su compra ha sido enviado a su correo electrónico registrado.
        </div>
        <a href="catalogo" class="btn btn-gold">VOLVER A LA TIENDA</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
