# ═══════════════════════════════════════════════════════════
# Evolution Stables - Bash Enhancements
# Source this in your .bashrc: source /home/evo/_config/bash-evo.sh
# ═══════════════════════════════════════════════════════════

EVO_ROOT="/home/evo"

# ─── Navigation ───────────────────────────────────────────
alias cd.='cd $EVO_ROOT'
alias cd.='cd $EVO_ROOT/00_DNA'
alias cd..='cd $EVO_ROOT/projects'
alias cd...='cd $EVO_ROOT/_scripts'
alias cd....='cd $EVO_ROOT/_config'

# Quick project navigation
cdp() { cd "$EVO_ROOT/projects/$1" 2>/dev/null || ls "$EVO_ROOT/projects/"; }

# ─── Evo CLI Shortcuts ────────────────────────────────────
alias v='evo vault'
alias vc='evo vault check'
alias ve='evo vault edit'
alias d='evo doctor'
alias dk='evo docker'
alias dks='evo docker status'
alias dkl='evo docker list'
alias b='evo backlog'
alias dec='evo decisions'
alias tldr='evo tldr'
alias radar='evo radar'
alias inbox='evo inbox-add'
alias mem='just memory'
alias memopt='just optimize-memory'

# ─── Git Shortcuts ───────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'

# DNA-specific git
gdna() {
    cd "$EVO_ROOT/00_DNA" && git add . && git commit -m "docs: $1" && git push
}

# ─── Quick Checks ─────────────────────────────────────────
alias check='just check'
alias status='just status'

# ─── File Operations ──────────────────────────────────────
# Create directory and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick backup with timestamp
backup() {
    local file=$1
    local timestamp=$(date +%Y%m%d_%H%M%S)
    cp -r "$file" "${file}.bak.${timestamp}"
    echo "Backed up: ${file}.bak.${timestamp}"
}

# Safe remove (move to trash instead of delete)
trash() {
    local trash_dir="$EVO_ROOT/.Trash/$(date +%Y%m%d)"
    mkdir -p "$trash_dir"
    mv "$@" "$trash_dir/"
    echo "Moved to trash: $trash_dir"
}

# ─── Search ───────────────────────────────────────────────
# Search in DNA
sdna() { grep -r "$1" "$EVO_ROOT/00_DNA/" --include="*.md" 2>/dev/null; }

# Search in projects
sproj() { grep -r "$1" "$EVO_ROOT/projects/" --include="*.py" --include="*.ts" --include="*.js" 2>/dev/null | head -20; }

# Find file by name
ff() { find "$EVO_ROOT" -name "$1" -type f 2>/dev/null | head -20; }

# ─── Utility ──────────────────────────────────────────────
# Quick timestamp
timestamp() { date +%Y%m%d_%H%M%S; }

# Weather (if curl available)
weather() { curl -s "wttr.in/${1:-Auckland}?format=3" 2>/dev/null || echo "Weather check requires internet"; }

# Quick serve current directory on port 8000
serve() { python3 -m http.server 8000 2>/dev/null & }

# Show directory sizes
dus() { du -sh "$@" 2>/dev/null | sort -hr; }

# ─── AI Session Starters ──────────────────────────────────
# Start Kimi with full context (RECOMMENDED - follows Memory Protocol)
kimic() {
    echo "🧠 Loading DNA context..."
    kimi -p "MANDATORY: Read these files BEFORE responding:
1. /evo/00_DNA/🧠 AI_CONTEXT.md
2. /evo/00_DNA/OPERATING_BACKLOG.md  
3. /evo/00_DNA/DECISION_LOG.md

DO NOT say 'I don't have access to previous conversations.'
DNA is the persistent memory. Acknowledge what you read.

Now respond to: ${1:-What are we working on?}"
}

# Continue last Kimi session
kimil() {
    kimi -C
}

# Fresh Kimi session (WARNING: No DNA context!)
kimif() {
    echo "⚠️  Fresh session - No DNA context loaded!"
    kimi "$@"
}

# ─── Prompt Enhancement (if Starship not installed) ───────
# Only set if Starship isn't handling the prompt
if ! command -v starship &> /dev/null; then
    # Show git branch in prompt
    parse_git_branch() {
        git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    
    # Enhanced prompt: user@host:dir (git-branch)$
    export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\$ '
fi

# ─── Friction Layer: Warn on plain kimi ───────────────────
# This creates a pause to prevent reflexive 'kimi' usage
alias kimi='echo "⚠️  Plain kimi skips DNA context." && echo "   Use: kimic (with context) | kimil (continue) | kimif (fresh)" && echo "" && sleep 2 && command kimi'

# ─── Welcome Message ──────────────────────────────────────
echo "🐎 Evolution Stables - Ready"
echo "   Quick: just, evo, cd., cdp <project>"
echo "   AI:    kimic (with context), kimil (continue)"
echo "   Help:  evo help, just"
echo ""
echo "   💡 New Kimi session? Use 'kimic' not 'kimi' to load context"
