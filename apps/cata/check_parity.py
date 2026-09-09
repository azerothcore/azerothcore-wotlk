"""Check parity tracking; optionally reconcile its data inventory with the pinned TrinityCore tree."""
import argparse
from collections import Counter
import csv
from pathlib import Path
import re
import subprocess
import tempfile

PIN = "c699217775d90794158422387b07a917e161b582"
ROOT = Path(__file__).resolve().parents[2]
FUNCTION_COLUMNS = (
    "id", "area", "scope", "reference", "status", "issue", "code_evidence", "data_evidence",
    "client_evidence", "acceptance", "gaps",
)
DATA_COLUMNS = (
    "id", "kind", "reference", "status", "issue", "source_manifest", "schema_evidence",
    "values_evidence", "relations_evidence", "runtime_evidence", "notes",
)
STATES = {"unassessed", "partial", "blocked", "verified", "deferred"}
SQL_SOURCES = (
    "sql/base/auth_database.sql", "sql/base/characters_database.sql",
    "sql/base/dev/world_database.sql", "sql/base/dev/hotfixes_database.sql",
)
STORE_SOURCES = (
    "src/server/game/DataStores/DBCStores.cpp", "src/server/game/DataStores/DB2Stores.cpp",
)


def reference_inventory(tree):
    inventory = {}
    for path in SQL_SOURCES + STORE_SOURCES:
        source = subprocess.check_output(["git", "-C", str(tree), "show", f"{PIN}:{path}"], text=True)
        if path in SQL_SOURCES:
            database = Path(path).stem.removesuffix("_database")
            names = re.findall(r"CREATE TABLE(?: IF NOT EXISTS)?\s+`([^`]+)`", source)
            entries = [(f"sql:{database}.{name}", "sql-table", name) for name in names]
        else:
            source = re.sub(r"/\*.*?\*/|//[^\n]*", "", source, flags=re.S)
            names = sorted(set(re.findall(r'"(\w+\.(?:dbc|db2))"', source)))
            entries = [(f"client:{name}", name.rsplit(".", 1)[1], name) for name in names]
        if not entries:
            raise ValueError(f"No reference entries found in {path}")
        for key, kind, name in entries:
            if key in inventory:
                raise ValueError(f"Duplicate reference entry: {key}")
            inventory[key] = (kind, f"{PIN}:{path}#{name}")
    return inventory


def read_rows(path, columns):
    with path.open(newline="") as stream:
        reader = csv.DictReader(stream, delimiter="\t")
        if reader.fieldnames != list(columns):
            raise ValueError(f"Wrong columns: {path}")
        rows = list(reader)
    seen = set()
    for row in rows:
        if None in row or any(value is None or not value.strip() for value in row.values()):
            raise ValueError(f"Malformed or empty cell: {path}: {row.get('id')}")
        if row["id"] == "-" or row["id"] in seen:
            raise ValueError(f"Duplicate id: {row['id']}")
        seen.add(row["id"])
        if row["status"] not in STATES:
            raise ValueError(f"Invalid status: {row['id']}")
        if not row["reference"].startswith(PIN + ":"):
            raise ValueError(f"Unpinned reference: {row['id']}")
        if row["status"] == "verified":
            required = ("issue", "acceptance", "code_evidence", "data_evidence", "client_evidence")
            if columns == DATA_COLUMNS:
                required = ("issue", "source_manifest", "schema_evidence", "values_evidence",
                            "relations_evidence", "runtime_evidence")
            missing = [key for key in required if row[key] == "-"]
            if missing:
                raise ValueError(f"Verified row lacks {', '.join(missing)}: {row['id']}")
        if row["status"] in {"blocked", "deferred"}:
            reason = row.get("gaps", row.get("notes"))
            if reason == "-":
                raise ValueError(f"Missing blocked/deferred reason: {row['id']}")
    return rows


def reconcile(rows, inventory, add_missing):
    by_id = {row["id"]: row for row in rows}
    missing = sorted(inventory.keys() - by_id.keys())
    extra = sorted(key for key in by_id if key.startswith(("sql:", "client:")) and key not in inventory)
    if extra:
        raise ValueError(f"Entries absent from pinned reference: {extra}")
    if missing and not add_missing:
        raise ValueError(f"Untracked reference datasets: {missing}")
    for key in missing:
        kind, reference = inventory[key]
        row = dict.fromkeys(DATA_COLUMNS, "-")
        row.update(id=key, kind=kind, reference=reference, status="unassessed",
                   notes="Reference inventory only; AC schema, records, relations, and runtime parity unverified.")
        rows.append(row)
        by_id[key] = row
    for key, (kind, reference) in inventory.items():
        if (by_id[key]["kind"], by_id[key]["reference"]) != (kind, reference):
            raise ValueError(f"Reference changed: {key}")
    return missing


def self_test():
    def must_reject(action):
        try:
            action()
        except ValueError:
            return
        raise AssertionError("Invalid tracker input was accepted")

    row = dict.fromkeys(FUNCTION_COLUMNS, "-")
    row.update(id="demo", area="demo", scope="demo", reference=PIN + ":src/server",
               status="unassessed", acceptance="demo")
    with tempfile.TemporaryDirectory() as directory:
        path = Path(directory) / "tracker.tsv"

        def read_case(rows):
            with path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, FUNCTION_COLUMNS, delimiter="\t", lineterminator="\n")
                writer.writeheader()
                writer.writerows(rows)
            return read_rows(path, FUNCTION_COLUMNS)

        assert read_case([row]) == [row]
        must_reject(lambda: read_case([row, row]))
        for change in ({"status": "verified"}, {"status": "invented"}, {"reference": "master:src/server"},
                       {"scope": ""}, {"status": "blocked"}):
            must_reject(lambda: read_case([row | change]))
        complete = row | {key: "reviewed-proof" for key in
                          ("issue", "code_evidence", "data_evidence", "client_evidence")}
        complete["status"] = "verified"
        assert read_case([complete]) == [complete]

    reference = {"client:Demo.dbc": ("dbc", PIN + ":store#Demo.dbc")}
    rows = []
    must_reject(lambda: reconcile(rows, reference, False))
    assert reconcile(rows, reference, True) == ["client:Demo.dbc"]
    rows[0]["notes"] = "Preserve my assessment"
    assert reconcile(rows, reference, True) == []
    assert rows[0]["notes"] == "Preserve my assessment"
    must_reject(lambda: reconcile(rows, {}, False))
    must_reject(lambda: reconcile(rows, {"client:Demo.dbc": ("db2", "wrong")}, False))
    print("Tracker self-test PASS: invalid proof, duplicate IDs, unpinned refs, and inventory drift rejected.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--reference-tree", type=Path, help="local TrinityCore checkout containing the pinned commit")
    parser.add_argument("--add-missing-data", action="store_true",
                        help="add unassessed reference rows; preserve evidence")
    parser.add_argument("--self-test", action="store_true", help="run synthetic tracker validation checks only")
    args = parser.parse_args()
    if args.self_test:
        if args.reference_tree or args.add_missing_data:
            parser.error("--self-test cannot be combined with reference inventory options")
        self_test()
        return
    if args.add_missing_data and args.reference_tree is None:
        parser.error("--add-missing-data requires --reference-tree")
    function_path = ROOT / "plan/parity-functionality.tsv"
    data_path = ROOT / "plan/parity-data.tsv"
    functions = read_rows(function_path, FUNCTION_COLUMNS)
    data = read_rows(data_path, DATA_COLUMNS)
    if args.reference_tree:
        inventory = reference_inventory(args.reference_tree)
        added = reconcile(data, inventory, args.add_missing_data)
        if added:
            with data_path.open("w", newline="") as stream:
                writer = csv.DictWriter(stream, DATA_COLUMNS, delimiter="\t", lineterminator="\n")
                writer.writeheader()
                writer.writerows(sorted(data, key=lambda row: row["id"]))
            data = read_rows(data_path, DATA_COLUMNS)
        print(f"Pinned SQL-table and client-store inventory: {len(inventory)} entries covered; {len(added)} added.")
    for label, rows in (("Functionality", functions), ("Data", data)):
        print(f"{label}: {len(rows)} rows; {dict(sorted(Counter(row['status'] for row in rows).items()))}")
    print("Tracking structure PASS. This does not verify behavior, data values, or the supplied evidence.")


if __name__ == "__main__":
    try:
        main()
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        raise SystemExit(str(error)) from error
