<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome | Tic Tac Toe</title>

<style>
body {
    font-family: 'Poppins', sans-serif;
    height: 100vh;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    
    /* Gradient animated background */
    background: linear-gradient(135deg, #00c6ff, #0072ff);
    animation: gradientBG 6s ease infinite alternate;
}
@keyframes gradientBG {
  0% { background: linear-gradient(135deg,#00c6ff,#0072ff); }
  100% { background: linear-gradient(135deg,#5100ff,#00eaff); }
}

/* floating bubbles */
.bubble {
  position: absolute;
  width: 80px;
  height: 80px;
  background: rgba(255,255,255,0.2);
  border-radius: 50%;
  filter: blur(2px);
  animation: float 6s infinite ease-in-out;
}
.b1{top:10%; left:20%; animation-delay:0s}
.b2{bottom:15%; right:15%; animation-delay:1.5s}
.b3{top:60%; left:5%; animation-delay:3s}
@keyframes float {
  0% { transform: translateY(0) scale(1); opacity: .6; }
  50% { transform: translateY(-25px) scale(1.1); opacity: 1; }
  100% { transform: translateY(0) scale(1); opacity: .6; }
}

/* glass card */
.container {
    background: rgba(255,255,255,0.17);
    padding: 45px;
    border-radius: 18px;
    text-align: center;
    backdrop-filter: blur(12px) saturate(160%);
    -webkit-backdrop-filter: blur(12px) saturate(160%);
    border: 1px solid rgba(255,255,255,0.45);
    box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    width: 380px;
}

/* animated title */
h1 {
    color: #fff;
    font-size: 32px;
    margin-bottom: 20px;
    font-weight: 700;
    text-shadow: 0 0 12px rgba(255,255,255,0.6);
    animation: glow 1.8s ease-in-out infinite alternate;
}
@keyframes glow {
    from { text-shadow: 0 0 10px #42e0ff, 0 0 30px #00d1ff; }
    to   { text-shadow: 0 0 18px #ffffff, 0 0 40px #27e6ff; }
}

/* buttons */
.btn {
    width: 100%;
    padding: 14px;
    margin: 10px 0;
    font-size: 18px;
    border: none;
    border-radius: 10px;
    background: rgba(255,255,255,0.28);
    color: #fff;
    backdrop-filter: blur(8px);
    cursor: pointer;
    letter-spacing: .5px;
    transition: .2s;
    text-shadow: 0 0 6px rgba(0,0,0,0.4);
}
.btn:hover {
    background: #00eaff;
    color: #002b55;
    box-shadow: 0 0 18px #00eaff;
    transform: translateY(-3px);
}

/* tagline */
.tagline {
    font-size: 14px;
    color: #eaffff;
    margin-bottom: 20px;
    opacity: .9;
}
</style>
</head>

<body>
<div class="bubble b1"></div>
<div class="bubble b2"></div>
<div class="bubble b3"></div>

<div class="container">
    <h1>✨ Tic Tac Toe 🎮</h1>
    <p class="tagline">A Smart Game Experience</p>

    <a href="login.jsp"><button class="btn">🔐 Login</button></a>
    <a href="signup.jsp"><button class="btn">✨ Sign Up</button></a>
</div>

<!-- click sound (optional) -->
<audio id="uiSound" src="sounds/click.mp3"></audio>
<script>
document.querySelectorAll(".btn").forEach(b=>{
    b.addEventListener("click", () => {
        let a = document.getElementById("uiSound");
        if(a) a.play();
    });
});
</script>

</body>
</html>


