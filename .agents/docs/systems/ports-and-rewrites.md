# Ports and rewrites

Porting C++, SQL or SAI from TrinityCore, cMaNGOS or tbc-db, and rewriting an existing script.

## Porting from another core

- Port the whole mechanism, not just enough to compile: every upstream call site sending or triggering it, every
  filter condition, and any upstream line replacing or removing old AC behaviour (e.g. an older empty send of the
  same packet).
- Keep upstream types or adapt the serialization: TC packets often declare GUIDs as `PackedGuid`, but AC's
  `<< ObjectGuid` writes the raw uint64, so write a packed GUID once: `appendPackGUID(guid.GetRawValue())`, or
  `guid.WriteAsPacked()`, which heap-allocates per call.
- Before upstream code replaces AC code, check the replaced lines' git history for AC-only guards or fixes upstream
  lacks, and keep them.
- Ported SAI or waypoint data is unverified: call it ported in the PR, never sniff-confirmed, and let sniff data
  override it. Ported paths, spells, summoned escorts and timers can all be wrong; another core's repeat timer can be
  a script loop, not a spawn cadence.
- Don't copy another core's workaround where AC has a mechanism.

## Rewriting a script

- Rewriting a script or porting SmartAI to C++: diff the deleted rows/code against the new code and carry over every
  behaviour unless a source (sniff, video, upstream) shows it wrong; list each behaviour dropped or changed on
  purpose in the PR description. Copy numeric params (radii, timers, durations, spell ids) from the deleted
  rows/code, never from a review bot's suggestion or a guess. Rewrites usually lose:
  - NPC, questgiver and gossip flags re-armed in `Reset`
  - texts and yells
  - actions at waypoint and path ends (e.g. GO activation)
  - the respawn/reload path of an encounter already `DONE`
- An entry moved to a C++ script whose `GetAI` returns an AI wherever the entry spawns never uses its AIName
  (`FactorySelector::SelectAI` picks the script AI first, pets excepted): clear AIName and delete its `smart_scripts`
  rows and their conditions. A null `GetAI` falls back to AIName, so keep the SmartAI where that happens: a ScriptName
  without `GetAI` (e.g. gossip-only), or a `GetInstanceAI` script whose entry also spawns outside that instance.
