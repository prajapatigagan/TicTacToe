<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.tictactoe.model.Game" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tic Tac Toe Game</title>

<style>
/* ----- Glass UI Theme Vars ----- */
:root{
  --bg1:#e3f2fd; --bg2:#bbdefb; --accent:#1976d2; --text:#08243a;
}

.theme-frost  { --bg1:#e3f2fd; --bg2:#bbdefb; --accent:#1976d2; --text:#08243a; }
.theme-emerald{ --bg1:#d5f5e3; --bg2:#b2f7d6; --accent:#1e8e57; --text:#06321f; }
.theme-sunset { --bg1:#ffd6a5; --bg2:#ffcad4; --accent:#ff6243; --text:#3a0f06; }
.theme-royal  { --bg1:#e0d7ff; --bg2:#c5b7ff; --accent:#6a42ff; --text:#1e104e; }
.theme-ocean  { --bg1:#b2f0f7; --bg2:#d0f9ff; --accent:#0e9db2; --text:#08323a; }
.theme-lava   { --bg1:#ffd1cf; --bg2:#ffb3ad; --accent:#e53e3e; --text:#3a0b0b; }
.theme-amber  { --bg1:#ffe9b6; --bg2:#ffd36b; --accent:#f59e0b; --text:#3a2a06; }
.theme-neon   { --bg1:#c2f5ff; --bg2:#d7faff; --accent:#00c2ff; --text:#042c33; }
.theme-rose   { --bg1:#ffd6e7; --bg2:#ffc2d9; --accent:#e91e63; --text:#3a0f20; }
.theme-slate  { --bg1:#e7edf3; --bg2:#d8e0e9; --accent:#2f5d8a; --text:#0b1b2b; }

/* Background */
body{
  font-family:'Poppins',sans-serif;
  background: radial-gradient(1200px 800px at 10% 0%, var(--bg1), transparent 60%),
              linear-gradient(135deg, var(--bg1), var(--bg2));
  text-align:center;
  padding-top:40px;
  color:var(--text);
}

/* Top buttons */
.top-buttons {
    display:flex;
    gap:10px;
    flex-wrap:wrap;
    justify-content:center;
    margin-bottom:15px;
}

.top-buttons .btn,
.top-buttons select {
    min-width:170px;
    height:45px;
    font-size:16px;
    padding:8px 14px;
    border-radius:8px;
    border:none;
    cursor:pointer;
    background:var(--accent);
    color:#fff;
}

.top-buttons select { color:#fff; }
.top-buttons .btn:hover,
.top-buttons select:hover { opacity:0.85; }

/* Board */
table{margin:30px auto;border-collapse:collapse}
td{width:100px;height:100px;border:2px solid #0d47a1;font-size:36px;text-align:center}
button.cell{width:100%;height:100%;font-size:36px;border:none;background:transparent;cursor:pointer;color:var(--text)}
button.cell:active{transform:scale(.96)}
button.cell:disabled{cursor:not-allowed;opacity:.5}

/* Winner text */
.winner{font-size:22px;color:#2e7d32;margin:18px;font-weight:bold}
</style>
</head>
<body>

<script>
/* Apply saved theme from localStorage */
(function(){
  var t = localStorage.getItem("tttTheme") || "theme-frost";
  var html = document.documentElement;
  [
    "theme-frost","theme-emerald","theme-sunset","theme-royal","theme-ocean",
    "theme-lava","theme-amber","theme-neon","theme-rose","theme-slate"
  ].forEach(x => html.classList.remove(x));
  html.classList.add(t);
})();
</script>

<%
String player1 = (String) session.getAttribute("player1");
String player2 = (String) session.getAttribute("player2");
if (player1 == null) player1 = "Player 1";
if (player2 == null) player2 = "Player 2";

Game game = (Game) session.getAttribute("game");
if (game == null) { game = new Game(); session.setAttribute("game", game); }

char[][] board = game.getBoard();
String winner = (String) request.getAttribute("winner");
boolean gameOver = (winner != null);
%>

<div class="top-buttons">

<form action="<%=request.getContextPath()%>/logout" method="post">
  <button class="btn">🚪 Logout</button>
</form>

<form action="<%=request.getContextPath()%>/restart" method="post">
  <input type="hidden" name="keepPlayers" value="true">
  <button class="btn">♻️ Restart (Same)</button>
</form>

<form action="<%=request.getContextPath()%>/restart" method="post">
  <button class="btn">🔁 New Players</button>
</form>

<form action="<%=request.getContextPath()%>/game" method="get">
  <input type="hidden" name="mode" value="pvp">
  <button class="btn">👥 Human vs Human</button>
</form>

<form action="<%=request.getContextPath()%>/game" method="get">
  <input type="hidden" name="mode" value="ai">
  <select name="difficulty">
    <option value="EASY">EASY</option>
    <option value="MEDIUM">MEDIUM</option>
    <option value="HARD" selected>HARD</option>
  </select>
  <button class="btn">🤖 Human vs AI</button>
</form>

</div>

<h1>🎮 Tic Tac Toe</h1>
<h3><%= player1 %> (X) vs <%= player2 %> (O)</h3>

<form action="<%=request.getContextPath()%>/game" method="post">
  <table>
<%
for (int i=0;i<3;i++){
  out.print("<tr>");
  for (int j=0;j<3;j++){
    out.print("<td>");
    char ch = board[i][j];

    if (ch == '-') {
%>
      <button class="cell" name="move" value="<%=i%>,<%=j%>" <%= gameOver?"disabled":"" %>></button>
<%
    } else {
%>
      <button class="cell" disabled><%= ch %></button>
<%
    }
    out.print("</td>");
  }
  out.print("</tr>");
}
%>
  </table>
</form>

<% if (winner != null) { %>
<div class="winner"><%= winner %></div>
<% } %>

</body>
<!-- 🔊 SOUND FILES -->
<audio id="clickSound" src="sounds/click.mp3"></audio>
<audio id="winSound" src="sounds/win.mp3"></audio>

<script>
// 🎵 Play click sound on move
document.querySelectorAll("button.cell").forEach(btn => {
  btn.addEventListener("click", () => {
    document.getElementById("clickSound").play();
  });
});

// 🎙️ Voice function
function speak(text){
  let msg = new SpeechSynthesisUtterance(text);
  msg.rate = 1;
  msg.pitch = 1;
  msg.volume = 1;

  // Try to use Google voice if available
  let voices = speechSynthesis.getVoices();
  msg.voice = voices.find(v => v.name.includes("Google")) || voices[0];

  speechSynthesis.speak(msg);
}

// 🏆 If winner exists → voice + win sound
<% if (winner != null) { %>
  const loser = "<%= request.getAttribute("loserName") %>";

  setTimeout(() => {
    // Play win sound
    document.getElementById("winSound").play();

    // Speak loser message
    speak(loser + ", you lost this match.");
  }, 700);
<% } %>
</script>

</html>




