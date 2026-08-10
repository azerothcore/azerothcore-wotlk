# GitHub agents

Custom agent profiles, used by the Copilot surfaces that read them: GitHub.com, the Copilot CLI and
supported IDEs. A profile needs YAML frontmatter with a `description` to register.

Copilot code review does not read this directory. It takes its instructions from
`.github/copilot-instructions.md`, `.github/instructions/**` and `AGENTS.md`.

## Available agents

- `pr-reviewer.md` — reviews a pull request against the project's conventions.

Conventions live in `AGENTS.md` and `.agents/docs/`. Profiles here point at those docs and must not
restate them, so there is one copy to keep current.
