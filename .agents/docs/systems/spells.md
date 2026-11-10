# Spells

## SpellInfoCorrections

`SpellInfoCorrections.cpp` overrides DBC spell data, and most of its entries are hacks. For any
change to it:

- Needing a correction is a sign the motivating claim may be wrong: re-verify the claim (issue,
  comment) against sniffs or DBC data before overriding.
- Compare with what the file mostly corrects: attributes, targets, radii, effects. Timing overrides
  (duration, amplitude) are rare and maintainers flag them; they need source evidence.
