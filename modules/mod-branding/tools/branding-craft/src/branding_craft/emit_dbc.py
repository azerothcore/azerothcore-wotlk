"""Client-side DBC rows for the craft catalog (#29 client deliverable).

The client needs the *same* craft spells in its ``Spell.dbc`` / ``SkillLineAbility.dbc`` or the recipe
is uncastable. :func:`spell_field_rows` / :func:`skill_field_rows` are the canonical field->value rows
generated from the catalog; both the CSV export here and the binary patcher (:mod:`branding_craft.dbc`)
consume them, so the reagent definitions match the server ``spell_dbc`` field-for-field -- the lockstep
the issue requires.
"""

from __future__ import annotations

import csv
import io

from . import constants as C
from .catalog import CATALOG, Catalog

# Field order for the CSV export (a readable subset; the binary patcher uses the full DBC layout).
SPELL_DBC_FIELDS = [
    "ID", "Attributes", "CastingTimeIndex", "RangeIndex", "EquippedItemClass",
    "Reagent_1", "Reagent_2", "ReagentCount_1", "ReagentCount_2",
    "Effect_1", "EffectDieSides_1", "EffectBasePoints_1", "ImplicitTargetA_1", "EffectItemType_1",
    "Name_Lang_enUS",
]

SKILL_LINE_ABILITY_FIELDS = [
    "ID", "SkillLine", "Spell", "MinSkillLineRank",
    "TrivialSkillLineRankHigh", "TrivialSkillLineRankLow",
]


def spell_field_rows(cat: Catalog = CATALOG) -> list[dict]:
    """Canonical Spell.dbc field->value rows for the craft spells (server + client share these)."""

    rows: list[dict] = []
    for r in cat.recipes:
        reagents = cat.reagents(r)
        items = [0, 0]
        counts = [0, 0]
        for i, (item, count) in enumerate(reagents):
            items[i] = item
            counts[i] = count
        rows.append({
            "ID": r.spell_id,
            "Attributes": C.SPELL_ATTR0_IS_TRADESPELL,
            "CastingTimeIndex": C.CAST_TIME_INDEX_INSTANT,
            "RangeIndex": C.RANGE_INDEX_SELF,
            "EquippedItemClass": C.EQUIPPED_ITEM_CLASS_NONE,
            "Reagent_1": items[0], "Reagent_2": items[1],
            "ReagentCount_1": counts[0], "ReagentCount_2": counts[1],
            "Effect_1": C.SPELL_EFFECT_CREATE_ITEM,
            "EffectDieSides_1": 1, "EffectBasePoints_1": 0,
            "ImplicitTargetA_1": C.TARGET_UNIT_CASTER,
            "EffectItemType_1": r.output.entry,
            "Name_Lang_enUS": r.name,
        })
    return rows


def skill_field_rows(cat: Catalog = CATALOG) -> list[dict]:
    """Canonical SkillLineAbility.dbc field->value rows mapping each spell into its profession."""

    return [
        {
            "ID": r.skill_line_ability_id,
            "SkillLine": r.skill_line,
            "Spell": r.spell_id,
            "MinSkillLineRank": r.req_skill_value,
            "TrivialSkillLineRankHigh": r.trivial_high,
            "TrivialSkillLineRankLow": r.req_skill_value,
        }
        for r in cat.recipes
    ]


def _to_csv(fields: list[str], rows: list[dict]) -> str:
    buf = io.StringIO()
    writer = csv.DictWriter(buf, fieldnames=fields, lineterminator="\n")
    writer.writeheader()
    writer.writerows(rows)
    return buf.getvalue()


def emit_spell_dbc_csv(cat: Catalog = CATALOG) -> str:
    return _to_csv(SPELL_DBC_FIELDS, spell_field_rows(cat))


def emit_skill_line_ability_csv(cat: Catalog = CATALOG) -> str:
    return _to_csv(SKILL_LINE_ABILITY_FIELDS, skill_field_rows(cat))
