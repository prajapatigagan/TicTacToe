<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Tic Tac Toe</title>

<style>
/* Gradient Background */
html,body{height:100%;}
body{
  margin:0;
  font-family:'Poppins',sans-serif;
  display:flex;justify-content:center;align-items:center;
  background:linear-gradient(135deg,#00c6ff,#0072ff);
  animation:slideBG 7s infinite alternate;
}
@keyframes slideBG{
  0%{background:linear-gradient(135deg,#00c6ff,#0072ff);}
  100%{background:linear-gradient(135deg,#5200ff,#00eaff);}
}

/* floating bubbles */
.bubble{position:fixed;border-radius:50%;background:rgba(255,255,255,.18);
  animation:float 6s infinite ease-in-out;filter:blur(2px);pointer-events:none;}
.b1{width:90px;height:90px;top:12%;left:10%;animation-delay:.2s}
.b2{width:130px;height:130px;bottom:15%;right:12%;animation-delay:1.3s}
.b3{width:70px;height:70px;bottom:55%;left:8%;animation-delay:2.1s}

@keyframes float{
  0%{transform:translateY(0) scale(1);opacity:.6;}
  50%{transform:translateY(-22px) scale(1.07);opacity:1;}
  100%{transform:translateY(0) scale(1);opacity:.6;}
}

/* Card */
.card{
  width:min(400px,90vw);
  background:rgba(255,255,255,.18);
  padding:36px 30px;
  border-radius:18px;
  backdrop-filter:blur(16px) saturate(160%);
  border:1px solid rgba(255,255,255,.45);
  color:#fff;
  text-align:center;
  box-shadow:0 18px 48px rgba(0,0,0,.25);
}
h1{
  margin:0 0 10px;font-size:30px;font-weight:700;
  text-shadow:0 0 18px rgba(255,255,255,.6);
}
.subtitle{margin-bottom:22px;opacity:.88}

/* input fields */
.input-wrap{
  position:relative;
  background:rgba(255,255,255,.55);
  border-radius:12px;
  border:1px solid rgba(255,255,255,.55);
  margin-bottom:12px;
}
.input-wrap input{
  width:100%;height:48px;border:none;background:transparent;
  padding:0 44px 0 14px;font-size:16px;color:#002b55;outline:none;
}
.icon{
  position:absolute;right:12px;top:50%;transform:translateY(-50%);
  cursor:pointer;font-size:20px;color:#0b1b2b;
}

/* button */
.btn{
  width:100%;height:46px;margin-top:16px;border:none;
  border-radius:12px;background:#00eaff;color:#002b55;
  font-size:17px;cursor:pointer;font-weight:600;
  box-shadow:0 0 18px rgba(0,234,255,.7);
  transition:.2s;
}
.btn:hover{
  transform:translateY(-2px);
  box-shadow:0 0 26px rgba(0,234,255,1);
}

/* shake animation for invalid */
.shake{
  animation:shake .4s ease;
}
@keyframes shake{
  0%{transform:translateX(0);}20%{transform:translateX(-6px);}
  40%{transform:translateX(6px);}60%{transform:translateX(-4px);}
  80%{transform:translateX(4px);}100%{transform:translateX(0);}
}

/* link */
.alt{margin-top:14px;font-size:14px;color:#e8ffff;}
.alt a{color:#fff;text-decoration:underline;}

</style>
</head>
<body>

<!-- bubbles -->
<div class="bubble b1"></div>
<div class="bubble b2"></div>
<div class="bubble b3"></div>

<div class="card" id="cardBox">
  <h1>🔐 Login</h1>
  <p class="subtitle">Welcome back! Let's play 🕹️</p>

  <form action="login" method="post" id="loginForm">
    
    <!-- username -->
    <div class="input-wrap">
      <input type="text" name="username" id="username" placeholder="Enter Username" required>
      <div class="icon">👤</div>
    </div>

    <!-- password -->
    <div class="input-wrap">
      <input type="password" name="password" id="password" placeholder="Enter Password" required>
      <div class="icon" id="togglePwd">👁️</div>
    </div>

    <button class="btn" type="submit">Login</button>
  </form>

  <div class="alt">
    New here? <a href="signup.jsp">Create account</a>
  </div>
</div>

<!-- click & error sound -->
<audio id="clickSound" src="sounds/click.mp3"></audio>
<audio id="errorSound" src="sounds/error.mp3"></audio>

<script>
const togglePwd = document.getElementById("togglePwd");
const pwd = document.getElementById("password");

togglePwd.addEventListener("click", ()=>{
  pwd.type = (pwd.type === "password") ? "text" : "password";
  togglePwd.textContent = (pwd.type === "password") ? "👁️" : "🙈";
});

document.querySelectorAll(".btn").forEach(btn=>{
  btn.addEventListener("click",()=>document.getElementById("clickSound").play());
});

// fake check effect - shake if empty
document.getElementById("loginForm").addEventListener("submit", (e)=>{
  if(pwd.value.trim()=="" || document.getElementById("username").value.trim()==""){
    e.preventDefault();
    document.getElementById("errorSound").play();
    document.getElementById("cardBox").classList.add("shake");
    setTimeout(()=>document.getElementById("cardBox").classList.remove("shake"),500);
  }
});
</script>

</body>
</html>


