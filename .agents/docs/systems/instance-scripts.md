# Instance scripts

Object storage of `InstanceScript`/`InstanceMapScript` (`instance_*.cpp`) and the scripts that read or write it.

## ObjectData slots

- Each entry in the `ObjectData` tables passed to `LoadObjectData` maps to a `DATA_*` slot holding a single guid:
  `OnCreatureCreate` overwrites it unconditionally and `OnCreatureRemove` erases it when the current holder despawns.
  A summon with a listed entry thus redirects every `instance->GetCreature(DATA_X)` to itself and, once it despawns,
  empties the slot while the original spawn still lives.
- Never summon an entry listed in `ObjectData`; use a dedicated entry or track the summon through the summoner's
  `SummonList`/guid member.
