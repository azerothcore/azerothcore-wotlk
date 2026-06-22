"""The one place Branded recipes are defined (#29).

Each :class:`Recipe` ties together its native craft spell, the profession it lives in, its reagent
counts, the Branded output it produces, and the BoP pattern item that teaches it. ``branding_recipe``
(the server mirror, #27) and the client ``Spell.dbc`` reagents are both generated from the *same*
reagent counts here, so the two can never disagree -- the drift guard #29 calls for.

Resources and Branded outputs are the §27 server content; they live here too so the whole closed loop
(resources -> craft spell -> output) is described and validated in a single catalog.
"""

from __future__ import annotations

from dataclasses import dataclass, field

from . import constants as C


@dataclass(frozen=True)
class ResourceItem:
    """A crafting input (Material or Fragment), config-mapped per §16.3."""

    entry: int
    name: str
    bonding: int
    item_class: int
    subclass: int
    quality: int
    displayid: int
    stackable: int
    config_key: str  # the Branding.Economy.*ItemId key this entry is wired to


@dataclass(frozen=True)
class BrandedItem:
    """A Branded output: heroic-cloned model, modest base stats (§27), BoA."""

    entry: int
    name: str
    item_class: int
    subclass: int
    inventory_type: int
    quality: int
    displayid: int
    item_level: int
    required_skill: int       # profession gate holds even before the native window (#27 scope 2)
    required_skill_rank: int


@dataclass(frozen=True)
class Recipe:
    """A native profession craft: reagents -> Branded output, taught by a BoP pattern item."""

    id: int                   # branding_recipe.id (mirror) -- also the .branding upgrade handle
    name: str                 # player-facing "Branded <item>"
    skill_line: int           # SkillLine.dbc id (profession the recipe appears in)
    spell_id: int             # Spell.dbc / spell_dbc craft spell id
    skill_line_ability_id: int
    pattern_entry: int        # item_template pattern (BoP) that teaches spell_id
    pattern_subclass: int     # recipe subclass matching the profession
    pattern_quality: int
    pattern_displayid: int
    output: BrandedItem
    material_count: int       # reagent: Material item (BoE)
    fragment_count: int       # reagent: Fragment item (BoA)
    char_xp: int
    req_skill_value: int      # MinSkillLineRank: skill needed to learn/craft
    trivial_high: int         # TrivialSkillLineRankHigh: skill at which the recipe greys out
    school: int = C.BRAND_GENERIC  # BrandId of the Fragment this recipe consumes; BRAND_GENERIC keeps
    #                                the generic Fragment. A schooled recipe consumes the per-school
    #                                Fragment at SCHOOL_FRAGMENT_BASE + school (the "Fire-Branded
    #                                Fragment" loop): mine fire in a fire event, forge fire gear.


def _school_fragment(school: int) -> ResourceItem:
    """The per-school Fragment for BrandId ``school`` (BoA, like the generic Fragment)."""

    name = C.BRAND_SCHOOL_NAMES[school]
    return ResourceItem(
        entry=C.SCHOOL_FRAGMENT_BASE + school,
        name=f"{name}-Branded Fragment",
        bonding=C.BIND_TO_ACCOUNT,  # BoA -- raid/invasion-sourced, account-wide (§16.3)
        item_class=C.ITEM_CLASS_TRADE_GOODS,
        subclass=C.ITEM_SUBCLASS_TRADE_GOODS_CLOTH,
        quality=C.QUALITY_RARE,
        displayid=41111,
        stackable=1000,
        config_key="Branding.Economy.SchoolFragmentBaseItemId",
    )


# One per-school Fragment for every BrandId, in enum order (so its entry == base + index).
SCHOOL_FRAGMENTS = [_school_fragment(i) for i in range(C.BRAND_SCHOOL_COUNT)]


@dataclass(frozen=True)
class Catalog:
    material: ResourceItem
    fragment: ResourceItem
    recipes: list[Recipe] = field(default_factory=list)
    school_fragments: list[ResourceItem] = field(default_factory=lambda: list(SCHOOL_FRAGMENTS))

    @property
    def outputs(self) -> list[BrandedItem]:
        return [r.output for r in self.recipes]

    def fragment_for(self, recipe: Recipe) -> ResourceItem:
        """The Fragment a recipe consumes: its per-school Fragment, or the generic one."""

        if recipe.school < C.BRAND_SCHOOL_COUNT:
            return self.school_fragments[recipe.school]
        return self.fragment

    def reagents(self, recipe: Recipe) -> list[tuple[int, int]]:
        """(item_entry, count) reagent pairs for a recipe, in (Material, Fragment) order.

        This is the canonical reagent definition consumed by BOTH the spell_dbc/Spell.dbc emitter
        and the branding_recipe mirror -- the single point that keeps them in lockstep. The Fragment
        entry is the recipe's per-school Fragment (or the generic Fragment for an unschooled recipe).
        """

        pairs: list[tuple[int, int]] = []
        if recipe.material_count:
            pairs.append((self.material.entry, recipe.material_count))
        if recipe.fragment_count:
            pairs.append((self.fragment_for(recipe).entry, recipe.fragment_count))
        return pairs


# --- The shipped starter set ------------------------------------------------------------------
# Three recipes, one per armour profession, scaling input cost / skill gate with tier (§8.3).
# displayid values clone heroic-dungeon / trade-good art; they are tunables -- retarget freely (the
# acceptance criteria gate on consume/produce/skill behaviour, not on which icon shows).

MATERIAL = ResourceItem(
    entry=190000,
    name="Branding Material",
    bonding=C.BIND_WHEN_EQUIPPED,  # BoE -- the surviving player market (§16.3)
    item_class=C.ITEM_CLASS_TRADE_GOODS,
    subclass=C.ITEM_SUBCLASS_TRADE_GOODS_CLOTH,
    quality=C.QUALITY_COMMON,
    displayid=6884,
    stackable=1000,
    config_key="Branding.Economy.MaterialItemId",
)

FRAGMENT = ResourceItem(
    entry=190001,
    name="Branding Fragment",
    bonding=C.BIND_TO_ACCOUNT,  # BoA -- raid/invasion-sourced, account-wide (§16.3)
    item_class=C.ITEM_CLASS_TRADE_GOODS,
    subclass=C.ITEM_SUBCLASS_TRADE_GOODS_CLOTH,
    quality=C.QUALITY_RARE,
    displayid=41111,
    stackable=1000,
    config_key="Branding.Economy.FragmentItemId",
)


def _branded(entry, name, subclass, ilvl, skill, rank, displayid, quality):
    return BrandedItem(
        entry=entry,
        name=name,
        item_class=C.ITEM_CLASS_ARMOR,
        subclass=subclass,
        inventory_type=C.INVTYPE_CHEST,
        quality=quality,
        displayid=displayid,
        item_level=ilvl,
        required_skill=skill,
        required_skill_rank=rank,
    )


CATALOG = Catalog(
    material=MATERIAL,
    fragment=FRAGMENT,
    recipes=[
        Recipe(
            id=1,
            name="Branded Leather Chestguard",
            skill_line=C.SKILL_LEATHERWORKING,
            spell_id=1900010,
            skill_line_ability_id=1900110,
            pattern_entry=190050,
            pattern_subclass=C.ITEM_SUBCLASS_RECIPE_LEATHERWORKING,
            pattern_quality=C.QUALITY_UNCOMMON,
            pattern_displayid=1387,
            output=_branded(
                190010, "Branded Leather Chestguard", C.ITEM_SUBCLASS_ARMOR_LEATHER,
                ilvl=187, skill=C.SKILL_LEATHERWORKING, rank=350, displayid=48723,
                quality=C.QUALITY_UNCOMMON,
            ),
            material_count=5,
            fragment_count=0,
            char_xp=100,
            req_skill_value=350,
            trivial_high=375,
            school=C.BRAND_NATURE,
        ),
        Recipe(
            id=2,
            name="Branded Plate Chestpiece",
            skill_line=C.SKILL_BLACKSMITHING,
            spell_id=1900011,
            skill_line_ability_id=1900111,
            pattern_entry=190051,
            pattern_subclass=C.ITEM_SUBCLASS_RECIPE_BLACKSMITHING,
            pattern_quality=C.QUALITY_RARE,
            pattern_displayid=1387,
            output=_branded(
                190011, "Branded Plate Chestpiece", C.ITEM_SUBCLASS_ARMOR_PLATE,
                ilvl=200, skill=C.SKILL_BLACKSMITHING, rank=400, displayid=48729,
                quality=C.QUALITY_RARE,
            ),
            material_count=10,
            fragment_count=5,
            char_xp=250,
            req_skill_value=400,
            trivial_high=425,
            school=C.BRAND_FIRE,
        ),
        Recipe(
            id=3,
            name="Branded Cloth Robe",
            skill_line=C.SKILL_TAILORING,
            spell_id=1900012,
            skill_line_ability_id=1900112,
            pattern_entry=190052,
            pattern_subclass=C.ITEM_SUBCLASS_RECIPE_TAILORING,
            pattern_quality=C.QUALITY_RARE,
            pattern_displayid=1387,
            output=_branded(
                190012, "Branded Cloth Robe", C.ITEM_SUBCLASS_ARMOR_CLOTH,
                ilvl=213, skill=C.SKILL_TAILORING, rank=450, displayid=48733,
                quality=C.QUALITY_RARE,
            ),
            material_count=20,
            fragment_count=10,
            char_xp=600,
            req_skill_value=450,
            trivial_high=450,
            school=C.BRAND_ARCANE,
        ),
    ],
)
