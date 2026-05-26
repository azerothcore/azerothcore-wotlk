# Black Rose client patch builder

Generates the binary DBC files for a 3.3.5a (build 12340) client patch that
matches the Black Rose server module. Covers the **bag**, **gem**,
**trinket**, **currency**, **custom item icons**, and **Rurik's Death
Mobile** mount in one build pipeline.

The mount intentionally reuses the stock 3.3.5a Mechano-Hog client model -
no custom M2/.skin/.blp assets are shipped, so the patch is small and the
client cannot reject a malformed model. The server-side spell
`spell_dbc.EffectMiscValue_1 = 29929` points the mount aura at the
stock "Mechano-hog" creature (entry `29929`); AC's
`AuraEffect::HandleAuraMounted` looks the display up via
`creature_template_model` at mount time.

## What this produces

Three buckets of files under `staging/`:

* **Nine DBC files** under `staging/DBFilesClient/` (item, spell, and
  enchant data the client needs for tooltips and right-click behavior).
* **UI and icon assets** under `staging/Interface/` (the login backdrop,
  Black Rose item icons, and the GlueXML overlay that wires it in).
* **One audio file** under `staging/Sound/` (replacement title music).

The DBCs:

| DBC                            | Black Rose rows added                                                                            |
|--------------------------------|--------------------------------------------------------------------------------------------------|
| `Spell.dbc`                    | Black Rose aura/use spells, gem and bag upgrade spells, Rurik's Death Mobile, and Rosy's Magic Stick use spell |
| `SpellDuration.dbc`            | `900900` 20 second duration                                                                      |
| `SpellItemEnchantment.dbc`     | 98 rows: red `900300..900386` and yellow `900400..900446` socket enchant tooltips                |
| `GemProperties.dbc`            | Same 98 IDs, red Type=2 / yellow Type=4                                                          |
| `ItemExtendedCost.dbc`         | `900700..900706` Black Miasma costs, `900710..900716` Black Petals costs, and `900720..900726` Black Thorns costs |
| `SkillLineAbility.dbc`         | `900903` registers Rurik's Death Mobile under the Riding skill line so it shows in the mount UI  |
| `QuestSort.dbc`                | `9009` "The Black Rose" header, referenced by `quest_template.QuestSortID = -9009`               |
| `Item.dbc`                     | One row per `item_template` entry in `[900100,901399]` (bags, trinket, mount item, gem upgrades, currencies, gems, and Rosy's sticks). Without these the client misclassifies custom items and breaks right-click. |
| `ItemDisplayInfo.dbc`          | Custom display IDs for The Black Rose, currencies, Ribbons, Mists, Jewels, and Rosy's sticks, pointing at BLP basenames in `extras/Interface/Icons/` |

These mirror the server `*_dbc` rows and the live `item_template` table
in `modules/mod-blackrose/data/sql/db-world/`, so client tooltips,
socket lines, the mount UI entry, and right-click behavior match what
the server enforces.

## How Item Icons Resolve

Custom item icons require both DBC mappings and the BLP assets. The client
does not have a separate icon manifest DBC; for 3.3.5a the item icon chain is:

```
Item.dbc item ID -> DisplayInfoID
ItemDisplayInfo.dbc DisplayInfoID -> InventoryIcon_1 basename
Interface\Icons\<InventoryIcon_1>.blp -> rendered icon
```

The server-side mirror is `item_template.displayid` plus
`itemdisplayinfo_dbc`, but the game client still needs its own patched
`DBFilesClient\Item.dbc` and `DBFilesClient\ItemDisplayInfo.dbc` inside the
MPQ. Shipping only `Interface\Icons\*.blp` is not enough; the client will have
the image files but no mapping from custom item/display IDs to those basenames.

Inside the packed MPQ the paths must be rooted exactly like this:

```
DBFilesClient\Item.dbc
DBFilesClient\ItemDisplayInfo.dbc
Interface\Icons\INV_BR_Misc_BlackMiasma.blp
Interface\Icons\INV_BR_Misc_StarkRibbon.blp
Interface\Icons\INV_BR_Misc_RosysMagicStick.blp
```

Do not pack the `staging/` folder itself as a top-level folder. If the archive
contains `staging\DBFilesClient\Item.dbc` or `staging\Interface\Icons\...`, the
client will not load those files.

If you ever want to swap the stock Mechano-Hog model for a custom mount,
re-add `creaturedisplayinfo` and `creaturemodeldata` to `_generate.py` and
to `DEFINITION_TO_SCHEMA` in `build_patch.py`. The schemas for both DBCs
are still defined in `dbc.py` so it's purely an additive change. You'll
also want to put the M2 bundle under `staging/Creature/<MountName>/` so it
gets packed into the MPQ alongside the patched DBCs - see the older git
history of this folder for an example using `tools/models/geargrinder/`.

## Layout

```
tools/clientpatch/
  README.md                 - this file
  build_patch.py            - CLI that produces DBCs and stages all assets
  dbc.py                    - WDBC binary read/write + 3.3.5a schemas
  dump_items.py             - dumps item_template rows to definitions/item.json
  definitions/              - JSON row data for each DBC (regenerable)
    _generate.py            - regenerates the JSONs from compact tables
    spell.json
    spellduration.json
    spellitemenchantment.json
    gemproperties.json
    itemextendedcost.json
    skilllineability.json
    questsort.json
    item.json               - regenerated by dump_items.py from live MySQL
    itemdisplayinfo.json    - custom item icon display rows
  extras/                   - non-DBC assets we ship as-is (committed)
    Interface/Icons/*.blp
    Interface/Glues/LoadingScreens/Login-Blackrose.blp
    Sound/Music/GlueScreenMusic/WotlkTitleScreen.mp3
    Interface/GlueXML/BlackRoseLogin.lua    <- append fodder, NOT shipped standalone
  extras_src/               - user-extracted stock client files (gitignored)
    Interface/GlueXML/GlueParent.lua   <- you extract this from interface.MPQ
  input/                    - drop base client DBCs here (gitignored)
    DBFilesClient/          - Spell.dbc, GemProperties.dbc, Item.dbc, ...
  staging/                  - build output (gitignored)
    DBFilesClient/          - patched DBCs
    Interface/...           - copied/patched UI files
    Sound/Music/...         - replacement music
```

`input/`, `extras_src/`, and `staging/` are gitignored so we do not
commit copyrighted client data or build artefacts.

## Quick start

### 1. Verify the toolchain (no client needed)

```bash
cd tools/clientpatch
python3 build_patch.py customonly
```

That writes DBCs containing **only** the Black Rose rows into
`staging/DBFilesClient/`. They are not a usable client patch on their own
because they would replace the client's full Spell.dbc with three rows. They
are useful for verifying the writer and inspecting individual rows in
WDBXEditor / MyDBCEditor.

### 2. Extract base DBCs from your reference client

You need the current authoritative DBCs. For most 3.3.5a clients the DBCs
live in the locale archives under `WoW/Data/enUS/`, not just the root
`WoW/Data/patch-3.MPQ`.

Open the archives below in priority order and extract the newest available
copy of each required DBC into `input/DBFilesClient/`:

```
WoW/Data/enUS/patch-enUS-3.MPQ
WoW/Data/enUS/patch-enUS-2.MPQ
WoW/Data/enUS/patch-enUS.MPQ
WoW/Data/patch-3.MPQ
WoW/Data/patch-2.MPQ
WoW/Data/patch.MPQ
WoW/Data/common-2.MPQ
WoW/Data/common.MPQ
WoW/Data/enUS/locale-enUS.MPQ
```

Required files:

```
input/DBFilesClient/Spell.dbc
input/DBFilesClient/SpellDuration.dbc
input/DBFilesClient/SpellItemEnchantment.dbc
input/DBFilesClient/GemProperties.dbc
input/DBFilesClient/ItemExtendedCost.dbc
input/DBFilesClient/SkillLineAbility.dbc
input/DBFilesClient/QuestSort.dbc
input/DBFilesClient/Item.dbc
input/DBFilesClient/ItemDisplayInfo.dbc
```

Later archives in the load chain override earlier ones. If you extract by
hand, keep the newest/highest-priority copy of each DBC.

### 3. Build the merged patch

```bash
python3 build_patch.py merge
```

The tool reads each base DBC from `input/DBFilesClient/`, upserts the Black
Rose rows by `ID` (replacing any existing row with the same ID), sorts by ID,
and writes the merged result to `staging/DBFilesClient/`. It also copies
assets from `extras/` into `staging/` and validates that every custom
`ItemDisplayInfo.dbc` icon basename has a matching staged BLP file.

Output looks like:

```
  Spell.dbc                      base= 49839 custom=   7 added=   5 merged=  2 total= 49844
  SpellDuration.dbc              base=   130 custom=   1 added=   1 merged=  0 total=   131
  SpellItemEnchantment.dbc       base=  2656 custom=  98 added=  98 merged=  0 total=  2754
  GemProperties.dbc              base=   626 custom=  98 added=  98 merged=  0 total=   724
  ItemExtendedCost.dbc           base=   972 custom=  21 added=  21 merged=  0 total=   993
  Item.dbc                       base= 46096 custom= 331 added= 331 merged=  0 total= 46427
  ItemDisplayInfo.dbc            base= 57986 custom=  29 added=  29 merged=  0 total= 58015
```

(Counts vary depending on what patches are already on top of the client.)

### Build flow summary

`build_patch.py` has two modes:

* `customonly` writes DBCs containing only the rows in `definitions/*.json`.
  Use this for inspecting generated rows. Do not ship it as a client patch,
  because it would replace full client DBCs with Black Rose-only files.
* `merge` reads full base DBCs from `input/DBFilesClient/`, overlays the
  Black Rose rows from `definitions/*.json`, and writes full patched DBCs to
  `staging/DBFilesClient/`. This is the distributable build.

During `merge`, normal rows are upserted by `ID`. Rows with `_merge: true`
only override the fields present in JSON, which is useful for tweaking stock
rows without zeroing fields we do not manage. After DBC writing, the script
copies `extras/` to `staging/`, validates icon pathing, and optionally appends
the login-screen Lua overlay if `extras_src/Interface/GlueXML/GlueParent.lua`
is available.

### 4. Pack into an MPQ

Open Ladik's MPQ Editor and create a new MPQ:

* New MPQ: `patch-Z.MPQ`
* Format: **MPQ format v1** (3.3.5a-compatible)
* Hash table size: 4096 (default is fine for a few hundred files)
* Add the **contents** of the `staging/` folder, preserving directory
  structure, so the files end up at:
  ```
  DBFilesClient\Spell.dbc                      (and the other 8 DBCs)
  DBFilesClient\Item.dbc
  DBFilesClient\ItemDisplayInfo.dbc
  Interface\Icons\INV_BR_Misc_BlackMiasma.blp  (and the other icons)
  Interface\GlueXML\GlueParent.lua             (stock + appended overlay)
  Interface\Glues\LoadingScreens\Login-Blackrose.blp
  Sound\Music\GlueScreenMusic\WotlkTitleScreen.mp3
  ```
  inside the archive.

Save and close.

If you would rather script it, build StormLib and use its
`MPQAddFile` / `smpq` CLI; the `staging/` layout already matches the in-MPQ
virtual paths.

### 5. Deploy

Drop the resulting `patch-Z.MPQ` into the client's `WoW/Data/` folder. The
client loads `patch-*.MPQ` archives alphabetically; `Z` sorts last so it
overrides everything else.

If an existing custom patch is locked by the client or an MPQ editor, close
that process before replacing it. For a quick local test, you can temporarily
deploy the new archive under a later-sorting name such as `patch-zz.mpq`;
remove the older duplicate once the lock is gone so you do not keep stale
patches around.

For a locale-scoped variant put it at `WoW/Data/enUS/patch-enUS-Z.MPQ`
instead. Both work for 3.3.5a.

Then:

1. Delete (or rename) `WoW/Cache/` so the client re-fetches item and quest
   data from the server. The `Cache/WDB/<locale>/` files in particular
   stash item, quest, and creature info.
2. Restart the client and log in.

## Verifying the patch is loaded

In-game:

* `/script DEFAULT_CHAT_FRAME:AddMessage(GetSpellInfo(900900))` should print
  `Power of the Black Rose`. If it prints nothing, `Spell.dbc` is not
  loading.
* `/script DEFAULT_CHAT_FRAME:AddMessage(GetSpellInfo(900903))` should print
  `Rurik's Death Mobile`. Same check, different spell.
* Hover **The Black Rose** trinket: the green `Use:` line should match the
  description we wrote.
* Add or hover **Black Miasma**: it should use
  `Interface\Icons\INV_BR_Misc_BlackMiasma.blp`. If it is a question mark,
  check that the packed MPQ contains both `DBFilesClient\Item.dbc` and
  `DBFilesClient\ItemDisplayInfo.dbc`, not just the BLP icon files.
* Hover any **Klug Ribbon** before socketing: tooltip should show
  `+N intellect` from the gem properties + enchantment join.
* Socket a Klug Ribbon into The Black Rose: the item tooltip should grow a
  socket bonus line `+N intellect`.
* Use **Reins of Rurik's Death Mobile** - the spell appears in the mount UI
  under Companions/Mounts as `Rurik's Death Mobile`, and casting it spawns
  the Mechano-Hog motorcycle model the client already has. If the mount
  appears but is named "Mekgineer's Chopper" or "Mechano-Hog", the client
  patch is not loading. If the mount UI says `Rurik's Death Mobile` but
  casting does nothing, the SQL migration `2026_05_22_06_*.sql` did not
  run (no display ID set on the server side).

If a tooltip is wrong but `GetSpellInfo` works, your row data is wrong rather
than the patch not loading.

## Updating the row data

There are two sources of truth, depending on which DBC:

* **Generated rows (spells, durations, enchants, gem props, ext costs,
  skill line, quest sort).** `definitions/_generate.py` is the source
  of truth; re-run it whenever the formulas change:

  ```bash
  cd tools/clientpatch/definitions
  python3 _generate.py
  ```

* **Item rows (`Item.dbc`).** `item_template` is the source of truth -
  the SQL migration in `modules/mod-blackrose/data/sql/db-world/`. After
  applying SQL changes, dump fresh rows from the live DB:

  ```bash
  python3 tools/clientpatch/dump_items.py
  ```

  This connects to MySQL using `MYSQL_HOST` / `MYSQL_USER` /
  `MYSQL_PASSWORD` / `MYSQL_DB` env vars (defaults: `127.0.0.1` /
  `acore` / `acore` / `acore_world`) and writes
  `definitions/item.json` covering every item with `entry` in
  `[900100, 901199]`.

Then rebuild the patch with `python3 build_patch.py merge` from the
`tools/clientpatch/` directory.

For one-off hand edits, just edit the JSON directly. Re-running the
generators will overwrite hand edits.

## Custom login screen

The patch also replaces the WotLK login screen with the gothic
"Black Rose" backdrop, swaps the title music for `Ink Psalm`, and
overlays animated ember + ash particles with a torchlight flicker.

### Assets we ship (already in `extras/`)

| Path inside MPQ                                            | Source file                                       |
|------------------------------------------------------------|---------------------------------------------------|
| `Interface\Glues\LoadingScreens\Login-Blackrose.blp`       | The skull/rose backdrop (BLP2)                    |
| `Sound\Music\GlueScreenMusic\WotlkTitleScreen.mp3`         | "Ink Psalm" (ID3 tags stripped)                   |
| `Interface\GlueXML\GlueParent.lua`                         | Stock + appended overlay (frame + particles + FX) |

The MP3 ships at the stock title music path so even if the Lua's
`PlayMusic()` call is a no-op on this client, our file overrides
Blizzard's at MPQ-load time and is what gets played.

### How the overlay loads

This is the third version of the loading mechanism. The first two
both tripped *"Your login interface files are corrupt please reinstall
the game"*:

| Attempt | What we tried | Why it failed |
|---|---|---|
| 1 | `<Include file="BlackRoseLogin.xml"/>` injected into GlueParent.xml | 3.3.5a's glue XML parser does not recognise `<Include>` |
| 2 | `<Script file="BlackRoseLogin.lua"/>` injected into GlueParent.xml + new BlackRoseLogin.lua at glue path | Glue parser appears to reject second `<Script>` directives, OR new Lua files at glue paths |
| 3 (current) | **Append our overlay onto the user's stock GlueParent.lua, no XML modification, no new files** | works |

So the live mechanism is: the user extracts their stock
`Interface\GlueXML\GlueParent.lua`. `build_patch.py merge` reads that
file, appends `extras/Interface/GlueXML/BlackRoseLogin.lua` onto it
wrapped in `-- BEGIN/END BlackRoseLogin overlay --` markers, and writes
the merged Lua to `staging/Interface/GlueXML/GlueParent.lua`. The patch
ships exactly one Lua file at one stock path; the unmodified
`GlueParent.xml` already `<Script>`-loads it.

Idempotent: re-running the merge scrubs any prior appended block before
re-appending the current overlay source, so re-builds never end up
with a double-pasted overlay.

### One-time setup: extract your stock GlueParent.lua

Open Ladik's MPQ Editor, open `WoW/Data/interface.MPQ`, browse to:

```
Interface\GlueXML\GlueParent.lua
```

Extract it to:

```
tools/clientpatch/extras_src/Interface/GlueXML/GlueParent.lua
```

That folder is gitignored, so you won't accidentally commit Blizzard
client code.

### Build

`python3 build_patch.py merge` automatically:

1. Copies everything under `extras/` into `staging/` preserving paths
   (note: anything under `extras/Interface/GlueXML/` is **not** copied
   standalone - it's append fodder, see step 2). This includes
   `extras/Interface/Icons/*.blp`, which `ItemDisplayInfo.dbc` references
   by basename without the `.blp` suffix.
2. Validates every custom `ItemDisplayInfo.dbc` icon row against the
   staged `Interface/Icons/*.blp` files so missing icon assets fail fast.
3. Reads `extras_src/Interface/GlueXML/GlueParent.lua`, strips any
   prior `-- BEGIN/END BlackRoseLogin overlay --` block (so re-runs
   are idempotent), appends the contents of
   `extras/Interface/GlueXML/BlackRoseLogin.lua`, and writes the
   merged file to `staging/Interface/GlueXML/GlueParent.lua`.
4. Skips the GlueParent patch (with a warning) if you haven't extracted
   the stock file yet - DBC patching still works fine, you just won't
   get the new login screen.

Then pack the entire `staging/` directory into `patch-Z.MPQ` (preserve
paths). Both `Interface\` and `Sound\` need to make it into the archive,
not just `DBFilesClient\`.

### Animation notes

`BlackRoseLogin.lua` runs entirely on stock client assets - it uses
`Interface\Buttons\WHITE8x8` (a 1x1 white pixel that ships in every
WoW client) tinted via `SetVertexColor` for all 36 embers and 8 ash
motes. Tunables at the top of the file:

```lua
local NUM_EMBERS    = 36
local NUM_ASH       = 8
local PALETTE_RED   = 0.65   -- 0..0.65 = crimson embers
local PALETTE_AMBER = 0.85   -- 0.65..0.85 = amber embers
                             -- 0.85..1.00 = sickly green (eye-glow echo)
```

The flicker on the BG is a `0.55 Hz` sine breath plus tiny per-frame
jitter on `SetVertexColor`. If you want it more or less alive, edit
`BlackRoseLogin_OnUpdate`'s flicker block - the only part of the file
that can affect "is the image too dark / too pulsing".

### Caveats

* **Frame strata is `BACKGROUND`.** Our overlay sits below the form, so
  the account/password edits, login button, version string, and ToS
  dialog all keep working untouched.
* **The 3D model is `Hide()`-d on first OnUpdate.** If for some reason
  Blizzard's `AccountLoginModel` re-shows itself (e.g. after a back-out
  to character select), we hide it again next frame.
* **AccountLogin's BACKGROUND-layer textures are alpha'd to 0.** Some
  clients ship a fullscreen banner texture there; nuking it ensures
  ours shows through. The login form lives on `AccountLoginUI`, a
  child frame, so it is not affected.
* **Tested at 1920x1080 windowed and 2560x1440 fullscreen.** Particle
  positions are computed in screen space relative to `CENTER`, so they
  scale to any aspect ratio.
* **If the login screen doesn't change after packing**, your
  `patch-Z.MPQ` was either (a) packed at format v2/v3/v4 instead of
  v1, (b) not in `WoW/Data/`, or (c) you forgot to wipe `WoW/Cache/`.

## Notes and gotchas

* **MPQ format must be v1** for 3.3.5a. Format v2/v3/v4 will not load.
* **Field ordering** in our schemas matches AzerothCore's `*_dbc` SQL
  tables exactly, which the AC core asserts equals the binary file layout
  (see `src/server/shared/DataStores/DBCDatabaseLoader.cpp:118`). The same
  alignment is used by the binary writer here.
* **Locale strings** for descriptions use the enUS slot only; other locale
  slots remain empty. `Name_Lang_Mask` and `Description_Lang_Mask` are set to
  `1` to mark the enUS slot as populated, matching the SQL.
* **Server SQL must already be applied.** The client patch only adds
  tooltip data and item type metadata; gameplay still goes through the
  server. Apply the module's SQL (`2026_05_22_00_blackrose_data.sql` and
  `2026_05_22_01_blackrose_dbc.sql`) and restart the worldserver before
  testing.
* **Cache must be cleared.** Custom item/spell IDs that the client has
  already cached as `Unknown` will stay broken until `WoW/Cache/` is wiped.
* **`Item.dbc` matters for both icons and right-click.** Without the custom
  item rows, the client can keep using stale stock display IDs and cannot
  classify custom equippables locally. That can render question-mark icons
  even when the BLP files are present, and can make trinkets send
  `CMSG_USE_ITEM` instead of `CMSG_AUTOEQUIP_ITEM`. Re-run `dump_items.py`,
  `build_patch.py merge`, and repack the MPQ any time you add/edit items in
  the SQL migration.
* **`ItemDisplayInfo.dbc` matters for icon basenames.** This DBC maps the
  `DisplayInfoID` from `Item.dbc` / `item_template.displayid` to
  `InventoryIcon_1`. The value must be a basename like
  `INV_BR_Misc_BlackMiasma`, not a path and not a `.blp` filename.
