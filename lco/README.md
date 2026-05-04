# LCO: Low-Cost OpenCode Wrapper

**Purpose:** A clean, consistent wrapper for the oh-my-opencode plugin configured for low-cost operation.

## Why This Exists

The oh-my-opencode plugin has dual naming conventions (`oh-my-opencode` / `oh-my-openagent`) and command aliases (`ultrawork` / `ulw`) that can be confusing. This wrapper provides:

1. **Consistent naming** - Everything uses `lco-*` prefixes
2. **Low-cost defaults** - Pre-configured for OpenCode Go's Grok models
3. **Easy updates** - Swap configs without touching the core plugin

## Directory Structure

```
lco/
├── config/                    # Custom configurations
│   └── low-cost-template.jsonc # Low-cost model config
├── scripts/                   # Installation & management scripts
│   ├── install.sh            # Install LCO config
│   ├── backup.sh              # Backup existing config
│   └── switch.sh              # Switch between configs
├── README.md                  # This file
└── NOTES.md                   # Personal notes & observations
```

## Quick Start

```bash
# Install low-cost configuration
./lco/scripts/install.sh

# Backup current config
./lco/scripts/backup.sh

# Switch configurations
./lco/scripts/switch.sh <config-name>
```

## Commands

Instead of `ultrawork` / `ulw`, use consistent LCO commands:

| Old Command | LCO Command | Description |
|-------------|-------------|-------------|
| `ultrawork` | `lco work` | Start work session |
| `ulw` | `lco quick` | Quick task |
| `/ralph-loop` | `lco loop` | Continuous loop |

*Note: These are aliases in your shell profile, not changes to the plugin.*

## Model Strategy

Based on OpenCode Go's $12/5hr budget:

| Model | Use For | Requests/5hr |
|-------|---------|--------------|
| DeepSeek V4 Flash | Routine tasks | ~31,650 |
| MiniMax M2.7 | Daily driver | ~3,400 |
| Kimi K2.5 | Complex work | ~1,850 |
| GLM-5 | Deep reasoning | ~1,150 |

## Files

| File | Purpose |
|------|---------|
| `config/low-cost-template.jsonc` | Copy this to `~/.config/opencode/` |
| `scripts/install.sh` | Installs config with backup |
| `scripts/backup.sh` | Backs up current config |
| `scripts/switch.sh` | Switch between config variants |

## Customization

Edit `config/low-cost-template.jsonc` to customize:
- Model assignments per agent
- Category routing
- Fallback chains
- Disabled features

---

*This is a personal wrapper. Modify freely for your workflow.*