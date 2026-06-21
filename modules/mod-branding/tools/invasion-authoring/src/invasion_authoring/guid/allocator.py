"""Hands out non-colliding custom GUIDs for authored spawns and waypoint paths.

Custom content must not clash with current or future official rows. The allocator starts at a base
that is at least a configurable floor (default 90,000,000) and at least ``max(creature.guid)+1``
from the live DB, then draws every creature GUID and waypoint path id from a single monotonic
counter, so the two sets are inherently disjoint. Allocation is deterministic for a given base and
call order, making re-exports stable.
"""

from __future__ import annotations


class GuidAllocator:
    def __init__(self, base: int) -> None:
        self.base = int(base)
        self._next = int(base)

    @classmethod
    def from_floor_and_db_max(cls, floor: int, db_max: int) -> GuidAllocator:
        """Pick a base clearing both the configured floor and the highest existing GUID."""
        return cls(base=max(int(floor), int(db_max) + 1))

    def allocate_guids(self, count: int) -> list[int]:
        if count < 0:
            raise ValueError("count must be non-negative")
        start = self._next
        self._next += count
        return list(range(start, start + count))

    def allocate_path_id(self) -> int:
        value = self._next
        self._next += 1
        return value

    def allocate_group_id(self) -> int:
        """A spawn_group id from the same monotonic space (disjoint from guids/path ids)."""
        value = self._next
        self._next += 1
        return value
