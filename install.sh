#!/bin/bash
# ═══════════════════════════════════════════════════════════
# Evo Dotfiles Installer
# Run: git clone <repo> && cd evo-dotfiles && ./install.sh
# ═══════════════════════════════════════════════════════════

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🚀 Installing Evo Dotfiles..."
echo "═══════════════════════════════════════════════════════════"
echo ""

# ─── 1. Install bin scripts ───────────────────────────────
echo -e "${BLUE}📦 Installing CLI tools...${NC}"
mkdir -p ~/.local/bin

for script in "$DOTFILES_DIR/bin/"*; do
    if [[ -f "$script" ]]; then
        script_name=$(basename "$script")
        cp "$script" ~/.local/bin/
        chmod +x ~/.local/bin/"$script_name"
        echo -e "  ${GREEN}✓${NC} $script_name"
    fi
done

# ─── 2. Wire up shell configuration ─────────────────────
echo ""
echo -e "${BLUE}🐚 Configuring shell...${NC}"

if ! grep -q "evo-dotfiles/shell/bash-evo.sh" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# Evo Dotfiles Configuration" >> ~/.bashrc
    echo "source $DOTFILES_DIR/shell/bash-evo.sh" >> ~/.bashrc
    echo -e "  ${GREEN}✓${NC} Added bash-evo.sh to ~/.bashrc"
else
    echo -e "  ${YELLOW}ℹ${NC}  bash-evo.sh already in ~/.bashrc"
fi

# ─── 3. VS Code settings ─────────────────────────────────
echo ""
echo -e "${BLUE}📝 VS Code configuration...${NC}"

if command -v code &>/dev/null; then
    # Ensure directories exist
    mkdir -p ~/.config/Code/User
    mkdir -p ~/.github
    
    # Copy Copilot instructions
    if [[ -f "$DOTFILES_DIR/vscode/copilot-instructions.md" ]]; then
        cp "$DOTFILES_DIR/vscode/copilot-instructions.md" ~/.github/
        echo -e "  ${GREEN}✓${NC} Copilot instructions installed"
    fi
    
    # Copy VS Code settings
    if [[ -f "$DOTFILES_DIR/vscode/settings.json" ]]; then
        # Merge with existing or create new
        if [[ -f ~/.config/Code/User/settings.json ]]; then
            echo -e "  ${YELLOW}ℹ${NC}  VS Code settings exist - merge manually if needed"
        else
            cp "$DOTFILES_DIR/vscode/settings.json" ~/.config/Code/User/
            echo -e "  ${GREEN}✓${NC} VS Code settings installed"
        fi
    fi
else
    echo -e "  ${YELLOW}ℹ${NC}  VS Code not found - skipping VS Code config"
fi

# ─── 4. Check for DNA folder ─────────────────────────────
echo ""
echo -e "${BLUE}🧠 Checking DNA...${NC}"

if [[ ! -d ~/00_DNA ]]; then
    echo -e "  ${YELLOW}⚠${NC}  No DNA folder found at ~/00_DNA"
    echo ""
    echo "  To set up DNA, run:"
    echo "    git clone <your-evo-brain-repo> ~/00_DNA"
    echo ""
    echo "  Or bootstrap from templates:"
    echo "    mkdir ~/00_DNA"
    echo "    cp $DOTFILES_DIR/templates/*.md ~/00_DNA/"
else
    echo -e "  ${GREEN}✓${NC}  DNA folder exists at ~/00_DNA"
fi

# ─── 5. Verify installation ──────────────────────────────
echo ""
echo -e "${BLUE}🔍 Verifying installation...${NC}"

# Reload bash config for current session
source ~/.bashrc 2>/dev/null || true

# Check tools
tools_ok=true
for tool in kimic claudec aidere dna-context; do
    if command -v $tool &>/dev/null; then
        echo -e "  ${GREEN}✓${NC} $tool available"
    else
        echo -e "  ${RED}✗${NC} $tool NOT FOUND"
        tools_ok=false
    fi
done

# ─── Summary ─────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════"
if [[ "$tools_ok" == true ]]; then
    echo -e "${GREEN}✅ Evo Dotfiles installed successfully!${NC}"
else
    echo -e "${YELLOW}⚠ Installation complete with warnings${NC}"
fi
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Open a NEW terminal (or run: source ~/.bashrc)"
echo "  2. Run: evo doctor"
echo "  3. Start working: kimic"
echo ""
echo "To set up your DNA on this machine:"
echo "  git clone git@github.com:yourusername/evo-brain.git ~/00_DNA"
echo ""
