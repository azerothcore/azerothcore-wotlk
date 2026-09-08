# Real-client automation: how the working design works

Reference for `run --auto-login` in `apps/cata/run_real_client_authentication.py`. This
describes the design that is currently working reliably — window focus is acquired once and
held, credentials land in the right fields, and the client is driven to world entry without
manual intervention. Several of these choices look arbitrary but are the result of specific
observed failures; changing them casually will reintroduce those failures.

## Window discovery

`owned_wow_window()` scans `wmctrl -lpGx` for a window whose PID is in the generation's own
tracked wine PIDs **and** whose title is exactly `World of Warcraft`. Both halves matter:

- Matching on PID keeps the automation from ever driving a window this run does not own —
  including the user's own applications on the same display.
- The client is launched via a launcher process and re-execs, so the PID set is refreshed on
  every poll (`add_processes(... find_wine_processes(...))`) rather than captured once. A
  window that appears late, under a PID that did not exist at launch, is still recognised.

Polled every 0.5s for up to 90s, because MPQ loading on a cold prefix is slow.

## Focus acquisition — the important part

**Do not use `XSetInputFocus`.** Measured live: an explicit `XSetInputFocus` that bypasses
the window manager's activation protocol — especially when repeated once per field click —
makes the client tear down its window and never recreate it. The most likely cause is DXVK
treating that as an unexpected focus-loss/gain pattern and resetting the device. This
manifested as the window simply vanishing mid-login, and it cost a lot of time to diagnose.

The working combination is:

1. `wmctrl -i -a <window_id>` — an EWMH `_NET_ACTIVE_WINDOW` request that the window manager
   handles itself, rather than a client bypassing it.
2. Read the WM's own `_NET_ACTIVE_WINDOW` root property back via `xprop` and compare it to
   the target window id.
3. Retry that pair for up to 5s.

Step 2 is not optional. `wmctrl -a` is asynchronous and returns before the WM has actually
activated the window; without reading the property back, the automation races ahead and types
into whatever currently holds focus. Verifying through the WM's own bookkeeping is what makes
this deterministic.

## Driving the login — keyboard, not clicks

Once focus is verified, the login is driven **by keyboard** (`Tab`/`Return`) rather than by
clicking each field. Every click is a potential re-activation, and re-activating per field is
exactly the pattern that triggered the window teardown above. `client_login_points()` still
derives field coordinates as fractions of live window geometry (0.506 across; 0.536 / 0.623 /
0.752 down) so they survive a resized or repositioned window, but clicking is kept to the
minimum needed.

Keys are synthesised with `XTest` (`xtest.fake_input`), with `Shift_L` held for alphabetic
characters so the canonical uppercase synthetic credentials are entered correctly, and a 50ms
gap between characters. Coordinates are always computed from the window's *current* geometry
immediately before use, never cached from discovery time.

## Intro movie handling

A fresh Wine prefix boots into the 4.3.4 intro cinematic, which swallows input. The isolated
config sets both `movie` and `playIntroMovie` to `0`, but the automation still defends against
it: it tracks the owned `MovieProxy.exe` process and repeatedly sends `Escape` while that
process exists, with a 30s no-movie deadline and a 240s overall deadline. Credentials are only
entered once the movie is gone. Typing into the login UI while the cinematic is still active
was a real observed failure.

## Safety properties worth preserving

- **Never type without verified focus.** The focus check is a precondition, not a formality.
  An earlier ad-hoc harness typed blind and sent live credentials into an unrelated window on
  the same display. Anything driving real input must verify ownership immediately before each
  input burst, and abort rather than guess.
- **Only ever drive run-owned windows.** The PID-set check is the guard for this.
- **Prefer the WM's protocol over direct X calls.** See focus acquisition above.

## Evidence capture

Each run captures `window.xwd` (a raw X window dump) plus `window.xprop` into
`evidence/raw/`. The `.xwd` can be decoded without any external tool — parse the big-endian
header for width/height/`bytes_per_line`/`ncolors`, skip `header_size + ncolors * 12`, then
reorder BGRX to RGB. This is how loading-screen progress has been measured objectively
(comparing progress-bar fill against its track) instead of relying on someone watching the
screen.

## The exact harness invocation

Recovering these arguments from scratch is slow and they are not stored anywhere the
`reset` command preserves (`generation.json` is removed by `reset`). Recorded here so a
future run does not have to reconstruct them:

```bash
cd /mnt/e1384d9e-bede-40dd-8b1c-be0beb488490/Fun/azerothcore-cata
M="/mnt/e1384d9e-bede-40dd-8b1c-be0beb488490/Fun/.plan11-runs/auth-15595/manifest.json"

# The binaries must report the current HEAD, so rebuild before every prepare.
cmake --build var/build-plan7 --target revision.h worldserver authserver -j "$(nproc)"

python3 apps/cata/run_real_client_authentication.py reset --manifest "$M"
python3 apps/cata/run_real_client_authentication.py prepare --manifest "$M" \
  --authserver  "$PWD/var/build-plan7/src/server/apps/authserver" \
  --worldserver "$PWD/var/build-plan7/src/server/apps/worldserver" \
  --unit-tests  "$PWD/var/build-plan7/src/test/unit_tests" \
  --client-root "/mnt/f79365ff-6a68-45da-925e-b9ddc6d5da6c/Blizzard Games/Battle.NET/drive_c/Games/Cataclysm-4.3.4.15595-enUS-x64" \
  --data-root   "/mnt/f79365ff-6a68-45da-925e-b9ddc6d5da6c/Fun/TrinityCore/TrinityCore/data" \
  --server-dbc-root "/mnt/f79365ff-6a68-45da-925e-b9ddc6d5da6c/Fun/node-dbc-reader/data/dbc" \
  --wine-runner "/home/trolloks/.var/app/com.usebottles.bottles/data/bottles/runners/ge-proton11-1/files" \
  --personal-bottle "/mnt/f79365ff-6a68-45da-925e-b9ddc6d5da6c/Blizzard Games/Battle.NET" \
  --migration "$PWD/data/sql/updates/pending_db_auth/rev_1786964293354831242.sql" \
  --display ":0" --xauthority "/home/trolloks/.Xauthority" \
  --mode in-world-control-bootstrap
python3 apps/cata/run_real_client_authentication.py run --manifest "$M" \
  --auto-login --stability-seconds 8 --timeout 110
```

`var/build-plan7` is the build tree the harness uses — not `var/build`, which is not
configured, nor `var/build-mysql-isolated`, which has no CMake cache.

## Retrying a failed run — do not reset and re-prepare

`run` accepts a generation already in `failed`/`inconclusive` state: it clears the raw
evidence and client `Logs`, flips the state back to `prepared`, and proceeds. So a run that
died on a transient environmental failure is retried by re-issuing the *same* `run` command
and nothing else.

`prepare` takes several minutes even with the database cache restored. Resetting and
re-preparing after a transient run failure throws that time away for no benefit.

### `owned WoW window did not receive focus` is transient — just re-run

Measured with an Xlib probe (`get_input_focus()` plus `_NET_ACTIVE_WINDOW`) sampled once a
second across several runs: for roughly the first **two seconds** after the WoW window is
mapped, the window manager reports `_NET_ACTIVE_WINDOW = 0x0` *and* X reports an input focus
of `0` — no window is focused at all. Activation requests issued inside that gap are simply
dropped, and the 5s deadline in `run_auto_login()` can expire against it. Once the gap
closes, focus lands on the WoW window and stays there for the rest of the run:

```
58:35 NET_ACTIVE=0x0       FOCUS=int:0                          WOW=0x08600003
58:36 NET_ACTIVE=0x8600003 FOCUS=0x8600003(World of Warcraft)   WOW=0x08600003
```

Consequences worth remembering:

- This is **not** caused by the user touching the desktop, and not by the screensaver — it
  reproduced with the machine untouched, the monitor on, and
  `org.cinnamon.ScreenSaver.GetActive` returning `false`. Do not go hunting for a lock screen.
- Three consecutive focus failures followed by a clean `observed` run, with no code or
  environment change in between, is the normal shape of this. Re-run rather than diagnose.
- Do **not** "fix" it by typing without verified focus. The verification is the safety
  property that stops synthetic credentials from being typed into an unrelated window; the
  correct remedy for the race is a retry, not a weaker check.

## Building before a run

`prepare` refuses binaries whose `--version` does not report the current HEAD, so a build is
required first. Two things about `var/build-plan7` that will otherwise cost time:

- Its CMake cache points `MYSQL_INCLUDE_DIR`/`MYSQL_LIBRARY` at `/tmp/mysql-dev`, a staging
  tree that does not survive a reboot. Repopulate it without root via
  `apt-get download libmysqlclient-dev libmysqlclient21` and `dpkg-deb -x` into
  `/tmp/mysql-dev`. MariaDB's headers (`/usr/include/mariadb`) are *not* a substitute — they
  lack `mysql_ssl_mode` and `mysql_stmt_bind_named_param`, and linking against them trips the
  `ACE00046` client/compile version assertion at startup.
- `mysql_com.h` includes `"mysql/udf_registration_types.h"`, so the include root needs a
  self-referential `mysql -> .` symlink inside it.

## Reading opcodes back out of a run

`GetOpcodeNameForLogging` emits a bracketed form, so grep for the bracket or you will get
no matches and wrongly conclude nothing was logged:

```bash
G=$(ls -d /mnt/e1384d9e-bede-40dd-8b1c-be0beb488490/Fun/.plan11-runs/auth-15595/generation-* | sort -V | tail -1)
grep -oE "\[(CMSG|MSG)_[A-Z_0-9]+" "$G/logs/WorldServer.log" | sort | uniq -c | sort -rn
```
