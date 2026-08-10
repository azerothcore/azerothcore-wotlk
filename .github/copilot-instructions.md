# Copilot instructions for AzerothCore

AzerothCore is a C++ MMORPG server emulator for World of Warcraft 3.3.5a (WotLK), built with CMake and backed by
MySQL. The project's conventions live in `AGENTS.md`, which routes to the detailed guides in `.agents/docs/`. Read
the guides that match what you are looking at before commenting on it.

## Code review output

Every pull request is read by a human maintainer. A review is only worth their time when it points at something
they would otherwise miss, so restrict the output to that.

- Do not open a review with a summary of the pull request. No overview paragraph, no "Changes" bullet list, no
  per-file table. The diff is on the same page and the author already described the change.
- Do not restate what a change does, and do not praise it or point out good practices.
- If there is nothing concrete to report, post no comments at all. Silence is the correct output for a clean
  pull request.
- Put findings in inline comments on the offending lines. Keep the review body empty.
- Write each comment as: what is wrong, why it matters, and the fix. Two or three sentences, no preamble, no
  emoji, no headings.

## What is worth a comment

Only comment when you can name a concrete defect:

- A bug, crash, deadlock, memory error, or use of an object past its lifetime.
- A data-integrity problem, most often a SQL `DELETE` whose `WHERE` clause is broader or narrower than the
  matching `INSERT`.
- A security issue, such as an unescaped query built by string concatenation instead of a `PreparedStatement`.
- A violation of a rule that is actually written down in `AGENTS.md` or `.agents/docs/`.

Do not comment on:

- Style questions that no project rule covers. Taste is not a finding.
- Anything CI already enforces. The codestyle scripts under `apps/codestyle/` and the `-Werror` builds report
  their own failures, and repeating them adds nothing.
- Missing tests, docstrings, or code comments, unless their absence is itself the defect being reported.
- Files under `data/sql/base/`, `data/sql/archive/`, `data/sql/updates/db_*/`, or `deps/`. Those are immutable or
  vendored. The one thing worth saying about them is that a pull request should not be touching them at all.
