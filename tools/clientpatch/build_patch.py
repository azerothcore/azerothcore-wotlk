#!/usr/bin/env python3
"""Build the Black Rose client DBC patch.

Two modes:

  customonly   Build DBC files containing ONLY the custom Black Rose rows.
               Useful for validating the binary writer; NOT a drop-in client
               patch on its own (it would replace the client's full Spell.dbc
               with three rows and break every other spell). Output goes to
               staging/DBFilesClient/.

  merge        Read base DBC files from input/DBFilesClient/, upsert the
               Black Rose custom rows by ID, and write merged DBC files to
               staging/DBFilesClient/. This is the real distributable.
               Use this once you have extracted base DBCs from the client.

Usage:
  python3 build_patch.py customonly
  python3 build_patch.py merge

The merged staging tree is what you pack into patch-Z.MPQ.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
from pathlib import Path

import dbc


HERE = Path(__file__).parent
ROOT = HERE.parent.parent
DEF_DIR = HERE / "definitions"
INPUT_DBC_DIR = HERE / "input" / "DBFilesClient"
EXTRAS_DIR = HERE / "extras"
EXTRAS_SRC_DIR = HERE / "extras_src"
STAGING_ROOT = HERE / "staging"
STAGING_DBC_DIR = STAGING_ROOT / "DBFilesClient"

GLUEPARENT_LUA_REL = Path("Interface") / "GlueXML" / "GlueParent.lua"
OVERLAY_LUA = HERE / "extras" / "Interface" / "GlueXML" / "BlackRoseLogin.lua"
APPEND_BEGIN = "-- BEGIN BlackRoseLogin overlay (auto-appended) --"
APPEND_END = "-- END BlackRoseLogin overlay --"


DEFINITION_TO_SCHEMA = {
    "spell": "spell",
    "spellduration": "spellduration",
    "spellitemenchantment": "spellitemenchantment",
    "gemproperties": "gemproperties",
    "itemextendedcost": "itemextendedcost",
    "skilllineability": "skilllineability",
    "questsort": "questsort",
    "item": "item",
}


def load_definition(name: str) -> list[dict]:
    path = DEF_DIR / f"{name}.json"
    if not path.exists():
        raise FileNotFoundError(f"Missing definition: {path}")
    return json.loads(path.read_text())


def copy_extras() -> int:
    """Mirror extras/ (BLP, MP3) into staging/.

    Anything under extras/Interface/GlueXML/ is intentionally NOT copied
    standalone - the BlackRoseLogin.lua source there is appended onto
    the user's stock GlueParent.lua by append_to_glueparent_lua().
    Shipping it as its own file alongside GlueParent.lua is what tripped
    "Your login interface files are corrupt" in earlier attempts.

    With --no-glue, even more is skipped (no GlueXML staging at all).
    """
    if not EXTRAS_DIR.is_dir():
        return 0
    copied = 0
    for src in EXTRAS_DIR.rglob("*"):
        if not src.is_file():
            continue
        rel = src.relative_to(EXTRAS_DIR)
        # Always skip the GlueXML source files - they're append fodder,
        # not standalone shippables.
        if rel.parts[:2] == ("Interface", "GlueXML"):
            continue
        if _SKIP_GLUE and rel.parts[:1] == ("Interface",):
            # tighter skip with --no-glue to keep the test minimal
            pass  # still ship Interface/Glues/* (BLP) - we want it for tests
        dst = STAGING_ROOT / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        copied += 1
        print(f"  extras  {rel}")
    return copied


def append_to_glueparent_lua() -> bool:
    """Append the BlackRoseLogin overlay onto the user's stock GlueParent.lua.

    Reads extras_src/Interface/GlueXML/GlueParent.lua (the user's copy
    from interface.MPQ), appends the contents of our overlay source
    (extras/Interface/GlueXML/BlackRoseLogin.lua) wrapped in marker
    comments, and writes the merged Lua to
    staging/Interface/GlueXML/GlueParent.lua.

    Why this and not <Script>-injection in GlueParent.xml:
        Earlier attempts patched GlueParent.xml to add a second
        <Script> directive that pointed at a brand-new
        BlackRoseLogin.lua we shipped alongside it. That tripped
        "Your login interface files are corrupt please reinstall
        the game" - either the glue XML parser only accepts one
        <Script> per <Ui>, or new Lua files at non-stock glue paths
        are rejected. Either way, the safest move is to NOT modify
        any XML and to NOT introduce any new file at a glue path:
        we ship a single file (modified GlueParent.lua) that the
        unmodified GlueParent.xml already <Script>-loads.

    Idempotent: re-running scrubs any prior appended block (delimited
    by APPEND_BEGIN / APPEND_END markers) before re-appending the
    current overlay source.

    Returns True when a merged file was written, False when there is
    no stock source to patch.
    """
    src = EXTRAS_SRC_DIR / GLUEPARENT_LUA_REL
    if not src.exists():
        return False
    if not OVERLAY_LUA.exists():
        sys.exit(
            f"ERROR: overlay source {OVERLAY_LUA.relative_to(HERE)} "
            "is missing. Re-pull the repo."
        )

    stock = src.read_text(encoding="utf-8")
    overlay = OVERLAY_LUA.read_text(encoding="utf-8")

    # Remove any previously-appended block so re-runs are idempotent.
    pattern = re.compile(
        re.escape(APPEND_BEGIN) + r".*?" + re.escape(APPEND_END) + r"\s*",
        flags=re.DOTALL,
    )
    cleaned = pattern.sub("", stock).rstrip() + "\n"

    merged = (
        cleaned
        + "\n"
        + APPEND_BEGIN
        + "\n"
        + overlay.rstrip()
        + "\n"
        + APPEND_END
        + "\n"
    )
    dst = STAGING_ROOT / GLUEPARENT_LUA_REL
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(merged, encoding="utf-8")
    extra_lines = merged.count("\n") - cleaned.count("\n")
    print(
        f"  appended {GLUEPARENT_LUA_REL}  (+{extra_lines} lines of overlay)"
    )
    return True


def build_customonly() -> None:
    STAGING_DBC_DIR.mkdir(parents=True, exist_ok=True)
    for def_name, schema_name in DEFINITION_TO_SCHEMA.items():
        schema = dbc.SCHEMAS[schema_name]
        rows = load_definition(def_name)
        out = dbc.DbcFile(schema=schema, rows=rows)
        out.sort_by_id()
        target = STAGING_DBC_DIR / schema.filename
        dbc.write_dbc(out, target)
        print(f"  wrote {target.relative_to(HERE)}  rows={len(rows)}")
    print("\nDONE. staging/DBFilesClient/ contains the custom-only DBCs.")
    print("These are NOT a usable client patch on their own - they would")
    print("replace the full client DBCs with only Black Rose rows. Use the")
    print("'merge' mode for distribution.")


def build_merge() -> None:
    if not INPUT_DBC_DIR.exists():
        sys.exit(
            f"ERROR: {INPUT_DBC_DIR.relative_to(HERE)} does not exist.\n"
            "Extract the client base DBCs into that folder first.\n"
            "See README.md > Extracting base DBCs."
        )
    STAGING_DBC_DIR.mkdir(parents=True, exist_ok=True)
    for def_name, schema_name in DEFINITION_TO_SCHEMA.items():
        schema = dbc.SCHEMAS[schema_name]
        custom_rows = load_definition(def_name)
        base_path = INPUT_DBC_DIR / schema.filename
        if not base_path.exists():
            sys.exit(
                f"ERROR: missing base file {base_path.relative_to(HERE)}.\n"
                "Extract it from the client (see README.md)."
            )
        merged = dbc.read_dbc(base_path, schema)
        before = len(merged.rows)
        merge_count = 0
        for row in custom_rows:
            # _merge=true means "override only the keys in this entry on
            # top of the existing stock row" - used to retune a couple
            # of fields (e.g. EffectBasePoints) on a stock spell without
            # dropping its visual/school/target geometry to zero, which
            # is what a full upsert would do.
            if row.pop("_merge", False):
                merged.merge_row(row)
                merge_count += 1
            else:
                merged.upsert(row)
        merged.sort_by_id()
        target = STAGING_DBC_DIR / schema.filename
        dbc.write_dbc(merged, target)
        added = len(merged.rows) - before
        print(
            f"  {schema.filename:30}"
            f" base={before:6d}"
            f" custom={len(custom_rows):4d}"
            f" added={added:4d}"
            f" merged={merge_count:3d}"
            f" total={len(merged.rows):6d}"
        )

    extras_count = copy_extras()
    if extras_count:
        print(f"\n  copied {extras_count} extras file(s) into staging/")
    if _SKIP_GLUE:
        print("\n  --no-glue: skipping GlueParent.lua append.")
    elif not append_to_glueparent_lua():
        print(
            "\nNOTE: extras_src/Interface/GlueXML/GlueParent.lua is missing.\n"
            "  Without it the custom login screen will NOT activate; the\n"
            "  patched MPQ will still ship the BLP and MP3, but nothing\n"
            "  will paint them onto the login screen. Extract your stock\n"
            "  GlueParent.lua from interface.MPQ into\n"
            f"  {EXTRAS_SRC_DIR.relative_to(HERE)}/{GLUEPARENT_LUA_REL} and rerun."
        )
    print("\nDONE. staging/ is ready to pack into patch-Z.MPQ.")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "mode",
        choices=["customonly", "merge"],
        help="customonly: write only Black Rose rows; "
        "merge: append/replace into base DBCs from input/",
    )
    parser.add_argument(
        "--no-glue",
        action="store_true",
        help="Skip the glue XML / Lua overlay - omit BlackRoseLogin.lua "
        "and the patched GlueParent.xml from staging. Useful for isolating "
        "whether the glue overlay is what's triggering 'Your login interface "
        "files are corrupt'. The DBCs, BLP, and MP3 still ship.",
    )
    args = parser.parse_args()
    global _SKIP_GLUE
    _SKIP_GLUE = bool(args.no_glue)
    if args.mode == "customonly":
        build_customonly()
    else:
        build_merge()
    return 0


_SKIP_GLUE = False


if __name__ == "__main__":
    raise SystemExit(main())
