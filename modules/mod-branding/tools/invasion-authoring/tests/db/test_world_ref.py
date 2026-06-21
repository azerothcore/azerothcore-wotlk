from invasion_authoring.db import CreatureTemplate, FakeWorldRef
from invasion_authoring.guid import GuidAllocator


def _fake() -> FakeWorldRef:
    return FakeWorldRef(
        templates=[
            CreatureTemplate(entry=299, name="Defias Smuggler", subname="", minlevel=10, maxlevel=11, rank=0),
            CreatureTemplate(entry=11502, name="Goblin Boss", subname="Leader", minlevel=20, maxlevel=20, rank=1),
            CreatureTemplate(entry=300, name="Defias Trapper", subname="", minlevel=12, maxlevel=13, rank=0),
        ],
        zone_maps={12: 0, 1519: 0},
        max_guid=91_234_567,
    )


def test_search_is_case_insensitive_substring():
    ref = _fake()
    hits = ref.search_creature_templates("defias", limit=10)
    assert {t.entry for t in hits} == {299, 300}


def test_search_respects_limit():
    ref = _fake()
    assert len(ref.search_creature_templates("e", limit=1)) == 1


def test_get_template_by_entry():
    ref = _fake()
    assert ref.get_creature_template(11502).name == "Goblin Boss"
    assert ref.get_creature_template(404) is None


def test_zone_map_lookup():
    ref = _fake()
    assert ref.zone_map(12) == 0
    assert ref.zone_map(99999) is None


def test_max_guid_feeds_allocator_base():
    ref = _fake()
    alloc = GuidAllocator.from_floor_and_db_max(floor=90_000_000, db_max=ref.max_creature_guid())
    assert alloc.base == 91_234_568
