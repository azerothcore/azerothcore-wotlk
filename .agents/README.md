# .agents

Source of truth for this repo's agent skills and rules:

- `skills/<name>/SKILL.md`
- `rules/<name>.md`

Agent-specific directories expose each via a relative symlink — for Claude Code:

    .claude/skills/<name> -> ../../.agents/skills/<name>
    .claude/rules/<name>.md -> ../../.agents/rules/<name>.md

To add a skill or rule: create it here, then symlink it.

The skills in this repository often build on those from
[agent-toolkit](https://github.com/eai-org/agent-toolkit/), invoking them when available.
Installing the toolkit at user level is therefore recommended.
