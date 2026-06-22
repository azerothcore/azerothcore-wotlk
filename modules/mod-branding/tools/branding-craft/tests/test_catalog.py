from branding_craft import constants as C
from branding_craft.catalog import CATALOG


def test_resources_use_the_decided_bind_model():
    # §16.3 hybrid: Material BoE (the market), Fragment BoA (account-wide).
    assert CATALOG.material.bonding == C.BIND_WHEN_EQUIPPED
    assert CATALOG.fragment.bonding == C.BIND_TO_ACCOUNT


def test_every_entry_sits_in_its_reserved_band():
    assert CATALOG.material.entry in C.RESOURCE_BAND
    assert CATALOG.fragment.entry in C.RESOURCE_BAND
    for frag in CATALOG.school_fragments:
        assert frag.entry in C.SCHOOL_FRAGMENT_BAND
    for r in CATALOG.recipes:
        assert r.output.entry in C.OUTPUT_BAND
        assert r.pattern_entry in C.PATTERN_BAND
        assert r.spell_id in C.CRAFT_SPELL_BAND
        assert r.skill_line_ability_id in C.SKILL_LINE_ABILITY_BAND


def test_one_per_school_fragment_laid_out_as_base_plus_brandid():
    # The C++ adapter resolves school -> Fragment as base + BrandId, so the offset must hold exactly.
    assert len(CATALOG.school_fragments) == C.BRAND_SCHOOL_COUNT
    for school, frag in enumerate(CATALOG.school_fragments):
        assert frag.entry == C.SCHOOL_FRAGMENT_BASE + school
        assert frag.bonding == C.BIND_TO_ACCOUNT          # BoA, like the generic Fragment
        assert frag.name == f"{C.BRAND_SCHOOL_NAMES[school]}-Branded Fragment"


def test_schooled_recipe_consumes_its_school_fragment():
    r = CATALOG.recipes[1]  # plate -> Fire, has both material and fragment
    assert r.school == C.BRAND_FIRE
    school_frag = CATALOG.school_fragments[C.BRAND_FIRE]
    pairs = CATALOG.reagents(r)
    assert pairs == [(CATALOG.material.entry, r.material_count), (school_frag.entry, r.fragment_count)]
    # ... and never the generic Fragment, which is reserved for unschooled recipes.
    assert school_frag.entry != CATALOG.fragment.entry


def test_unschooled_recipe_falls_back_to_the_generic_fragment():
    from dataclasses import replace
    generic = replace(CATALOG.recipes[1], school=C.BRAND_GENERIC)
    pairs = CATALOG.reagents(generic)
    assert pairs[1] == (CATALOG.fragment.entry, generic.fragment_count)


def test_zero_count_reagents_are_omitted():
    r = CATALOG.recipes[0]  # fragment_count == 0
    pairs = CATALOG.reagents(r)
    assert pairs == [(CATALOG.material.entry, r.material_count)]


def test_output_required_skill_matches_profession():
    # The profession gate must hold even before the native window ships (#27 scope 2).
    for r in CATALOG.recipes:
        assert r.output.required_skill == r.skill_line
