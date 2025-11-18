<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Tic Tac Toe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background: linear-gradient(135deg, #6dd5fa, #2980b9);
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        h1 {
            font-size: 3em;
            margin-bottom: 20px;
        }
        a {
            display: inline-block;
            background-color: white;
            color: #2980b9;
            padding: 12px 25px;
            text-decoration: none;
            font-size: 1.2em;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        a:hover {
            background-color: #2980b9;
            color: white;
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <h1>Welcome to Tic Tac Toe 🎮</h1>
    <p>Click below to start playing!</p>
    <a href="game">Start Game</a>
</body>
</html>
