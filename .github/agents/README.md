# GitHub agents

Custom agent profiles, read by Copilot on GitHub.com, the CLI and supported IDEs. A profile needs
YAML frontmatter with a `description` to register.

Copilot code review does not read this directory; its instructions are
`.github/copilot-instructions.md`, `.github/instructions/**` and `AGENTS.md`.

Conventions live in `AGENTS.md` and `.agents/docs/`. Profiles point at them and must not restate
them, so there is one copy to keep current.
