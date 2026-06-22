"""Binary WDBC (DBC) patcher -- merge the craft rows into an extracted client DBC.

Produces ready-to-pack ``Spell.dbc`` / ``SkillLineAbility.dbc`` binaries from an extracted base, so
the only remaining manual step is packing them into the client MPQ (needs StormLib/MPQEditor; MPQ
*writing* is out of scope for pure Python). Pure stdlib -- reads/writes the WDBC byte layout directly.

WDBC layout (3.3.5a): 20-byte header [magic 'WDBC', record_count, field_count, record_size,
string_block_size] + records + string block. In Spell.dbc and SkillLineAbility.dbc every field is
4 bytes, so column index i lives at byte offset i*4 within a record. Localized string columns store a
**byte offset** into the string block; we set only the enUS slot (offset 0 = empty for the rest).
"""

from __future__ import annotations

import struct

from .catalog import CATALOG, Catalog
from .dbc_layout import SKILL_LINE_ABILITY_COLUMNS, SPELL_DBC_COLUMNS
from .emit_dbc import skill_field_rows, spell_field_rows

_HEADER = struct.Struct("<4siiii")


def merge_rows(base: bytes, columns: list[str], rows: list[dict]) -> bytes:
    """Append ``rows`` to a WDBC ``base`` whose fields are ``columns``; return the new DBC bytes.

    String values are appended to the string block and stored as offsets; int values are written
    in place. Raises if the base's field layout doesn't match ``columns`` (guards a wrong/oddly
    modified client DBC before we corrupt it).
    """

    magic, record_count, field_count, record_size, string_block_size = _HEADER.unpack_from(base, 0)
    if magic != b"WDBC":
        raise ValueError(f"not a WDBC file (magic={magic!r})")
    if field_count != len(columns) or record_size != len(columns) * 4:
        raise ValueError(
            f"DBC layout mismatch: file has {field_count} fields / {record_size}B records, "
            f"expected {len(columns)} / {len(columns) * 4} (client DBC is not stock 3.3.5a?)"
        )

    rec_start = _HEADER.size
    str_start = rec_start + record_count * record_size
    records = bytearray(base[rec_start:str_start])
    strings = bytearray(base[str_start:str_start + string_block_size])
    if not strings:
        strings = bytearray(b"\x00")  # offset 0 must be the empty string

    index = {name: i for i, name in enumerate(columns)}
    for row in rows:
        rec = bytearray(record_size)
        for col, val in row.items():
            i = index[col]
            if isinstance(val, str):
                offset = len(strings)
                strings += val.encode("utf-8") + b"\x00"
                struct.pack_into("<i", rec, i * 4, offset)
            else:
                struct.pack_into("<i", rec, i * 4, int(val))
        records += rec
        record_count += 1

    header = _HEADER.pack(b"WDBC", record_count, field_count, record_size, len(strings))
    return header + bytes(records) + bytes(strings)


def patch_spell_dbc(base: bytes, cat: Catalog = CATALOG) -> bytes:
    return merge_rows(base, SPELL_DBC_COLUMNS, spell_field_rows(cat))


def patch_skill_line_ability_dbc(base: bytes, cat: Catalog = CATALOG) -> bytes:
    return merge_rows(base, SKILL_LINE_ABILITY_COLUMNS, skill_field_rows(cat))


def new_empty_dbc(columns: list[str]) -> bytes:
    """A valid empty WDBC with the given field layout (for tests / building a patch from scratch)."""

    return _HEADER.pack(b"WDBC", 0, len(columns), len(columns) * 4, 1) + b"\x00"
