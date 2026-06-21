import pytest

from invasion_authoring.guid import GuidAllocator


def test_base_respects_floor_when_db_is_empty():
    alloc = GuidAllocator.from_floor_and_db_max(floor=90_000_000, db_max=0)
    assert alloc.base == 90_000_000


def test_base_clears_db_max_when_higher_than_floor():
    alloc = GuidAllocator.from_floor_and_db_max(floor=90_000_000, db_max=95_000_123)
    assert alloc.base == 95_000_124


def test_guids_are_contiguous_and_advance():
    alloc = GuidAllocator(base=90_000_000)
    first = alloc.allocate_guids(3)
    assert first == [90_000_000, 90_000_001, 90_000_002]
    second = alloc.allocate_guids(2)
    assert second == [90_000_003, 90_000_004]


def test_guids_and_path_ids_never_overlap():
    alloc = GuidAllocator(base=90_000_000)
    guids = set(alloc.allocate_guids(5))
    paths = {alloc.allocate_path_id() for _ in range(5)}
    more_guids = set(alloc.allocate_guids(5))
    assert guids.isdisjoint(paths)
    assert more_guids.isdisjoint(paths)
    assert guids.isdisjoint(more_guids)


def test_group_ids_disjoint_from_guids_and_paths():
    alloc = GuidAllocator(base=90_000_000)
    guids = set(alloc.allocate_guids(3))
    groups = {alloc.allocate_group_id() for _ in range(3)}
    paths = {alloc.allocate_path_id() for _ in range(3)}
    assert guids.isdisjoint(groups)
    assert groups.isdisjoint(paths)
    assert guids.isdisjoint(paths)


def test_allocate_zero_is_empty():
    alloc = GuidAllocator(base=90_000_000)
    assert alloc.allocate_guids(0) == []


def test_negative_count_rejected():
    alloc = GuidAllocator(base=90_000_000)
    with pytest.raises(ValueError):
        alloc.allocate_guids(-1)


def test_deterministic_for_same_base_and_order():
    a = GuidAllocator(base=90_000_000)
    b = GuidAllocator(base=90_000_000)
    assert a.allocate_guids(4) == b.allocate_guids(4)
    assert a.allocate_path_id() == b.allocate_path_id()
