---
name: Azeroth Single
last_updated: 2026-05-11
---

# Azeroth Single Strategy

## Target problem

This repo is a learning ground for predictable agent-driven development, but agent changes are currently too large and messy to understand as a fundamental unit of change. Validation is mostly manual, and architecture trade-offs are hard to evaluate without stronger software engineering fundamentals.

## Our approach

We make agent work predictable by forcing every change through a small, evidence-backed loop: understand existing patterns, make a scoped patch, explain trade-offs and risks, verify with tests, and record architectural lessons. The bet is that a highly contributed-to open source game server already contains good decisions, so each change should teach why it fits or does not fit within that framework.

## Who it's for

**Primary:** Me, an avid gamer learning agent-driven software development - I'm hiring this repo to teach software architecture through agent work on a real game server codebase.

## Key metrics

- **Character loading time** - Time from selecting a character to reaching a playable state; measured through local performance checks or instrumentation.
- **Map loading time** - Time for a world or map transition to complete; measured through local performance checks or instrumentation.
- **Quest load time** - Time for quest data and interactions to become available; measured through local performance checks or instrumentation.
- **Developer throughput** - PRs completed with agent assistance, with each PR representing a scoped, understandable unit of change.
- **Weekly usage** - Whether I return to the repo/process each week; measured by weekly development activity.

## Tracks

### Quest iteration

Small changes to existing quests and net new quest content are the main learning surface.

_Why it serves the approach:_ Quest work gives agents bounded changes where patterns, tests, and architecture trade-offs can be studied without taking on the whole server at once.

### Performance improvement

Reduce character, map, and quest loading friction while learning how server architecture affects runtime behavior.

_Why it serves the approach:_ Performance work makes architecture concrete by tying design choices to observable latency and loading outcomes.

### Quality of life improvements

Reduce unnecessary MMO time sinks instead of optimizing for maximum playtime.

_Why it serves the approach:_ Quality of life work gives the project a clear product direction and creates changes that can be judged by whether they make play smoother, not just bigger.
