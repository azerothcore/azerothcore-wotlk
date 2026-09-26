# .agents

Source of truth for this repo's agent skills and docs:

- `skills/<name>/SKILL.md`
- `docs/` — task-scoped agent docs; taxonomy and placement policy in `docs/README.md`
- `plans/` — per-task planning docs, gitignored

Conventions live in `AGENTS.md` and `docs/`. Agent-specific files point there instead of restating
them, so there is one copy to keep current.

## Hooking up your agent

- **Claude Code** — reads `CLAUDE.md`, which imports `AGENTS.md`. Skills are exposed by a relative
  symlink: `.claude/skills/<name> -> ../../.agents/skills/<name>`.
- **GitHub Copilot** — reads `AGENTS.md` natively. Code review also reads
  `.github/copilot-instructions.md`; custom agent profiles live in `.github/agents/`.
- **Any other agent** — point it at `AGENTS.md` through its own entry file (`GEMINI.md`,
  `.cursorrules`, …), using that agent's include syntax or, where includes are unsupported, a line
  telling it to read `AGENTS.md` first.

To add a skill: create it here, then symlink it from each agent's skills dir. Docs need no
symlinks — AGENTS.md references them by path.

On Windows, symlinks need `git config core.symlinks true` plus Developer Mode or an elevated shell;
without them git checks the links out as plain text files.

The skills in this repository often build on those from
[agent-toolkit](https://github.com/eai-org/agent-toolkit/), invoking them when available.
Installing the toolkit at user level is therefore recommended.
