"""Compare one starting profile against local Cata DBCs and a TDB dump without using a database."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import tempfile

from check_parity import PIN


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


def skill_dependencies(root, server_root, race, class_id):
    """List direct automatic grants; this is not a simulation of Player::Create."""
    def records(name, fields, size):
        return [struct.unpack(f"<{size // 4}I", row) for row in dbc_rows(root / name, fields, size)]

    def matches(mask, value):
        return mask == 0 or bool(mask & (1 << (value - 1)))

    skills = [row for row in records("SkillRaceClassInfo.dbc", 9, 36)
              if row[5] == 1 and row[6] <= 1 and matches(row[2], race) and matches(row[3], class_id)]
    skill_ids = {row[1] for row in skills}
    definitions = {row[0] for row in records("SkillLine.dbc", 7, 28)}
    spells = {row[0]: row for row in records("Spell.dbc", 48, 192)}
    levels = {row[0]: row for row in records("SpellLevels.dbc", 4, 16)}
    server_spells = {struct.unpack_from("<I", row)[0]
                     for row in dbc_rows(server_root / "Spell.dbc", 234, 936)}
    grants = []
    missing_spells, missing_levels = set(), set()
    for row in records("SkillLineAbility.dbc", 14, 56):
        if (row[1] not in skill_ids or row[9] not in (1, 2)
                or not matches(row[3], race) or not matches(row[4], class_id)):
            continue
        spell = spells.get(row[2])
        if spell is None:
            missing_spells.add(row[2])
            continue
        level = levels.get(spell[41])
        if spell[41] and level is None:
            missing_levels.add(spell[41])
            continue
        if level and max(level[1], level[3]) > 1:
            continue
        grants.append({"ability": row[0], "skill": row[1], "spell": row[2],
                       "acquire_method": row[9], "minimum_skill_rank": row[7]})
    return {"level": 1, "skills": sorted(skill_ids),
            "missing_reference_skills": sorted(skill_ids - definitions),
            "missing_reference_spells": sorted(missing_spells),
            "missing_reference_spell_levels": sorted(missing_levels),
            "potential_automatic_grants": sorted(grants, key=lambda row: row["ability"]),
            "missing_server_potential_grants": sorted({row["spell"] for row in grants} - server_spells),
            "limits": "Direct joins only. Skill-rank thresholds, spell effects, triggered/learned spells, "
                      "specialization and runtime grants still require native loader and creation verification."}


def applied_updates(line):
    prefix = "INSERT INTO `updates` VALUES "
    if not line.startswith(prefix):
        return {}
    values = line[len(prefix):].strip().removesuffix(";")
    row_pattern = r"\('([^']+\.sql)','([0-9A-Fa-f]{40}|)','(ARCHIVED|RELEASED)','[^']+',\d+\)"
    rows = list(re.finditer(row_pattern, values))
    if ",".join(row.group() for row in rows) != values or not rows:
        raise ValueError("Unsupported updates INSERT format")
    result = {row[1]: {"sha1": row[2].lower(), "state": row[3]} for row in rows}
    if len(result) != len(rows):
        raise ValueError("Duplicate applied update name")
    return result


def reference_updates(tree, applied):
    """Compare immutable git blobs with the dump's ledger, without executing SQL."""
    if not applied:
        raise ValueError("Reference dump lacks its applied-update ledger")
    roots = ("sql/old/4.3.4/world", "sql/old/custom/world", "sql/updates/world", "sql/custom/world")
    command = ["git", "-C", str(tree)]
    paths = subprocess.check_output(command + ["ls-tree", "-r", "--name-only", PIN, "--", *roots],
                                    text=True).splitlines()
    paths = sorted((path for path in paths if path.endswith(".sql")), key=lambda path: Path(path).name)
    if len({Path(path).name for path in paths}) != len(paths):
        raise ValueError("Duplicate reference update filename")
    # One git process reads all pinned blobs; never consult a dirty reference working tree.
    blobs = subprocess.check_output(command + ["cat-file", "--batch"],
                                    input="".join(f"{PIN}:{path}\n" for path in paths).encode())
    cursor, matched = 0, 0
    inventory, differences = [], []
    for path in paths:
        end = blobs.index(b"\n", cursor)
        header = blobs[cursor:end].split()
        if len(header) != 3 or header[1] != b"blob":
            raise ValueError(f"Missing reference SQL blob: {path}")
        size = int(header[2])
        content = blobs[end + 1:end + 1 + size]
        cursor = end + size + 2
        digest = hashlib.sha1(content).hexdigest()
        inventory.append(f"{path}\t{digest}\n")
        previous = applied.get(Path(path).name)
        if previous and previous["sha1"] == digest:
            matched += 1
            continue
        tokens = sorted(set(re.findall(rb"\b(?:playercreateinfo\w*|player_levelstats|player_(?:class|race)\w*stats)\b",
                                       content)))
        differences.append({"path": path, "sha1": digest,
                            "sha256": hashlib.sha256(content).hexdigest(),
                            "status": "hash_differs" if previous else "absent_from_dump_ledger",
                            "dump_entry": previous,
                            "same_hash_in_dump": sorted(name for name, row in applied.items()
                                                        if row["sha1"] == digest),
                            "starter_table_mentions": [token.decode() for token in tokens]})
    return {"reference_commit": PIN, "roots": list(roots), "dump_ledger_rows": len(applied),
            "reference_files": len(paths), "matching_name_and_hash": matched,
            "inventory_sha256": hashlib.sha256("".join(inventory).encode()).hexdigest(),
            "differences": differences, "replay_verified": False,
            "limits": "Ledger comparison, not SQL replay. Mentions are search candidates, not semantic "
                      "dependency analysis. Resolve renamed/modified files before choosing an update sequence."}


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
    update = "('2025_06_21_00_world.sql','" + "A" * 40 + "','RELEASED','2025-06-21 00:00:00',0)"
    assert applied_updates(f"INSERT INTO `updates` VALUES {update};") == {
        "2025_06_21_00_world.sql": {"sha1": "a" * 40, "state": "RELEASED"}}
    rejects(lambda: applied_updates(f"INSERT INTO `updates` VALUES {update},broken;"))
    rejects(lambda: applied_updates(f"INSERT INTO `updates` VALUES {update},{update};"))
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
        cata, server = Path(directory) / "cata", Path(directory) / "server"
        cata.mkdir()
        server.mkdir()

        def write_dbc(root, name, width, rows):
            (root / name).write_bytes(struct.pack("<4s4I", b"WDBC", len(rows), width, width * 4, 1)
                                     + b"".join(struct.pack(f"<{width}I", *row) for row in rows) + b"\0")

        write_dbc(cata, "SkillRaceClassInfo.dbc", 9, [
            (1, 26, 1, 1, 0, 1, 1, 0, 0), (2, 27, 1, 2, 0, 1, 1, 0, 0),
            (3, 28, 1, 1, 0, 1, 2, 0, 0), (4, 29, 1, 1, 0, 0, 1, 0, 0)])
        write_dbc(cata, "SkillLine.dbc", 7, [(26, 0, 0, 0, 0, 0, 0)])
        spell_rows = []
        for spell_id, level_id in ((100, 1), (101, 2), (102, 999), (103, 0)):
            row = [0] * 48
            row[0], row[41] = spell_id, level_id
            spell_rows.append(row)
        write_dbc(cata, "Spell.dbc", 48, spell_rows)
        write_dbc(server, "Spell.dbc", 234, [(100,) + (0,) * 233])
        write_dbc(cata, "SpellLevels.dbc", 4, [(1, 1, 0, 1), (2, 2, 0, 1)])
        write_dbc(cata, "SkillLineAbility.dbc", 14, [
            (spell_id, 26, spell_id, 1, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0)
            for spell_id in (100, 101, 102, 103, 104)])
        result = skill_dependencies(cata, server, 1, 1)
        assert result["skills"] == [26]
        assert [row["spell"] for row in result["potential_automatic_grants"]] == [100, 103]
        assert result["missing_server_potential_grants"] == [103]
        assert result["missing_reference_spells"] == [104]
        assert result["missing_reference_spell_levels"] == [999]
    print("Starting-data audit self-test PASS: profile parsing and malformed-source rejection.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cata-dbc-root", type=Path)
    parser.add_argument("--server-dbc-root", type=Path)
    parser.add_argument("--world-reference", type=Path)
    parser.add_argument("--reference-tree", type=Path, help="Compare the dump's update ledger with the pinned TC commit")
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
    updates = {}
    with args.world_reference.open() as stream:
        for line in stream:
            entries = applied_updates(line)
            if updates.keys() & entries.keys():
                raise ValueError("Duplicate applied update name across INSERT statements")
            updates.update(entries)
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
    paths += [args.cata_dbc_root / name for name in
              ("SkillRaceClassInfo.dbc", "SkillLine.dbc", "SkillLineAbility.dbc", "SpellLevels.dbc")]
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
                      "starting_skills": skill_dependencies(args.cata_dbc_root, args.server_dbc_root,
                                                            args.race, args.class_id),
                      "world_updates": reference_updates(args.reference_tree, updates) if args.reference_tree else None,
                      "source_sha256": hashes,
                      "limits": "File comparison only; source provenance, post-release updates, item values, "
                                "skill values, stats, transitive spell dependencies, and runtime creation remain unverified."},
                     indent=2))


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        raise SystemExit(str(error)) from error
