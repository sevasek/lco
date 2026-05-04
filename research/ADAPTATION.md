# Oh-My-OpenCode Adaptation Plan

**Goal:** A low-cost automated coding system
**Subscription:** OpenCode Go (Grok) - dollar-based limits
**Created:** 2026-05-04

---

## Guiding Principles

1. **Low-cost operation** - Strategic model selection to maximize requests
2. **Full automation** - System runs without hand-holding
3. **Effectiveness over speed** - Reliable results, even if slower
4. **Preserve autonomy** - Keep existing automation features (Ralph Loop, todo continuation, etc.)
5. **Preserve team differentiation** - Specialized agents working together, not with user
6. **Model efficiency** - Use cheaper models for routine work, expensive models only when needed

---

## OpenCode Go Usage Reality

| Window | Limit | Notes |
|--------|-------|-------|
| Every 5 hours | $12 USD | ~880-31,650 requests depending on model |
| Weekly | $30 USD | ~2,100-75,000 requests |
| Monthly | $60 USD | ~9,000-315,000+ requests |

**Key Insight:** DeepSeek V4 Flash gives **36x more requests** than GLM-5.1 for the same budget.

| Model | Requests / 5hr | Use For |
|-------|---------------|---------|
| DeepSeek V4 Flash | ~31,650 | Lightweight, routine tasks |
| MiniMax M2.7 | ~3,400 | Daily driver |
| Kimi K2.5 | ~1,850 | Complex, frontend, long context |
| GLM-5 | ~1,150 | Reasoning, architecture |

---

## Priority Levels

### Priority 1: Model Foundation (Must Do)
**Goal:** Low-cost operation with reliable fallback

| Action | Details |
|--------|---------|
| Set efficient models as PRIMARY | Each category/agent explicitly configured |
| Order fallback chain | DeepSeek V4 Flash → MiniMax M2.7 → Kimi K2.5 → GLM-5 → big-pickle |
| Use cheap models by default | Reserve expensive models for complex tasks |

**Config location:** `~/.config/opencode/oh-my-opencode.jsonc`

---

### Priority 2: Preserve Autonomy Features (Must Do)
**Goal:** Keep existing automation that makes the system "just work"

| Feature | Status | File/Location |
|---------|--------|---------------|
| Ralph Loop (`/ultrawork`) | KEEP | src/hooks/ralph-loop/ |
| Todo Continuation | KEEP | src/hooks/todo-continuation-enforcer/ |
| Runtime Fallback | KEEP | src/hooks/runtime-fallback/ |
| Model Fallback | KEEP | src/hooks/model-fallback/ |
| Auto-retry | KEEP | Implemented in hooks |
| Session Recovery | KEEP | src/hooks/session-recovery/ |

**Rationale:** These features create "set and forget" automation. The system fixes itself when things go wrong.

---

### Priority 3: Preserve Agent Differentiation (Must Do)
**Goal:** Keep the specialized team working as designed

| Agent | Role | Recommended Model | Requests/5hr |
|-------|------|-------------------|--------------|
| Sisyphus | Orchestrator, plans and delegates | kimi-k2.5 | ~1,850 |
| Hephaestus | Autonomous deep worker | kimi-k2.5 | ~1,850 |
| Librarian | External docs/code search | deepseek-v4-flash | ~31,650 |
| Explore | Fast grep/analysis | deepseek-v4-flash | ~31,650 |
| Oracle | Read-only consultation | glm-5 | ~1,150 |
| Atlas | Todo orchestrator | minimax-m2.7 | ~3,400 |
| Multimodal-Looker | Image/PDF analysis | kimi-k2.5 | ~1,850 |

**Key insight:** Agents work *with each other*, not with the user. This team dynamic must be preserved.

---

### Priority 4: Task Routing (Should Do)
**Goal:** Route tasks to the best model for the job type

| Category | Primary Model | Fallback | Task Types |
|----------|---------------|----------|------------|
| quick | deepseek-v4-flash | qwen3.5-plus | Simple edits, grep, reading |
| deep | kimi-k2.5 | glm-5 | Complex multi-file changes |
| visual-engineering | kimi-k2.5 | - | UI work, images |
| ultrabrain | glm-5 | kimi-k2.6 | Hard logic, debugging |
| artistry | deepseek-v4-flash | qwen3.5-plus | Creative text |
| writing | deepseek-v4-flash | qwen3.5-plus | Documentation |

---

### Priority 5: Skills Selection (Should Do)
**Goal:** Enable only skills that add value without overhead

| Skill | Recommendation | Rationale |
|-------|---------------|-----------|
| git-master | **ENABLE** | Version control essential |
| code-review | **ENABLE** | Quality assurance |
| testing | **ENABLE** | Reliable code |
| playwright | DISABLE | Browser automation overhead unless needed |
| frontend-ui-ux | DISABLE | Visual work - use kimi-k2.5 directly |
| custom skills | Evaluate per-use | Add as needed |

---

### Priority 6: Optimization (Later)
**Goal:** Tune after effectiveness proven

- Disable unused hooks (audit first)
- Simplify transform hooks (may not need all 5)
- Reduce unnecessary output
- Optimize for specific workflow patterns

---

## Implementation Roadmap

### Phase 1: Foundation (Priority 1)
- [ ] Create config file with low-cost model assignments
- [ ] Set fallback chain in config
- [ ] Test model switching works

### Phase 2: Automation (Priority 2)
- [ ] Verify all autonomy features enabled
- [ ] Test Ralph Loop with low-cost models
- [ ] Test todo continuation

### Phase 3: Team (Priority 3)
- [ ] Configure each agent with low-cost model
- [ ] Test agent delegation
- [ ] Verify team collaboration works

### Phase 4: Routing (Priority 4)
- [ ] Configure categories with optimal models
- [ ] Test task routing
- [ ] Verify category selection works

### Phase 5: Skills (Priority 5)
- [ ] Audit available skills
- [ ] Enable/disable as planned
- [ ] Test skill execution

### Phase 6: Optimization (Priority 6)
- [ ] Benchmark performance
- [ ] Identify bottlenecks
- [ ] Tune as needed

---

## Final Configuration Template

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

## Notes

- DeepSeek V4 Flash is your workhorse for maximum requests (36x more than expensive models)
- Kimi K2.5 is your power model for complex work (262K context, multimodal)
- GLM-5 is for deep reasoning (architecture, hard bugs)
- Breaking large tasks into smaller chunks improves success rate
- Explicit, clear prompts = better outputs
- The fallback chain ensures the system never gets stuck

---

*See also: ANALYSIS.md, DESIGN.md, INNOVATE.md, LOW-COST-MODELS.md*