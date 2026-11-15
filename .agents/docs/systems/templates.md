# Templates

## creature_template_model

- Rows were generated from the old `modelid1`-`modelid4` columns, and that migration copied
  `creature_template.VerifiedBuild` onto every `Idx`: equal probabilities are that import's default, not a
  randomization claim.
- Judge a stamp by its build, not its `Idx`: a legacy build on the extra rows is migration noise, while later sniff
  passes stamp `Idx` >= 1 legitimately.
- Authority is the creature query response's per-index `Probability`, which Classic and retail sniffs carry and 3.3.5
  clients omit.
- Suppress a model by setting its `Probability` to 0 and keeping the row, never by deleting it. Keep a creature's only
  row at 1: the loader reads a zero total as equal chance and resets every row to 1.0.

## creature_immunities

- Negative ids are curated shared sets: reference them via `creature_template.CreatureImmunitiesId`, never edit them
  or allocate new ones.
- Positive ids are single-creature sets: reuse one only on an exact match. To extend a creature's immunities, insert a
  superset under a new id and point its `CreatureImmunitiesId` at it.
