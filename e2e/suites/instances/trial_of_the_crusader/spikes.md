# Pursuing Spikes targeting (AC#14076)

Run with the normal `E2E_*` realm/database settings, from `e2e/`:

```sh
go test -tags=e2e ./suites/instances/trial_of_the_crusader -run TestAC_14076 -count=2 -p 1 -parallel 1 -v
```

Two level-80 paladins form a fresh raid and enter the empty ToC arena. A neutral
World Trigger fixture casts the encounter's real summon spell (66169), creating
Pursuing Spikes (34660) with the ToC instance AI. Characters receive extra health,
but no god mode or damage immunity. The immunity spells are cast by the clients.
The summon and persistent fixture are removed during cleanup.

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

Live reproduction on the unmodified PTR core (`ca8e6d78dee1+`) showed Hand of
Protection still active when the spike reached the player and switched targets
about 6.7 seconds after the cast. The committed test must fail with `AC#14076
CONFIRMED BUG` on that behavior and pass on a patched server. Patched-binary
validation is pending; local reproduction is not proof that the fix passes.

This fixture exercises spike AI in an instance, not the complete boss fight.
Manual encounter checks still needed: Ice Block, Feign Death, Vanish, target death
and disconnect; Permafrost collision's four-second pause and speed restart; normal
boss submerge/emerge cleanup. No change to Permafrost/Hand of Freedom (#16496) is
included. PR #19684 was merged independently in August 2024.

The TC9 gateway sometimes performs a second instance transfer during fixture setup
when repeating the entire test in one process; this produces a setup failure before
spike summoning. Reproduction succeeded in a complete single run. Stock-core CI and
repeatability on the patched binary remain to be checked.
