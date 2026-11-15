# Retail evidence

## Sources

- A spell id missing from Wowhead is inconclusive: check the world DB's `spell_dbc` table (server-side spells) before
  concluding a sniffed id doesn't exist.

## Unit flags

- `unit_flags`, `unit_flags2` and `dynamicflags` (SAI set/add-flag actions, C++
  `SetUnitFlag*`/`ReplaceAllUnitFlags*`/`SetDynamicFlag`): add only with sniff or upstream evidence (the same flag in
  another script is none).
