import argparse
import shutil
import csv
import sys
import os

from datetime import datetime
from pathlib import Path
from collections import Counter


def collect_sql_files(
    full_filepath: Path,
    source_dir: Path,
    target_dir: Path,
    counter: dict,
    dry: bool = False,
    files_to_ignore: list[Path|str] | None = None,
    modules_to_ignore: list[str] | None = None,
):
    """
    collects a file from full_filepath.
    updates counter.
    prints action taken.
    picks up some info from script's filepath:
        assumed [filepath] structure:
            [module]/*/sql/[database]/[*other_folders]/[filename].sql
    output file path:
        [target_dir]/[database]/[module]_[counter['written']]_[*other_folders]_[filename].sql
    Returns:
        dict, a row for report.
    """

    def get_db_name(db_name_to_parse: str) -> Path:
        if db_name_to_parse.startswith("db"):
            # assumes db_*.sql or db-*.sql filename
            db_name_to_parse = db_name_to_parse[3:]
        return Path(f"db_{db_name_to_parse}")

    filepath = full_filepath.relative_to(source_dir)

    module = filepath.parents[-2]
    path_to_parse = filepath.parts[filepath.parts.index("sql") + 1 :]
    database = get_db_name(path_to_parse[0])
    other_folders = "".join(path_to_parse[1:-1])

    fp_out = database / f"{module}_{counter['written']}_{other_folders}_{filepath.parts[-1]}"

    target_file = target_dir / fp_out

    if files_to_ignore and str(filepath) in files_to_ignore:
        counter["skipped"] += 1
        print(f"skipped existing module:{module} name:{fp_out} ")
        return
    elif modules_to_ignore and str(module) in modules_to_ignore:
        counter["skipped"] += 1
        print(f"skipped ignored module:{module} name:{fp_out} ")
        return

    if not dry:
        # required by shutil.copy2
        target_file.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(full_filepath, target_file)

    result = dict(
        index=counter["total"],
        module_index=counter["modules"][str(module)],
        module=module,
        database=database,
        applied=datetime.now().isoformat(timespec="seconds"),
        fp_in=filepath,
        fp_out=fp_out,
        target_dir=target_dir,
    )
    counter["written"] += 1
    counter["total"] += 1
    counter["modules"][str(module)] += 1
    print(f"parsed module:{module} name:{fp_out} ")
    return result


def write_report(data: list[dict], report_dir):
    """Dump report to csv"""
    data = [e for e in data if e is not None]
    if not data:
        return
    with report_dir.open("w") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)


def read_report(report_dir: Path):
    """
    Reads csv report
    Returns:
        report:list[dict] for debugging
        files_to_ignore:list of already parsed files
        counter:Counter with report stats
    """
    counter: dict = Counter(dict(written=0, skipped=0, total=0, modules=Counter()))

    if not report_dir.exists():
        return None, None, counter

    with report_dir.open() as csvfile:
        reader = csv.DictReader(csvfile)
        report = list(reader)

    counter["total"] = len(report)

    files_to_ignore = []
    for e in report:
        files_to_ignore.append(e["fp_in"])
        counter["modules"][e["module"]] += 1
    return report, files_to_ignore, counter


def main(
    dry_run: bool = False,
    glob: str = "**/sql/**/*.sql",
    modules_to_ignore: list = ["mod-playerbots"],
    repo_folder: Path | str = Path(__file__).parents[2],
    source_path: Path | str = "modules",
    target_path: Path | str = "data/sql/custom",
    report_path: Path | str = "apps/sqlparser/modules_sql_parsed.csv",
    **kwargs,
):
    """control flow for the whole script"""
    repo_folder = Path(repo_folder)
    source_dir = repo_folder / source_path
    target_dir = repo_folder / target_path
    report_dir = repo_folder / report_path

    report, files_to_ignore, counter = read_report(report_dir)
    ## implied folder structure: modules/*/sql/dbname/*/*.sql
    report = [
        collect_sql_files(
            e,
            source_dir,
            target_dir,
            counter,
            dry_run,
            files_to_ignore,
            modules_to_ignore,
        )
        for e in source_dir.glob(glob)
    ]
    if not dry_run:
        write_report(report, report_dir)

    print("report stats", counter)


def argparsed(default_args=["--help"]):
    """wrap main function for CLI invocation"""
    parser = argparse.ArgumentParser(
        description="""
        Collect and copy SQL files to new folder, generate report. 
        Skips collecting pulled updates based on report.""",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("-d", "--dry_run", action="store_true", help="Simulate without changes")
    parser.add_argument("-r", "--run", action="store_true", help="Run")
    parser.add_argument("-y", "--force", action="store_true", help="Run without confirmation")

    main_params = dict(
        glob=dict(help="glob pattern to find scripts", default="**/sql/**/*.sql"),
        source_path=dict(help="location of modules folder, relative to repo", default="modules"),
        target_path=dict(
            help="location of target folder, relative to repo", default="data/sql/custom"
        ),
        modules_to_ignore=dict(help="list of modules to ignore", default=["mod-playerbots"]),
    )
    for k, v in main_params.items():
        parser.add_argument(f"--{k}", **v)

    args = parser.parse_args(args=None if sys.argv[1:] else default_args)

    if args.run or args.force or args.dry_run:
        if args.run:
            prompt = "This script will copy SQL files. are you sure? [y/N]\n"
            if input(prompt).lower() != "y":
                print("Aborting")
                return
        kwargs = {
            e: os.getenv(f"AC_SQLPARSER_{e.upper()}", getattr(args, e)) for e in main_params.keys()
        }
        kwargs = {k: v for k, v in kwargs.items() if v is not None}

        main(**kwargs)


if __name__ == "__main__":
    argparsed()
