# Script Features:
collects SQL files for modules into data/sql/custom folder.
stores history of such files for debug purposes in csv in its folder.
reads AC_SQLPARSER_* variables to override CLI config.
renames *.sql files in order to store info that could otherwise be lost during manual collection.
  for example, application order and initial folder structure.
gets invoked over normal CLI.  

# Usage:
```python sqlparser.py -r```

# CLI help:
```
python sqlparser.py      
usage: sqlparser.py [-h] [-d] [-r] [-y] [--glob GLOB] [--source_path SOURCE_PATH] [--target_path TARGET_PATH]
                    [--modules_to_ignore MODULES_TO_IGNORE]

Collect and copy SQL files to new folder, generate report. Skips collecting pulled updates based on report.

options:
  -h, --help            show this help message and exit
  -d, --dry_run         Simulate without changes (default: False)
  -r, --run             Run (default: False)
  -y, --force           Run without confirmation (default: False)
  --glob GLOB           glob pattern to find scripts (default: **/sql/**/*.sql)
  --source_path SOURCE_PATH
                        location of modules folder, relative to repo (default: modules)
  --target_path TARGET_PATH
                        location of target folder, relative to repo (default: data/sql/custom)
  --modules_to_ignore MODULES_TO_IGNORE
                        list of modules to ignore (default: ['mod-playerbots'])
```
# override CLI with env example:
```export AC_SQLPARSE_SOURCE_PATH=very_different_modules; python sqlparser.py```

# Linters and checkers
I use black and mypy to check this code without customization.
I do not imply any requirements on further editors of this code.
Example of invocation:
```
black sqlparser.py
mypy sqlparser.py
```

# list of work in progress, related to PR comments:  
- [x] readme.md:
    - [x] comment on lints and checks
- [x] remove globals
- [x] remove hardcoded path
- [x] remove if collected from main
- [x] rename parameter in get_db_name
- [x] docstrings
- [x] run mypy to control type safety
- [x] improve readability
- [x] remove default args in argparsed
- [x] explain filepath reading
- [x] change arguments, define --dry-run option
- [x] env variables -> argparse
- [ ] decide and implement docker-compose interaction



