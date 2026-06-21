"""Load/save authoring projects as ``.invasion`` JSON files."""

from __future__ import annotations

import json
from pathlib import Path

from .model import Project


def save_project(project: Project, path: str | Path) -> None:
    Path(path).write_text(json.dumps(project.to_dict(), indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def load_project(path: str | Path) -> Project:
    data = json.loads(Path(path).read_text(encoding="utf-8"))
    return Project.from_dict(data)
