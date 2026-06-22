"""Command-line entry point: regenerate the server SQL / client DBC rows from the catalog.

    branding-craft validate        # internal consistency + branding_recipe lockstep (exit 1 on drift)
    branding-craft world-sql       # emit the pending_db_world rev SQL
    branding-craft spell-csv       # emit the client Spell.dbc patch rows (CSV)
    branding-craft skill-csv       # emit the client SkillLineAbility.dbc patch rows (CSV)

Each emit command writes to stdout unless ``--out FILE`` is given.
"""

from __future__ import annotations

import argparse
import os
import sys

from .dbc import patch_skill_line_ability_dbc, patch_spell_dbc
from .emit_dbc import emit_skill_line_ability_csv, emit_spell_dbc_csv
from .emit_sql import emit_branding_recipe_sql, emit_world_sql
from .validate import recipe_mirror_rows, validate


def _write(text: str, out: str | None) -> None:
    if out:
        with open(out, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(text)
    else:
        sys.stdout.write(text)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="branding-craft", description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    sub.add_parser("validate", help="check the catalog is internally consistent")

    for name in ("world-sql", "recipe-sql", "spell-csv", "skill-csv"):
        p = sub.add_parser(name)
        p.add_argument("--out", help="write to FILE instead of stdout")

    bd = sub.add_parser("build-dbc", help="merge craft rows into extracted base DBCs (binary)")
    bd.add_argument("--spell-in", required=True, help="extracted base Spell.dbc")
    bd.add_argument("--skill-in", required=True, help="extracted base SkillLineAbility.dbc")
    bd.add_argument("--out-dir", required=True, help="directory to write patched DBCs into")

    args = parser.parse_args(argv)

    if args.cmd == "validate":
        problems = validate()
        if problems:
            for p in problems:
                print(f"DRIFT: {p}", file=sys.stderr)
            return 1
        rows = recipe_mirror_rows()
        print(f"OK: {len(rows)} recipes, catalog internally consistent")
        return 0

    if args.cmd == "world-sql":
        _write(emit_world_sql(), args.out)
    elif args.cmd == "recipe-sql":
        _write(emit_branding_recipe_sql(), args.out)
    elif args.cmd == "spell-csv":
        _write(emit_spell_dbc_csv(), args.out)
    elif args.cmd == "skill-csv":
        _write(emit_skill_line_ability_csv(), args.out)
    elif args.cmd == "build-dbc":
        os.makedirs(args.out_dir, exist_ok=True)
        with open(args.spell_in, "rb") as fh:
            spell = patch_spell_dbc(fh.read())
        with open(args.skill_in, "rb") as fh:
            skill = patch_skill_line_ability_dbc(fh.read())
        spath = os.path.join(args.out_dir, "Spell.dbc")
        kpath = os.path.join(args.out_dir, "SkillLineAbility.dbc")
        with open(spath, "wb") as fh:
            fh.write(spell)
        with open(kpath, "wb") as fh:
            fh.write(skill)
        print(f"wrote {spath} ({len(spell)} bytes), {kpath} ({len(skill)} bytes)")
        print("pack these into a patch MPQ under DBFilesClient\\ (see README)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
