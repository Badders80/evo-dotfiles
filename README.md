# 🧠 Evo Dotfiles

**Universal AI Tool DNA Integration** — Your complete working environment, anywhere.

---

## 🚀 New Machine Setup (2 Minutes)

```bash
# 1. Clone dotfiles
git clone git@github.com:yourusername/evo-dotfiles.git
cd evo-dotfiles

# 2. Install everything
./install.sh

# 3. Clone your brain (optional - for existing projects)
git clone git@github.com:yourusername/evo-brain.git ~/00_DNA

# 4. Verify
evo doctor
```

---

## 📦 What's Included

### CLI Tools (Auto-installed to `~/.local/bin/`)

| Tool | Purpose |
|------|---------|
| `kimic` | Start Kimi CLI with DNA context |
| `claudec` | Start Claude CLI with DNA context |
| `aidere` | Start Aider with DNA context |
| `dna-context` | Output DNA to clipboard/pipe for any tool |
| `evo-doctor` | Health check everything |

### Shell Configuration

- All aliases and shortcuts (`cd.`, `cd..`, `gs`, `gp`, etc.)
- Friction layer: plain `kimi` warns you to use `kimic`
- Welcome message with tips

### VS Code Integration

- Copilot instructions auto-loaded
- Continue/Cline extension settings
- AI context pre-configured

---

## 🎯 Usage Cheat Sheet

### Starting a Session

```bash
kimic                    # Kimi with full context
claudec                  # Claude with full context
aidere                   # Aider with full context
```

### VS Code (Automatic)

Just open VS Code. Copilot/Continue/Cline automatically load your DNA context from `.github/copilot-instructions.md`.

### Any Web UI (ChatGPT, Gemini, etc.)

```bash
# Copy DNA to clipboard
dna-context | xclip -selection clipboard

# Paste into any web UI
```

### Health Check

```bash
evo doctor              # Verify everything is working
```

---

## 🧠 The DNA System

Your **actual work** (tasks, decisions, context) lives in `~/00_DNA/`:

- `🧠 AI_CONTEXT.md` — Project overview
- `OPERATING_BACKLOG.md` — Current work
- `DECISION_LOG.md` — Why you made choices

This dotfiles repo carries the **tools**. Your DNA carries the **data**.

---

## 📁 Repository Structure

```
evo-dotfiles/
├── bin/                    # CLI tools
├── shell/                  # Bash configuration
├── vscode/                 # VS Code settings
├── templates/              # Starter templates for new projects
├── install.sh              # One-command setup
└── README.md               # This file
```

---

## 🔄 Updating

```bash
cd ~/evo-dotfiles
git pull
./install.sh
```

---

## ⚠️ Important: Two Repos

| Repo | Purpose | Privacy |
|------|---------|---------|
| `evo-dotfiles` | Tools, scripts, config | Can be public |
| `evo-brain` | Your actual DNA data | **Keep private** |

**Never commit your real `00_DNA/` folder to public repos.** It contains your project details, decisions, and potentially sensitive context.

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| `kimic: command not found` | Run `source ~/.bashrc` or open new terminal |
| `dna-context` not working | Check `~/.local/bin/` is in your PATH |
| VS Code not loading context | Check `.github/copilot-instructions.md` exists |
| Missing DNA folder | Clone your evo-brain repo to `~/00_DNA` |

---

**Built for Evolution Stables — works anywhere.**
