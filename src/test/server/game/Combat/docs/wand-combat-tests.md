# Wand combat regression tests (PR #27198)

These tests use only AzerothCore and its Google Test fixtures. No bot client,
AzerothGhost, running realm, database, or extracted client data is required.

`WandCombatTest` checks production combat calculations, the shared wand predicate,
attack/proc classification, and the deliberately unchanged spell-crit calculation.

`WandCombatE2ETest` exercises the native **per-shot server pipeline**:
`Spell::prepare` -> target selection and hit resolution -> damage/procs -> player
weapon-skill updates. It uses the same triggered cast flags as
`Unit::_UpdateAutoRepeatSpell`. The fixtures provide real Player, Creature, Item
and Spell objects with synthetic spell/item/skill records. They do not emulate the
hit formula, damage application, proc classification or skill-update logic.
The fixture uses the server defaults for magic miss multipliers (11 against
creatures, 7 against players), supplies arrows, and gives the thrown weapon enough
durability to finish a complete sample.

An additional scenario exercises the auto-repeat controller, its initial delay,
repeated shots and cancellation, advancing attack timers explicitly.

The e2e boundary here is inside the server. These tests do **not** cover login,
client packets, real world/DBC content loading,
line-of-sight geometry or client presentation. They are not evidence of testing a
live realm or a graphical client.

## Running

From the repository root, configure a separate build and build the test target:

```sh
cmake -S . -B build-wand-tests -DBUILD_TESTING=ON -DSCRIPTS=none -DMODULES=none
cmake --build build-wand-tests --target unit_tests -j2
build-wand-tests/src/test/unit_tests --gtest_filter='WandCombatTest.*'
ctest --test-dir build-wand-tests -R '^wand_combat_e2e$' --output-on-failure
```

For the measured shot counts and rates, save Google Test's XML output:

```sh
build-wand-tests/src/test/unit_tests --gtest_filter='WandCombatE2ETest.*' \
  --gtest_output=xml:wand-combat-results.xml
```

The ordinary `unit` CTest entry excludes this e2e suite; a full `ctest` run executes
both entries without duplicating the combat scenarios.

## Review coverage and oracles

- Level 80, Wands 1, level-80 NPC: exact 60% miss cap and 20,000 resolved shots.
- Level 80, Wands 400, level-83 NPC: exact 8% miss chance and 20,000 resolved shots.
- Skill gain on hits **and misses**: separate low-skill trials verify actual skill
  field increments, zero damage on misses, and nonzero damage on hits.
- Spell-only hit: apply `ITEM_MOD_HIT_SPELL_RATING` through the production item
  bonus path; verify that spell hit increases while wand misses remain near 8%.
- Generic hit rating: apply `ITEM_MOD_HIT_RATING`; it increases ranged hit too and
  must still improve wand accuracy. The review's generic "+spell hit gear" wording
  should not be interpreted as making ordinary WotLK hit-rating gear ineffective.
- Auto Shot and Throw: verify their existing ranged proc classification and
  capped-skill accuracy in the presence of spell hit.
- Both public `SpellHitResult` overloads are exercised. Wand crit remains spell crit.

Rate tests disable weapon-skill gains so the denominator refers to one fixed skill
value. The skill-gain scenario uses normal gains and restores skill 1 before each
trial. At that level gap the existing skill-up chance exceeds 100%, so a missed
shot must increment skill; it is not enough to see eventual progress after hits.

Statistical assertions use six standard deviations plus a small allowance for the
core's inclusive random-roll interval. They also reject unexpected outcomes and
check actual damage. Rating conversion data is absent in this isolated fixture,
so the core's default conversion of one rating point per percentage point is used;
the tests validate the choice of rating channel, not a particular live item value.

To check that the tests detect the original regression, temporarily remove the
wand branches in both `Unit::SpellHitResult` overloads and the wand ranged-attack
classification in `Unit::MeleeSpellHitResult`, rebuild and run the wand suites.
The low-skill rate, capped-skill rate and spell-hit cases must fail. Restore the
production change afterward. A separate mutation removing missed outcomes from
`ProcSkillsAndReactives` must fail the missed-shot skill-gain case.

## Recorded native validation — 2026-09-05

Built the `unit_tests` target with GCC in Debug mode, scripts/modules disabled.
All 8 wand unit tests and 10 native e2e scenarios passed. Another 11 existing tests
(`ProcUnitIntegrationTest` and `FrostboltPvPTest`) passed alongside the wand unit
tests in shuffled order. C++ codestyle and `git diff --check` passed.

Each accuracy row below represents 20,000 actual per-shot casts. The old-behavior
column comes from a separate executable linked with a scratch copy of `Unit.cpp`
that removes only the three wand-specific hit-routing/classification changes.
The branch's production source was not modified for this negative control.

| Scenario | PR misses / shots | PR miss rate | Old-behavior miss rate |
| --- | ---: | ---: | ---: |
| Wands 1 vs level 80 | 11972 / 20000 | 59.860% | 4.130% |
| Wands 400 vs level 83 | 1592 / 20000 | 7.960% | 16.830% |
| Spell-only hit rating, capped skill | 1597 / 20000 | 7.985% | 0.000% |
| Generic hit rating, capped skill | 1004 / 20000 | 5.020% | Not sampled |
| Ranged hit bonus, capped skill | 1007 / 20000 | 5.035% | Not sampled |
| Hunter Auto Shot | 1600 / 20000 | 8.000% | 8.210% |
| Throw | 1631 / 20000 | 8.155% | 7.860% |

The skill-gain scenario observed 60 misses and 40 hits; every shot raised Wands
from 1 to 2. The auto-repeat delay/repetition/cancellation and unchanged spell-crit
checks also passed.

The negative control failed all four selected wand regression checks, including
both `SpellHitResult` overloads; Auto Shot and Throw passed. These are native
fixture measurements, not live-realm measurements. No PR comment was posted.
