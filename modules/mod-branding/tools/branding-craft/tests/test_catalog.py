from branding_craft import constants as C
from branding_craft.catalog import CATALOG


def test_resources_use_the_decided_bind_model():
    # §16.3 hybrid: Material BoE (the market), Fragment BoA (account-wide).
    assert CATALOG.material.bonding == C.BIND_WHEN_EQUIPPED
    assert CATALOG.fragment.bonding == C.BIND_TO_ACCOUNT


def test_every_entry_sits_in_its_reserved_band():
    assert CATALOG.material.entry in C.RESOURCE_BAND
    assert CATALOG.fragment.entry in C.RESOURCE_BAND
    for r in CATALOG.recipes:
        assert r.output.entry in C.OUTPUT_BAND
        assert r.pattern_entry in C.PATTERN_BAND
        assert r.spell_id in C.CRAFT_SPELL_BAND
        assert r.skill_line_ability_id in C.SKILL_LINE_ABILITY_BAND


def test_reagents_are_material_then_fragment():
    r = CATALOG.recipes[1]  # has both material and fragment
    pairs = CATALOG.reagents(r)
    assert pairs == [(CATALOG.material.entry, r.material_count), (CATALOG.fragment.entry, r.fragment_count)]


def test_zero_count_reagents_are_omitted():
    r = CATALOG.recipes[0]  # fragment_count == 0
    pairs = CATALOG.reagents(r)
    assert pairs == [(CATALOG.material.entry, r.material_count)]


def test_output_required_skill_matches_profession():
    # The profession gate must hold even before the native window ships (#27 scope 2).
    for r in CATALOG.recipes:
        assert r.output.required_skill == r.skill_line
