import argparse
import shutil
import csv
import sys

from datetime import datetime
from pathlib import Path
from collections import Counter

# constants, can be overriden using arguments

## implied folder structure: modules/*/sql/dbname/*/*.sql
glob = "**/sql/**/*.sql"

repo_folder = Path("/Users/v0/Py/_hobby/wow/server")

source_suffix = "modules"
source_dir = lambda: repo_folder / source_suffix
target_suffix = "data/sql/custom"
target_dir = lambda: repo_folder / target_suffix
report_suffix = "modules_sql_parsed.csv"
report_path = lambda: repo_folder / report_suffix


counters = dict(
    written=0, skipped=0, total=0, modules=Counter()  # module: counter
)


def get_db_name(arg):
    if arg.startswith("db"):
        # assumes db_*.sql or db-*.sql filename
        arg = arg[3:]
    return f"db_{arg}"


def collect_sql_files(full_fp, files_to_ignore=None, dry=False):
    # fp means filepath
    global counters

    fp = full_fp.relative_to(source_dir())

    module = fp.parents[-2]
    path_to_parse = fp.parts[fp.parts.index("sql") + 1 :]
    database = get_db_name(path_to_parse[0])
    other_folders = "".join(path_to_parse[1:-1])

    target_file = (
        target_dir()
        / database
        / f"{module}_{counters['written']}_{other_folders}_{fp.parts[-1]}"
    )
    fp_out = target_file.relative_to(target_dir())

    if files_to_ignore and str(fp) in files_to_ignore:
        counters["skipped"] += 1
        print(f"skipped existing module:{module} name:{fp_out} ")
        return

    if not dry:
        # required by shutil.copy2
        target_file.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(full_fp, target_file)

    result = dict(
        index=counters["total"],
        module_index=counters["modules"][str(module)],
        module=module,
        database=database,
        applied=datetime.now().isoformat(timespec="seconds"),
        fp_in=fp,
        fp_out=fp_out,
        target_dir=target_dir(),
    )
    counters["written"] += 1
    counters["total"] += 1
    counters["modules"][str(module)] += 1
    print(f"parsed module:{module} name:{fp_out} ")
    return result


def write_report(data):
    with report_path().open("w") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)


def read_report():
    # reads report, updates counters, returns report and files_to_ignore
    global counters
    if not report_path().exists():
        return None, None

    with report_path().open() as csvfile:
        reader = csv.DictReader(csvfile)
        report = list(reader)

    counters["total"] = len(report)

    files_to_ignore = []
    for e in report:
        files_to_ignore.append(e["fp_in"])
        counters["modules"][e["module"]] += 1

    return report, files_to_ignore


def main(dry=False):
    report, files_to_ignore = read_report()
    collected = [
        collect_sql_files(e, files_to_ignore, dry)
        for e in source_dir().glob(glob)
    ]
    collected = [e for e in collected if e is not None]
    if not dry and collected:
        write_report(collected)

    print("report stats", counters)


def argparsed():
    global glob, repo_folder, source_suffix, target_suffix, report_suffix

    default = ["--help"]
    # default = "-y", "", "--glob", "test"
    parser = argparse.ArgumentParser(
        description="Collect and copy SQL files to new folder, generate report. Skips collecting pulled updates based on report."
    )
    parser.add_argument(
        "option",
        nargs="?",
        choices=["dry-run", "run", None],
        help="Simulate without changes OR run parser",
    )
    parser.add_argument("-y", nargs="?", help="Run without confirmation")

    globals_to_parse = [
        ["glob", "glob pattern to find scripts"],
        ["repo_folder", "repository folder"],
        ["source_suffix", "location of modules folder, appends to repo_folder"],
        ["target_suffix", "location of target folder, appends to repo_folder"],
        ["report_suffix", "location of module results, appends to repo_folder"],
    ]

    for e in globals_to_parse:
        parser.add_argument(f"--{e[0]}", help=e[1])

    args = parser.parse_args(args=None if sys.argv[1:] else default)

    if args.option == "run":
        prompt = "This script will copy SQL files. are you sure? [y/N]\n"
        if input(prompt).lower() != "y":
            print("Aborting")
            return
    elif args.option == "--help":
        return
    for e in globals_to_parse:
        value = getattr(args, e[0])
        if value:
            globals()[e[0]] = value

    main(args.option == "dry-run")


if __name__ == "__main__":
    argparsed()
