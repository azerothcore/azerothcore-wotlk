# SmartAI

Data-driven behaviour in the world DB's `smart_scripts` (engine: `src/server/game/AI/SmartScripts/`).

- Edits rewrite the full block: `DELETE` + `INSERT` of every row for the `(entryorguid, source_type)` pair, the
  `DELETE` matching both columns; never a partial `UPDATE`, not even for a comment-only fix.
