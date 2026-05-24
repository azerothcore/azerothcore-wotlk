"""Binary DBC reader/writer for 3.3.5a (build 12340) client patch authoring.

Schema layouts mirror the AzerothCore SQL `*_dbc` tables one-to-one, which the
AC core asserts equals the format string and the binary file. AC's format
strings mark fields the server does not read as `x`; in the actual binary,
some of those `x` slots are still strings (notably the unused locale columns).
The schemas below override those positions back to `s` so localized client
tooltip text gets emitted correctly.

Format characters (subset used here):
    n - primary key uint32 (4 bytes)
    i - int32 / uint32     (4 bytes)
    f - float32            (4 bytes)
    s - string ref         (4 bytes, offset into string pool)
    x - unused int32       (4 bytes, written as 0)
"""

from __future__ import annotations

import struct
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterable


WDBC_MAGIC = b"WDBC"


@dataclass
class Schema:
    filename: str
    fmt: str
    columns: list[str]

    def __post_init__(self) -> None:
        if len(self.fmt) != len(self.columns):
            raise ValueError(
                f"{self.filename}: fmt length {len(self.fmt)} does not match"
                f" column count {len(self.columns)}"
            )

    @property
    def field_count(self) -> int:
        return len(self.fmt)

    @property
    def record_size(self) -> int:
        return sum(1 if c in ("b", "X") else 4 for c in self.fmt)

    def index_of(self, column: str) -> int:
        return self.columns.index(column)


def _spell_schema() -> Schema:
    """3.3.5a Spell.dbc - 234 fields, 936 bytes/record.

    Source: AzerothCore SpellEntryfmt + spell_dbc SQL column order.
    Locale string fields the AC server does not read are marked 'x' in
    AC's fmt; we restore them to 's' so client tooltips work.
    """
    ac_fmt = "niiiiiiiiiiiixixiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifxiiiiiiiiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiiiiiiiifffiiiiiiiiiiiiiiifffiiiiiiiiiiiiiissssssssssssssssxssssssssssssssssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxiiiiiiiiiiixfffxxxiiiiixxfffxx"  # noqa: E501
    fmt = list(ac_fmt)
    for i in range(170, 186):
        fmt[i] = "s"
    for i in range(187, 203):
        fmt[i] = "s"
    columns = [
        "ID", "Category", "DispelType", "Mechanic", "Attributes",
        "AttributesEx", "AttributesEx2", "AttributesEx3", "AttributesEx4",
        "AttributesEx5", "AttributesEx6", "AttributesEx7", "ShapeshiftMask",
        "unk_320_2", "ShapeshiftExclude", "unk_320_3", "Targets",
        "TargetCreatureType", "RequiresSpellFocus", "FacingCasterFlags",
        "CasterAuraState", "TargetAuraState", "ExcludeCasterAuraState",
        "ExcludeTargetAuraState", "CasterAuraSpell", "TargetAuraSpell",
        "ExcludeCasterAuraSpell", "ExcludeTargetAuraSpell", "CastingTimeIndex",
        "RecoveryTime", "CategoryRecoveryTime", "InterruptFlags",
        "AuraInterruptFlags", "ChannelInterruptFlags", "ProcTypeMask",
        "ProcChance", "ProcCharges", "MaxLevel", "BaseLevel", "SpellLevel",
        "DurationIndex", "PowerType", "ManaCost", "ManaCostPerLevel",
        "ManaPerSecond", "ManaPerSecondPerLevel", "RangeIndex", "Speed",
        "ModalNextSpell", "CumulativeAura", "Totem_1", "Totem_2",
        "Reagent_1", "Reagent_2", "Reagent_3", "Reagent_4", "Reagent_5",
        "Reagent_6", "Reagent_7", "Reagent_8", "ReagentCount_1",
        "ReagentCount_2", "ReagentCount_3", "ReagentCount_4", "ReagentCount_5",
        "ReagentCount_6", "ReagentCount_7", "ReagentCount_8",
        "EquippedItemClass", "EquippedItemSubclass", "EquippedItemInvTypes",
        "Effect_1", "Effect_2", "Effect_3", "EffectDieSides_1",
        "EffectDieSides_2", "EffectDieSides_3", "EffectRealPointsPerLevel_1",
        "EffectRealPointsPerLevel_2", "EffectRealPointsPerLevel_3",
        "EffectBasePoints_1", "EffectBasePoints_2", "EffectBasePoints_3",
        "EffectMechanic_1", "EffectMechanic_2", "EffectMechanic_3",
        "ImplicitTargetA_1", "ImplicitTargetA_2", "ImplicitTargetA_3",
        "ImplicitTargetB_1", "ImplicitTargetB_2", "ImplicitTargetB_3",
        "EffectRadiusIndex_1", "EffectRadiusIndex_2", "EffectRadiusIndex_3",
        "EffectAura_1", "EffectAura_2", "EffectAura_3", "EffectAuraPeriod_1",
        "EffectAuraPeriod_2", "EffectAuraPeriod_3", "EffectMultipleValue_1",
        "EffectMultipleValue_2", "EffectMultipleValue_3",
        "EffectChainTargets_1", "EffectChainTargets_2", "EffectChainTargets_3",
        "EffectItemType_1", "EffectItemType_2", "EffectItemType_3",
        "EffectMiscValue_1", "EffectMiscValue_2", "EffectMiscValue_3",
        "EffectMiscValueB_1", "EffectMiscValueB_2", "EffectMiscValueB_3",
        "EffectTriggerSpell_1", "EffectTriggerSpell_2", "EffectTriggerSpell_3",
        "EffectPointsPerCombo_1", "EffectPointsPerCombo_2",
        "EffectPointsPerCombo_3", "EffectSpellClassMaskA_1",
        "EffectSpellClassMaskA_2", "EffectSpellClassMaskA_3",
        "EffectSpellClassMaskB_1", "EffectSpellClassMaskB_2",
        "EffectSpellClassMaskB_3", "EffectSpellClassMaskC_1",
        "EffectSpellClassMaskC_2", "EffectSpellClassMaskC_3",
        "SpellVisualID_1", "SpellVisualID_2", "SpellIconID", "ActiveIconID",
        "SpellPriority", "Name_Lang_enUS", "Name_Lang_enGB", "Name_Lang_koKR",
        "Name_Lang_frFR", "Name_Lang_deDE", "Name_Lang_enCN", "Name_Lang_zhCN",
        "Name_Lang_enTW", "Name_Lang_zhTW", "Name_Lang_esES", "Name_Lang_esMX",
        "Name_Lang_ruRU", "Name_Lang_ptPT", "Name_Lang_ptBR", "Name_Lang_itIT",
        "Name_Lang_Unk", "Name_Lang_Mask", "NameSubtext_Lang_enUS",
        "NameSubtext_Lang_enGB", "NameSubtext_Lang_koKR",
        "NameSubtext_Lang_frFR", "NameSubtext_Lang_deDE",
        "NameSubtext_Lang_enCN", "NameSubtext_Lang_zhCN",
        "NameSubtext_Lang_enTW", "NameSubtext_Lang_zhTW",
        "NameSubtext_Lang_esES", "NameSubtext_Lang_esMX",
        "NameSubtext_Lang_ruRU", "NameSubtext_Lang_ptPT",
        "NameSubtext_Lang_ptBR", "NameSubtext_Lang_itIT",
        "NameSubtext_Lang_Unk", "NameSubtext_Lang_Mask",
        "Description_Lang_enUS", "Description_Lang_enGB",
        "Description_Lang_koKR", "Description_Lang_frFR",
        "Description_Lang_deDE", "Description_Lang_enCN",
        "Description_Lang_zhCN", "Description_Lang_enTW",
        "Description_Lang_zhTW", "Description_Lang_esES",
        "Description_Lang_esMX", "Description_Lang_ruRU",
        "Description_Lang_ptPT", "Description_Lang_ptBR",
        "Description_Lang_itIT", "Description_Lang_Unk",
        "Description_Lang_Mask",
        "AuraDescription_Lang_enUS", "AuraDescription_Lang_enGB",
        "AuraDescription_Lang_koKR", "AuraDescription_Lang_frFR",
        "AuraDescription_Lang_deDE", "AuraDescription_Lang_enCN",
        "AuraDescription_Lang_zhCN", "AuraDescription_Lang_enTW",
        "AuraDescription_Lang_zhTW", "AuraDescription_Lang_esES",
        "AuraDescription_Lang_esMX", "AuraDescription_Lang_ruRU",
        "AuraDescription_Lang_ptPT", "AuraDescription_Lang_ptBR",
        "AuraDescription_Lang_itIT", "AuraDescription_Lang_Unk",
        "AuraDescription_Lang_Mask",
        "ManaCostPct", "StartRecoveryCategory", "StartRecoveryTime",
        "MaxTargetLevel", "SpellClassSet", "SpellClassMask_1",
        "SpellClassMask_2", "SpellClassMask_3", "MaxTargets", "DefenseType",
        "PreventionType", "StanceBarOrder", "EffectChainAmplitude_1",
        "EffectChainAmplitude_2", "EffectChainAmplitude_3", "MinFactionID",
        "MinReputation", "RequiredAuraVision", "RequiredTotemCategoryID_1",
        "RequiredTotemCategoryID_2", "RequiredAreasID", "SchoolMask",
        "RuneCostID", "SpellMissileID", "PowerDisplayID",
        "EffectBonusMultiplier_1", "EffectBonusMultiplier_2",
        "EffectBonusMultiplier_3", "SpellDescriptionVariableID",
        "SpellDifficultyID",
    ]
    return Schema("Spell.dbc", "".join(fmt), columns)


def _spell_duration_schema() -> Schema:
    return Schema(
        "SpellDuration.dbc",
        "niii",
        ["ID", "Duration", "DurationPerLevel", "MaxDuration"],
    )


def _spell_item_enchantment_schema() -> Schema:
    """3.3.5a SpellItemEnchantment.dbc - 38 fields."""
    ac_fmt = "niiiiiiixxxiiissssssssssssssssxiiiiiii"
    fmt = list(ac_fmt)
    fmt[31] = "i"
    columns = [
        "ID", "Charges",
        "Effect_1", "Effect_2", "Effect_3",
        "EffectPointsMin_1", "EffectPointsMin_2", "EffectPointsMin_3",
        "EffectPointsMax_1", "EffectPointsMax_2", "EffectPointsMax_3",
        "EffectArg_1", "EffectArg_2", "EffectArg_3",
        "Name_Lang_enUS", "Name_Lang_enGB", "Name_Lang_koKR",
        "Name_Lang_frFR", "Name_Lang_deDE", "Name_Lang_enCN",
        "Name_Lang_zhCN", "Name_Lang_enTW", "Name_Lang_zhTW",
        "Name_Lang_esES", "Name_Lang_esMX", "Name_Lang_ruRU",
        "Name_Lang_ptPT", "Name_Lang_ptBR", "Name_Lang_itIT",
        "Name_Lang_Unk", "Name_Lang_Mask",
        "ItemVisual", "Flags", "Src_ItemID", "Condition_Id",
        "RequiredSkillID", "RequiredSkillRank", "MinLevel",
    ]
    return Schema("SpellItemEnchantment.dbc", "".join(fmt), columns)


def _gem_properties_schema() -> Schema:
    return Schema(
        "GemProperties.dbc",
        "niiii",
        ["ID", "Enchant_Id", "Maxcount_Inv", "Maxcount_Item", "Type"],
    )


def _item_extended_cost_schema() -> Schema:
    return Schema(
        "ItemExtendedCost.dbc",
        "niiiiiiiiiiiiiii",
        [
            "ID", "HonorPoints", "ArenaPoints", "ArenaBracket",
            "ItemID_1", "ItemID_2", "ItemID_3", "ItemID_4", "ItemID_5",
            "ItemCount_1", "ItemCount_2", "ItemCount_3", "ItemCount_4",
            "ItemCount_5", "RequiredArenaRating", "ItemPurchaseGroup",
        ],
    )


def _skill_line_ability_schema() -> Schema:
    """3.3.5a SkillLineAbility.dbc - 14 fields, all 4-byte ints."""
    return Schema(
        "SkillLineAbility.dbc",
        "niiiiiiiiiiiii",
        [
            "ID", "SkillLine", "Spell", "RaceMask", "ClassMask",
            "ExcludeRace", "ExcludeClass", "MinSkillLineRank",
            "SupercededBySpell", "AcquireMethod",
            "TrivialSkillLineRankHigh", "TrivialSkillLineRankLow",
            "CharacterPoints_1", "CharacterPoints_2",
        ],
    )


def _quest_sort_schema() -> Schema:
    """3.3.5a QuestSort.dbc - 18 fields (1 ID + 16 locale strings + mask).

    AC fmt is `nxxxxxxxxxxxxxxxxx`: the server reads sort headers from
    the SQL `questsort_dbc` table at runtime, so all locale slots are
    marked unused. We restore the 16 locale string slots to 's' so the
    client UI can render our custom header text.
    """
    fmt = list("n" + "s" * 16 + "i")
    columns = [
        "ID",
        "SortName_Lang_enUS", "SortName_Lang_enGB", "SortName_Lang_koKR",
        "SortName_Lang_frFR", "SortName_Lang_deDE", "SortName_Lang_enCN",
        "SortName_Lang_zhCN", "SortName_Lang_enTW", "SortName_Lang_zhTW",
        "SortName_Lang_esES", "SortName_Lang_esMX", "SortName_Lang_ruRU",
        "SortName_Lang_ptPT", "SortName_Lang_ptBR", "SortName_Lang_itIT",
        "SortName_Lang_Unk", "SortName_Lang_Mask",
    ]
    return Schema("QuestSort.dbc", "".join(fmt), columns)


def _item_schema() -> Schema:
    """3.3.5a Item.dbc - 8 fields, all 4-byte ints.

    Without an Item.dbc entry the client falls back to defaulting
    InventoryType to 0 internally, which breaks right-click handling
    for trinkets, bags, and any other equippable custom item.
    """
    return Schema(
        "Item.dbc",
        "niiiiiii",
        [
            "ID", "ClassID", "SubclassID", "SoundOverrideSubclassID",
            "Material", "DisplayInfoID", "InventoryType", "SheatheType",
        ],
    )


def _creature_display_info_schema() -> Schema:
    """3.3.5a CreatureDisplayInfo.dbc - 16 fields.

    AC fmt is `nixifxxxxxxxxxxx`. The server does not read the texture
    variation strings or the trailing fields; we override 'x' positions
    that are strings or floats in the actual file. Column 10 is
    SizeClass per AC's `CreatureDisplayInfoEntry` comment in
    `src/server/shared/DataStores/DBCStructure.h`.
    """
    return Schema(
        "CreatureDisplayInfo.dbc",
        "niiifissssiiiiii",
        [
            "ID", "ModelID", "SoundID", "ExtendedDisplayInfoID",
            "CreatureModelScale", "CreatureModelAlpha",
            "TextureVariation_1", "TextureVariation_2",
            "TextureVariation_3", "PortraitTextureName",
            "SizeClass", "BloodID", "NPCSoundID",
            "ParticleColorID", "CreatureGeosetData",
            "ObjectEffectPackageID",
        ],
    )


def _creature_model_data_schema() -> Schema:
    """3.3.5a CreatureModelData.dbc - 28 fields.

    AC fmt is `nixxfxxxxxxxxxfffxxxxxxxxxxx`; we override 'x' positions
    that are strings or floats in the actual binary so we can author
    useful values for the client. Column types follow the wowdev wiki
    layout for CreatureModelData (3.3.5a) cross-checked against the
    `CreatureModelDataEntry` comments in
    `src/server/shared/DataStores/DBCStructure.h`.
    """
    return Schema(
        "CreatureModelData.dbc",
        "nisifiifffifiiffffffffffffff",
        [
            "ID", "Flags", "ModelName", "SizeClass", "ModelScale",
            "BloodID", "FootprintTextureID", "FootprintTextureLength",
            "FootprintTextureWidth", "FootprintParticleScale",
            "FoleyMaterialID", "FootstepShakeSize", "DeathThudShakeSize",
            "SoundID", "CollisionWidth", "CollisionHeight", "MountHeight",
            "GeoBoxMinX", "GeoBoxMinY", "GeoBoxMinZ",
            "GeoBoxMaxX", "GeoBoxMaxY", "GeoBoxMaxZ",
            "WorldEffectScale", "AttachedEffectScale",
            "MissileCollisionRadius", "MissileCollisionPush",
            "MissileCollisionRaise",
        ],
    )


SCHEMAS: dict[str, Schema] = {
    "spell": _spell_schema(),
    "spellduration": _spell_duration_schema(),
    "spellitemenchantment": _spell_item_enchantment_schema(),
    "gemproperties": _gem_properties_schema(),
    "itemextendedcost": _item_extended_cost_schema(),
    "skilllineability": _skill_line_ability_schema(),
    "questsort": _quest_sort_schema(),
    "item": _item_schema(),
    "creaturedisplayinfo": _creature_display_info_schema(),
    "creaturemodeldata": _creature_model_data_schema(),
}


@dataclass
class DbcFile:
    schema: Schema
    rows: list[dict[str, Any]] = field(default_factory=list)

    def upsert(self, row: dict[str, Any]) -> None:
        """Replace a row by ID, or append if new."""
        new_id = int(row["ID"])
        for i, existing in enumerate(self.rows):
            if int(existing["ID"]) == new_id:
                self.rows[i] = row
                return
        self.rows.append(row)

    def merge_row(self, row: dict[str, Any]) -> None:
        """Field-merge an override onto an existing row by ID.

        Unlike upsert(), this preserves every field of the existing row
        and only overrides the keys present in `row`. Use this when you
        want to retune a couple of values on a stock DBC entry (e.g.
        change EffectBasePoints_1 on a raid spell so the client tooltip
        stops showing raid-tier numbers) without nuking SpellVisual,
        SchoolMask, target geometry, or any of the dozens of other
        columns we don't want to manage by hand.

        If no row with this ID exists in the base DBC, the merge falls
        back to a plain append so the override still lands.
        """
        new_id = int(row["ID"])
        for existing in self.rows:
            if int(existing["ID"]) == new_id:
                existing.update(row)
                return
        self.rows.append(row)

    def sort_by_id(self) -> None:
        self.rows.sort(key=lambda r: int(r["ID"]))


def read_dbc(path: Path, schema: Schema) -> DbcFile:
    data = path.read_bytes()
    if len(data) < 20 or data[:4] != WDBC_MAGIC:
        raise ValueError(f"{path}: not a WDBC file")
    record_count, field_count, record_size, string_size = struct.unpack(
        "<IIII", data[4:20]
    )
    if field_count != schema.field_count:
        raise ValueError(
            f"{path}: field count {field_count} does not match schema"
            f" {schema.field_count}"
        )
    if record_size != schema.record_size:
        raise ValueError(
            f"{path}: record size {record_size} does not match schema"
            f" {schema.record_size}"
        )
    records_end = 20 + record_size * record_count
    record_blob = data[20:records_end]
    string_blob = data[records_end:records_end + string_size]
    rows: list[dict[str, Any]] = []
    for r in range(record_count):
        offset = r * record_size
        row: dict[str, Any] = {}
        for col, t in zip(schema.columns, schema.fmt):
            if t in ("b", "X"):
                row[col] = record_blob[offset]
                offset += 1
            elif t == "f":
                (row[col],) = struct.unpack(
                    "<f", record_blob[offset:offset + 4]
                )
                offset += 4
            elif t == "s":
                (so,) = struct.unpack(
                    "<I", record_blob[offset:offset + 4]
                )
                end = string_blob.index(b"\x00", so)
                row[col] = string_blob[so:end].decode("utf-8", "replace")
                offset += 4
            else:
                (row[col],) = struct.unpack(
                    "<I", record_blob[offset:offset + 4]
                )
                offset += 4
        rows.append(row)
    return DbcFile(schema=schema, rows=rows)


def write_dbc(dbc: DbcFile, path: Path) -> None:
    schema = dbc.schema
    string_pool = bytearray(b"\x00")
    string_offsets: dict[str, int] = {"": 0}

    def intern(s: str) -> int:
        if s in string_offsets:
            return string_offsets[s]
        offset = len(string_pool)
        string_pool.extend(s.encode("utf-8"))
        string_pool.append(0)
        string_offsets[s] = offset
        return offset

    record_blob = bytearray()
    for row in dbc.rows:
        for col, t in zip(schema.columns, schema.fmt):
            val = row.get(col, 0)
            if t in ("b", "X"):
                record_blob.append(int(val) & 0xFF if val else 0)
            elif t == "f":
                record_blob.extend(struct.pack("<f", float(val) if val else 0.0))
            elif t == "s":
                record_blob.extend(struct.pack("<I", intern(str(val) if val else "")))
            else:
                v = int(val) if val else 0
                if v < 0:
                    record_blob.extend(struct.pack("<i", v))
                else:
                    record_blob.extend(struct.pack("<I", v & 0xFFFFFFFF))

    if len(record_blob) % 4 != 0:
        record_blob.extend(b"\x00" * (4 - len(record_blob) % 4))

    header = struct.pack(
        "<4sIIII",
        WDBC_MAGIC,
        len(dbc.rows),
        schema.field_count,
        schema.record_size,
        len(string_pool),
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("wb") as f:
        f.write(header)
        f.write(record_blob)
        f.write(string_pool)


def empty(schema: Schema) -> DbcFile:
    return DbcFile(schema=schema, rows=[])
