<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Tic Tac Toe – Players</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />

<style>
  /* ---------- Base: Glass UI ---------- */
  :root{
    --bg1:#dfe9f3; --bg2:#ffffff;
    --text:#0b1b2b; --muted:#4b5b6b; --accent:#1976d2;
    --card-bg: rgba(255,255,255,.18);
    --card-brd: rgba(255,255,255,.35);
    --btn-bg: rgba(255,255,255,.25);
    --btn-brd: rgba(255,255,255,.45);
  }
  html,body{height:100%}
  body{
    margin:0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Poppins, Arial;
    background: radial-gradient(1200px 800px at 10% 0%, var(--bg1), transparent 60%),
                linear-gradient(135deg, var(--bg1), var(--bg2));
    color: var(--text);
  }
  .wrap{
    min-height:100%; display:grid; place-items:center; padding:40px 16px;
  }
  .glass{
    width:min(520px, 92vw);
    background: var(--card-bg);
    border:1px solid var(--card-brd);
    border-radius:18px;
    box-shadow: 0 20px 60px rgba(0,0,0,.18);
    backdrop-filter: blur(14px) saturate(140%);
    -webkit-backdrop-filter: blur(14px) saturate(140%);
    padding:28px;
  }
  .title{
    margin:0 0 4px; font-size:28px; font-weight:800; letter-spacing:.2px;
  }
  .subtitle{margin:0 0 22px; color:var(--muted)}
  .row{display:flex; gap:12px; flex-wrap:wrap}
  .field{
    flex:1 1 220px;
    display:flex; flex-direction:column; gap:6px;
  }
  label{font-size:13px; color:var(--muted)}
  input, select{
    height:44px; padding:0 14px; font-size:16px; color:var(--text);
    border-radius:12px; border:1px solid var(--btn-brd);
    background: rgba(255,255,255,.55);
    outline:none;
  }
  .actions{display:flex; gap:10px; flex-wrap:wrap; margin-top:16px}
  .btn{
    min-width:170px; height:45px; font-size:16px;
    color:#fff; background: var(--accent);
    border:1px solid transparent; border-radius:12px;
    cursor:pointer; transition:.15s transform ease, .2s opacity ease;
  }
  .btn.ghost{
    color: var(--text);
    background: var(--btn-bg);
    border-color: var(--btn-brd);
  }
  .btn:hover{transform:translateY(-1px)}
  .chipset{display:flex; gap:8px; flex-wrap:wrap; margin-top:10px}
  .chip{
    width:34px; height:34px; border-radius:10px; border:1px solid rgba(255,255,255,.5);
    cursor:pointer; outline:2px solid transparent; outline-offset:2px;
  }
  .chip.active{outline:2px solid var(--text)}
  .hint{font-size:12px; color:var(--muted); margin-top:6px}

  /* ---------- 10 Themes (override CSS variables) ---------- */
  .theme-frost     { --bg1:#e3f2fd; --bg2:#bbdefb; --accent:#1976d2; --text:#08243a; }
  .theme-emerald   { --bg1:#d5f5e3; --bg2:#b2f7d6; --accent:#1e8e57; --text:#06321f; }
  .theme-sunset    { --bg1:#ffd6a5; --bg2:#ffcad4; --accent:#ff6243; --text:#3a0f06; }
  .theme-royal     { --bg1:#e0d7ff; --bg2:#c5b7ff; --accent:#6a42ff; --text:#1e104e; }
  .theme-ocean     { --bg1:#b2f0f7; --bg2:#d0f9ff; --accent:#0e9db2; --text:#08323a; }
  .theme-lava      { --bg1:#ffd1cf; --bg2:#ffb3ad; --accent:#e53e3e; --text:#3a0b0b; }
  .theme-amber     { --bg1:#ffe9b6; --bg2:#ffd36b; --accent:#f59e0b; --text:#3a2a06; }
  .theme-neon      { --bg1:#c2f5ff; --bg2:#d7faff; --accent:#00c2ff; --text:#042c33; }
  .theme-rose      { --bg1:#ffd6e7; --bg2:#ffc2d9; --accent:#e91e63; --text:#3a0f20; }
  .theme-slate     { --bg1:#e7edf3; --bg2:#d8e0e9; --accent:#2f5d8a; --text:#0b1b2b; }

  /* Optional: glass noise for extra polish */
  .noise::before{
    content:""; position:absolute; inset:0; pointer-events:none; border-radius:inherit;
    background-image:url('data:image/svg+xml;utf8,\
<svg xmlns="http://www.w3.org/2000/svg" width=\"160\" height=\"160\" viewBox=\"0 0 160 160\">\
<filter id=\"n\"><feTurbulence type=\"fractalNoise\" baseFrequency=\"0.9\" numOctaves=\"2\" stitchTiles=\"stitch\"/></filter>\
<rect width=\"100%\" height=\"100%\" filter=\"url(%23n)\" opacity=\".035\"/></svg>');
  }
</style>
</head>
<body>
<div class="wrap">
  <div class="glass noise" id="card">
    <h1 class="title">Tic Tac Toe</h1>
    <p class="subtitle">Enter player names & pick a theme</p>

    <form class="row" action="<%=request.getContextPath()%>/game" method="get">
      <div class="field">
        <label>Player 1 (X)</label>
        <input type="text" name="player1" placeholder="Player 1" required />
      </div>
      <div class="field">
        <label>Player 2 (O)</label>
        <input type="text" name="player2" placeholder="Player 2" required />
      </div>
      <div class="field" style="flex:1 1 100%">
        <label>Theme</label>
        <div class="row">
          <select id="themeSelect">
            <option value="theme-frost">Frost Blue</option>
            <option value="theme-emerald">Emerald Mist</option>
            <option value="theme-sunset">Sunset Peach</option>
            <option value="theme-royal">Royal Purple</option>
            <option value="theme-ocean">Ocean Teal</option>
            <option value="theme-lava">Lava Red</option>
            <option value="theme-amber">Golden Amber</option>
            <option value="theme-neon">Neon Cyan</option>
            <option value="theme-rose">Rose Quartz</option>
            <option value="theme-slate">Slate Gray</option>
          </select>
          <button type="button" class="btn ghost" id="previewBtn">Preview</button>
        </div>
        <div class="chipset" id="chips"></div>
        <p class="hint">Tip: Preview se live dekh lo, “Start Game” pe theme auto-save ho jayegi.</p>
      </div>

      <!-- Hidden: theme will be saved to localStorage; no need to submit -->
      <div class="actions">
        <button class="btn" type="submit">Start Game ▶</button>
        <button class="btn ghost" type="button" id="resetTheme">Reset Theme</button>
      </div>
    </form>
  </div>
</div>

<script>
  // ---------- Theme Manager ----------
  const THEME_KEY = 'tttTheme';
  const themes = [
    'theme-frost','theme-emerald','theme-sunset','theme-royal','theme-ocean',
    'theme-lava','theme-amber','theme-neon','theme-rose','theme-slate'
  ];

  const html = document.documentElement;
  const select = document.getElementById('themeSelect');
  const previewBtn = document.getElementById('previewBtn');
  const chipsBox = document.getElementById('chips');
  const resetBtn = document.getElementById('resetTheme');

  // Build color chips for quick selection
  themes.forEach(t => {
    const chip = document.createElement('button');
    chip.type = 'button';
    chip.className = 'chip';
    chip.dataset.theme = t;
    chip.title = t.replace('theme-','').toUpperCase();
    chipsBox.appendChild(chip);
  });

  // Apply theme helper
  function applyTheme(t){
    themes.forEach(x => html.classList.remove(x));
    if (t) html.classList.add(t);
    // active ring on chip
    [...chipsBox.children].forEach(c => c.classList.toggle('active', c.dataset.theme===t));
    // align select
    if (t) select.value = t;
  }

  // Load saved theme
  const saved = localStorage.getItem(THEME_KEY) || 'theme-frost';
  applyTheme(saved);

  // Preview button
  previewBtn.addEventListener('click', () => {
    applyTheme(select.value);
    localStorage.setItem(THEME_KEY, select.value);
  });

  // Chip click
  chipsBox.addEventListener('click', (e) => {
    const t = e.target?.dataset?.theme;
    if (!t) return;
    applyTheme(t);
    localStorage.setItem(THEME_KEY, t);
  });

  // Reset
  resetBtn.addEventListener('click', ()=>{
    localStorage.removeItem(THEME_KEY);
    applyTheme('theme-frost');
  });

  // Save on submit as well (so user directly hits Start Game)
  document.querySelector('form').addEventListener('submit', ()=>{
    localStorage.setItem(THEME_KEY, select.value);
  });
</script>
</body>
</html>

