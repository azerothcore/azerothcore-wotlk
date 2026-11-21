# Pursuing Spikes targeting (AC#14076)

Run with the normal `E2E_*` realm/database settings, from `e2e/`:

```sh
go test -tags=e2e ./suites/instances/trial_of_the_crusader -run TestAC_14076 -count=1 -p 1 -parallel 1 -v
```

Two level-80 paladins form a fresh raid and enter the empty ToC arena. A neutral
World Trigger fixture casts the encounter's real summon spell (66169), creating
Pursuing Spikes (34660) with the ToC instance AI. Characters receive extra health,
but no god mode or damage immunity. The immunity spells are cast by the clients.
The summon and persistent fixture are removed during cleanup. Each run owns two
new accounts: cleanup is registered before login, closes the bot sessions, deletes
their characters through the server, then deletes the accounts and GM permissions.
This also runs after assertion/setup failures. Cleanup errors fail the test and
trigger an attempt to ban remaining accounts; ban failures are reported too.
Existing accounts from earlier runs are untouched.
Character retention follows the server's configured deletion policy. A killed
test process cannot run Go cleanup callbacks and still requires manual cleanup.

Oracles:

- Hand of Protection (10278): retain Mark (67574) and the same target throughout
  nine seconds, including reaching the stationary player and accelerating (65922).
- Divine Shield (642): release the fully immune player and mark the other player.
  If both players become fully immune, clear the target, continue accelerating,
  and reacquire the first player after they cancel their shield without resetting speed.
- Initially immune: summon while both players have Divine Shield, then cancel one
  shield and verify acquisition resumes at the accelerated speed.

The [issue discussion](https://github.com/azerothcore/azerothcore-wotlk/issues/14076#issuecomment-1345338310)
distinguishes Hand of Protection from Divine Shield, Ice Block and threat-dropping
abilities. Mark has `SPELL_ATTR0_NO_IMMUNITIES`; full immunity does not itself
remove it. The spike AI must explicitly release and replace the mark.

This fixture exercises spike AI in an instance, not the complete boss fight.
Additional encounter scenarios are Ice Block, Feign Death, Vanish, target death
and disconnect; Permafrost collision's four-second pause and speed restart; and
boss submerge/emerge cleanup. No change to Permafrost/Hand of Freedom (#16496) is
included. PR #19684 was merged independently in August 2024.

For test results and environment, see the
[PR description](https://github.com/azerothcore/azerothcore-wotlk/pull/27733).

## Pursuit start (`TestToC_PursuingSpikesTargetSearch`)

```sh
go test -tags=e2e ./suites/instances/trial_of_the_crusader -run TestToC_PursuingSpikesTargetSearch -count=1 -p 1 -parallel 1 -v
```

Same raid and summon as above, but in Anub'arak's chamber: a killed Frost Sphere
falls to the chamber floor (z 143) and casts Permafrost, which it cannot do from
the arena. Both paladins stand in the Permafrost 35 yards from the World Trigger,
so the spike's first pursuit breaks on arrival and restarts after 4s.

Oracles, read from the spike's `SMSG_SPELL_GO` server timestamps and its raid boss
emote:

- First pursuit: the spike idles about 1.6s after it appears, then 67470 hits both
  players and Pursued by Anub'arak (67574) lands 1.6s later, with no target and no
  movement before it and the emote naming the marked player.
- Divine Shield on the marked player: the other is re-marked within a second,
  without a new 67470.
- Restart: 67470 hits the player who is not shielded, and the mark and emote
  follow 1.6s later without the spike moving first.

65920 is cast triggered and has no spell visual, so the core sends no
`SMSG_SPELL_GO` for it.
