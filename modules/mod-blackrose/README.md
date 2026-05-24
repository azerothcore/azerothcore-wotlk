# Black Rose Module

This module owns the custom Black Rose questline, Rosy vendor content, Bag of
the Black Rose upgrades, The Black Rose trinket, and the first red/yellow Black
Rose gem systems.

Build with modules enabled, apply the module SQL updates, restart worldserver,
and clear the WoW client cache before validating item names and tooltips.

## Client DBC Patch

The server module provides the custom rows used by worldserver. For full client
tooltip display, the client patch must also include:

- Spell `900900` with the green trinket `Use:` text.
- The 20-second duration row for spell `900900`.
- Black Rose `SpellItemEnchantment` rows for all Ribbon/Mist socket bonuses.
- Black Rose `GemProperties` rows for all Ribbon/Mist gem items.

## Configuration

Track `conf/BlackRose.conf.dist` in git. The real `BlackRose.conf` is generated
or copied into the server config directory for local use and should stay
untracked.

## Contribution Helpers

- `pull_request_template.md` documents the expected PR summary and test plan.
- `.git_commit_template.txt` follows the repository Conventional Commits style.
- `setup_git_commit_template.sh` can set the local git commit template for this
  repository.
