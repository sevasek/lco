# LCO: Low-Cost OpenCode Wrapper

A pre-configured model-routing layer for [oh-my-opencode](https://github.com/code-yeongyu/oh-my-openagent) that maximises request volume under [OpenCode Go's](https://opencode.ai/go) dollar-denominated budget caps.

**Core insight:** OpenCode Go limits are dollar-based ($12/5 hr, $30/wk, $60/mo), not request-based. Choosing DeepSeek V4 Flash over GLM-5.1 gives you **36× more requests** for the same spend. LCO bakes this logic into ready-to-use agent configurations.

---

## Why This Exists

- oh-my-opencode ships with no default config targeting budget tiers
- OpenCode Go's model roster changes; keeping routing current is manual work
- The dual naming conventions (`oh-my-opencode` / `oh-my-openagent`, `ultrawork` / `ulw`) add friction

LCO provides a single drop-in `template.jsonc` that routes each agent category to the cheapest model that can handle the task class, with fallback chains for quota exhaustion.

---

## Quick Start

```bash
# From the repo root (or inside lco/)
cd lco
./scripts/install.sh
```

The installer backs up your existing config then writes `~/.config/opencode/oh-my-openagent.jsonc`.  
Restart OpenCode to apply.

### Manual install

```bash
cp lco/config/template.jsonc ~/.config/opencode/oh-my-openagent.jsonc
```

---

## Directory Structure

```
lco/
├── config/
│   └── template.jsonc      # drop-in model routing config
├── scripts/
│   ├── install.sh           # install with auto-backup
│   ├── backup.sh            # manual backup of current config
│   └── switch.sh            # interactive config switcher
├── NOTES.md                 # personal model observations
├── ISSUES.md                # upstream issues tracker
└── README.md                # this file
```

---

## Model Cost Reference

All figures assume OpenCode Go's $12 / 5-hour window.

| Model | Requests / 5 hr | Cost / Request | Best For |
|-------|----------------|----------------|----------|
| DeepSeek V4 Flash | ~31,650 | $0.0004 | Routine tasks, grep, docs |
| Qwen3.5 Plus | ~10,200 | $0.001 | Balanced, good fallback |
| MiniMax M2.7 | ~3,400 | $0.004 | Daily driver |
| Kimi K2.6 | ~3,450 | $0.003 | General quality |
| Kimi K2.5 | ~1,850 | $0.007 | Complex / long-context |
| GLM-5 | ~1,150 | $0.010 | Architecture, hard bugs |
| GLM-5.1 | ~880 | $0.014 | Deep reasoning |

---

## Agent Routing (template.jsonc)

| Agent | Assigned Model | Rationale |
|-------|---------------|-----------|
| sisyphus (orchestrator) | Kimi K2.5 | Delegation planning needs quality |
| hephaestus (deep worker) | Kimi K2.5 | Multi-file work, 262K context |
| oracle (consultation) | GLM-5 | Reasoning-heavy analysis |
| atlas (todos) | MiniMax M2.7 | Balanced daily driver |
| librarian (search) | DeepSeek V4 Flash | High-volume, speed critical |
| explore (grep) | DeepSeek V4 Flash | Maximum requests |
| multimodal-looker (vision) | Kimi K2.5 | Only multimodal-capable option |

**Category routing:**

| Category | Model | Fallback |
|----------|-------|---------|
| quick | DeepSeek V4 Flash | Qwen3.5 Plus |
| deep | Kimi K2.5 | Kimi K2.6 → GLM-5 |
| visual-engineering | Kimi K2.5 | — |
| ultrabrain | GLM-5 | GLM-5.1 |
| artistry / writing | DeepSeek V4 Flash | Qwen3.5 Plus |

---

## Scripts

```bash
# Install LCO config (backs up existing first)
./scripts/install.sh

# Manual backup to ~/.config/opencode/backups/
./scripts/backup.sh

# Interactive switcher — choose from configs in lco/config/
./scripts/switch.sh
```

---

## Customisation

Edit `lco/config/template.jsonc` to adjust:

- **Model assignments** — swap any agent to a different model
- **Fallback chains** — add or reorder `fallback_models` arrays
- **Disabled features** — populate `disabled_agents`, `disabled_hooks`, etc.
- **Background tasks** — tune `max_concurrent_per_model` for your quota

---

## Competitive Landscape

| Tool | Approach | Cost |
|------|----------|------|
| **LCO (this)** | Static config routing optimised for OpenCode Go | Free + $10/mo OpenCode Go |
| Morph Router | Dynamic per-request routing, 430 ms overhead | $0.001/request on top of model cost |
| Cline auto-routing | BYOK, classifies per turn, good for Anthropic family | ~$8–12/mo BYOK |
| Aider | BYOK, no agent routing, manual model selection | ~$5–15/mo BYOK |
| Claude Code | Anthropic-locked, no model switching | $20/mo Pro |

LCO's advantage: zero routing overhead, zero per-request fees, tuned specifically for OpenCode Go's model roster and dollar caps.

---

## 🚀 Roadmap

### Feature 1: Multi-Tier Config Templates

**What:** Ship three ready-made configs — `ultra-budget.jsonc` (DeepSeek V4 Flash everywhere), `balanced.jsonc` (current LCO default), `quality.jsonc` (Kimi K2.5 / GLM-5 everywhere).

**Why it matters:** Different workdays have different needs. A quick refactor session suits ultra-budget; a complex architectural change warrants quality. Swapping is currently manual.

**Implementation:** Add two new JSONC files to `lco/config/` and update `switch.sh` to show descriptions alongside filenames.

**Effort:** Low — 1–2 hrs.

---

### Feature 2: Usage Quota Monitor

**What:** A `scripts/quota-status.sh` that reads OpenCode's session log / API to show remaining budget for the current 5-hour window and weekly limit, with a per-agent breakdown of estimated spend.

**Why it matters:** It's easy to hit the $12 cap mid-session without realising it until requests start failing. A proactive warning saves context loss.

**Implementation:** Parse OpenCode's log file (likely at `~/.local/share/opencode/` or similar) or use the OpenCode CLI's status command. Display remaining budget + estimated sessions left.

**Effort:** Medium — 2–4 hrs depending on log format stability.

---

### Feature 3: Auto-Sync Upstream Agent Roster

**What:** A `scripts/sync-agents.sh` that reads the upstream oh-my-openagent `src/agents/` directory, diffs it against `template.jsonc`, and flags any new agents that aren't yet assigned a model in the LCO config.

**Why it matters:** The upstream adds new agents frequently (the repo has diverged 1379+ commits). Missing an agent means it falls back to the upstream default (usually an expensive premium model), quietly burning quota.

**Implementation:** `jq` to parse the config, `ls` or `grep` to enumerate upstream agents, diff the two sets and output a report.

**Effort:** Low — 1–2 hrs.

---

## Notes

- Shell aliases (`lco work`, `lco quick`, `lco loop`) are **not** in this repo — add them to your shell profile manually if desired
- The upstream `template.jsonc` schema path (`./src/config/schema/oh-my-opencode-config.ts`) is relative to the OpenCode install directory, not this repo
- See `NOTES.md` for personal model observations and `ISSUES.md` for tracked upstream issues

---

*Personal wrapper — modify freely.*
