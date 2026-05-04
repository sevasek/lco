# OpenCode Go Low-Cost Models: Analysis & Configuration

**Research Date:** 2026-05-04 | **Updated:** 2026-05-04
**Subscription:** OpenCode Go (Grok) | **Goal:** Low-cost automated coding system

---

## Executive Summary

OpenCode Go provides generous low-cost access to Grok models via dollar-based usage limits. The key insight: **you get way more requests with cheaper models**. For a low-cost automated coding system, strategic model selection is critical.

---

## 1. OpenCode Go Usage Limits

### Dollar-Based Limits (Not Fixed Requests)

| Window | Limit | Notes |
|--------|-------|-------|
| Every 5 hours | $12 USD | ~880-31,650 requests depending on model |
| Weekly | $30 USD | ~2,100-75,000 requests |
| Monthly | $60 USD | ~9,000-315,000+ requests |

### Cost Per Request by Model

| Model | Approx Requests / 5hr | Cost/Request | Best For |
|-------|----------------------|--------------|----------|
| DeepSeek V4 Flash | ~31,650 | $0.0004 | Lightweight tasks, speed |
| Qwen3.5 Plus | ~10,200 | $0.001 | Good balance |
| MiniMax M2.7 | ~3,400 | $0.004 | Daily driver, fast coding |
| Kimi K2.6 | ~3,450 | $0.003 | High quality, all-rounder |
| Kimi K2.5 | ~1,850 | $0.007 | Frontend, long context |
| GLM-5 | ~1,150 | $0.010 | General coding + reasoning |
| GLM-5.1 | ~880 | $0.014 | Deep reasoning |

**Key Insight:** DeepSeek V4 Flash gives **36x more requests** than GLM-5.1 for the same $12 budget.

---

## 2. Model Recommendations

### By Use Case

| Use Case | Primary Model | Backup Model | Rationale |
|----------|---------------|--------------|-----------|
| **Daily driver** | MiniMax M2.7 | DeepSeek V4 Flash | Great limits, fast, capable |
| **Complex/frontend** | Kimi K2.5 | Kimi K2.6 | Long context, excellent instructions |
| **Architecture/hard bugs** | GLM-5 | GLM-5.1 | Strong reasoning |
| **Lightweight tasks** | DeepSeek V4 Flash | Qwen3.5 Plus | Maximum requests |
| **Vision/PDF** | Kimi K2.5 | - | Multimodal capable |

### For Low-Cost Automated Coding System

Based on the adaptation goals (full automation, preserve team differentiation):

| Agent | Recommended Model | Requests/5hr | Notes |
|-------|-------------------|--------------|-------|
| **Sisyphus** (orchestrator) | Kimi K2.5 | ~1,850 | Best for delegation planning |
| **Hephaestus** (deep worker) | Kimi K2.5 | ~1,850 | Long context for multi-file |
| **Librarian** (search) | DeepSeek V4 Flash | ~31,650 | Speed + high volume |
| **Explore** (grep) | DeepSeek V4 Flash | ~31,650 | Maximum efficiency |
| **Oracle** (consultation) | GLM-5 | ~1,150 | Reasoning for analysis |
| **Atlas** (todos) | MiniMax M2.7 | ~3,400 | Balanced daily driver |
| **Multimodal-Looker** (vision) | Kimi K2.5 | ~1,850 | Only multimodal option |

### Fallback Chain (Priority Order)

```jsonc
"fallback_models": [
  "opencode-go/minimax-m2.7",      // Daily driver (3,400 req/5hr)
  "opencode-go/kimi-k2.5",         // Complex tasks (1,850 req/5hr)
  "opencode-go/deepseek-v4-flash",  // Lightweight (31,650 req/5hr)
  "opencode-go/glm-5",             // Reasoning (1,150 req/5hr)
  "opencode-go/big-pickle"         // Ultimate fallback
]
```

---

## 3. Task-to-Model Mapping

### Category Routing

| Category | Primary Model | Fallback | Task Types |
|----------|---------------|----------|------------|
| **quick** | DeepSeek V4 Flash | Qwen3.5 Plus | Simple edits, grep, reading |
| **deep** | Kimi K2.5 | GLM-5 | Complex multi-file changes |
| **visual-engineering** | Kimi K2.5 | - | UI work, images |
| **ultrabrain** | GLM-5 | Kimi K2.6 | Hard logic, debugging |
| **artistry** | DeepSeek V4 Flash | Qwen3.5 Plus | Creative text |
| **writing** | DeepSeek V4 Flash | Qwen3.5 Plus | Documentation |

---

## 4. Optimization Strategy

### For Maximum Automation Efficiency

1. **Use DeepSeek V4 Flash for routine tasks** - 36x more requests than expensive models
2. **Reserve Kimi/GLM for complex work** - Only when needed
3. **Break large tasks into smaller chunks** - More requests, better results
4. **Monitor usage** - OpenCode shows remaining quota

### Recommended Config for Low-Cost Automated System

```jsonc
{
  "categories": {
    "quick": {
      "model": "opencode-go/deepseek-v4-flash",
      "fallback_models": ["opencode-go/qwen3.5-plus"]
    },
    "deep": {
      "model": "opencode-go/kimi-k2.5",
      "fallback_models": ["opencode-go/kimi-k2.6", "opencode-go/glm-5"]
    },
    "visual-engineering": {
      "model": "opencode-go/kimi-k2.5"
    },
    "ultrabrain": {
      "model": "opencode-go/glm-5",
      "fallback_models": ["opencode-go/glm-5.1"]
    },
    "artistry": {
      "model": "opencode-go/deepseek-v4-flash"
    },
    "writing": {
      "model": "opencode-go/deepseek-v4-flash"
    }
  },
  "agents": {
    "sisyphus": {
      "model": "opencode-go/kimi-k2.5"
    },
    "hephaestus": {
      "model": "opencode-go/kimi-k2.5"
    },
    "librarian": {
      "model": "opencode-go/deepseek-v4-flash"
    },
    "explore": {
      "model": "opencode-go/deepseek-v4-flash"
    },
    "oracle": {
      "model": "opencode-go/glm-5"
    },
    "atlas": {
      "model": "opencode-go/minimax-m2.7"
    },
    "multimodal-looker": {
      "model": "opencode-go/kimi-k2.5"
    }
  },
  "model_fallback": {
    "fallback_models": [
      "opencode-go/deepseek-v4-flash",
      "opencode-go/minimax-m2.7",
      "opencode-go/kimi-k2.5",
      "opencode-go/glm-5",
      "opencode-go/big-pickle"
    ]
  }
}
```

---

## 5. Usage Tips

### Quick Commands in OpenCode

- Type `/models` in TUI to see full model list and switch
- Monitor usage in OpenCode status

### Model Selection Heuristics

| Situation | Recommended Model | Why |
|-----------|-------------------|-----|
| Routine refactoring | DeepSeek V4 Flash | Speed + volume |
| Writing tests | DeepSeek V4 Flash | Repetitive, fast |
| Understanding new codebase | Kimi K2.5 | Long context |
| Multi-file feature | Kimi K2.5 | 262K context |
| Architecture planning | GLM-5 | Deep reasoning |
| Debugging complex bug | GLM-5 | Reasoning |
| Simple question | DeepSeek V4 Flash | Fast |

---

## 6. Summary

For a **low-cost automated coding system** on OpenCode Go:

1. **Primary model:** Kimi K2.5 (quality) or MiniMax M2.7 (balance)
2. **High-volume model:** DeepSeek V4 Flash (36x more requests)
3. **Reasoning model:** GLM-5 (when needed)
4. **Fallback chain:** Always include multiple tiers

The system is designed to preserve autonomy and team differentiation while being cost-effective.

---

*See also: ANALYSIS.md, INNOVATE.md, DESIGN.md, ADAPTATION.md*