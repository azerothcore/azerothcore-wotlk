"""Regenerates the JSON row definitions for the Black Rose client patch
from the same compact tables the module SQL uses. Mirrors:

    modules/mod-blackrose/data/sql/db-world/2026_05_22_00_blackrose.sql

so the client DBC rows match the server `*_dbc` rows row-for-row.

Run from this directory:

    python3 _generate.py

That will rewrite the sibling JSON files. Hand-edit the JSON if a row needs
to diverge from the SQL formula; this script will overwrite hand edits when
re-run.
"""

from __future__ import annotations

import json
from pathlib import Path


HERE = Path(__file__).parent

BLACK_MIASMA = 900200
BLACK_PETALS = 900201

BLACK_ROSE_AURA = 900900
BLACK_ROSE_UPGRADE_USE = 900901
BLACK_ROSE_BAG_UPGRADE_USE = 900902
RURIK_DEATH_MOBILE_SPELL = 900903

BLACK_ROSE_QUEST_SORT_ID = 9009
BLACK_ROSE_QUEST_SORT_NAME = "The Black Rose"

ATTRIBUTES = 384
# Stock 3.3.5a SpellDuration.dbc row 21 = -1 (permanent). The mount
# aura uses it; the Black Rose on-use aura uses its own custom 20s
# duration row.
DURATION_INDEX_PERMANENT = 21

MOUNT_NAME = "Rurik's Death Mobile"
MOUNT_SKILL_LINE_RIDING = 777
# The mount appearance is controlled by the SERVER's
# `spell_dbc.EffectMiscValue_1` for spell 900903 (set in
# `2026_05_22_01_blackrose_dbc.sql` to creature `29929`, the stock
# Mechano-hog). AC's `AuraEffect::HandleAuraMounted` reads that as a
# creature_template entry and resolves the display via
# `creature_template_model` at mount time. The client-side spell row's
# `EffectMiscValue_1` is metadata only and ignored at mount time, so we
# leave it 0.
MOUNT_MISC_VALUE_CLIENT = 0

RED_GEM_BASE = 900300
YELLOW_GEM_BASE = 900400
MIA_EXT_BASE = 900700
PETAL_EXT_BASE = 900710

ITEM_MOD_AGILITY = 3
ITEM_MOD_STRENGTH = 4
ITEM_MOD_INTELLECT = 5
ITEM_MOD_SPIRIT = 6
ITEM_MOD_STAMINA = 7
ITEM_MOD_SPELL_POWER = 45
ITEM_MOD_ATTACK_POWER = 38
ITEM_MOD_CRIT_RATING = 32
ITEM_MOD_HASTE_RATING = 36
ITEM_MOD_MANA_REGEN = 43

ITEM_ENCHANTMENT_TYPE_STAT = 5

GEM_TYPE_RED = 2
GEM_TYPE_YELLOW = 4

RED_FAMILIES = [
    (0, "strength", ITEM_MOD_STRENGTH, None, None),
    (1, "intellect", ITEM_MOD_INTELLECT, None, None),
    (2, "spirit", ITEM_MOD_SPIRIT, None, None),
    (3, "agility", ITEM_MOD_AGILITY, None, None),
    (4, "stamina", ITEM_MOD_STAMINA, None, None),
    (5, "strength", ITEM_MOD_STRENGTH, "stamina", ITEM_MOD_STAMINA),
    (6, "intellect", ITEM_MOD_INTELLECT, "spirit", ITEM_MOD_SPIRIT),
    (7, "strength", ITEM_MOD_STRENGTH, "agility", ITEM_MOD_AGILITY),
    (8, "intellect", ITEM_MOD_INTELLECT, "stamina", ITEM_MOD_STAMINA),
]

RED_RANK_SINGLE = [2, 22, 42, 62, 82, 102, 122]
RED_RANK_SPLIT = [1, 11, 21, 31, 41, 51, 61]

YELLOW_FAMILIES = [
    (0, "spell power", ITEM_MOD_SPELL_POWER, False),
    (1, "attack power", ITEM_MOD_ATTACK_POWER, False),
    (2, "crit rating", ITEM_MOD_CRIT_RATING, False),
    (3, "haste rating", ITEM_MOD_HASTE_RATING, False),
    (4, "mana per 5 seconds", ITEM_MOD_MANA_REGEN, True),
]

YELLOW_RANK_NORMAL = [6, 26, 86, 126, 166, 206, 246]
YELLOW_RANK_MP5 = [10, 25, 50, 75, 200, 325, 525]


def write(path: Path, payload) -> None:
    path.write_text(json.dumps(payload, indent=2) + "\n")


def gen_spell() -> list[dict]:
    common_text = {
        "Name_Lang_Mask": 1,
        "Description_Lang_Mask": 1,
        "AuraDescription_Lang_Mask": 0,
    }

    no_item_class_constraint = {
        "EquippedItemClass": -1,
        "EquippedItemSubclass": 0,
        "EquippedItemInvTypes": 0,
    }

    aura = {
        "ID": BLACK_ROSE_AURA,
        "Attributes": ATTRIBUTES,
        "CastingTimeIndex": 1,
        "DurationIndex": BLACK_ROSE_AURA,
        "RangeIndex": 1,
        "Effect_1": 6,
        "EffectDieSides_1": 1,
        "EffectBasePoints_1": 0,
        "ImplicitTargetA_1": 1,
        "EffectAura_1": 4,
        "EffectMiscValue_1": 0,
        "SpellIconID": 0,
        "ActiveIconID": 0,
        "Name_Lang_enUS": "Power of the Black Rose",
        "Name_Lang_Mask": 1,
        "Description_Lang_enUS":
            "Increases Black Rose socketed gem effectiveness by 250%.",
        "Description_Lang_Mask": 1,
        "AuraDescription_Lang_enUS":
            "Black Rose socketed gem effectiveness increased by 250%.",
        "AuraDescription_Lang_Mask": 1,
        "SchoolMask": 1,
        **no_item_class_constraint,
    }

    upgrade_gem = {
        "ID": BLACK_ROSE_UPGRADE_USE,
        "Attributes": ATTRIBUTES,
        "CastingTimeIndex": 1,
        "DurationIndex": 0,
        "RangeIndex": 1,
        "Effect_1": 3,
        "EffectDieSides_1": 1,
        "EffectBasePoints_1": 0,
        "ImplicitTargetA_1": 1,
        "EffectAura_1": 0,
        "EffectMiscValue_1": 0,
        "SpellIconID": 0,
        "ActiveIconID": 0,
        "Name_Lang_enUS": "Empower Black Rose Gem",
        "Name_Lang_Mask": 1,
        "Description_Lang_enUS": "Use to empower a socketed Black Rose gem.",
        "Description_Lang_Mask": 1,
        "AuraDescription_Lang_enUS": "",
        "AuraDescription_Lang_Mask": 0,
        "SchoolMask": 1,
        **no_item_class_constraint,
    }

    upgrade_bag = {
        "ID": BLACK_ROSE_BAG_UPGRADE_USE,
        "Attributes": ATTRIBUTES,
        "CastingTimeIndex": 1,
        "DurationIndex": 0,
        "RangeIndex": 1,
        "Effect_1": 3,
        "EffectDieSides_1": 1,
        "EffectBasePoints_1": 0,
        "ImplicitTargetA_1": 1,
        "EffectAura_1": 0,
        "EffectMiscValue_1": 0,
        "SpellIconID": 0,
        "ActiveIconID": 0,
        "Name_Lang_enUS": "Upgrade Black Rose Bag",
        "Name_Lang_Mask": 1,
        "Description_Lang_enUS":
            "Use to upgrade an empty Bag of the Black Rose.",
        "Description_Lang_Mask": 1,
        "AuraDescription_Lang_enUS": "",
        "AuraDescription_Lang_Mask": 0,
        "SchoolMask": 1,
        **no_item_class_constraint,
    }

    mount = {
        "ID": RURIK_DEATH_MOBILE_SPELL,
        "Attributes": 0,
        "CastingTimeIndex": 1,
        "DurationIndex": DURATION_INDEX_PERMANENT,
        "RangeIndex": 1,
        "Effect_1": 6,
        "EffectDieSides_1": 1,
        "EffectBasePoints_1": 59,
        "ImplicitTargetA_1": 1,
        "EffectAura_1": 78,
        "EffectMiscValue_1": MOUNT_MISC_VALUE_CLIENT,
        "SpellIconID": 0,
        "ActiveIconID": 0,
        "Name_Lang_enUS": MOUNT_NAME,
        "Name_Lang_Mask": 1,
        "Description_Lang_enUS":
            f"Summons and dismisses a rideable {MOUNT_NAME}.",
        "Description_Lang_Mask": 1,
        "AuraDescription_Lang_enUS": "Mounted.",
        "AuraDescription_Lang_Mask": 1,
        "SchoolMask": 1,
        **no_item_class_constraint,
    }

    return [aura, upgrade_gem, upgrade_bag, mount]


def gen_spell_duration() -> list[dict]:
    return [
        {
            "ID": BLACK_ROSE_AURA,
            "Duration": 20000,
            "DurationPerLevel": 0,
            "MaxDuration": 20000,
        }
    ]


def gen_spell_item_enchantment() -> list[dict]:
    rows: list[dict] = []

    for family_id, name1, stat1, name2, stat2 in RED_FAMILIES:
        for rank_index, (single, split) in enumerate(
            zip(RED_RANK_SINGLE, RED_RANK_SPLIT)
        ):
            row_id = RED_GEM_BASE + family_id * 10 + rank_index
            if name2 is None:
                value = single
                effect_2 = 0
                effect_pts_2 = 0
                effect_arg_2 = 0
                tooltip = f"+{value} {name1}"
            else:
                value = split
                effect_2 = ITEM_ENCHANTMENT_TYPE_STAT
                effect_pts_2 = split
                effect_arg_2 = stat2
                tooltip = f"+{split} {name1} and +{split} {name2}"
            rows.append({
                "ID": row_id,
                "Charges": 0,
                "Effect_1": ITEM_ENCHANTMENT_TYPE_STAT,
                "Effect_2": effect_2,
                "Effect_3": 0,
                "EffectPointsMin_1": value,
                "EffectPointsMin_2": effect_pts_2,
                "EffectPointsMin_3": 0,
                "EffectPointsMax_1": value,
                "EffectPointsMax_2": effect_pts_2,
                "EffectPointsMax_3": 0,
                "EffectArg_1": stat1,
                "EffectArg_2": effect_arg_2,
                "EffectArg_3": 0,
                "Name_Lang_enUS": tooltip,
                "Name_Lang_Mask": 1,
                "ItemVisual": 0,
                "Flags": 0,
                "Src_ItemID": row_id,
                "Condition_Id": 0,
                "RequiredSkillID": 0,
                "RequiredSkillRank": 0,
                "MinLevel": 0,
            })

    for family_id, stat_name, stat_id, is_mp5 in YELLOW_FAMILIES:
        rank_values = YELLOW_RANK_MP5 if is_mp5 else YELLOW_RANK_NORMAL
        for rank_index, value in enumerate(rank_values):
            row_id = YELLOW_GEM_BASE + family_id * 10 + rank_index
            rows.append({
                "ID": row_id,
                "Charges": 0,
                "Effect_1": ITEM_ENCHANTMENT_TYPE_STAT,
                "Effect_2": 0,
                "Effect_3": 0,
                "EffectPointsMin_1": value,
                "EffectPointsMin_2": 0,
                "EffectPointsMin_3": 0,
                "EffectPointsMax_1": value,
                "EffectPointsMax_2": 0,
                "EffectPointsMax_3": 0,
                "EffectArg_1": stat_id,
                "EffectArg_2": 0,
                "EffectArg_3": 0,
                "Name_Lang_enUS": f"+{value} {stat_name}",
                "Name_Lang_Mask": 1,
                "ItemVisual": 0,
                "Flags": 0,
                "Src_ItemID": row_id,
                "Condition_Id": 0,
                "RequiredSkillID": 0,
                "RequiredSkillRank": 0,
                "MinLevel": 0,
            })

    return rows


def gen_gem_properties() -> list[dict]:
    rows: list[dict] = []
    for family_id, *_ in RED_FAMILIES:
        for rank_index in range(7):
            row_id = RED_GEM_BASE + family_id * 10 + rank_index
            rows.append({
                "ID": row_id,
                "Enchant_Id": row_id,
                "Maxcount_Inv": 0,
                "Maxcount_Item": 0,
                "Type": GEM_TYPE_RED,
            })
    for family_id, *_ in YELLOW_FAMILIES:
        for rank_index in range(7):
            row_id = YELLOW_GEM_BASE + family_id * 10 + rank_index
            rows.append({
                "ID": row_id,
                "Enchant_Id": row_id,
                "Maxcount_Inv": 0,
                "Maxcount_Item": 0,
                "Type": GEM_TYPE_YELLOW,
            })
    return rows


def gen_item_extended_cost() -> list[dict]:
    rows: list[dict] = []
    miasma_counts = [1, 10, 50, 500, 1000, 5000, 10000]
    for i, count in enumerate(miasma_counts):
        rows.append({
            "ID": MIA_EXT_BASE + i,
            "HonorPoints": 0,
            "ArenaPoints": 0,
            "ArenaBracket": 0,
            "ItemID_1": BLACK_MIASMA,
            "ItemID_2": 0, "ItemID_3": 0, "ItemID_4": 0, "ItemID_5": 0,
            "ItemCount_1": count,
            "ItemCount_2": 0, "ItemCount_3": 0,
            "ItemCount_4": 0, "ItemCount_5": 0,
            "RequiredArenaRating": 0,
            "ItemPurchaseGroup": 0,
        })
    petal_counts = [1, 10, 50, 500, 1000, 5000, 10000]
    for i, count in enumerate(petal_counts):
        rows.append({
            "ID": PETAL_EXT_BASE + i,
            "HonorPoints": 0,
            "ArenaPoints": 0,
            "ArenaBracket": 0,
            "ItemID_1": BLACK_PETALS,
            "ItemID_2": 0, "ItemID_3": 0, "ItemID_4": 0, "ItemID_5": 0,
            "ItemCount_1": count,
            "ItemCount_2": 0, "ItemCount_3": 0,
            "ItemCount_4": 0, "ItemCount_5": 0,
            "RequiredArenaRating": 0,
            "ItemPurchaseGroup": 0,
        })
    return rows


def gen_quest_sort() -> list[dict]:
    return [
        {
            "ID": BLACK_ROSE_QUEST_SORT_ID,
            "SortName_Lang_enUS": BLACK_ROSE_QUEST_SORT_NAME,
            "SortName_Lang_Mask": 1,
        }
    ]


def gen_skill_line_ability() -> list[dict]:
    return [
        {
            "ID": RURIK_DEATH_MOBILE_SPELL,
            "SkillLine": MOUNT_SKILL_LINE_RIDING,
            "Spell": RURIK_DEATH_MOBILE_SPELL,
            "RaceMask": 0,
            "ClassMask": 0,
            "ExcludeRace": 0,
            "ExcludeClass": 0,
            "MinSkillLineRank": 0,
            "SupercededBySpell": 0,
            "AcquireMethod": 0,
            "TrivialSkillLineRankHigh": 0,
            "TrivialSkillLineRankLow": 0,
            "CharacterPoints_1": 0,
            "CharacterPoints_2": 0,
        }
    ]


def main() -> None:
    write(HERE / "spell.json", gen_spell())
    write(HERE / "spellduration.json", gen_spell_duration())
    write(HERE / "spellitemenchantment.json", gen_spell_item_enchantment())
    write(HERE / "gemproperties.json", gen_gem_properties())
    write(HERE / "itemextendedcost.json", gen_item_extended_cost())
    write(HERE / "skilllineability.json", gen_skill_line_ability())
    write(HERE / "questsort.json", gen_quest_sort())
    print(f"Wrote definitions under {HERE}")


if __name__ == "__main__":
    main()
