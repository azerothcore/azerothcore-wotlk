"""WotLK 3.3.5a constants and mod-branding reserved bands used by the craft catalog.

Kept as plain module-level constants (no enums in the public emit surface) so the emitted SQL is
trivially auditable against the AzerothCore base schema and the §16.4 entry-band decision.
"""

# --- mod-branding reserved entry bands (ARCHITECTURE.md §16.4) ---------------------------------
# item_template reserved band: 190000-190099.
ITEM_BAND_MIN = 190000
ITEM_BAND_MAX = 190099
RESOURCE_BAND = range(190000, 190010)  # Material, Fragment
OUTPUT_BAND = range(190010, 190050)    # Branded outputs
PATTERN_BAND = range(190050, 190100)   # Recipe pattern items

# Reserved Spell.dbc / spell_dbc band for Branded craft spells (#29). Far above the 3.3.5a shipped
# spell id range so a custom craft spell can never collide with a Blizzard spell.
CRAFT_SPELL_BAND = range(1900000, 1900100)
# Reserved skilllineability_dbc id band for the craft-spell -> profession mappings.
SKILL_LINE_ABILITY_BAND = range(1900100, 1900200)

# --- item_template.bonding (Item bind, §16.3 hybrid model) -------------------------------------
BIND_NEVER = 0
BIND_WHEN_PICKED_UP = 1   # BoP -- used by recipe pattern items (#29 owner decision)
BIND_WHEN_EQUIPPED = 2    # BoE -- Materials (the surviving market)
BIND_TO_ACCOUNT = 5       # BoA -- Fragments and Branded items (account-wide grind)

# --- item_template.class / subclass ------------------------------------------------------------
ITEM_CLASS_CONSUMABLE = 0
ITEM_CLASS_ARMOR = 4
ITEM_CLASS_TRADE_GOODS = 7
ITEM_CLASS_RECIPE = 9
ITEM_SUBCLASS_TRADE_GOODS_CLOTH = 5
ITEM_SUBCLASS_TRADE_GOODS_LEATHER = 6
# Recipe (book/pattern) subclasses map 1:1 to the profession the pattern teaches.
ITEM_SUBCLASS_RECIPE_LEATHERWORKING = 2
ITEM_SUBCLASS_RECIPE_TAILORING = 3
ITEM_SUBCLASS_RECIPE_BLACKSMITHING = 5

# Armor subclasses (Branded outputs clone heroic-dungeon slots; §27 modest base).
ITEM_SUBCLASS_ARMOR_CLOTH = 1
ITEM_SUBCLASS_ARMOR_LEATHER = 2
ITEM_SUBCLASS_ARMOR_PLATE = 4

# inventory_type for the cloned slot.
INVTYPE_CHEST = 5

# --- SkillLine ids (SkillLine.dbc, the professions the recipes live in) ------------------------
SKILL_BLACKSMITHING = 164
SKILL_LEATHERWORKING = 165
SKILL_TAILORING = 197

# Item quality.
QUALITY_COMMON = 1
QUALITY_UNCOMMON = 2
QUALITY_RARE = 3

# --- Spell.dbc enums (only what a CREATE_ITEM craft spell needs) -------------------------------
SPELL_EFFECT_CREATE_ITEM = 24
# Implicit target A = the caster (the crafter receives the item).
TARGET_UNIT_CASTER = 1
# SpellCastTimes.dbc index 1 == 0ms (instant). DBC indices, not raw milliseconds.
CAST_TIME_INDEX_INSTANT = 1
# SpellRange.dbc index 1 == "Self Only" (0 yd).
RANGE_INDEX_SELF = 1
# spelltrigger for a recipe pattern that *teaches* its spell on use.
SPELL_TRIGGER_LEARN = 6
# EquippedItemClass = -1: the craft spell requires no equipped item.
EQUIPPED_ITEM_CLASS_NONE = -1

# SPELL_ATTR0_IS_TRADESPELL (0x00000040) -- marks the spell as a trade-skill recipe so the client
# lists it in the profession window rather than the spellbook.
SPELL_ATTR0_IS_TRADESPELL = 0x00000040
