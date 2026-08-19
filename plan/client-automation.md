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
