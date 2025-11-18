<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sign Up | Tic Tac Toe</title>

<style>
/* ------- Animated Gradient Background ------- */
:root{
  --accent:#00eaff;
  --accent-2:#0072ff;
  --text:#0b1b2b;
}
*{box-sizing:border-box}
html,body{height:100%}
body{
  margin:0;
  font-family:'Poppins',system-ui,Segoe UI,Roboto,Arial;
  display:flex; align-items:center; justify-content:center;
  background: linear-gradient(135deg,#00c6ff,#0072ff);
  animation: bgshift 7s ease-in-out infinite alternate;
}
@keyframes bgshift{
  0%{ background: linear-gradient(135deg,#00c6ff,#0072ff); }
  100%{ background: linear-gradient(135deg,#5100ff,#00eaff); }
}

/* floating bubbles */
.bubble{
  position:fixed; border-radius:50%; background:rgba(255,255,255,.16);
  filter: blur(2px); pointer-events:none; z-index:0;
  animation: float 6s ease-in-out infinite;
}
.b1{ width:80px;height:80px; top:10%; left:12%; animation-delay:.2s }
.b2{ width:120px;height:120px; bottom:12%; right:10%; animation-delay:1.2s }
.b3{ width:60px;height:60px; top:65%; left:8%; animation-delay:2.1s }
@keyframes float{
  0%{ transform:translateY(0) scale(1); opacity:.6 }
  50%{ transform:translateY(-26px) scale(1.06); opacity:1 }
  100%{ transform:translateY(0) scale(1); opacity:.6 }
}

/* ------- Glass Card ------- */
.card{
  position:relative; z-index:1;
  width:min(420px, 92vw);
  background: rgba(255,255,255,.18);
  border:1px solid rgba(255,255,255,.45);
  backdrop-filter: blur(14px) saturate(160%);
  -webkit-backdrop-filter: blur(14px) saturate(160%);
  border-radius:18px; padding:28px 26px 24px;
  box-shadow: 0 20px 60px rgba(0,0,0,.28);
  color:#fff;
}
h1{
  margin:0 0 6px; font-weight:800; font-size:30px; letter-spacing:.3px;
  text-shadow: 0 0 14px rgba(255,255,255,.6);
}
.subtitle{ margin:0 0 18px; opacity:.9 }

/* form fields */
.form-row{ display:flex; flex-direction:column; gap:8px; margin:12px 0 }
.label{ font-size:13px; opacity:.9 }
.input-wrap{
  position:relative;
  background: rgba(255,255,255,.55);
  border:1px solid rgba(255,255,255,.6);
  border-radius:12px;
}
.input-wrap input{
  width:100%; height:48px; border:none; outline:none;
  background:transparent; padding:0 46px 0 14px; font-size:16px; color:#0b1b2b;
}
.icon{
  position:absolute; right:12px; top:50%; transform:translateY(-50%);
  width:24px; height:24px; display:grid; place-items:center; cursor:pointer;
  color:#0b1b2b;
}
.hint{ font-size:12px; opacity:.9; color:#eaf7ff }

/* strength meter */
.meter{
  height:8px; border-radius:10px; background:rgba(255,255,255,.35);
  overflow:hidden; margin-top:8px;
}
.meter > span{
  display:block; height:100%; width:0%;
  background:linear-gradient(90deg, #ff4d4d, #ffd166, #06d6a0);
  transition: width .25s ease;
}
.meter-label{ font-size:12px; margin-top:6px; opacity:.95 }

/* checkbox row */
.row-inline{ display:flex; align-items:center; gap:10px; margin:10px 0 2px }

/* buttons */
.btn{
  width:100%; height:46px; margin-top:10px;
  border:none; border-radius:12px; cursor:pointer;
  font-size:16px; letter-spacing:.4px; color:#002b55;
  background:#00eaff; box-shadow:0 0 18px rgba(0,234,255,.6);
  transition:.18s transform ease, .2s box-shadow ease, .18s opacity ease;
}
.btn:hover{ transform:translateY(-2px); box-shadow:0 0 24px rgba(0,234,255,.9); }
.btn:disabled{ opacity:.6; cursor:not-allowed; transform:none; box-shadow:none; }

.alt{
  margin-top:12px; font-size:14px; color:#e8fbff;
}
.alt a{ color:#fff; text-decoration:underline }

/* errors */
.err{ color:#ffe6e6; font-size:12px; margin-top:6px; display:none }
.err.show{ display:block }

/* small footer */
.footer-note{ margin-top:12px; font-size:12px; opacity:.8 }
</style>
</head>
<body>

<div class="bubble b1"></div>
<div class="bubble b2"></div>
<div class="bubble b3"></div>

<div class="card">
  <h1>📝 Create Account</h1>
  <p class="subtitle">Join Tic Tac Toe and start playing!</p>

  <form action="signup" method="post" id="signupForm" novalidate>
    <!-- Username -->
    <div class="form-row">
      <div class="label">Username</div>
      <div class="input-wrap">
        <input type="text" name="username" id="username" placeholder="Enter username" required autocomplete="username">
        <!-- user icon -->
        <div class="icon" tabindex="-1" aria-hidden="true">👤</div>
      </div>
      <div class="err" id="uErr">Please enter a username (3+ chars).</div>
    </div>

    <!-- Password -->
    <div class="form-row">
      <div class="label">Password</div>
      <div class="input-wrap">
        <input type="password" name="password" id="password" placeholder="Create a strong password" required autocomplete="new-password">
        <div class="icon" id="togglePwd" title="Show/Hide">👁️</div>
      </div>
      <div class="meter"><span id="strengthBar"></span></div>
      <div class="meter-label" id="strengthText">Strength: —</div>
      <div class="hint">Use 8+ chars, 1 uppercase, 1 number.</div>
      <div class="err" id="pErr">Password doesn’t meet the minimum rules.</div>
    </div>

    <!-- Terms -->
    <div class="row-inline">
      <input type="checkbox" id="terms">
      <label for="terms">I agree to the <a href="#" onclick="return false;">terms & conditions</a></label>
    </div>

    <!-- Submit -->
    <button class="btn" id="submitBtn" type="submit" disabled>Create Account</button>
  </form>

  <div class="alt">Already have an account? <a href="login.jsp">Login here</a></div>
  <div class="footer-note">Secure & fast — no spam, ever.</div>
</div>

<!-- optional click sound -->
<audio id="uiSound" src="sounds/click.mp3"></audio>

<script>
(function(){
  const username = document.getElementById('username');
  const password = document.getElementById('password');
  const uErr = document.getElementById('uErr');
  const pErr = document.getElementById('pErr');
  const togglePwd = document.getElementById('togglePwd');
  const bar = document.getElementById('strengthBar');
  const label = document.getElementById('strengthText');
  const terms = document.getElementById('terms');
  const submitBtn = document.getElementById('submitBtn');
  const uiSound = document.getElementById('uiSound');
  const form = document.getElementById('signupForm');

  function scorePassword(p){
    let score = 0;
    if (!p) return 0;
    const rules = [
      /.{8,}/,        // length
      /[A-Z]/,        // uppercase
      /[a-z]/,        // lowercase
      /[0-9]/,        // number
      /[^A-Za-z0-9]/  // special
    ];
    rules.forEach(r => { if (r.test(p)) score += 20; });
    return Math.min(score, 100);
  }

  function renderStrength(p){
    const s = scorePassword(p);
    bar.style.width = s + '%';
    if (s <= 40) { label.textContent = 'Strength: Weak'; }
    else if (s <= 70) { label.textContent = 'Strength: Medium'; }
    else { label.textContent = 'Strength: Strong'; }
    return s;
  }

  function validate(){
    const uOk = username.value.trim().length >= 3;
    const s = renderStrength(password.value);
    const pOk = s >= 60; // require at least "Medium"
    const tOk = terms.checked;

    uErr.classList.toggle('show', !uOk);
    pErr.classList.toggle('show', !pOk);

    submitBtn.disabled = !(uOk && pOk && tOk);
  }

  username.addEventListener('input', validate);
  password.addEventListener('input', validate);
  terms.addEventListener('change', validate);

  // show/hide password
  togglePwd.addEventListener('click', ()=>{
    password.type = (password.type === 'password') ? 'text' : 'password';
    togglePwd.textContent = (password.type === 'password') ? '👁️' : '🙈';
  });

  // click sound
  document.querySelectorAll('.btn').forEach(b=>{
    b.addEventListener('click', ()=>{ if(uiSound) uiSound.play(); });
  });

  // final guard before submit
  form.addEventListener('submit', (e)=>{
    validate();
    if (submitBtn.disabled) e.preventDefault();
  });

  // initial state
  validate();
})();
</script>

</body>
</html>
