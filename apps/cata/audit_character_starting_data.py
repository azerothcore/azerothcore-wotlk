"""Compare one starting profile against local Cata DBCs and a TDB dump without using a database."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import tempfile


def dbc_rows(path, fields, size):
    data = path.read_bytes()
    if len(data) < 20:
        raise ValueError(f"Truncated DBC header: {path}")
    magic, count, actual_fields, actual_size, strings = struct.unpack_from("<4s4I", data)
    if (magic, actual_fields, actual_size) != (b"WDBC", fields, size):
        raise ValueError(f"Unexpected DBC layout: {path}")
    if len(data) != 20 + count * size + strings:
        raise ValueError(f"Truncated or trailing DBC data: {path}")
    return [data[20 + i * size:20 + (i + 1) * size] for i in range(count)]


def outfits(path, fields, size, race, class_id):
    result = []
    for row in dbc_rows(path, fields, size):
        if row[4:6] == bytes((race, class_id)):
            result.append({"gender": row[6], "outfit": row[7],
                           "items": [item for item in struct.unpack_from("<24i", row, 8) if item > 0]})
    if not result:
        raise ValueError(f"No matching starting outfit: {path}")
    return sorted(result, key=lambda row: (row["gender"], row["outfit"]))


def numeric_values(line, table):
    prefix = f"INSERT INTO `{table}` VALUES "
    if not line.startswith(prefix):
        return []
    # These two TDB tables contain only numeric columns; reject any other SQL representation.
    value_list = line[len(prefix):].strip().removesuffix(";")
    if not re.fullmatch(r"\([^()]+\)(?:,\([^()]+\))*", value_list):
        raise ValueError(f"Unsupported INSERT format for {table}")
    rows = [[float(value) if "." in value or "e" in value.lower() else int(value)
             for value in group.split(",")] for group in re.findall(r"\(([^()]+)\)", value_list)]
    width = {"playercreateinfo": 8, "playercreateinfo_action": 5}[table]
    if any(len(row) != width for row in rows):
        raise ValueError(f"Unexpected row width for {table}")
    return rows


def self_test():
    def rejects(action):
        try:
            action()
        except ValueError:
            return
        raise AssertionError("Malformed source was accepted")

    assert numeric_values("INSERT INTO `playercreateinfo_action` VALUES (1,1,73,88161,0);\n",
                          "playercreateinfo_action") == [[1, 1, 73, 88161, 0]]
    for values in ("(1,1)", "(1,1,0,'text',0)", "(1,1,0,1,0),broken"):
        rejects(lambda: numeric_values(f"INSERT INTO `playercreateinfo_action` VALUES {values};",
                                       "playercreateinfo_action"))
    with tempfile.TemporaryDirectory() as directory:
        path = Path(directory) / "CharStartOutfit.dbc"
        row = bytearray(304)
        row[4:8] = bytes((1, 1, 0, 0))
        struct.pack_into("<i", row, 8, 58231)
        data = struct.pack("<4s4I", b"WDBC", 1, 79, 304, 1) + row + b"\0"
        path.write_bytes(data)
        assert outfits(path, 79, 304, 1, 1) == [{"gender": 0, "outfit": 0, "items": [58231]}]
        rejects(lambda: outfits(path, 79, 304, 2, 1))
        rejects(lambda: dbc_rows(path, 77, 296))
        for invalid in (data[:10], data[:-1], data + b"\0"):
            path.write_bytes(invalid)
            rejects(lambda: dbc_rows(path, 79, 304))
    print("Starting-data audit self-test PASS: profile parsing and malformed-source rejection.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cata-dbc-root", type=Path)
    parser.add_argument("--server-dbc-root", type=Path)
    parser.add_argument("--world-reference", type=Path)
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--race", type=int, default=1)
    parser.add_argument("--class-id", type=int, default=1)
    args = parser.parse_args()
    if args.self_test:
        self_test()
        return
    if not all((args.cata_dbc_root, args.server_dbc_root, args.world_reference)):
        parser.error("--cata-dbc-root, --server-dbc-root, and --world-reference are required")
    if not 1 <= args.race <= 255 or not 1 <= args.class_id <= 255:
        parser.error("race and class-id must fit a nonzero byte")
    expected = outfits(args.cata_dbc_root / "CharStartOutfit.dbc", 79, 304, args.race, args.class_id)
    current = outfits(args.server_dbc_root / "CharStartOutfit.dbc", 77, 296, args.race, args.class_id)
    tables = {"playercreateinfo": [], "playercreateinfo_action": []}
    with args.world_reference.open() as stream:
        for line in stream:
            for name, rows in tables.items():
                rows.extend(row for row in numeric_values(line, name) if row[:2] == [args.race, args.class_id])
    if not all(tables.values()):
        raise ValueError("Reference dump lacks a spawn or action profile for this race/class")
    action_spells = sorted({int(row[3]) for row in tables["playercreateinfo_action"] if row[4] == 0})
    spell_ids = {}
    for label, root, fields, size in (("cata", args.cata_dbc_root, 48, 192),
                                      ("server", args.server_dbc_root, 234, 936)):
        spell_ids[label] = {struct.unpack_from("<I", row)[0] for row in dbc_rows(root / "Spell.dbc", fields, size)}
    paths = [args.world_reference] + [root / name for root in (args.cata_dbc_root, args.server_dbc_root)
                                    for name in ("CharStartOutfit.dbc", "Spell.dbc")]
    hashes = {}
    for path in paths:
        with path.open("rb") as stream:
            hashes[str(path)] = hashlib.file_digest(stream, "sha256").hexdigest()
    print(json.dumps({"race": args.race, "class": args.class_id, "reference_outfits": expected,
                      "server_outfits": current, "outfits_match": expected == current,
                      "reference_spawn": tables["playercreateinfo"],
                      "reference_actions": tables["playercreateinfo_action"],
                      "missing_reference_action_spells": sorted(set(action_spells) - spell_ids["cata"]),
                      "missing_server_action_spells": sorted(set(action_spells) - spell_ids["server"]),
                      "source_sha256": hashes,
                      "limits": "File comparison only; source provenance, post-release updates, item values, "
                                "skills, stats, other spell dependencies, and runtime creation remain unverified."},
                     indent=2))


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError) as error:
        raise SystemExit(str(error)) from error
