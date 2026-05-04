# GitHub Issues: Naming Inconsistency

*Draft issues for creating on your own fork.*

---

## Issue 1: Rename `ultrawork` Command

**Title:** Rename: Standardize `ultrawork` command

**Body:**

```markdown
# Rename: Standardize `ultrawork` Command

## Summary
The command `ultrawork` is used alongside `ulw` as an alias throughout the codebase. Consider consolidating to a single consistent name.

## Occurrences
- **TypeScript files:** ~304 occurrences
- **Patterns:** `ultrawork` keyword detection, file names, function names, variable names
- **Key files:** `src/shared/system-directive.ts`, `src/plugin/ultrawork-*.ts`, `src/hooks/keyword-detector/`

## Code Impact Analysis

### Breaking Change Risk: **HIGH**
- User commands (`/ultrawork`) would need migration
- Configuration keys referencing `ultrawork` would break
- Documentation and skill files may reference this name

### Estimated Cost to Rename
- **Time:** 4-6 hours
- **Testing:** 1-2 hours (comprehensive test suite)
- **Risk:** High - user-facing command alias

## Recommendation
**Deprecate gradually** - Keep `ultrawork` as alias, prefer `ulw` or new name, add deprecation warning.

## Alternative Names to Consider
- `work` (simple, clear)
- `go` (short)
- Keep `ultrawork` and remove `ulw` instead
```

---

## Issue 2: Rename `ulw` Command

**Title:** Rename: Standardize `ulw` command

**Body:**

```markdown
# Rename: Standardize `ulw` Command

## Summary
The command `ulw` is used alongside `ultrawork` as an alias throughout the codebase. Consider consolidating to a single consistent name.

## Occurrences
- **TypeScript files:** ~138 occurrences
- **Patterns:** `ulw` keyword detection, file names (`ulw-loop`), function names
- **Key files:** `src/plugin/tool-execute-before.ulw-loop.test.ts`, `src/shared/system-directive.ts`, `src/hooks/ralph-loop/ulw-loop-verification.test.ts`

## Code Impact Analysis

### Breaking Change Risk: **HIGH**
- User commands (`/ulw-loop`) would need migration
- Configuration may reference this name
- Documentation and skill files may reference this name

### Estimated Cost to Rename
- **Time:** 3-5 hours
- **Testing:** 1-2 hours
- **Risk:** High - user-facing command alias

## Relationship to `ultrawork`
`ulw` and `ultrawork` are co-existing aliases. Renaming one affects the other. Pick one to keep and deprecate the other, or pick a new name entirely.

## Recommendation
**Pick one canonical name** - Either keep `ulw` (shorter, less typing) or `ultrawork` (more descriptive), but not both.

## Alternative Names to Consider
- `work` (replaces both, simple)
- `go` (short)
- `ulw` (keep, remove `ultrawork`)
- `ultrawork` (keep, remove `ulw`)
```

---

## Issue 3: Rename `oh-my-opencode` to `oh-my-openagent`

**Title:** Rename: Standardize plugin name `oh-my-opencode` → `oh-my-openagent`

**Body:**

```markdown
# Rename: Standardize Plugin Name

## Summary
The plugin uses dual naming conventions: `oh-my-opencode` (legacy) and `oh-my-openagent` (new). This causes confusion in code, docs, and configuration.

## Occurrences
- **TypeScript files:** ~551 occurrences of `oh-my-opencode`
- **TypeScript files:** ~277 occurrences of `oh-my-openagent`
- **Files:** Package configs, source files, test files, config file recognition

## Code Impact Analysis

### Files Affected
- All source files using constants (`PLUGIN_NAME`, `LEGACY_PLUGIN_NAME`)
- Package.json (dual publish as both names)
- Config file recognition in `src/shared/plugin-identity.ts`
- Log file naming: `oh-my-opencode.log`
- Cache directory naming: `oh-my-opencode`

### Breaking Change Risk: **EXTREME**
- npm package name cannot change (already published)
- All existing user configs using `oh-my-opencode.jsonc` would break
- Migration system handles some of this but not all paths
- Very high chance of user confusion and breakage

### Estimated Cost to Rename
- **Time:** 8-12 hours (extensive refactoring)
- **Testing:** 2-3 hours
- **Risk:** Extreme - published npm package with existing users

## Recommendation
**Keep dual naming for backward compatibility** - The current approach of recognizing both names is intentional during transition period. Close as "won't fix" or "later".
```

---

## Issue 4: Consolidate `ralph-loop` Command

**Title:** Rename: Clarify relationship between `ralph-loop` and `ulw-loop`

**Body:**

```markdown
# Rename: Clarify Relationship Between `ralph-loop` and `ulw-loop`

## Summary
The codebase has both `ralph-loop` and `ulw-loop` commands with slightly different behavior. The naming is confusing.

## Occurrences
- **TypeScript files:** ~80 occurrences of `ralph-loop`
- Multiple file pairs: `tool-execute-before.ts` vs `tool-execute-before.ulw-loop.test.ts`

## Code Impact Analysis

### Breaking Change Risk: **MEDIUM**
- User commands would need migration
- Internal logic is already split (RalphLoop vs UlwLoop)
- Can be kept as separate commands but needs clearer naming

### Estimated Cost to Rename
- **Time:** 2-3 hours
- **Testing:** 1 hour
- **Risk:** Medium - user-facing commands

## Recommendation
Rename `ulw-loop` to something more descriptive, or document the relationship clearly between `ralph-loop` and `ulw-loop`.
```

---

Created for your own fork. Copy the body content and create issues manually on your GitHub repo.