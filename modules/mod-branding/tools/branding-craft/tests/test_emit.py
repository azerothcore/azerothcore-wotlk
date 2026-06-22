import csv
import io
import re

from branding_craft.catalog import CATALOG
from branding_craft.emit_dbc import emit_skill_line_ability_csv, emit_spell_dbc_csv
from branding_craft.emit_sql import emit_branding_recipe_sql, emit_world_sql


def test_world_sql_obeys_codestyle_basics():
    sql = emit_world_sql()
    assert sql.endswith("\n") and not sql.endswith("\n\n")  # single trailing newline
    assert "\t" not in sql                                  # no tabs
    assert ";;" not in sql                                  # no double semicolons
    assert "\n\n\n" not in sql                              # no multiple blank lines
    # Indented value rows use 4 spaces, never 2/3.
    for line in sql.splitlines():
        if line.startswith(" ") and line.lstrip().startswith("("):
            assert line.startswith("    (")


def test_every_insert_has_delete_on_the_immediately_preceding_line():
    # codestyle-sql.py requires DELETE on the line directly above INSERT (no blank line between).
    lines = emit_world_sql().splitlines()
    for i, line in enumerate(lines):
        if line.startswith("INSERT INTO `"):
            assert i > 0 and lines[i - 1].startswith("DELETE FROM `"), line


def _values_block(sql: str, table: str) -> str:
    # the value rows live after the VALUES keyword, skipping the column-list parens
    return sql.split(f"INSERT INTO `{table}`")[1].split(" VALUES")[1].split(";")[0]


def _branding_recipe_rows(sql: str) -> dict[int, tuple[int, int]]:
    block = _values_block(sql, "branding_recipe")
    rows = re.findall(r"\((\d+), (\d+), (\d+), (\d+), (\d+)\)", block)
    return {int(r[0]): (int(r[1]), int(r[2])) for r in rows}


def _spell_reagent_counts(sql: str) -> dict[int, tuple[int, int]]:
    block = _values_block(sql, "spell_dbc")
    # ID is the first cell; ReagentCount_1/_2 are cells 8 and 9 (0-indexed) per the column list.
    out: dict[int, tuple[int, int]] = {}
    for row in re.findall(r"\(([^)]*)\)", block):
        cells = [c.strip() for c in row.split(",")]
        out[int(cells[0])] = (int(cells[7]), int(cells[8]))
    return out


def test_spell_reagents_and_branding_recipe_are_in_lockstep():
    # The whole point of #29: server mirror counts == craft-spell reagent counts.
    recipe_rows = _branding_recipe_rows(emit_branding_recipe_sql())
    spell_counts = _spell_reagent_counts(emit_world_sql())
    for r in CATALOG.recipes:
        assert recipe_rows[r.id] == (r.material_count, r.fragment_count)
        assert spell_counts[r.spell_id] == (r.material_count, r.fragment_count)


def test_recipe_sql_is_codestyle_clean():
    sql = emit_branding_recipe_sql()
    assert "\t" not in sql and ";;" not in sql and "\n\n\n" not in sql
    assert sql.endswith("\n") and not sql.endswith("\n\n")
    lines = sql.splitlines()
    ins = next(i for i, ln in enumerate(lines) if ln.startswith("INSERT INTO `branding_recipe`"))
    assert lines[ins - 1].startswith("DELETE FROM `branding_recipe`")


def test_recipe_patterns_are_bop_and_teach_the_spell():
    sql = emit_world_sql()
    block = sql.split("INSERT INTO `item_template`")[1].split(";")[0]
    for r in CATALOG.recipes:
        # the pattern row must contain its craft spell id with the LEARN trigger (6) and bonding 1.
        assert re.search(rf"\b{r.pattern_entry}\b.*\b{r.spell_id}, 6, 1,", block), r.pattern_entry


def test_spell_csv_matches_spell_dbc_reagents():
    sql = emit_world_sql()
    spell_counts = _spell_reagent_counts(sql)
    reader = csv.DictReader(io.StringIO(emit_spell_dbc_csv()))
    for row in reader:
        sid = int(row["ID"])
        assert spell_counts[sid] == (int(row["ReagentCount_1"]), int(row["ReagentCount_2"]))


def test_skill_csv_maps_each_spell_to_its_profession():
    reader = {int(r["Spell"]): int(r["SkillLine"]) for r in csv.DictReader(io.StringIO(emit_skill_line_ability_csv()))}
    for r in CATALOG.recipes:
        assert reader[r.spell_id] == r.skill_line
