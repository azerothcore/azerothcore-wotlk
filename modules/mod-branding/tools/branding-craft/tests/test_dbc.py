import struct

import pytest

from branding_craft.catalog import CATALOG
from branding_craft.dbc import (
    merge_rows,
    new_empty_dbc,
    patch_skill_line_ability_dbc,
    patch_spell_dbc,
)
from branding_craft.dbc_layout import SKILL_LINE_ABILITY_COLUMNS, SPELL_DBC_COLUMNS


def _parse(data, columns):
    magic, rc, fc, rs, sbs = struct.unpack_from("<4siiii", data, 0)
    assert magic == b"WDBC"
    assert fc == len(columns) and rs == len(columns) * 4
    rec_start = 20
    str_start = rec_start + rc * rs
    strings = data[str_start:str_start + sbs]
    rows = []
    idx = {n: i for i, n in enumerate(columns)}
    for r in range(rc):
        base = rec_start + r * rs
        rows.append((base, idx))
    return rc, strings, rows, idx, data


def _int(data, base, idx, col):
    return struct.unpack_from("<i", data, base + idx[col] * 4)[0]


def _str(data, strings, base, idx, col):
    off = struct.unpack_from("<i", data, base + idx[col] * 4)[0]
    end = strings.index(b"\x00", off)
    return strings[off:end].decode("utf-8")


def test_layout_constants_match_stock_record_sizes():
    assert len(SPELL_DBC_COLUMNS) == 234       # stock 3.3.5a Spell.dbc (936-byte records)
    assert len(SKILL_LINE_ABILITY_COLUMNS) == 14


def test_patch_spell_dbc_appends_one_record_per_recipe():
    out = patch_spell_dbc(new_empty_dbc(SPELL_DBC_COLUMNS))
    rc, strings, rows, idx, data = _parse(out, SPELL_DBC_COLUMNS)
    assert rc == len(CATALOG.recipes)
    for (base, _), r in zip(rows, CATALOG.recipes, strict=True):
        assert _int(data, base, idx, "ID") == r.spell_id
        assert _int(data, base, idx, "Effect_1") == 24             # CREATE_ITEM
        assert _int(data, base, idx, "EffectItemType_1") == r.output.entry
        assert _int(data, base, idx, "ReagentCount_1") == r.material_count
        assert _str(data, strings, base, idx, "Name_Lang_enUS") == r.name


def test_patch_skill_line_ability_maps_spell_to_profession():
    out = patch_skill_line_ability_dbc(new_empty_dbc(SKILL_LINE_ABILITY_COLUMNS))
    rc, strings, rows, idx, data = _parse(out, SKILL_LINE_ABILITY_COLUMNS)
    assert rc == len(CATALOG.recipes)
    for (base, _), r in zip(rows, CATALOG.recipes, strict=True):
        assert _int(data, base, idx, "Spell") == r.spell_id
        assert _int(data, base, idx, "SkillLine") == r.skill_line


def test_merge_preserves_existing_records():
    base = patch_spell_dbc(new_empty_dbc(SPELL_DBC_COLUMNS))  # already has the craft rows
    again = merge_rows(base, SPELL_DBC_COLUMNS, [{"ID": 1900099, "Name_Lang_enUS": "X"}])
    rc, *_ = struct.unpack_from("<4siiii", again, 0)[1:]
    assert rc == len(CATALOG.recipes) + 1


def test_layout_mismatch_is_rejected():
    # an empty DBC declared with the wrong field count must not be silently corrupted
    bad = new_empty_dbc(["ID", "Other"])
    with pytest.raises(ValueError, match="layout mismatch"):
        patch_spell_dbc(bad)
