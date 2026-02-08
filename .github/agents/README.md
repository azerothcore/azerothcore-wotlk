# GitHub Agents Configuration

This directory contains configuration files for AI-powered code review and development agents used in the AzerothCore project.

## Overview

Agent configuration files provide context-specific instructions to AI tools (like GitHub Copilot, Claude, etc.) when they interact with this repository. These configurations ensure that automated reviews and code suggestions follow project-specific standards and best practices.

## Available Agents

### PR Reviewer (`pr-reviewer.md`)

The PR Reviewer agent is configured to review pull requests with deep understanding of AzerothCore's:
- Architecture patterns (two-server model, scripting system, database structure)
- Code style requirements (indentation, line length, formatting)
- Commit message conventions (Conventional Commits format)
- Testing and validation requirements
- Security and quality standards

**Key Feature**: This agent always references `/CLAUDE.md` for comprehensive project context before reviewing any PR.

## How It Works

When an AI tool reviews a PR in this repository:

1. The tool reads the appropriate agent configuration from this directory
2. The agent configuration instructs it to read `/CLAUDE.md` for full project context
3. The agent applies project-specific rules during review
4. Feedback is provided following the project's conventions and standards

## For Contributors

If you're using AI tools to assist with contributions:

1. Familiarize yourself with `/CLAUDE.md` - it contains essential project knowledge
2. The AI agents will help ensure your changes follow project standards
3. Agent feedback should be treated as helpful suggestions that align with maintainer expectations

## For Maintainers

To update agent configurations:

1. Edit the relevant `.md` file in this directory
2. Ensure any changes align with documentation in `/CLAUDE.md`
3. Test the updated configuration with a sample PR review
4. Commit changes following the project's commit message format

## References

- Project guidelines: `/CLAUDE.md`
- PR template: `/pull_request_template.md`
- Contribution guide: `/.github/CONTRIBUTING.md`
