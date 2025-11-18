<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Player</title>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #bbdefb, #e3f2fd);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        background: white;
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        text-align: center;
    }
    h1 {
        color: #0d47a1;
        margin-bottom: 30px;
    }
    button {
        background-color: #1976d2;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 8px;
        font-size: 18px;
        cursor: pointer;
        margin: 10px;
        width: 80%;
    }
    button:hover {
        background-color: #0d47a1;
    }
</style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= session.getAttribute("username") %> 🎮</h1>
    <p>Choose how you want to play:</p>

    <form action="playerNames.jsp" method="get">
        <button type="submit">👥 Play with Two Players</button>
    </form>
    
    <form action="logout" method="get">
        <button style="background-color:#ef5350;">🚪 Logout</button>
    </form>
</div>

</body>
</html>
