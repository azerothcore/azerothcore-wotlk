#!/usr/bin/env python3
"""Run the isolated Plan 7 build-15595 real-client authentication proof."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import secrets
import shutil
import signal
import socket
import subprocess
import sys
import tempfile
import time
from typing import Literal, TypedDict
import uuid


REPO_ROOT = Path(__file__).resolve().parents[2]
MYSQL_IMAGE = "mysql:8.4"
DATABASE_CACHE_VERSION = 1
CLIENT_BUILD = 15595
CLIENT_SHA256 = "0ea9cc0458cb137f4e0767e8a1896e2042480a4a22397480d7ee64c2e696192a"
ACCOUNT = "PLAN6USER"
PASSWORD = "PLAN6PASS"
ACCOUNT_ID = 900000
REALM_ID = 42
AUTH_PORT = 3724
WRITABLE_CLIENT_DIRS = ("WTF", "Cache", "Logs", "Errors", "Screenshots")
SRP_N = int("894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7", 16)
SRP_G = 7
DEFAULT_MIGRATION = REPO_ROOT / "data/sql/updates/pending_db_auth/rev_1786964293354831242.sql"
DEFAULT_FIXTURE = REPO_ROOT / "apps/cata/fixtures/plan7-client-authentication.json"
PLAN6_RUNNER = REPO_ROOT / "apps/cata/run_authentication_handoff.py"
DATABASE_SQL_DIRECTORIES = tuple(
    (f"{kind}-{database}", REPO_ROOT / f"data/sql/{kind}/db_{database}")
    for kind in ("base", "updates") for database in ("auth", "characters", "world")
)

State = Literal[
    "allocating", "prepared", "servers_ready", "client_running", "observed", "accepted",
    "failed", "inconclusive", "replayed", "reset",
]


class ProcessIdentity(TypedDict, total=False):
    kind: str
    pid: int
    start_ticks: int
    boot_id: str
    exe: str
    cmdline: list[str]
    cwd: str
    config: str
    prefix: str
    process_group: int
    session: int
    active: bool


class Generation(TypedDict, total=False):
    number: int
    mode: str
    state: State
    completed_state: str
    root: str
    prefix: str
    ports: dict[str, int]
    docker: dict[str, str | None]
    schemas: dict[str, str]
    processes: list[ProcessIdentity]
    inputs: dict[str, object]
    paths: dict[str, str]
    released_updates: dict[str, list[str]]
    database_cache: dict[str, str]
    evidence: dict[str, object] | None
    failure: dict[str, str] | None
    isolation_unchanged: bool
    replay_passed: bool


class Manifest(TypedDict, total=False):
    version: int
    run_id: str
    repo_commit: str
    root: str
    mysql_root_password: str
    mysql_user: str
    mysql_password: str
    baseline: dict[str, object]
    client_base: dict[str, object]
    database_cache: dict[str, object]
    generations: list[Generation]


TRANSITIONS: dict[str, set[str]] = {
    "allocating": {"prepared", "failed", "inconclusive", "reset"},
    "prepared": {"servers_ready", "failed", "inconclusive", "reset"},
    "servers_ready": {"client_running", "failed", "inconclusive", "reset"},
    "client_running": {"observed", "failed", "inconclusive", "reset"},
    "observed": {"accepted", "failed", "inconclusive", "reset"},
    "accepted": {"replayed", "failed", "inconclusive", "reset"},
    "failed": {"reset"},
    "inconclusive": {"reset"},
    "replayed": {"reset"},
    "reset": set(),
}

CLIENT_MILESTONES = (
    ("auth_login_ok", re.compile(r"LOGIN_STATE_AUTHENTICATED.*LOGIN_OK", re.IGNORECASE)),
    ("world_connected", re.compile(r"COP_CONNECT.*RESPONSE_CONNECTED.*TRUE", re.IGNORECASE)),
    ("world_auth_ok", re.compile(r"COP_AUTHENTICATE.*AUTH_OK.*TRUE", re.IGNORECASE)),
    ("characters_started", re.compile(r"Initiating: COP_GET_CHARACTERS", re.IGNORECASE)),
)
CHARACTER_MILESTONES = CLIENT_MILESTONES[:3] + (
    ("characters_completed", re.compile(r"Completed: COP_GET_CHARACTERS.*TRUE", re.IGNORECASE)),
)
FORBIDDEN_CHARACTER_OPCODES = frozenset({
    "CMSG_CHAR_CREATE", "CMSG_CHAR_DELETE", "CMSG_CHAR_CUSTOMIZE", "CMSG_CHAR_FACTION_CHANGE",
    "CMSG_CHAR_RACE_CHANGE", "CMSG_CHAR_RENAME", "CMSG_PLAYER_LOGIN",
})
EMPTY_CHARACTER_ENUM_PAYLOAD = "000001000000"
POPULATED_CHARACTER_ENUM_PAYLOAD = (
    "0000010000C08046000100000000000000000000000000000000000000000000000000000000000000000000000000000000"
    "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    "000000000000000000000000000000000000000000070000000000000000000000000000F90FA7420000000000357E04C300"
    "000000000043617461706C616E000503CDD70BC6000101020C000000"
)
POPULATED_MODE = "populated-character-list"
CHARACTER_SELECTION_MODE = "character-selection"
INITIAL_POST_LOAD_PACKETS_MODE = "initial-post-load-packets"
MAP_INSERTION_MODE = "map-insertion-object-bootstrap"
IN_WORLD_CONTROL_MODE = "in-world-control-bootstrap"
POPULATED_CHARACTER_MODES = frozenset({
    POPULATED_MODE, CHARACTER_SELECTION_MODE, INITIAL_POST_LOAD_PACKETS_MODE, MAP_INSERTION_MODE,
    IN_WORLD_CONTROL_MODE,
})
CHARACTER_MODES = frozenset({"character-screen", *POPULATED_CHARACTER_MODES})
CHARACTER_GUID = 0x01020304
CHARACTER_NAME = "Cataplan"
CHARACTER_LIST_POSITION = 7
CHARACTER_POSITION = (-8949.95, -132.493, 83.5312)
CHARACTER_RACE = 1
CHARACTER_CLASS = 1
CHARACTER_MAP = 0
CHARACTER_ZONE = 12


def plan_number(mode: str) -> str:
    if mode == IN_WORLD_CONTROL_MODE:
        return "13"
    if mode == MAP_INSERTION_MODE:
        return "12"
    if mode == INITIAL_POST_LOAD_PACKETS_MODE:
        return "11"
    if mode == CHARACTER_SELECTION_MODE:
        return "10"
    if mode == POPULATED_MODE:
        return "9"
    return "8" if mode == "character-screen" else "7"


def run_command(
    args: list[str], *, input_bytes: bytes | None = None, check: bool = True,
    timeout: int = 120, env: dict[str, str] | None = None,
) -> subprocess.CompletedProcess[bytes]:
    result = subprocess.run(
        args, input=input_bytes, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False,
        timeout=timeout, env=env,
    )
    if check and result.returncode:
        stderr = result.stderr.decode(errors="replace").strip()
        stdout = result.stdout.decode(errors="replace").strip()
        raise RuntimeError(f"{args[0]} failed with exit {result.returncode}: {stderr or stdout}")
    return result


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def database_cache_key(image_id: str, directories: tuple[tuple[str, Path], ...]) -> str:
    digest = hashlib.sha256(f"plan7-database-cache-v{DATABASE_CACHE_VERSION}\0{image_id}\0".encode())
    for label, directory in directories:
        paths = sorted(directory.glob("*.sql"))
        if not paths:
            raise RuntimeError(f"SQL directory contains no files: {directory}")
        for path in paths:
            digest.update(f"{label}/{path.name}\0".encode())
            digest.update(bytes.fromhex(sha256(path)))
    return digest.hexdigest()


def srp_registration(username: str, password: str, salt: bytes) -> bytes:
    identity = hashlib.sha1(f"{username}:{password}".encode()).digest()
    exponent = int.from_bytes(hashlib.sha1(salt + identity).digest(), "little")
    return pow(SRP_G, exponent, SRP_N).to_bytes(32, "little")


def tree_metadata(path: Path) -> str | None:
    if not path.exists():
        return None
    digest = hashlib.sha256()
    paths = [path]
    if path.is_dir():
        paths.extend(sorted(path.rglob("*")))
    for entry in paths:
        stat = entry.lstat()
        relative = "." if entry == path else entry.relative_to(path).as_posix()
        digest.update(
            f"{relative}\0{stat.st_mode}\0{stat.st_uid}\0{stat.st_gid}\0{stat.st_size}\0"
            f"{stat.st_ino}\0{stat.st_mtime_ns}\0{stat.st_ctime_ns}\n".encode()
        )
    return digest.hexdigest()


def tree_content_hash(path: Path) -> str:
    if not path.is_dir():
        raise RuntimeError(f"data directory is absent: {path}")
    digest = hashlib.sha256()
    files = sorted(item for item in path.rglob("*") if item.is_file())
    if not files:
        raise RuntimeError(f"data directory contains no files: {path}")
    for item in files:
        relative = item.relative_to(path).as_posix()
        digest.update(f"{relative}\0{item.stat().st_size}\0".encode())
        digest.update(bytes.fromhex(sha256(item)))
    return digest.hexdigest()


def docker_inventory() -> dict[str, list[str]]:
    containers = run_command(
        ["docker", "ps", "-a", "--no-trunc", "--format", "{{.ID}} {{.Names}}"],
    ).stdout.decode().splitlines()
    volumes = run_command(["docker", "volume", "ls", "--format", "{{.Name}}"]).stdout.decode().splitlines()
    return {"containers": sorted(containers), "volumes": sorted(volumes)}


def unused_port() -> int:
    with socket.socket() as probe:
        probe.bind(("127.0.0.1", 0))
        return int(probe.getsockname()[1])


def require_unused(port: int) -> None:
    with socket.socket() as probe:
        probe.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        try:
            probe.bind(("127.0.0.1", port))
        except OSError as error:
            raise RuntimeError(f"loopback port {port} is already in use") from error


def nearest_existing_parent(path: Path) -> Path:
    current = path.resolve()
    while not current.exists():
        if current.parent == current:
            raise RuntimeError(f"no existing parent for {path}")
        current = current.parent
    return current


def require_external_root(path: Path) -> Path:
    resolved = path.resolve()
    if resolved == REPO_ROOT or REPO_ROOT in resolved.parents:
        raise RuntimeError("the Plan 7 run root must be outside the Git worktree")
    if resolved == Path("/") or resolved == Path.home().resolve():
        raise RuntimeError(f"refusing broad run root: {resolved}")
    return resolved


def load_manifest(path: Path) -> Manifest:
    if not path.is_file():
        raise RuntimeError(f"manifest does not exist: {path}")
    value = json.loads(path.read_text())
    if value.get("version") != 1 or not isinstance(value.get("generations"), list):
        raise RuntimeError("unsupported or malformed Plan 7 manifest")
    if Path(value["root"]).resolve() != path.parent.resolve():
        raise RuntimeError("manifest root does not match its parent directory")
    return value


def save_manifest(path: Path, manifest: Manifest) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.{os.getpid()}.tmp")
    descriptor = os.open(temporary, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    try:
        with os.fdopen(descriptor, "w") as handle:
            json.dump(manifest, handle, indent=2, sort_keys=True)
            handle.write("\n")
            handle.flush()
            os.fsync(handle.fileno())
        os.replace(temporary, path)
        os.chmod(path, 0o600)
    finally:
        temporary.unlink(missing_ok=True)


def active_generation(manifest: Manifest) -> Generation:
    generations = manifest.get("generations", [])
    if not generations:
        raise RuntimeError("manifest has no generation")
    return generations[-1]


def set_state(generation: Generation, new_state: State) -> None:
    old_state = generation["state"]
    if new_state not in TRANSITIONS[old_state]:
        raise RuntimeError(f"invalid Plan 7 state transition: {old_state} -> {new_state}")
    generation["state"] = new_state


def record_failure(manifest_path: Path, manifest: Manifest, error: BaseException) -> None:
    generation = active_generation(manifest)
    generation["failure"] = {"phase": generation["state"], "message": str(error)}
    if generation["state"] not in ("failed", "inconclusive", "reset"):
        set_state(generation, "failed")
    save_manifest(manifest_path, manifest)


def copy_tree(source: Path, destination: Path) -> None:
    if destination.exists():
        raise RuntimeError(f"copy destination already exists: {destination}")
    shutil.copytree(source, destination, symlinks=False, copy_function=shutil.copy2)


def make_tree_read_only(path: Path) -> None:
    for entry in (path, *path.rglob("*")):
        if not entry.is_symlink():
            entry.chmod(entry.stat().st_mode & ~0o222)


def make_tree_writable(path: Path) -> None:
    for entry in (path, *path.rglob("*")):
        if not entry.is_symlink():
            entry.chmod(entry.stat().st_mode | 0o200)


def link_client_base(base: Path, destination: Path) -> None:
    if destination.exists():
        raise RuntimeError(f"client link destination already exists: {destination}")
    destination.mkdir()
    for entry in base.iterdir():
        if entry.name == "Data":
            link_client_data(entry, destination / entry.name)
            continue
        if entry.name not in WRITABLE_CLIENT_DIRS:
            (destination / entry.name).symlink_to(entry, target_is_directory=entry.is_dir())
    for name in WRITABLE_CLIENT_DIRS:
        (destination / name).mkdir()


# Data/Cache is writable: the client rewrites SoundCache-*.MPQ there at runtime. It has
# to be a real local directory, never a symlink to the protected source tree -- otherwise
# the client writes its sound cache straight back into the user's real installation, which
# both violates the isolation contract and trips the protected-tree guard on the next
# prepare. WRITABLE_CLIENT_DIRS covers the top-level Cache dir; this covers Data/Cache.
WRITABLE_CLIENT_DATA_DIRS = ("Cache",)


def link_client_data(source: Path, destination: Path) -> None:
    destination.mkdir()
    for entry in source.iterdir():
        if entry.name == "enUS" or entry.name in WRITABLE_CLIENT_DATA_DIRS:
            continue
        (destination / entry.name).symlink_to(entry, target_is_directory=entry.is_dir())

    for name in WRITABLE_CLIENT_DATA_DIRS:
        (destination / name).mkdir(exist_ok=True)

    locale_source = source / "enUS"
    locale_destination = destination / "enUS"
    locale_destination.mkdir()
    for entry in locale_source.iterdir():
        if entry.name != "realmlist.wtf":
            (locale_destination / entry.name).symlink_to(entry, target_is_directory=entry.is_dir())


def write_client_config(client: Path) -> None:
    (client / "Logs").mkdir(exist_ok=True)
    (client / "WTF").mkdir(exist_ok=True)
    (client / "WTF/Config.wtf").write_text(
        'SET locale "enUS"\nSET realmlist "127.0.0.1"\nSET patchlist "127.0.0.1"\n'
        'SET readTOS "1"\nSET readEULA "1"\nSET movie "0"\nSET playIntroMovie "0"\nSET accounttype "CT"\n'
        'SET gxWindow "1"\nSET gxMaximize "0"\n'
    )


def install_dxvk(generation: Generation) -> None:
    inputs = generation["inputs"]
    source = Path(str(inputs.get("dxvk_d3d9") or (
        Path(str(inputs["wine_runner"])) / "lib/wine/dxvk/x86_64-windows/d3d9.dll"
    )))
    if not source.is_file():
        raise RuntimeError(f"installed Wine runner has no bundled DXVK d3d9.dll: {source}")
    destination = Path(generation["paths"]["client"]) / "d3d9.dll"
    if destination.is_symlink():
        destination.unlink()
    destination.unlink(missing_ok=True)
    shutil.copy2(source, destination)


def ensure_client_base(manifest: Manifest, generation: Generation) -> None:
    client = Path(generation["paths"]["client"])
    source = Path(str(generation["inputs"]["client_root"]))
    executable = client / "Wow-64.exe"
    if not executable.is_symlink() or executable.resolve() != source / "Wow-64.exe":
        raise RuntimeError("run client is not the expected read-only source-client symlink overlay")


def require_owned_path(path: Path, generation: Generation) -> Path:
    resolved = path.resolve()
    root = Path(generation["root"]).resolve()
    if resolved == root or root not in resolved.parents:
        raise RuntimeError(f"refusing path outside owned generation: {resolved}")
    return resolved


def remove_owned_path(path: Path, generation: Generation) -> None:
    resolved = require_owned_path(path, generation)
    if resolved.is_dir() and not resolved.is_symlink():
        shutil.rmtree(resolved)
    else:
        resolved.unlink(missing_ok=True)


def container_details(name: str) -> dict:
    result = run_command(["docker", "inspect", name], check=False)
    if result.returncode:
        raise RuntimeError(f"owned container is absent: {name}")
    return json.loads(result.stdout)[0]


def assert_container_owned(manifest: Manifest, generation: Generation, schema: str | None = None) -> dict:
    docker = generation["docker"]
    details = container_details(str(docker["container"]))
    labels = details["Config"].get("Labels") or {}
    expected = {
        "org.azerothcore.plan": plan_number(str(generation["mode"])),
        "org.azerothcore.run_id": manifest["run_id"],
        "org.azerothcore.generation": str(generation["number"]),
    }
    if details["Id"] != docker["container_id"]:
        raise RuntimeError("owned MySQL container ID changed")
    if any(labels.get(key) != value for key, value in expected.items()):
        raise RuntimeError("owned MySQL container labels changed")
    binding = details["NetworkSettings"]["Ports"].get("3306/tcp")
    mysql_port = generation["ports"]["mysql"]
    if not binding or binding[0]["HostIp"] != "127.0.0.1" or int(binding[0]["HostPort"]) != mysql_port:
        raise RuntimeError("owned MySQL loopback binding changed")
    volumes = {mount["Name"] for mount in details["Mounts"] if mount["Type"] == "volume"}
    if volumes != {docker["volume"]}:
        raise RuntimeError("owned MySQL volume attachment changed")
    image_id = generation.get("inputs", {}).get("mysql_image_id")
    if image_id and details["Image"] != image_id:
        raise RuntimeError("owned MySQL container image changed")
    if schema is not None and schema not in generation["schemas"].values():
        raise RuntimeError(f"refusing unowned schema: {schema}")
    return details


def mysql(
    manifest: Manifest, generation: Generation, sql: str | bytes, schema: str | None = None,
    timeout: int = 600,
) -> str:
    assert_container_owned(manifest, generation, schema)
    command = [
        "docker", "exec", "-i", str(generation["docker"]["container"]), "mysql", "--batch",
        "--skip-column-names", "-uroot", f"-p{manifest['mysql_root_password']}",
    ]
    if schema:
        command.extend(["-D", schema])
    payload = sql.encode() if isinstance(sql, str) else sql
    return run_command(command, input_bytes=payload, timeout=timeout).stdout.decode().rstrip("\n")


def populated_character_seed_sql() -> str:
    x, y, z = CHARACTER_POSITION
    return (
        f"DELETE FROM `characters` WHERE `account`={ACCOUNT_ID} OR `guid`={CHARACTER_GUID} "
        f"OR `name`='{CHARACTER_NAME}';"
        # `health` must be seeded non-zero. Player::LoadFromDB restores it verbatim via
        # SetHealth(savedHealth), so leaving it at the column default of 0 loads the
        # character with no health -- the client then receives a 0/0-HP player in its own
        # CREATE_OBJECT2 block and never completes world entry (permanent 90% loading
        # screen). Seeded larger than any level-1 pool; LoadFromDB clamps to GetMaxHealth(),
        # so this simply means "spawn at full health".
        "INSERT INTO `characters` "
        "(`guid`,`account`,`name`,`race`,`class`,`gender`,`level`,`skin`,`face`,`hairStyle`,`hairColor`,"
        "`facialStyle`,`playerFlags`,`position_x`,`position_y`,`position_z`,`map`,`orientation`,`taximask`,"
        "`at_login`,`zone`,`extra_flags`,`equipmentCache`,`exploredZones`,`knownTitles`,`order`,`innTriggerId`,"
        # `cinematic`=1 marks the intro cinematic as already seen. Left at the 0 default the
        # server sends SMSG_TRIGGER_CINEMATIC just before SMSG_LOGIN_VERIFY_WORLD (matching
        # TrinityCore's `if (!getCinematic())` gate), and the real client parks in cinematic
        # mode: it never answers with CMSG_COMPLETE_CINEMATIC or CMSG_NEXT_CINEMATIC_CAMERA,
        # never reaches the normal in-world state, and so never sends CMSG_TIME_SYNC_RESP --
        # while still servicing every other opcode, which makes it look like a loading hang.
        # The cinematic path is not what this harness exercises, so skip it.
        "`health`,`cinematic`) "
        f"VALUES ({CHARACTER_GUID},{ACCOUNT_ID},'{CHARACTER_NAME}',{CHARACTER_RACE},{CHARACTER_CLASS},0,1,0,0,0,0,0,0,"
        f"{x},{y},{z},{CHARACTER_MAP},0,'',0,{CHARACTER_ZONE},0,'','','',{CHARACTER_LIST_POSITION},0,10000,1);"
    )


def verify_populated_character_seed(manifest: Manifest, generation: Generation) -> dict[str, object]:
    x, y, z = CHARACTER_POSITION
    matches = mysql(
        manifest, generation,
        "SELECT COUNT(*) FROM `characters` WHERE "
        f"`guid`={CHARACTER_GUID} AND `account`={ACCOUNT_ID} AND `name`='{CHARACTER_NAME}' "
        f"AND `race`={CHARACTER_RACE} AND `class`={CHARACTER_CLASS} AND `gender`=0 AND `level`=1 "
        "AND `skin`=0 AND `face`=0 AND `hairStyle`=0 AND `hairColor`=0 AND `facialStyle`=0 "
        f"AND ABS(`position_x`-({x}))<0.001 AND ABS(`position_y`-({y}))<0.001 "
        f"AND ABS(`position_z`-({z}))<0.001 AND `map`={CHARACTER_MAP} AND `zone`={CHARACTER_ZONE} AND `orientation`=0 "
        "AND `playerFlags`=0 AND `at_login`=0 AND `extra_flags`=0 AND COALESCE(`order`,0)=7 "
        "AND `taximask`='' AND `innTriggerId`=0 AND `equipmentCache`='' AND `exploredZones`='' "
        "AND `knownTitles`='' AND `cinematic`=1 AND `deleteDate` IS NULL;",
        generation["schemas"]["characters"],
    )
    if matches != "1":
        raise RuntimeError(f"owned populated character seed matched {matches!r} rows instead of one")
    return {
        "guid_low": CHARACTER_GUID, "name": CHARACTER_NAME, "race": CHARACTER_RACE,
        "class": CHARACTER_CLASS, "gender": 0,
        "level": 1, "map": CHARACTER_MAP, "zone": CHARACTER_ZONE,
        "list_position": CHARACTER_LIST_POSITION,
        "flags": 0, "flags2": 0, "visual_items_nonzero": 0,
    }


def verify_populated_character_identity(manifest: Manifest, generation: Generation) -> dict[str, object]:
    matches = mysql(
        manifest, generation,
        "SELECT COUNT(*) FROM `characters` WHERE "
        f"`guid`={CHARACTER_GUID} AND `account`={ACCOUNT_ID} AND `name`='{CHARACTER_NAME}' "
        "AND `deleteDate` IS NULL;",
        generation["schemas"]["characters"],
    )
    if matches != "1":
        raise RuntimeError(f"owned selected character matched {matches!r} rows instead of one")
    return {
        "guid_low": CHARACTER_GUID, "name": CHARACTER_NAME, "race": CHARACTER_RACE,
        "class": CHARACTER_CLASS, "gender": 0,
        "level": 1, "map": CHARACTER_MAP, "zone": CHARACTER_ZONE,
        "list_position": CHARACTER_LIST_POSITION,
        "flags": 0, "flags2": 0, "visual_items_nonzero": 0,
    }


def realm_character_count(manifest: Manifest, generation: Generation) -> int:
    output = mysql(
        manifest, generation,
        f"SELECT `numchars` FROM `realmcharacters` WHERE `realmid`={REALM_ID} AND `acctid`={ACCOUNT_ID};",
        generation["schemas"]["auth"],
    )
    try:
        return int(output)
    except ValueError as error:
        raise RuntimeError(f"owned auth database returned an invalid realm character count: {output!r}") from error


def import_sql_directory(
    manifest: Manifest, generation: Generation, directory: Path, schema: str,
) -> None:
    paths = sorted(directory.glob("*.sql"))
    if not paths:
        raise RuntimeError(f"SQL base directory contains no files: {directory}")
    for path in paths:
        mysql(manifest, generation, path.read_bytes(), schema)


def apply_released_updates(
    manifest: Manifest, generation: Generation, directory: Path, schema: str,
) -> list[str]:
    applied = set(mysql(manifest, generation, "SELECT `name` FROM `updates`;", schema).splitlines())
    added = []
    for path in sorted(directory.glob("*.sql")):
        if path.name in applied:
            continue
        contents = path.read_bytes()
        mysql(manifest, generation, contents, schema)
        file_hash = hashlib.sha1(contents).hexdigest().upper()
        mysql(
            manifest, generation,
            "INSERT INTO `updates` (`name`,`hash`,`state`,`speed`) "
            f"VALUES ('{path.name}','{file_hash}','RELEASED',0);",
            schema,
        )
        added.append(path.name)
    return added


def wait_for_mysql(manifest: Manifest, generation: Generation) -> None:
    deadline = time.monotonic() + 90
    ready_since: float | None = None
    while time.monotonic() < deadline:
        result = run_command(
            [
                "docker", "exec", str(generation["docker"]["container"]), "mysql", "--batch",
                "--skip-column-names", "-uroot", f"-p{manifest['mysql_root_password']}",
                "-e", "SELECT 1;",
            ],
            check=False,
        )
        if result.returncode == 0 and result.stdout.strip() == b"1":
            if ready_since is None:
                ready_since = time.monotonic()
            elif time.monotonic() - ready_since >= 1:
                return
        else:
            ready_since = None
        time.sleep(0.25)
    raise RuntimeError("owned MySQL did not become ready within 90 seconds")


def database_cache_path(manifest: Manifest) -> Path:
    return Path(manifest["root"]) / "database-cache.sql"


def database_cache_staging_path(manifest: Manifest) -> Path:
    return Path(manifest["root"]) / ".database-cache.sql.building"


def remove_database_cache_files(manifest: Manifest) -> None:
    for path in (database_cache_path(manifest), database_cache_staging_path(manifest)):
        if path.is_symlink():
            raise RuntimeError(f"refusing symlinked database cache path: {path}")
        path.unlink(missing_ok=True)


def reconcile_database_cache(manifest_path: Path, manifest: Manifest, key: str) -> Path | None:
    record = manifest.get("database_cache")
    if not record:
        return None
    path = Path(str(record["path"]))
    if path != database_cache_path(manifest):
        raise RuntimeError("cached database dump is outside the manifest root")
    state = record.get("state")
    if state in {"building", "purging"}:
        remove_database_cache_files(manifest)
        manifest.pop("database_cache")
        save_manifest(manifest_path, manifest)
        return None
    if state != "ready":
        raise RuntimeError("cached database dump has an unknown lifecycle state")
    if path.is_symlink():
        raise RuntimeError("refusing a symlinked database cache")
    if record.get("key") != key or not path.is_file() or sha256(path) != record.get("sha256"):
        record["state"] = "purging"
        save_manifest(manifest_path, manifest)
        remove_database_cache_files(manifest)
        manifest.pop("database_cache")
        save_manifest(manifest_path, manifest)
        return None
    return path


def dump_database_cache(
    manifest_path: Path, manifest: Manifest, generation: Generation, key: str,
) -> Path:
    assert_container_owned(manifest, generation)
    path = database_cache_path(manifest)
    temporary = database_cache_staging_path(manifest)
    if path.exists() or path.is_symlink() or temporary.exists() or temporary.is_symlink():
        raise RuntimeError("refusing to overwrite an unrecorded database cache file")
    manifest["database_cache"] = {
        "version": DATABASE_CACHE_VERSION,
        "path": str(path),
        "key": key,
        "released_updates": generation["released_updates"],
        "state": "building",
    }
    save_manifest(manifest_path, manifest)
    command = [
        "docker", "exec", str(generation["docker"]["container"]), "mysqldump",
        "-uroot", f"-p{manifest['mysql_root_password']}", "--single-transaction",
        "--set-gtid-purged=OFF", "--databases", *generation["schemas"].values(),
    ]
    descriptor = os.open(temporary, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(descriptor, "wb") as handle:
        result = subprocess.run(
            command, stdout=handle, stderr=subprocess.PIPE, check=False, timeout=1800,
        )
        if result.returncode:
            stderr = result.stderr.decode(errors="replace").strip()
            raise RuntimeError(f"mysqldump failed with exit {result.returncode}: {stderr}")
        handle.flush()
        os.fsync(handle.fileno())
    os.replace(temporary, path)
    os.chmod(path, 0o600)
    manifest["database_cache"]["sha256"] = sha256(path)
    manifest["database_cache"]["state"] = "ready"
    save_manifest(manifest_path, manifest)
    return path


def restore_database_cache(
    manifest_path: Path, manifest: Manifest, generation: Generation, path: Path,
) -> None:
    assert_container_owned(manifest, generation)
    command = [
        "docker", "exec", "-i", str(generation["docker"]["container"]), "mysql",
        "-uroot", f"-p{manifest['mysql_root_password']}",
    ]
    with path.open("rb") as handle:
        result = subprocess.run(
            command, stdin=handle, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            check=False, timeout=1800,
        )
    if result.returncode:
        stderr = result.stderr.decode(errors="replace").strip()
        manifest["database_cache"]["state"] = "purging"
        save_manifest(manifest_path, manifest)
        reconcile_database_cache(manifest_path, manifest, str(generation["inputs"]["database_cache_key"]))
        raise RuntimeError(f"database cache restore failed with exit {result.returncode}: {stderr}")


def replace_config(source: str, replacements: dict[str, str]) -> str:
    lines = source.splitlines()
    seen: set[str] = set()
    for index, line in enumerate(lines):
        for key, value in replacements.items():
            if re.match(rf"^\s*#?\s*{re.escape(key)}\s*=", line):
                if key not in seen:
                    lines[index] = f"{key} = {value}"
                    seen.add(key)
                elif not line.lstrip().startswith("#"):
                    lines[index] = f"# disabled duplicate for Plan 7: {line}"
    missing = set(replacements) - seen
    if missing:
        raise RuntimeError(f"config template keys are missing: {sorted(missing)}")
    return "\n".join(lines) + "\n"


def write_configs(manifest: Manifest, generation: Generation) -> None:
    paths = generation["paths"]
    config_dir = Path(paths["config"])
    log_dir = Path(paths["logs"])
    config_dir.mkdir(parents=True, exist_ok=True)
    log_dir.mkdir(parents=True, exist_ok=True)
    common = (
        f"127.0.0.1;{generation['ports']['mysql']};{manifest['mysql_user']};"
        f"{manifest['mysql_password']};"
    )
    auth_replacements = {
        "RealmServerPort": str(AUTH_PORT),
        "BindIP": '"127.0.0.1"',
        "LogsDir": f'"{log_dir}"',
        "PidFile": f'"{config_dir / "authserver.pid"}"',
        "RealmsStateUpdateDelay": "1",
        "LoginDatabaseInfo": f'"{common}{generation["schemas"]["auth"]}"',
        "Updates.EnableDatabases": "0",
        "Updates.AutoSetup": "0",
        "StrictVersionCheck": "0",
        "SourceDirectory": f'"{REPO_ROOT}"',
        "Appender.Auth": '2,5,0,AuthServer.log,w',
        "Logger.root": "4,Auth",
    }
    world_replacements = {
        "RealmID": str(REALM_ID),
        "WorldServerPort": str(generation["ports"]["world"]),
        "BindIP": '"127.0.0.1"',
        "LoginDatabaseInfo": f'"{common}{generation["schemas"]["auth"]}"',
        "WorldDatabaseInfo": f'"{common}{generation["schemas"]["world"]}"',
        "CharacterDatabaseInfo": f'"{common}{generation["schemas"]["characters"]}"',
        "DataDir": f'"{Path(paths["data"])}"',
        "LogsDir": f'"{log_dir}"',
        "PidFile": f'"{config_dir / "worldserver.pid"}"',
        "Console.Enable": "0",
        "Updates.EnableDatabases": "0",
        "Updates.AutoSetup": "0",
        "Expansion": "3",
        "MoveMaps.Enable": "0",
        "vmap.enableLOS": "0",
        "vmap.enableHeight": "0",
        "Warden.Enabled": "0",
        "Ra.Enable": "0",
        "SOAP.Enabled": "0",
        "Cluster.Enabled": "0",
        "Appender.Server": '2,5,0,WorldServer.log,w',
        "Logger.network": "4,Server",
        "Logger.network.opcode": "4,Server",
    }
    auth_source = (REPO_ROOT / "src/server/apps/authserver/authserver.conf.dist").read_text()
    world_source = (REPO_ROOT / "src/server/apps/worldserver/worldserver.conf.dist").read_text()
    Path(paths["auth_config"]).write_text(replace_config(auth_source, auth_replacements))
    Path(paths["world_config"]).write_text(replace_config(world_source, world_replacements))


def proc_stat(pid: int) -> tuple[int, int, int]:
    text = Path(f"/proc/{pid}/stat").read_text()
    tail = text[text.rfind(")") + 2:].split()
    return int(tail[19]), int(tail[2]), int(tail[3])


def proc_environment(pid: int) -> dict[str, str]:
    values: dict[str, str] = {}
    for field in Path(f"/proc/{pid}/environ").read_bytes().split(b"\0"):
        if b"=" in field:
            key, value = field.split(b"=", 1)
            values[key.decode(errors="replace")] = value.decode(errors="replace")
    return values


def process_identity(pid: int, kind: str, *, config: Path | None = None, prefix: Path | None = None) -> ProcessIdentity:
    start_ticks, process_group, session = proc_stat(pid)
    record: ProcessIdentity = {
        "kind": kind,
        "pid": pid,
        "start_ticks": start_ticks,
        "boot_id": Path("/proc/sys/kernel/random/boot_id").read_text().strip(),
        "exe": str(Path(f"/proc/{pid}/exe").resolve()),
        "cmdline": [
            part.decode(errors="replace")
            for part in Path(f"/proc/{pid}/cmdline").read_bytes().split(b"\0") if part
        ],
        "cwd": str(Path(f"/proc/{pid}/cwd").resolve()),
        "process_group": process_group,
        "session": session,
        "active": True,
    }
    if config is not None:
        record["config"] = str(config.resolve())
    if prefix is not None:
        record["prefix"] = str(prefix.resolve())
    return record


def assert_process_owned(record: ProcessIdentity) -> None:
    pid = int(record["pid"])
    proc = Path(f"/proc/{pid}")
    if not proc.exists():
        raise RuntimeError(f"owned {record['kind']} PID {pid} is absent")
    try:
        current = process_identity(pid, record["kind"])
    except FileNotFoundError as error:
        raise RuntimeError(f"owned {record['kind']} PID {pid} exited during identity verification") from error
    for key in ("start_ticks", "boot_id", "exe"):
        if current[key] != record[key]:
            raise RuntimeError(f"refusing changed {record['kind']} PID {pid}")
    if "config" in record and str(record["config"]) not in current["cmdline"]:
        raise RuntimeError(f"owned {record['kind']} config no longer matches PID {pid}")
    if "prefix" in record:
        environment = proc_environment(pid)
        if Path(environment.get("WINEPREFIX", "")).resolve() != Path(record["prefix"]).resolve():
            raise RuntimeError(f"owned Wine prefix no longer matches PID {pid}")


def find_wine_processes(prefix: Path) -> list[ProcessIdentity]:
    expected = prefix.resolve()
    records = []
    for proc in Path("/proc").iterdir():
        if not proc.name.isdigit():
            continue
        try:
            environment = proc_environment(int(proc.name))
            value = environment.get("WINEPREFIX")
            if value and Path(value).resolve() == expected:
                records.append(process_identity(int(proc.name), "wine", prefix=prefix))
        except (FileNotFoundError, PermissionError, ProcessLookupError, ValueError):
            continue
    return sorted(records, key=lambda item: int(item["pid"]))


def add_processes(generation: Generation, records: list[ProcessIdentity]) -> None:
    known = {(int(item["pid"]), int(item["start_ticks"])) for item in generation["processes"]}
    for record in records:
        identity = (int(record["pid"]), int(record["start_ticks"]))
        if identity not in known:
            generation["processes"].append(record)
            known.add(identity)


def stop_process(record: ProcessIdentity, process: subprocess.Popen[bytes] | None = None) -> None:
    if not record.get("active", False):
        return
    pid = int(record["pid"])
    if not Path(f"/proc/{pid}").exists():
        record["active"] = False
        return
    assert_process_owned(record)
    os.kill(pid, signal.SIGTERM)
    deadline = time.monotonic() + 15
    while Path(f"/proc/{pid}").exists() and time.monotonic() < deadline:
        if process is not None and process.poll() is not None:
            break
        time.sleep(0.1)
    if process is not None and process.poll() is None:
        process.wait(timeout=1)
    if Path(f"/proc/{pid}").exists() and (process is None or process.poll() is None):
        raise RuntimeError(f"owned {record['kind']} PID {pid} did not stop")
    record["active"] = False


def stop_servers(generation: Generation, popens: dict[str, subprocess.Popen[bytes]] | None = None) -> None:
    popens = popens or {}
    for kind in ("worldserver", "authserver"):
        for record in reversed(generation["processes"]):
            if record["kind"] == kind and record.get("active", False):
                stop_process(record, popens.get(kind))


def wine_environment(generation: Generation) -> dict[str, str]:
    paths = generation["paths"]
    environment = os.environ.copy()
    environment.update({
        "WINEPREFIX": paths["wine_prefix"],
        "WINEARCH": "win64",
        "XDG_DATA_HOME": paths["xdg_data"],
        "XDG_CONFIG_HOME": paths["xdg_config"],
        "XDG_CACHE_HOME": paths["xdg_cache"],
        "XDG_STATE_HOME": paths["xdg_state"],
        "GSETTINGS_BACKEND": "memory",
        "DISPLAY": str(generation["inputs"]["display"]),
        "WINEDLLOVERRIDES": "d3d9=n,b",
        "http_proxy": "http://127.0.0.1:9",
        "https_proxy": "http://127.0.0.1:9",
        # +seh is cheap and is what surfaced the "stack overflow" warning that used
        # to be mistaken for a client crash (see issue #32) -- that warning turns out
        # to be an artifact of stop_wine()'s own `wineserver -k` teardown, not a real
        # in-game fault: it appears at a fixed address/size regardless of game state,
        # and only on runs where the client process was still alive when killed
        # (compare a run with no crash line -- its trace just stops mid-normal-trace,
        # same as the "crashed" runs stop mid-SEH-warning). Do not treat this warning
        # as a failure signal without first checking the client was still responsive.
        # +tid/+module are far too verbose/slow for routine runs, only useful for a
        # one-off manual diagnostic session.
        "WINEDEBUG": "+seh",
    })
    xauthority = str(generation["inputs"].get("xauthority") or "")
    if xauthority:
        environment["XAUTHORITY"] = xauthority
    else:
        environment.pop("XAUTHORITY", None)
    return environment


def configure_wine_proxy(generation: Generation) -> None:
    wine = str(generation["inputs"]["wine"])
    key = r"HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
    environment = wine_environment(generation)
    run_command(
        [wine, "reg", "add", key, "/v", "ProxyEnable", "/t", "REG_DWORD", "/d", "1", "/f"],
        env=environment,
    )
    run_command(
        [wine, "reg", "add", key, "/v", "ProxyServer", "/t", "REG_SZ", "/d", "127.0.0.1:9", "/f"],
        env=environment,
    )


def stop_wine(generation: Generation) -> None:
    prefix = Path(generation["paths"]["wine_prefix"])
    current = find_wine_processes(prefix)
    add_processes(generation, current)
    for record in current:
        assert_process_owned(record)
    wineserver = Path(str(generation["inputs"]["wine_runner"])) / "bin/wineserver"
    if current and wineserver.is_file():
        run_command([str(wineserver), "-k"], check=False, timeout=30, env=wine_environment(generation))
        deadline = time.monotonic() + 15
        while find_wine_processes(prefix) and time.monotonic() < deadline:
            time.sleep(0.1)
    current_identities = {(int(item["pid"]), int(item["start_ticks"])): item for item in find_wine_processes(prefix)}
    for record in reversed(generation["processes"]):
        key = (int(record["pid"]), int(record["start_ticks"]))
        if record["kind"] == "wine" and key in current_identities:
            stop_process(record)
        elif record["kind"] == "wine":
            record["active"] = False


def wait_for_port(port: int, record: ProcessIdentity, timeout: int) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        assert_process_owned(record)
        try:
            with socket.create_connection(("127.0.0.1", port), timeout=0.2):
                return
        except OSError:
            time.sleep(0.1)
    raise RuntimeError(f"owned server did not open loopback port {port} within {timeout} seconds")


def wait_for_world(manifest: Manifest, generation: Generation, record: ProcessIdentity) -> None:
    deadline = time.monotonic() + 300
    while time.monotonic() < deadline:
        assert_process_owned(record)
        try:
            with socket.create_connection(("127.0.0.1", generation["ports"]["world"]), timeout=0.2):
                listening = True
        except OSError:
            listening = False
        flag = mysql(
            manifest, generation, f"SELECT `flag` FROM `realmlist` WHERE `id`={REALM_ID};",
            generation["schemas"]["auth"],
        )
        if listening and flag == "0":
            return
        time.sleep(0.25)
    raise RuntimeError("worldserver did not reach listener and realm-online readiness")


def binary_identity(path: Path, head: str, *, reports_version: bool) -> dict[str, object]:
    resolved = path.resolve()
    if not resolved.is_file() or not os.access(resolved, os.X_OK):
        raise RuntimeError(f"required executable is absent: {resolved}")
    identity: dict[str, object] = {"path": str(resolved), "sha256": sha256(resolved)}
    if reports_version:
        output = run_command([str(resolved), "--version"], timeout=30)
        version = (output.stdout + output.stderr).decode(errors="replace").strip()
        if head[:12] not in version and head not in version:
            raise RuntimeError(f"binary does not report current HEAD {head[:12]}: {resolved}")
        identity["version"] = version
    return identity


def preflight_prepare(args: argparse.Namespace) -> dict[str, object]:
    manifest_path = args.manifest.resolve()
    root = require_external_root(manifest_path.parent)
    if args.minimum_free_gib < 25:
        raise RuntimeError("--minimum-free-gib cannot weaken the 25 GiB Plan 7 safety floor")
    available = shutil.disk_usage(nearest_existing_parent(root)).free
    if available < args.minimum_free_gib * 1024 ** 3:
        raise RuntimeError(f"run filesystem has {available} bytes free; need {args.minimum_free_gib} GiB")
    require_unused(AUTH_PORT)
    image_result = run_command(["docker", "image", "inspect", MYSQL_IMAGE], check=False)
    if image_result.returncode:
        raise RuntimeError(f"required local image is absent: {MYSQL_IMAGE}")
    mysql_image_id = json.loads(image_result.stdout)[0]["Id"]
    for command in ("ss", "xprop", "wmctrl"):
        if shutil.which(command) is None:
            raise RuntimeError(f"required evidence command is absent: {command}")
    head = run_command(["git", "rev-parse", "HEAD"], timeout=30).stdout.decode().strip()
    authserver = binary_identity(args.authserver, head, reports_version=True)
    worldserver = binary_identity(args.worldserver, head, reports_version=True)
    unit_tests = binary_identity(args.unit_tests, head, reports_version=False)
    client_root = args.client_root.resolve()
    client_executable = client_root / "Wow-64.exe"
    if not client_executable.is_file() or sha256(client_executable) != CLIENT_SHA256:
        raise RuntimeError("source Wow-64.exe does not match the pinned build-15595 SHA-256")
    data_root = args.data_root.resolve()
    dbc_root = args.server_dbc_root.resolve() if args.server_dbc_root else data_root / "dbc"
    if not dbc_root.is_dir() or not (data_root / "maps").is_dir():
        raise RuntimeError("data candidates must contain readable server DBC and Cataclysm maps directories")
    wine_runner = args.wine_runner.resolve()
    wine = next(
        (path for path in (wine_runner / "bin/wine64", wine_runner / "bin/wine")
         if path.is_file() and os.access(path, os.X_OK)),
        None,
    )
    wineserver = wine_runner / "bin/wineserver"
    dxvk_d3d9 = wine_runner / "lib/wine/dxvk/x86_64-windows/d3d9.dll"
    if wine is None or not wineserver.is_file() or not os.access(wineserver, os.X_OK):
        raise RuntimeError(f"installed Wine runner is incomplete: {wine_runner}")
    if not dxvk_d3d9.is_file():
        raise RuntimeError(f"installed Wine runner has no bundled DXVK d3d9.dll: {wine_runner}")
    xauthority = args.xauthority.resolve() if args.xauthority else os.environ.get("XAUTHORITY", "")
    display_env = os.environ.copy()
    display_env["DISPLAY"] = args.display
    if xauthority:
        display_env["XAUTHORITY"] = str(xauthority)
    display = run_command(["xprop", "-root", "_NET_SUPPORTING_WM_CHECK"], check=False, env=display_env)
    if display.returncode:
        raise RuntimeError(f"cannot access requested X display {args.display}")
    migration = args.migration.resolve()
    if migration != DEFAULT_MIGRATION.resolve() or not migration.is_file():
        raise RuntimeError("--migration must name the Plan 6 build-15595 pending auth update")
    personal_bottle = args.personal_bottle.resolve()
    if not personal_bottle.exists():
        raise RuntimeError(f"personal Bottle baseline path is absent: {personal_bottle}")
    return {
        "root": str(root),
        "repo_commit": head,
        "mysql_image_id": mysql_image_id,
        "database_cache_key": database_cache_key(mysql_image_id, DATABASE_SQL_DIRECTORIES),
        "authserver": authserver,
        "worldserver": worldserver,
        "unit_tests": unit_tests,
        "client_root": str(client_root),
        "client_executable": str(client_executable),
        "client_tree": tree_metadata(client_root),
        "client_sha256": CLIENT_SHA256,
        "data_root": str(data_root),
        "server_dbc_root": str(dbc_root),
        "data_dbc_hash": tree_content_hash(dbc_root),
        "data_maps_hash": tree_content_hash(data_root / "maps"),
        "wine_runner": str(wine_runner),
        "wine": str(wine),
        "wine_sha256": sha256(wine),
        "wineserver_sha256": sha256(wineserver),
        "dxvk_d3d9": str(dxvk_d3d9),
        "dxvk_d3d9_sha256": sha256(dxvk_d3d9),
        "personal_bottle": str(personal_bottle),
        "personal_bottle_tree": tree_metadata(personal_bottle),
        "migration": str(migration),
        "migration_sha256": sha256(migration),
        "display": args.display,
        "xauthority": str(xauthority),
    }


def prepare(args: argparse.Namespace) -> None:
    inputs = preflight_prepare(args)
    manifest_path = args.manifest.resolve()
    if manifest_path.exists():
        manifest = load_manifest(manifest_path)
        latest = active_generation(manifest)
        if latest["state"] != "reset":
            if latest["state"] == "prepared":
                print(f"generation {latest['number']} is already prepared")
                return
            raise RuntimeError(f"cannot prepare after generation in state {latest['state']}")
        baseline = manifest["baseline"]
        current_protected = {
            "client_sha256": inputs["client_sha256"],
            "client_tree": inputs["client_tree"],
            "personal_bottle_tree": inputs["personal_bottle_tree"],
        }
        if any(baseline[key] != value for key, value in current_protected.items()):
            raise RuntimeError("protected client or personal Bottle changed between generations")
    else:
        manifest = {
            "version": 1,
            "run_id": uuid.uuid4().hex[:12],
            "repo_commit": str(inputs["repo_commit"]),
            "root": str(inputs["root"]),
            "mysql_root_password": secrets.token_hex(16),
            "mysql_user": "plan7",
            "mysql_password": secrets.token_hex(16),
            "baseline": {
                "docker": docker_inventory(),
                "client_sha256": inputs["client_sha256"],
                "client_tree": inputs["client_tree"],
                "personal_bottle_tree": inputs["personal_bottle_tree"],
            },
            "generations": [],
        }
    number = len(manifest["generations"]) + 1
    generation_root = Path(str(inputs["root"])) / f"generation-{number}"
    prefix = f"acore-cata-plan{plan_number(args.mode)}-{manifest['run_id']}-g{number}"
    paths = {
        "client": str(generation_root / "client"),
        "data": str(generation_root / "data"),
        "config": str(generation_root / "config"),
        "logs": str(generation_root / "logs"),
        "raw_evidence": str(generation_root / "evidence/raw"),
        "sanitized_evidence": str(generation_root / "evidence/sanitized.json"),
        "xdg_data": str(generation_root / "xdg/data"),
        "xdg_config": str(generation_root / "xdg/config"),
        "xdg_cache": str(generation_root / "xdg/cache"),
        "xdg_state": str(generation_root / "xdg/state"),
        "wine_prefix": str(generation_root / "wine-prefix"),
        "auth_config": str(generation_root / "config/authserver.conf"),
        "world_config": str(generation_root / "config/worldserver.conf"),
    }
    generation: Generation = {
        "number": number,
        "mode": args.mode,
        "stability_seconds": 10 if args.mode in CHARACTER_MODES else 0,
        "state": "allocating",
        "completed_state": "",
        "root": str(generation_root),
        "prefix": prefix,
        "ports": {"mysql": unused_port(), "auth": AUTH_PORT, "world": unused_port()},
        "docker": {
            "container": f"{prefix}-mysql", "container_id": None, "volume": f"{prefix}-mysql-data",
        },
        "schemas": {"auth": "acore_auth", "characters": "acore_characters", "world": "acore_world"},
        "processes": [],
        "inputs": inputs,
        "paths": paths,
        "released_updates": {},
        "evidence": None,
        "failure": None,
        "isolation_unchanged": False,
        "replay_passed": False,
    }
    manifest["generations"].append(generation)
    generation_root.mkdir(parents=True, exist_ok=False)
    save_manifest(manifest_path, manifest)
    try:
        labels = [
            "--label", f"org.azerothcore.plan={plan_number(args.mode)}",
            "--label", f"org.azerothcore.run_id={manifest['run_id']}",
            "--label", f"org.azerothcore.generation={number}",
        ]
        require_unused(generation["ports"]["mysql"])
        run_command(["docker", "volume", "create", *labels, str(generation["docker"]["volume"])])
        result = run_command([
            "docker", "run", "-d", "--name", str(generation["docker"]["container"]), *labels,
            "-e", f"MYSQL_ROOT_PASSWORD={manifest['mysql_root_password']}",
            "-p", f"127.0.0.1:{generation['ports']['mysql']}:3306",
            "-v", f"{generation['docker']['volume']}:/var/lib/mysql", str(inputs["mysql_image_id"]),
        ])
        generation["docker"]["container_id"] = result.stdout.decode().strip()
        save_manifest(manifest_path, manifest)
        wait_for_mysql(manifest, generation)
        auth = generation["schemas"]["auth"]
        characters = generation["schemas"]["characters"]
        world = generation["schemas"]["world"]
        cache_key = str(inputs["database_cache_key"])
        cache = reconcile_database_cache(manifest_path, manifest, cache_key)
        if cache:
            restore_database_cache(manifest_path, manifest, generation, cache)
            generation["released_updates"] = dict(manifest["database_cache"]["released_updates"])
            generation["database_cache"] = {"key": cache_key, "result": "restored"}
        else:
            mysql(
                manifest, generation,
                f"CREATE DATABASE `{auth}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
                f"CREATE DATABASE `{characters}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
                f"CREATE DATABASE `{world}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;",
            )
            released = {}
            for key, schema in (("auth", auth), ("characters", characters), ("world", world)):
                import_sql_directory(manifest, generation, REPO_ROOT / f"data/sql/base/db_{key}", schema)
                released[key] = apply_released_updates(
                    manifest, generation, REPO_ROOT / f"data/sql/updates/db_{key}", schema,
                )
            generation["released_updates"] = released
            dump_database_cache(manifest_path, manifest, generation, cache_key)
            generation["database_cache"] = {"key": cache_key, "result": "built"}
        realm_count = 1 if args.mode in POPULATED_CHARACTER_MODES else 0
        mysql(
            manifest, generation,
            f"CREATE USER IF NOT EXISTS '{manifest['mysql_user']}'@'%' "
            f"IDENTIFIED BY '{manifest['mysql_password']}';"
            f"GRANT ALL ON `{auth}`.* TO '{manifest['mysql_user']}'@'%';"
            f"GRANT ALL ON `{characters}`.* TO '{manifest['mysql_user']}'@'%';"
            f"GRANT ALL ON `{world}`.* TO '{manifest['mysql_user']}'@'%';",
        )
        migration = Path(str(inputs["migration"]))
        mysql(manifest, generation, migration.read_bytes(), auth)
        build = mysql(
            manifest, generation,
            "SELECT CONCAT(`majorVersion`,'.',`minorVersion`,'.',`bugfixVersion`) "
            "FROM `build_info` WHERE `build`=15595;",
            auth,
        )
        if build != "4.3.4":
            raise RuntimeError(f"owned auth database reports unexpected build 15595 version: {build}")
        salt = bytes(range(1, 33))
        verifier = srp_registration(ACCOUNT, PASSWORD, salt)
        mysql(
            manifest, generation,
            f"DELETE FROM `realmcharacters` WHERE `acctid`={ACCOUNT_ID} OR `realmid`={REALM_ID};"
            f"DELETE FROM `account` WHERE `id`={ACCOUNT_ID} OR `username`='{ACCOUNT}';"
            f"DELETE FROM `realmlist` WHERE `id`={REALM_ID} OR `name`='Plan 7 Realm';"
            "INSERT INTO `account` (`id`,`username`,`salt`,`verifier`,`email`,`reg_mail`,`expansion`,`Flags`) "
            f"VALUES ({ACCOUNT_ID},'{ACCOUNT}',UNHEX('{salt.hex()}'),UNHEX('{verifier.hex()}'),"
            "'plan7@example.invalid','plan7@example.invalid',3,0);"
            "INSERT INTO `realmlist` (`id`,`name`,`address`,`localAddress`,`localSubnetMask`,`port`,`icon`,"
            "`flag`,`timezone`,`allowedSecurityLevel`,`population`,`gamebuild`) "
            f"VALUES ({REALM_ID},'Plan 7 Realm','127.0.0.1','127.0.0.1','255.255.255.0',"
            f"{generation['ports']['world']},0,0,1,0,0,{CLIENT_BUILD});"
            f"INSERT INTO `realmcharacters` (`realmid`,`acctid`,`numchars`) "
            f"VALUES ({REALM_ID},{ACCOUNT_ID},{realm_count});",
            auth,
        )
        if args.mode in POPULATED_CHARACTER_MODES:
            mysql(manifest, generation, populated_character_seed_sql(), characters)
            verify_populated_character_seed(manifest, generation)
            if character_row_count(manifest, generation) != 1 or realm_character_count(manifest, generation) != 1:
                raise RuntimeError("owned populated character seed counts do not equal one")
        data_destination = Path(paths["data"])
        data_destination.mkdir()
        copy_tree(Path(str(inputs["server_dbc_root"])), data_destination / "dbc")
        copy_tree(Path(str(inputs["data_root"])) / "maps", data_destination / "maps")
        if tree_content_hash(data_destination / "dbc") != inputs["data_dbc_hash"]:
            raise RuntimeError("run-owned DBC copy differs from its candidate input")
        if tree_content_hash(data_destination / "maps") != inputs["data_maps_hash"]:
            raise RuntimeError("run-owned maps copy differs from its candidate input")
        client_destination = Path(paths["client"])
        link_client_base(Path(str(inputs["client_root"])), client_destination)
        if sha256(client_destination / "Wow-64.exe") != CLIENT_SHA256:
            raise RuntimeError("run client differs from the pinned source executable")
        for name in WRITABLE_CLIENT_DIRS:
            target = client_destination / name
            if target.exists():
                remove_owned_path(target, generation)
        write_client_config(client_destination)
        realmlist = client_destination / "Data/enUS/realmlist.wtf"
        realmlist.write_text("set realmlist 127.0.0.1\nset patchlist 127.0.0.1\n")
        install_dxvk(generation)
        for key in ("xdg_data", "xdg_config", "xdg_cache", "xdg_state", "raw_evidence"):
            Path(paths[key]).mkdir(parents=True, exist_ok=True)
        write_configs(manifest, generation)
        run_command(
            [str(inputs["wine"]), "wineboot", "-u"], timeout=300, env=wine_environment(generation),
        )
        configure_wine_proxy(generation)
        stop_wine(generation)
        if find_wine_processes(Path(paths["wine_prefix"])):
            raise RuntimeError("fresh-prefix initialization left owned Wine processes running")
        set_state(generation, "prepared")
        save_manifest(manifest_path, manifest)
    except BaseException as error:
        record_failure(manifest_path, manifest, error)
        raise
    print(
        f"prepared Plan {plan_number(args.mode)} generation {number} in {generation_root} "
        f"(database cache {generation['database_cache']['result']})"
    )


def start_server(
    generation: Generation, kind: str, binary: Path, config: Path, stdout_path: Path,
) -> tuple[subprocess.Popen[bytes], ProcessIdentity, object]:
    output = stdout_path.open("wb")
    process = subprocess.Popen([str(binary), "-c", str(config)], stdout=output, stderr=subprocess.STDOUT)
    record = process_identity(process.pid, kind, config=config)
    generation["processes"].append(record)
    return process, record, output


def connection_log(generation: Generation) -> str:
    path = Path(generation["paths"]["client"]) / "Logs/connection.log"
    return path.read_text(errors="replace") if path.is_file() else ""


def matched_milestones(
    text: str, milestones: tuple[tuple[str, re.Pattern[str]], ...] = CLIENT_MILESTONES,
) -> list[str]:
    offset = 0
    found = []
    for name, pattern in milestones:
        match = pattern.search(text, offset)
        if match is None:
            break
        found.append(name)
        offset = match.end()
    return found


def capture_runtime(generation: Generation) -> None:
    raw = Path(generation["paths"]["raw_evidence"])
    raw.mkdir(parents=True, exist_ok=True)
    network = run_command(["ss", "-tpn"], check=False).stdout
    with (raw / "network.log").open("ab") as handle:
        handle.write(network)
        handle.write(b"\n")
    window = run_command(["wmctrl", "-lpGx"], check=False, env=wine_environment(generation))
    (raw / "windows.log").write_bytes(window.stdout + window.stderr)


def capture_owned_window(generation: Generation) -> None:
    if shutil.which("wmctrl") is None or shutil.which("xprop") is None or shutil.which("xwd") is None:
        return
    raw = Path(generation["paths"]["raw_evidence"])
    owned_pids = {int(item["pid"]) for item in generation["processes"] if item["kind"] == "wine"}
    result = run_command(["wmctrl", "-lpGx"], check=False, env=wine_environment(generation))
    for line in result.stdout.decode(errors="replace").splitlines():
        fields = line.split(None, 8)
        if len(fields) < 3 or not fields[2].isdigit() or int(fields[2]) not in owned_pids:
            continue
        window_id = fields[0]
        metadata = run_command(
            ["xprop", "-id", window_id, "_NET_WM_PID", "WM_CLASS", "WM_NAME"],
            check=False, env=wine_environment(generation),
        )
        (raw / "window.xprop").write_bytes(metadata.stdout + metadata.stderr)
        run_command(
            ["xwd", "-silent", "-id", window_id, "-out", str(raw / "window.xwd")],
            check=False, env=wine_environment(generation), timeout=30,
        )
        return


def owned_window_evidence(generation: Generation) -> bool:
    raw = Path(generation["paths"]["raw_evidence"])
    return all((raw / name).is_file() and (raw / name).stat().st_size > 0 for name in ("window.xprop", "window.xwd"))


def client_login_points(x: int, y: int, width: int, height: int) -> tuple[tuple[int, int], ...]:
    return (
        (x + round(width * 0.506), y + round(height * 0.536)),
        (x + round(width * 0.506), y + round(height * 0.623)),
        (x + round(width * 0.506), y + round(height * 0.752)),
    )


def x_keysym_name(value: str) -> str:
    return value.lower() if len(value) == 1 and value.isalpha() else value


def owned_wow_window(output: str, owned_pids: set[int]) -> tuple[str, int, int, int, int] | None:
    for line in output.splitlines():
        fields = line.split(None, 9)
        if (
            len(fields) == 10 and fields[2].isdigit() and int(fields[2]) in owned_pids
            and fields[9] == "World of Warcraft"
        ):
            return fields[0], *(int(value) for value in fields[3:7])
    return None


def automate_client_login(generation: Generation) -> None:
    try:
        from Xlib import X, XK, display
        from Xlib.ext import xtest
    except ImportError as error:
        raise RuntimeError("--auto-login requires the installed python3-xlib package") from error

    deadline = time.monotonic() + 90
    window: tuple[str, int, int, int, int] | None = None
    while time.monotonic() < deadline:
        add_processes(generation, find_wine_processes(Path(generation["paths"]["wine_prefix"])))
        owned_pids = {int(item["pid"]) for item in generation["processes"] if item["kind"] == "wine"}
        output = run_command(
            ["wmctrl", "-lpGx"], check=False, env=wine_environment(generation),
        ).stdout.decode(errors="replace")
        window = owned_wow_window(output, owned_pids)
        if window:
            break
        time.sleep(0.5)
    if not window:
        raise RuntimeError("owned WoW window did not appear within 90 seconds")

    window_id, x, y, width, height = window
    # Measured live: an explicit XSetInputFocus (bypassing the window manager's own
    # activation protocol), especially repeated once per field click, makes the
    # client tear down its window and never recreate it -- almost certainly DXVK
    # treating that as an unexpected focus-loss/gain pattern and resetting the
    # device. wmctrl's `-a` (an EWMH _NET_ACTIVE_WINDOW request the WM handles
    # itself) plus reading the WM's own _NET_ACTIVE_WINDOW root property back is the
    # combination proven stable across Plans 7-10: acquire focus once, verify it via
    # the WM's own bookkeeping, then drive the rest of the login by keyboard
    # (Tab/Return) rather than by re-clicking (and thus re-activating) each field.
    focus_deadline = time.monotonic() + 5
    while time.monotonic() < focus_deadline:
        run_command(["wmctrl", "-i", "-a", window_id])
        active = run_command(["xprop", "-root", "_NET_ACTIVE_WINDOW"], check=False)
        active_id = re.search(rb"0x[0-9a-fA-F]+", active.stdout)
        if active_id is not None and int(active_id.group(), 16) == int(window_id, 16):
            break
        time.sleep(0.25)
    else:
        raise RuntimeError("owned WoW window did not receive focus")

    connection = display.Display(str(generation["inputs"]["display"]))
    shift = connection.keysym_to_keycode(XK.string_to_keysym("Shift_L"))
    control = connection.keysym_to_keycode(XK.string_to_keysym("Control_L"))

    def press(value: str, modifier: int | None = None) -> None:
        symbol = XK.string_to_keysym(x_keysym_name(value))
        keycode = connection.keysym_to_keycode(symbol)
        if modifier:
            xtest.fake_input(connection, X.KeyPress, modifier)
        xtest.fake_input(connection, X.KeyPress, keycode)
        xtest.fake_input(connection, X.KeyRelease, keycode)
        if modifier:
            xtest.fake_input(connection, X.KeyRelease, modifier)

    def click(point: tuple[int, int]) -> None:
        connection.screen().root.warp_pointer(*point)
        xtest.fake_input(connection, X.ButtonPress, 1)
        xtest.fake_input(connection, X.ButtonRelease, 1)
        connection.sync()
        time.sleep(0.2)

    def enter(value: str) -> None:
        for character in value:
            press(character, shift if character.isalpha() else None)
            time.sleep(0.05)

    movie_seen = False
    no_movie_deadline = time.monotonic() + 30
    movie_deadline = time.monotonic() + 240
    while time.monotonic() < movie_deadline:
        movie_active = any(
            any("MovieProxy.exe" in argument for argument in item.get("cmdline", []))
            for item in find_wine_processes(Path(generation["paths"]["wine_prefix"]))
        )
        if movie_active:
            movie_seen = True
            press("Escape")
            connection.sync()
            time.sleep(1)
            continue
        if movie_seen or time.monotonic() >= no_movie_deadline:
            break
        time.sleep(1)
    account_point, _, _ = client_login_points(x, y, width, height)
    click(account_point)
    press("a", control)
    press("BackSpace")
    enter(ACCOUNT)
    press("Tab")
    press("a", control)
    press("BackSpace")
    enter(PASSWORD)
    press("Return")
    connection.sync()
    connection.close()


def automate_character_selection(generation: Generation) -> None:
    try:
        from Xlib import X, XK, display
        from Xlib.ext import xtest
    except ImportError as error:
        raise RuntimeError("character selection requires the installed python3-xlib package") from error

    deadline = time.monotonic() + 30
    window: tuple[str, int, int, int, int] | None = None
    while time.monotonic() < deadline:
        add_processes(generation, find_wine_processes(Path(generation["paths"]["wine_prefix"])))
        owned_pids = {int(item["pid"]) for item in generation["processes"] if item["kind"] == "wine"}
        output = run_command(
            ["wmctrl", "-lpGx"], check=False, env=wine_environment(generation),
        ).stdout.decode(errors="replace")
        window = owned_wow_window(output, owned_pids)
        if window:
            break
        time.sleep(0.5)
    if not window:
        raise RuntimeError("owned WoW window did not appear for character selection")

    window_id = window[0]
    connection = display.Display(str(generation["inputs"]["display"]))
    target = connection.create_resource_object("window", int(window_id, 16))
    run_command(["wmctrl", "-i", "-a", window_id])
    target.set_input_focus(X.RevertToParent, X.CurrentTime)
    connection.sync()
    time.sleep(1)
    keycode = connection.keysym_to_keycode(XK.string_to_keysym("Return"))
    xtest.fake_input(connection, X.KeyPress, keycode)
    xtest.fake_input(connection, X.KeyRelease, keycode)
    connection.sync()
    connection.close()


def character_row_count(manifest: Manifest, generation: Generation) -> int:
    output = mysql(
        manifest, generation,
        f"SELECT COUNT(*) FROM `characters` WHERE `account`={ACCOUNT_ID} AND `deleteDate` IS NULL;",
        generation["schemas"]["characters"],
    )
    try:
        return int(output)
    except ValueError as error:
        raise RuntimeError(f"owned character database returned a non-numeric row count: {output!r}") from error


def run_client(args: argparse.Namespace) -> None:
    manifest_path = args.manifest.resolve()
    manifest = load_manifest(manifest_path)
    generation = active_generation(manifest)
    if generation["mode"] in CHARACTER_MODES and args.stability_seconds < 5:
        raise RuntimeError("--stability-seconds must be at least 5")
    retryable = generation["state"] in {"failed", "inconclusive"}
    if retryable:
        if any(process.get("active", False) for process in generation["processes"]):
            raise RuntimeError("cannot retry a diagnostic generation with active processes")
        for path in (
            Path(generation["paths"]["raw_evidence"]),
            Path(generation["paths"]["client"]) / "Logs",
        ):
            if path.exists():
                remove_owned_path(path, generation)
            path.mkdir(parents=True)
        generation["state"] = "prepared"
        generation["failure"] = None
        generation["evidence"] = None
    if generation["state"] != "prepared":
        raise RuntimeError(f"cannot run from state {generation['state']}")
    assert_container_owned(manifest, generation)
    ensure_client_base(manifest, generation)
    save_manifest(manifest_path, manifest)
    write_client_config(Path(generation["paths"]["client"]))
    install_dxvk(generation)
    configure_wine_proxy(generation)
    stop_wine(generation)
    save_manifest(manifest_path, manifest)
    require_unused(AUTH_PORT)
    require_unused(generation["ports"]["world"])
    paths = generation["paths"]
    popens: dict[str, subprocess.Popen[bytes]] = {}
    outputs: list[object] = []
    try:
        auth_process, auth_record, auth_output = start_server(
            generation, "authserver", Path(str(generation["inputs"]["authserver"]["path"])),
            Path(paths["auth_config"]), Path(paths["logs"]) / "authserver.stdout.log",
        )
        popens["authserver"] = auth_process
        outputs.append(auth_output)
        save_manifest(manifest_path, manifest)
        wait_for_port(AUTH_PORT, auth_record, 60)
        world_process, world_record, world_output = start_server(
            generation, "worldserver", Path(str(generation["inputs"]["worldserver"]["path"])),
            Path(paths["world_config"]), Path(paths["logs"]) / "worldserver.stdout.log",
        )
        popens["worldserver"] = world_process
        outputs.append(world_output)
        save_manifest(manifest_path, manifest)
        wait_for_world(manifest, generation, world_record)
        set_state(generation, "servers_ready")
        save_manifest(manifest_path, manifest)
        wine = Path(str(generation["inputs"]["wine"]))
        client = Path(paths["client"]) / "Wow-64.exe"
        client_output = (Path(paths["logs"]) / "client.stdout.log").open("wb")
        outputs.append(client_output)
        launcher = subprocess.Popen(
            [str(wine), str(client)], stdout=client_output, stderr=subprocess.STDOUT,
            cwd=client.parent, env=wine_environment(generation), start_new_session=True,
        )
        try:
            generation["processes"].append(process_identity(launcher.pid, "wine", prefix=Path(paths["wine_prefix"])))
        except FileNotFoundError:
            pass
        set_state(generation, "client_running")
        save_manifest(manifest_path, manifest)
        print(f"owned client launched on {generation['inputs']['display']}")
        if args.auto_login and generation["mode"] in {"authentication", *CHARACTER_MODES}:
            automate_client_login(generation)
            print("synthetic credentials submitted automatically")
        elif generation["mode"] in {"authentication", *CHARACTER_MODES}:
            print(f"enter synthetic credentials manually: {ACCOUNT} / {PASSWORD}")
        deadline = time.monotonic() + (args.no_login_seconds if generation["mode"] == "no-login" else args.timeout)
        character_hold_started: float | None = None
        selection_sent = False
        post_marker_hold_started: float | None = None
        milestone_definition = CHARACTER_MILESTONES if generation["mode"] in CHARACTER_MODES else CLIENT_MILESTONES
        while time.monotonic() < deadline:
            add_processes(generation, find_wine_processes(Path(paths["wine_prefix"])))
            capture_runtime(generation)
            milestones = matched_milestones(connection_log(generation), milestone_definition)
            if generation["mode"] == "authentication" and len(milestones) == 4:
                break
            if generation["mode"] in CHARACTER_MODES:
                if len(milestones) == len(CHARACTER_MILESTONES) and character_hold_started is None:
                    character_hold_started = time.monotonic()
                if (
                    generation["mode"] in {CHARACTER_SELECTION_MODE, *POST_MARKER_MODES}
                    and character_hold_started is not None and not selection_sent
                ):
                    automate_character_selection(generation)
                    generation["selection_action"] = "enter"
                    save_manifest(manifest_path, manifest)
                    selection_sent = True
                if (
                    generation["mode"] == CHARACTER_SELECTION_MODE and selection_sent
                    and player_login_callbacks(generation)
                ):
                    break
                if generation["mode"] in POST_MARKER_MODES and selection_sent:
                    marker_count = POST_MARKER_COUNTERS[generation["mode"]](generation)
                    if marker_count and post_marker_hold_started is None:
                        capture_runtime(generation)
                        generation["post_marker_snapshots"] = 1
                        post_marker_hold_started = time.monotonic()
                    if (
                        post_marker_hold_started is not None
                        and time.monotonic() - post_marker_hold_started >= args.stability_seconds
                    ):
                        capture_runtime(generation)
                        generation["post_marker_snapshots"] = 2
                        generation["post_marker_hold_seconds"] = args.stability_seconds
                        break
                if (
                    generation["mode"] not in {CHARACTER_SELECTION_MODE, *POST_MARKER_MODES}
                    and character_hold_started is not None
                    and time.monotonic() - character_hold_started >= args.stability_seconds
                ):
                    break
            if generation["mode"] == "no-login" and time.monotonic() + 0.5 >= deadline:
                break
            if launcher.poll() is not None and not find_wine_processes(Path(paths["wine_prefix"])):
                break
            time.sleep(0.5)
        capture_runtime(generation)
        capture_owned_window(generation)
        if generation["mode"] in CHARACTER_MODES:
            generation["stability_seconds"] = args.stability_seconds if character_hold_started is not None else 0
        raw = Path(paths["raw_evidence"])
        source_log = Path(paths["client"]) / "Logs/connection.log"
        if source_log.is_file():
            shutil.copy2(source_log, raw / "connection.log")
        for name in ("WorldServer.log", "AuthServer.log"):
            source = Path(paths["logs"]) / name
            if source.is_file():
                shutil.copy2(source, raw / name)
        set_state(generation, "observed")
    except BaseException as error:
        record_failure(manifest_path, manifest, error)
        raise
    finally:
        cleanup_error: BaseException | None = None
        try:
            stop_wine(generation)
            stop_servers(generation, popens)
        except BaseException as error:
            cleanup_error = error
        finally:
            for output in outputs:
                output.close()
            save_manifest(manifest_path, manifest)
        if cleanup_error is not None:
            if generation["state"] not in ("failed", "inconclusive", "reset"):
                record_failure(manifest_path, manifest, cleanup_error)
            raise cleanup_error
    print(f"observed Plan {plan_number(str(generation['mode']))} generation {generation['number']}; run verify next")


def world_log_text(generation: Generation) -> str:
    paths = generation["paths"]
    candidates = [
        Path(paths["raw_evidence"]) / "WorldServer.log",
        Path(paths["logs"]) / "WorldServer.log",
        Path(paths["logs"]) / "worldserver.stdout.log",
    ]
    source = next((path for path in candidates if path.is_file()), None)
    return source.read_text(errors="replace") if source else ""


def server_transcript(generation: Generation) -> list[dict[str, str]]:
    transcript = []
    pattern = re.compile(r"\b(C->S|S->C):\s+.*?\b((?:CMSG|SMSG|MSG)_[A-Z0-9_]+)\b")
    for direction, opcode in pattern.findall(world_log_text(generation)):
        transcript.append({"direction": "c2s" if direction == "C->S" else "s2c", "opcode": opcode})
    return transcript


def enumerated_characters(generation: Generation) -> list[dict[str, int]]:
    pattern = re.compile(
        r"Enumerated account (\d+) character GUID Full: 0x[0-9a-fA-F]+ Type: Player Low: (\d+) "
        r"at list position (\d+)\."
    )
    return [
        {"account_id": int(account), "guid_low": int(guid), "list_position": int(position)}
        for account, guid, position in pattern.findall(world_log_text(generation))
    ]


def player_login_requests(generation: Generation) -> list[int]:
    pattern = re.compile(r"Account \(\d+\) is trying to login with character \(.*? Low: (\d+)\)")
    return [int(guid) for guid in pattern.findall(world_log_text(generation))]


def player_login_callbacks(generation: Generation) -> list[int]:
    pattern = re.compile(r"Player login callback for account \d+ character .*? Low: (\d+)")
    return [int(guid) for guid in pattern.findall(world_log_text(generation))]


def initial_packets_marker_count(generation: Generation) -> int:
    return world_log_text(generation).count("Finished sending initial packets before going to map")


def initial_packet_prefix(generation: Generation) -> list[str]:
    packet = re.compile(r"\b(C->S|S->C):\s+.*?\b((?:CMSG|SMSG|MSG)_[A-Z0-9_]+)\b")
    prefix: list[str] = []
    selected = False
    for line in world_log_text(generation).splitlines():
        match = packet.search(line)
        if match and match.group(1) == "C->S" and match.group(2) == "CMSG_PLAYER_LOGIN":
            selected = True
            continue
        if "Finished sending initial packets before going to map" in line:
            break
        if selected and match and match.group(1) == "S->C":
            prefix.append(match.group(2))
    return prefix


def map_insertion_marker_count(generation: Generation) -> int:
    return world_log_text(generation).count("Finished object update bootstrap after adding to map")


def map_insertion_packet_prefix(generation: Generation) -> list[str]:
    """Packets from the Plan 11 pre-map marker through the Plan 12 post-bootstrap
    marker: LOGIN_VERIFY_WORLD and the object/update bootstrap, not the pre-map
    prefix Plan 11 already proved and not anything after this marker (movement/
    control is Plan 13)."""
    packet = re.compile(r"\b(C->S|S->C):\s+.*?\b((?:CMSG|SMSG|MSG)_[A-Z0-9_]+)\b")
    prefix: list[str] = []
    selected = False
    for line in world_log_text(generation).splitlines():
        if "Finished sending initial packets before going to map" in line:
            selected = True
            continue
        if "Finished object update bootstrap after adding to map" in line:
            break
        match = packet.search(line)
        if selected and match and match.group(1) == "S->C":
            prefix.append(match.group(2))
    return prefix


IN_WORLD_CONTROL_MARKER = "Resolved client time sync response, first in-world control liveness signal"


def in_world_control_marker_count(generation: Generation) -> int:
    return world_log_text(generation).count(IN_WORLD_CONTROL_MARKER)


def in_world_control_packet_prefix(generation: Generation) -> list[str]:
    """Packets from the Plan 12 post-bootstrap marker through the first resolved
    CMSG_TIME_SYNC_RESP: whatever the server sends while waiting, plus the first
    client-initiated packet, proving the client is alive and ticking. Movement or
    other player-control packets are not awaited here; that is the Movement plan
    family, not this boundary."""
    packet = re.compile(r"\b(C->S|S->C):\s+.*?\b((?:CMSG|SMSG|MSG)_[A-Z0-9_]+)\b")
    prefix: list[str] = []
    selected = False
    for line in world_log_text(generation).splitlines():
        if "Finished object update bootstrap after adding to map" in line:
            selected = True
            continue
        if IN_WORLD_CONTROL_MARKER in line:
            break
        match = packet.search(line)
        if selected and match:
            prefix.append(f"{match.group(1)}:{match.group(2)}")
    return prefix


POST_MARKER_MODES = frozenset({INITIAL_POST_LOAD_PACKETS_MODE, MAP_INSERTION_MODE, IN_WORLD_CONTROL_MODE})
POST_MARKER_COUNTERS = {
    INITIAL_POST_LOAD_PACKETS_MODE: initial_packets_marker_count,
    MAP_INSERTION_MODE: map_insertion_marker_count,
    IN_WORLD_CONTROL_MODE: in_world_control_marker_count,
}


def player_login_diagnostic(generation: Generation) -> str:
    text = world_log_text(generation)
    callback = text.rfind("Player login callback for account ")
    if callback < 0:
        return "not-observed"
    later = text[callback:]
    if "Player::LoadFromDB failed" in later:
        return "load-returned-false"
    if "logged in with character" in later:
        return "load-returned-true"
    return "not-observed"


def selection_proof_is_complete(
    selection: dict[str, object] | None, transcript: list[dict[str, str]],
    enum_events: list[dict[str, int]],
) -> bool:
    expected_enum = {
        "account_id": ACCOUNT_ID, "guid_low": CHARACTER_GUID, "list_position": CHARACTER_LIST_POSITION,
    }
    return (
        enum_events == [expected_enum]
        and selection == {
            "action": "enter",
            "seeded_guid_low": CHARACTER_GUID,
            "enumerated_guid_low": CHARACTER_GUID,
            "request_guid_low": CHARACTER_GUID,
            "callback_guid_low": CHARACTER_GUID,
            "legit_characters_admission": True,
        }
        and sum(item == {"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"} for item in transcript) == 1
    )


def owned_established_lines(generation: Generation) -> list[str]:
    path = Path(generation["paths"]["raw_evidence"]) / "network.log"
    if not path.is_file():
        return []
    lines = path.read_text(errors="replace").splitlines()
    wine_pids = [str(item["pid"]) for item in generation["processes"] if item["kind"] == "wine"]
    return [
        line for line in lines
        if "ESTAB" in line and any(f"pid={pid}," in line for pid in wine_pids)
    ]


def endpoint_evidence(generation: Generation) -> bool:
    owned = owned_established_lines(generation)
    ports = (AUTH_PORT, generation["ports"]["world"])
    if not all(any(len(line.split()) > 4 and line.split()[4].endswith(f":{port}") for line in owned) for port in ports):
        return False
    allowed = {f":{port}" for port in ports}
    return all(len(line.split()) > 4 and any(line.split()[4].endswith(suffix) for suffix in allowed) for line in owned)


def protected_inputs_unchanged(manifest: Manifest, generation: Generation) -> bool:
    inputs = generation["inputs"]
    baseline = manifest["baseline"]
    client_root = Path(str(inputs["client_root"]))
    personal_bottle = Path(str(inputs["personal_bottle"]))
    base_record = manifest.get("client_base")
    base_unchanged = not base_record or base_record.get("purged", False) or (
        tree_metadata(Path(str(base_record["path"]))) == base_record["tree"]
    )
    return base_unchanged and (
        sha256(client_root / "Wow-64.exe") == baseline["client_sha256"]
        and tree_metadata(client_root) == baseline["client_tree"]
        and tree_metadata(personal_bottle) == baseline["personal_bottle_tree"]
    )


def purge_client_base(manifest: Manifest) -> None:
    record = manifest.get("client_base")
    if not record or record.get("purged", False):
        return
    if any(generation["state"] != "reset" for generation in manifest["generations"]):
        raise RuntimeError("all Plan 7 generations must be reset before purging the cached client")
    base = Path(str(record["path"]))
    expected = (Path(manifest["root"]) / "client-base").resolve()
    if base.resolve() != expected or tree_metadata(base) != record["tree"]:
        raise RuntimeError("refusing to purge a changed or unowned cached client base")
    make_tree_writable(base)
    shutil.rmtree(base)
    record["purged"] = True


def purge_database_cache(manifest_path: Path, manifest: Manifest) -> None:
    record = manifest.get("database_cache")
    if not record:
        return
    if any(generation["state"] != "reset" for generation in manifest["generations"]):
        raise RuntimeError("all Plan 7 generations must be reset before purging the database cache")
    path = Path(str(record["path"]))
    if path != database_cache_path(manifest):
        raise RuntimeError("refusing to purge a database cache outside the manifest root")
    if record.get("state") != "purging":
        record["state"] = "purging"
        save_manifest(manifest_path, manifest)
    remove_database_cache_files(manifest)
    manifest.pop("database_cache")
    save_manifest(manifest_path, manifest)


def sanitized_evidence(
    generation: Generation, milestones: list[str], transcript: list[dict[str, str]],
    *, character_rows: int | None = None, realm_count: int | None = None,
    enumerated: dict[str, object] | None = None, screen_confirmed: bool = False,
    selection: dict[str, object] | None = None, downstream_diagnostic: str | None = None,
    initial_packet_prefix_value: list[str] | None = None, pre_map_marker_count: int | None = None,
    map_insertion_prefix_value: list[str] | None = None, map_insertion_marker_count_value: int | None = None,
    in_world_control_prefix_value: list[str] | None = None, in_world_control_marker_count_value: int | None = None,
) -> dict[str, object]:
    auth_index = next(
        (index for index, item in enumerate(transcript) if item["opcode"] == "SMSG_AUTH_RESPONSE"), None,
    )
    candidate = None
    if auth_index is not None:
        candidate = next(
            (item["opcode"] for item in transcript[auth_index + 1:] if item["direction"] == "s2c"), None,
        )
    allowlisted = [
        item for item in transcript
        if item["opcode"] in {
            "SMSG_AUTH_CHALLENGE", "CMSG_AUTH_SESSION", "SMSG_AUTH_RESPONSE",
            "CMSG_CHAR_ENUM", "SMSG_CHAR_ENUM", "SMSG_TUTORIAL_FLAGS", "SMSG_CLIENTCACHE_VERSION",
        }
    ]
    character_mode = generation["mode"] in CHARACTER_MODES
    populated_mode = generation["mode"] in POPULATED_CHARACTER_MODES
    selection_mode = generation["mode"] == CHARACTER_SELECTION_MODE
    initial_packets_mode = generation["mode"] == INITIAL_POST_LOAD_PACKETS_MODE
    map_insertion_mode = generation["mode"] == MAP_INSERTION_MODE
    in_world_control_mode = generation["mode"] == IN_WORLD_CONTROL_MODE
    login_mode = selection_mode or initial_packets_mode or map_insertion_mode or in_world_control_mode
    owned_window = owned_window_evidence(generation) if character_mode else (
        Path(generation["paths"]["raw_evidence"]) / "window.xprop"
    ).is_file()
    forbidden_opcodes = FORBIDDEN_CHARACTER_OPCODES - ({"CMSG_PLAYER_LOGIN"} if login_mode else set())
    forbidden = sorted({item["opcode"] for item in transcript if item["opcode"] in forbidden_opcodes})
    return {
        "schema": 1,
        "build": CLIENT_BUILD,
        "mode": generation["mode"],
        "outcome": (
            "in_world_control_bootstrap_candidate" if in_world_control_mode and "characters_completed" in milestones
            else "map_insertion_object_bootstrap_candidate" if map_insertion_mode and "characters_completed" in milestones
            else "initial_post_load_packets_candidate" if initial_packets_mode and "characters_completed" in milestones
            else "character_selection_candidate" if selection_mode and "characters_completed" in milestones
            else "populated_character_list_candidate" if populated_mode and "characters_completed" in milestones
            else "character_screen_candidate" if character_mode and "characters_completed" in milestones
            else "world_auth_ok" if "world_auth_ok" in milestones else "not_accepted"
        ),
        "client_milestones": milestones,
        "server_milestones": allowlisted,
        "endpoint_ownership": endpoint_evidence(generation),
        "network_scope": "owned-auth-and-world-only" if endpoint_evidence(generation) else "inconclusive",
        "owned_window": owned_window,
        "screen_confirmed": screen_confirmed if character_mode else None,
        "character_rows": character_rows if character_mode else None,
        "realm_character_count": realm_count if populated_mode else None,
        "enumerated": enumerated if populated_mode else None,
        "selection": selection if login_mode else None,
        "downstream_diagnostic": downstream_diagnostic if selection_mode else None,
        "pre_map_packet_prefix": initial_packet_prefix_value if initial_packets_mode else None,
        "pre_map_marker_count": pre_map_marker_count if initial_packets_mode else None,
        "map_insertion_packet_prefix": map_insertion_prefix_value if map_insertion_mode else None,
        "map_insertion_marker_count": map_insertion_marker_count_value if map_insertion_mode else None,
        "in_world_control_packet_prefix": in_world_control_prefix_value if in_world_control_mode else None,
        "in_world_control_marker_count": in_world_control_marker_count_value if in_world_control_mode else None,
        "post_marker_hold_seconds": (
            generation.get("post_marker_hold_seconds", 0) if generation["mode"] in POST_MARKER_MODES else None
        ),
        "post_marker_snapshots": (
            generation.get("post_marker_snapshots", 0) if generation["mode"] in POST_MARKER_MODES else None
        ),
        "empty_response_payload": EMPTY_CHARACTER_ENUM_PAYLOAD if generation["mode"] == "character-screen" else None,
        "response_body": POPULATED_CHARACTER_ENUM_PAYLOAD if populated_mode else None,
        "stability_seconds": generation.get("stability_seconds", 0) if character_mode else None,
        "forbidden_opcodes": forbidden if character_mode else [],
        "next_server_packet": {
            "opcode": candidate or "unknown",
            "status": "candidate/inconclusive" if candidate else "not-observed/inconclusive",
        },
        "payload_shape": "typed-auth-success; no raw payload retained",
        "inputs": {
            "client_sha256": CLIENT_SHA256,
            "authserver_sha256": generation["inputs"]["authserver"]["sha256"],
            "worldserver_sha256": generation["inputs"]["worldserver"]["sha256"],
            "dbc_tree_sha256": generation["inputs"]["data_dbc_hash"],
            "maps_tree_sha256": generation["inputs"]["data_maps_hash"],
        },
    }


def verify(args: argparse.Namespace) -> None:
    manifest_path = args.manifest.resolve()
    manifest = load_manifest(manifest_path)
    generation = active_generation(manifest)
    if generation["state"] not in {"observed", "accepted"}:
        raise RuntimeError(f"cannot verify from state {generation['state']}")
    raw_log = Path(generation["paths"]["raw_evidence"]) / "connection.log"
    text = raw_log.read_text(errors="replace") if raw_log.is_file() else ""
    milestone_definition = CHARACTER_MILESTONES if generation["mode"] in CHARACTER_MODES else CLIENT_MILESTONES
    milestones = matched_milestones(text, milestone_definition)
    transcript = server_transcript(generation)
    character_mode = generation["mode"] in CHARACTER_MODES
    populated_mode = generation["mode"] in POPULATED_CHARACTER_MODES
    selection_mode = generation["mode"] == CHARACTER_SELECTION_MODE
    initial_packets_mode = generation["mode"] == INITIAL_POST_LOAD_PACKETS_MODE
    map_insertion_mode = generation["mode"] == MAP_INSERTION_MODE
    in_world_control_mode = generation["mode"] == IN_WORLD_CONTROL_MODE
    login_mode = selection_mode or initial_packets_mode or map_insertion_mode or in_world_control_mode
    rows = character_row_count(manifest, generation) if character_mode else None
    realm_count = realm_character_count(manifest, generation) if populated_mode else None
    seed = (
        verify_populated_character_identity(manifest, generation) if login_mode
        else verify_populated_character_seed(manifest, generation) if populated_mode else None
    )
    enum_events = enumerated_characters(generation) if populated_mode else []
    enumerated = None
    if seed is not None:
        enumerated = seed
    requests = player_login_requests(generation) if login_mode else []
    callbacks = player_login_callbacks(generation) if login_mode else []
    selection = {
        "action": generation.get("selection_action"),
        "seeded_guid_low": seed["guid_low"] if seed is not None else None,
        "enumerated_guid_low": enum_events[0]["guid_low"] if len(enum_events) == 1 else None,
        "request_guid_low": requests[0] if len(requests) == 1 else None,
        "callback_guid_low": callbacks[0] if len(callbacks) == 1 else None,
        "legit_characters_admission": len(callbacks) == 1,
    } if login_mode else None
    evidence = sanitized_evidence(
        generation, milestones, transcript, character_rows=rows, realm_count=realm_count, enumerated=enumerated,
        screen_confirmed=bool(args.confirm_expected_screen), selection=selection,
        downstream_diagnostic=player_login_diagnostic(generation) if selection_mode else None,
        initial_packet_prefix_value=initial_packet_prefix(generation) if initial_packets_mode else None,
        pre_map_marker_count=initial_packets_marker_count(generation) if initial_packets_mode else None,
        map_insertion_prefix_value=map_insertion_packet_prefix(generation) if map_insertion_mode else None,
        map_insertion_marker_count_value=map_insertion_marker_count(generation) if map_insertion_mode else None,
        in_world_control_prefix_value=(
            in_world_control_packet_prefix(generation) if in_world_control_mode else None
        ),
        in_world_control_marker_count_value=(
            in_world_control_marker_count(generation) if in_world_control_mode else None
        ),
    )
    unchanged = protected_inputs_unchanged(manifest, generation)
    generation["isolation_unchanged"] = unchanged
    evidence["protected_inputs_unchanged"] = unchanged
    evidence["reset"] = "pending"
    server_ok = (
        any(item == {"direction": "c2s", "opcode": "CMSG_AUTH_SESSION"} for item in transcript)
        and any(item == {"direction": "s2c", "opcode": "SMSG_AUTH_RESPONSE"} for item in transcript)
    )
    if character_mode:
        character_ok = (
            len(milestones) == len(CHARACTER_MILESTONES)
            and any(item == {"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"} for item in transcript)
            and any(item == {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"} for item in transcript)
            and rows == (1 if populated_mode else 0)
            and evidence["stability_seconds"] >= 5
            and evidence["endpoint_ownership"]
            and evidence["owned_window"]
            and evidence["screen_confirmed"]
            and not evidence["forbidden_opcodes"]
            and unchanged
        )
        if populated_mode:
            character_ok = character_ok and realm_count == 1 and enum_events == [{
                "account_id": ACCOUNT_ID, "guid_low": CHARACTER_GUID,
                "list_position": CHARACTER_LIST_POSITION,
            }]
        if selection_mode:
            character_ok = character_ok and selection_proof_is_complete(selection, transcript, enum_events)
        if initial_packets_mode:
            character_ok = character_ok and selection_proof_is_complete(selection, transcript, enum_events) and (
                evidence["pre_map_marker_count"] == 1
                and bool(evidence["pre_map_packet_prefix"])
                and evidence["post_marker_hold_seconds"] >= 5
                and evidence["post_marker_snapshots"] == 2
            )
        if map_insertion_mode:
            character_ok = character_ok and selection_proof_is_complete(selection, transcript, enum_events) and (
                evidence["map_insertion_marker_count"] == 1
                and bool(evidence["map_insertion_packet_prefix"])
                and "SMSG_LOGIN_VERIFY_WORLD" in evidence["map_insertion_packet_prefix"]
                and evidence["post_marker_hold_seconds"] >= 5
                and evidence["post_marker_snapshots"] == 2
            )
        if in_world_control_mode:
            character_ok = character_ok and selection_proof_is_complete(selection, transcript, enum_events) and (
                evidence["in_world_control_marker_count"] == 1
                and bool(evidence["in_world_control_packet_prefix"])
                and "C->S:CMSG_TIME_SYNC_RESP" in evidence["in_world_control_packet_prefix"]
                and evidence["post_marker_hold_seconds"] >= 5
                and evidence["post_marker_snapshots"] == 2
            )
        if character_ok:
            evidence["outcome"] = (
                "in_world_control_bootstrap_pass" if in_world_control_mode
                else "map_insertion_object_bootstrap_pass" if map_insertion_mode
                else "initial_post_load_packets_pass" if initial_packets_mode
                else "character_selection_pass" if selection_mode
                else "populated_character_list_pass" if populated_mode else "character_screen_pass"
            )
            set_state(generation, "accepted")
        elif not unchanged:
            set_state(generation, "failed")
        else:
            evidence["outcome"] = "inconclusive"
            set_state(generation, "inconclusive")
    elif generation["mode"] == "no-login":
        started = any(item["kind"] == "wine" for item in generation["processes"])
        started = started and bool(evidence["owned_window"])
        network_safe = not owned_established_lines(generation)
        evidence["network_scope"] = "no-established-tcp" if network_safe else "unexpected-connection"
        evidence["outcome"] = "no_login_isolation_ok" if unchanged and started and network_safe else "inconclusive"
        if unchanged and started and network_safe:
            set_state(generation, "accepted")
        elif not unchanged:
            set_state(generation, "failed")
        else:
            set_state(generation, "inconclusive")
    elif len(milestones) == 4 and server_ok and evidence["endpoint_ownership"] and unchanged:
        if generation["state"] == "observed":
            set_state(generation, "accepted")
    else:
        evidence["outcome"] = "inconclusive"
        set_state(generation, "inconclusive")
    generation["evidence"] = evidence
    evidence_path = Path(generation["paths"]["sanitized_evidence"])
    evidence_path.parent.mkdir(parents=True, exist_ok=True)
    evidence_path.write_text(json.dumps(evidence, indent=2, sort_keys=True) + "\n")
    save_manifest(manifest_path, manifest)
    print(json.dumps(evidence, indent=2, sort_keys=True))
    if generation["state"] != "accepted":
        raise RuntimeError(f"Plan {plan_number(str(generation['mode']))} evidence is incomplete; verdict is INCONCLUSIVE")


def normalized_replay(evidence: dict[str, object]) -> dict[str, object]:
    auth = evidence.get("auth", {})
    return {
        "build": evidence.get("build"),
        "m2_verified": auth.get("m2_verified") if isinstance(auth, dict) else None,
        "peer_k_equals_database_k": evidence.get("peer_k_equals_database_k"),
        "database_k_equals_world_query_k": evidence.get("database_k_equals_world_query_k"),
        "world": evidence.get("world"),
    }


def replay(args: argparse.Namespace) -> None:
    manifest_path = args.manifest.resolve()
    manifest = load_manifest(manifest_path)
    generation = active_generation(manifest)
    if generation.get("replay_passed", False):
        print(json.dumps(generation["evidence"], indent=2, sort_keys=True))
        return
    accepted_state = generation["state"] == "accepted"
    accepted_reset = generation["state"] == "reset" and generation.get("completed_state") in {
        "accepted", "replayed",
    }
    if (not accepted_state and not accepted_reset) or generation["mode"] != "authentication":
        raise RuntimeError("replay requires an accepted authentication generation")
    fixture_path = args.fixture.resolve()
    if not fixture_path.is_file():
        raise RuntimeError(f"sanitized Plan 7 fixture is absent: {fixture_path}")
    fixture = json.loads(fixture_path.read_text())
    if fixture.get("schema") != 1 or fixture.get("build") != CLIENT_BUILD:
        raise RuntimeError("sanitized Plan 7 fixture has the wrong schema or build")
    expected_client = fixture.get("client_milestones")
    expected_server = fixture.get("server_milestones")
    if generation["evidence"].get("client_milestones") != expected_client:
        raise RuntimeError("real-client milestones differ from the sanitized fixture")
    if generation["evidence"].get("server_milestones") != expected_server:
        raise RuntimeError("real-server milestones differ from the sanitized fixture")
    replay_root = Path(generation["root"]) / "evidence/plan6-replay"
    replay_root.mkdir(parents=True, exist_ok=True)
    replay_manifest = replay_root / "manifest.json"
    inputs = generation["inputs"]
    prepare_command = [
        sys.executable, str(PLAN6_RUNNER), "prepare", "--manifest", str(replay_manifest),
        "--migration", str(inputs["migration"]), "--client", str(Path(str(inputs["client_root"])) / "Wow-64.exe"),
        "--bottle", str(inputs["personal_bottle"]),
    ]
    normalized: dict[str, object] | None = None
    try:
        run_command(prepare_command, timeout=1200)
        run_command([
            sys.executable, str(PLAN6_RUNNER), "run", "--manifest", str(replay_manifest),
            "--authserver", str(inputs["authserver"]["path"]),
            "--unit-tests", str(inputs["unit_tests"]["path"]),
        ], timeout=600)
        replay_manifest_value = json.loads(replay_manifest.read_text())
        replay_evidence = replay_manifest_value["generations"][-1]["evidence"]
        normalized = normalized_replay(replay_evidence)
        if normalized != fixture.get("plan6_replay"):
            raise RuntimeError("Plan 6 semantic replay differs from the sanitized fixture")
    finally:
        if replay_manifest.is_file():
            run_command(
                [sys.executable, str(PLAN6_RUNNER), "reset", "--manifest", str(replay_manifest)],
                timeout=180,
            )
    if normalized is None:
        raise RuntimeError("Plan 6 semantic replay produced no normalized evidence")
    generation["evidence"]["plan6_replay"] = normalized
    generation["replay_passed"] = True
    if accepted_state:
        set_state(generation, "replayed")
    else:
        generation["completed_state"] = "replayed"
    save_manifest(manifest_path, manifest)
    print("Plan 7 semantic replay passed")


def reset(args: argparse.Namespace) -> None:
    manifest_path = args.manifest.resolve()
    manifest = load_manifest(manifest_path)
    generation = active_generation(manifest)
    if generation["state"] == "reset":
        purged = []
        if args.purge_client_base:
            purge_client_base(manifest)
            purged.append("client base")
        if args.purge_database_cache:
            purge_database_cache(manifest_path, manifest)
            purged.append("database cache")
        if purged:
            save_manifest(manifest_path, manifest)
            print(f"purged cached real-client {' and '.join(purged)}")
            return
        print(f"generation {generation['number']} is already reset")
        return
    completed_state = generation["state"]
    stop_wine(generation)
    stop_servers(generation)
    docker = generation["docker"]
    container = run_command(["docker", "inspect", str(docker["container"])], check=False)
    if container.returncode == 0:
        details = assert_container_owned(manifest, generation)
        run_command(["docker", "rm", "-f", details["Name"].removeprefix("/")])
    volume_result = run_command(["docker", "volume", "inspect", str(docker["volume"])], check=False)
    if volume_result.returncode == 0:
        volume = json.loads(volume_result.stdout)[0]
        labels = volume.get("Labels") or {}
        expected = {
            "org.azerothcore.plan": plan_number(str(generation["mode"])),
            "org.azerothcore.run_id": manifest["run_id"],
            "org.azerothcore.generation": str(generation["number"]),
        }
        if any(labels.get(key) != value for key, value in expected.items()):
            raise RuntimeError("refusing to remove a volume whose ownership labels changed")
        run_command(["docker", "volume", "rm", str(docker["volume"])])
    for key in ("client", "data", "xdg_data", "xdg_config", "xdg_cache", "xdg_state", "wine_prefix"):
        path = Path(generation["paths"][key])
        if path.exists():
            remove_owned_path(path, generation)
    unchanged = protected_inputs_unchanged(manifest, generation)
    generation["isolation_unchanged"] = unchanged
    if isinstance(generation.get("evidence"), dict):
        generation["evidence"]["protected_inputs_unchanged"] = unchanged
        generation["evidence"]["reset"] = "PASS" if unchanged else "FAIL"
    generation["completed_state"] = completed_state
    set_state(generation, "reset")
    if args.purge_client_base:
        purge_client_base(manifest)
    if args.purge_database_cache:
        purge_database_cache(manifest_path, manifest)
    save_manifest(manifest_path, manifest)
    for port in generation["ports"].values():
        require_unused(int(port))
    if not unchanged:
        raise RuntimeError("protected client or personal Bottle metadata changed during Plan 7")
    print(f"reset generation {generation['number']}; evidence remains under {generation['root']}")


def comparison_projection(evidence: dict[str, object]) -> dict[str, object]:
    return {
        "schema": evidence.get("schema"),
        "build": evidence.get("build"),
        "mode": evidence.get("mode"),
        "outcome": evidence.get("outcome"),
        "client_milestones": evidence.get("client_milestones"),
        "server_milestones": evidence.get("server_milestones"),
        "payload_shape": evidence.get("payload_shape"),
        "inputs": evidence.get("inputs"),
        "character_rows": evidence.get("character_rows"),
        "realm_character_count": evidence.get("realm_character_count"),
        "enumerated": evidence.get("enumerated"),
        "empty_response_payload": evidence.get("empty_response_payload"),
        "response_body": evidence.get("response_body"),
        "selection": evidence.get("selection"),
        "pre_map_packet_prefix": evidence.get("pre_map_packet_prefix"),
        "pre_map_marker_count": evidence.get("pre_map_marker_count"),
        "map_insertion_packet_prefix": evidence.get("map_insertion_packet_prefix"),
        "map_insertion_marker_count": evidence.get("map_insertion_marker_count"),
        "in_world_control_packet_prefix": evidence.get("in_world_control_packet_prefix"),
        "in_world_control_marker_count": evidence.get("in_world_control_marker_count"),
        "post_marker_hold_seconds": evidence.get("post_marker_hold_seconds"),
        "post_marker_snapshots": evidence.get("post_marker_snapshots"),
        "stability_seconds": evidence.get("stability_seconds"),
        "endpoint_ownership": evidence.get("endpoint_ownership"),
        "owned_window": evidence.get("owned_window"),
        "screen_confirmed": evidence.get("screen_confirmed"),
        "forbidden_opcodes": evidence.get("forbidden_opcodes"),
        "protected_inputs_unchanged": evidence.get("protected_inputs_unchanged"),
        "reset": evidence.get("reset"),
    }


def compare_last_two(args: argparse.Namespace) -> None:
    manifest = load_manifest(args.manifest.resolve())
    candidates = [
        item for item in manifest["generations"]
        if item.get("state") == "reset"
        and item.get("completed_state") in {"accepted", "replayed"} and item.get("isolation_unchanged")
        and item.get("evidence")
    ]
    if candidates:
        mode = candidates[-1].get("mode")
        candidates = [item for item in candidates if item.get("mode") == mode]
    if len(candidates) < 2:
        raise RuntimeError("two reset, accepted generations of the same mode are required")
    left, right = candidates[-2:]
    if left["number"] == right["number"]:
        raise RuntimeError("repeatability comparison requires distinct generations")
    if comparison_projection(left["evidence"]) != comparison_projection(right["evidence"]):
        raise RuntimeError("the last two sanitized results differ")
    print(json.dumps({
        "generations": [left["number"], right["number"]],
        "repeatable": True,
        "replay_passed": bool(left.get("replay_passed") or right.get("replay_passed")),
    }, sort_keys=True))


def self_check() -> None:
    sample = """one LOGIN_STATE_AUTHENTICATED LOGIN_OK
two COP_CONNECT RESPONSE_CONNECTED TRUE
three COP_AUTHENTICATE AUTH_OK TRUE
four Initiating: COP_GET_CHARACTERS
"""
    assert matched_milestones(sample) == [name for name, _ in CLIENT_MILESTONES]
    assert matched_milestones(sample.replace("AUTH_OK", "AUTH_FAILED")) == ["auth_login_ok", "world_connected"]
    character_sample = """one LOGIN_STATE_AUTHENTICATED LOGIN_OK
two COP_CONNECT RESPONSE_CONNECTED TRUE
three COP_AUTHENTICATE AUTH_OK TRUE
four Completed: COP_GET_CHARACTERS result=TRUE
"""
    assert matched_milestones(character_sample, CHARACTER_MILESTONES) == [name for name, _ in CHARACTER_MILESTONES]
    assert matched_milestones(character_sample.replace("result=TRUE", "result=FALSE"), CHARACTER_MILESTONES) == [
        "auth_login_ok", "world_connected", "world_auth_ok",
    ]
    assert stability_seconds("5") == 5
    try:
        stability_seconds("4")
    except argparse.ArgumentTypeError:
        pass
    else:
        raise AssertionError("stability below five seconds was accepted")
    assert len(srp_registration(ACCOUNT, PASSWORD, bytes(range(1, 33)))) == 32
    generation: Generation = {
        "mode": "authentication",
        "ports": {"world": 18085},
        "processes": [],
        "paths": {"raw_evidence": "/abs/private"},
        "inputs": {
            "authserver": {"sha256": "a" * 64}, "worldserver": {"sha256": "b" * 64},
            "data_dbc_hash": "c" * 64, "data_maps_hash": "d" * 64,
        },
    }
    transcript = [
        {"direction": "c2s", "opcode": "CMSG_AUTH_SESSION"},
        {"direction": "s2c", "opcode": "SMSG_AUTH_RESPONSE"},
        {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
    ]
    evidence = sanitized_evidence(generation, [name for name, _ in CLIENT_MILESTONES], transcript)
    encoded = json.dumps(evidence, sort_keys=True)
    assert "/abs/private" not in encoded and ACCOUNT not in encoded and PASSWORD not in encoded
    assert evidence["next_server_packet"] == {"opcode": "SMSG_CHAR_ENUM", "status": "candidate/inconclusive"}
    character_generation = dict(generation)
    character_generation["mode"] = "character-screen"
    character_generation["stability_seconds"] = 10
    character_evidence = sanitized_evidence(
        character_generation,
        [name for name, _ in CHARACTER_MILESTONES],
        [
            {"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
            {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
        ],
        character_rows=0,
        screen_confirmed=True,
    )
    assert character_evidence["empty_response_payload"] == EMPTY_CHARACTER_ENUM_PAYLOAD
    assert character_evidence["forbidden_opcodes"] == []
    assert "CMSG_PLAYER_LOGIN" in sanitized_evidence(
        character_generation,
        [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"}],
    )["forbidden_opcodes"]
    populated_generation = dict(character_generation)
    populated_generation["mode"] = POPULATED_MODE
    expected_character = {
        "guid_low": CHARACTER_GUID, "name": CHARACTER_NAME, "race": CHARACTER_RACE,
        "class": CHARACTER_CLASS, "gender": 0,
        "level": 1, "map": CHARACTER_MAP, "zone": CHARACTER_ZONE,
        "list_position": CHARACTER_LIST_POSITION,
        "flags": 0, "flags2": 0, "visual_items_nonzero": 0,
    }
    populated_evidence = sanitized_evidence(
        populated_generation, [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
         {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"}],
        character_rows=1, realm_count=1, enumerated=expected_character, screen_confirmed=True,
    )
    assert len(POPULATED_CHARACTER_ENUM_PAYLOAD) == 278 * 2
    assert populated_evidence["response_body"] == POPULATED_CHARACTER_ENUM_PAYLOAD
    assert populated_evidence["realm_character_count"] == 1
    assert populated_evidence["enumerated"] == expected_character
    assert plan_number(POPULATED_MODE) == "9"
    selection_generation = dict(populated_generation)
    selection_generation["mode"] = CHARACTER_SELECTION_MODE
    selection_evidence = sanitized_evidence(
        selection_generation, [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
         {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
         {"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"}],
        character_rows=1, realm_count=1, enumerated=expected_character, screen_confirmed=True,
        selection={
            "action": "enter", "seeded_guid_low": CHARACTER_GUID,
            "enumerated_guid_low": CHARACTER_GUID, "request_guid_low": CHARACTER_GUID,
            "callback_guid_low": CHARACTER_GUID, "legit_characters_admission": True,
        }, downstream_diagnostic="not-observed",
    )
    assert selection_evidence["forbidden_opcodes"] == []
    assert plan_number(CHARACTER_SELECTION_MODE) == "10"
    initial_packets_generation = dict(selection_generation)
    initial_packets_generation["mode"] = INITIAL_POST_LOAD_PACKETS_MODE
    initial_packets_generation["post_marker_hold_seconds"] = 5
    initial_packets_generation["post_marker_snapshots"] = 2
    initial_packets_evidence = sanitized_evidence(
        initial_packets_generation, [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
         {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
         {"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"}],
        character_rows=1, realm_count=1, enumerated=expected_character, screen_confirmed=True,
        selection={
            "action": "enter", "seeded_guid_low": CHARACTER_GUID,
            "enumerated_guid_low": CHARACTER_GUID, "request_guid_low": CHARACTER_GUID,
            "callback_guid_low": CHARACTER_GUID, "legit_characters_admission": True,
        }, initial_packet_prefix_value=["SMSG_SETUP_CURRENCY"], pre_map_marker_count=1,
    )
    assert initial_packets_evidence["forbidden_opcodes"] == []
    assert initial_packets_evidence["pre_map_packet_prefix"] == ["SMSG_SETUP_CURRENCY"]
    assert plan_number(INITIAL_POST_LOAD_PACKETS_MODE) == "11"
    map_insertion_generation = dict(selection_generation)
    map_insertion_generation["mode"] = MAP_INSERTION_MODE
    map_insertion_generation["post_marker_hold_seconds"] = 5
    map_insertion_generation["post_marker_snapshots"] = 2
    map_insertion_evidence = sanitized_evidence(
        map_insertion_generation, [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
         {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
         {"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"}],
        character_rows=1, realm_count=1, enumerated=expected_character, screen_confirmed=True,
        selection={
            "action": "enter", "seeded_guid_low": CHARACTER_GUID,
            "enumerated_guid_low": CHARACTER_GUID, "request_guid_low": CHARACTER_GUID,
            "callback_guid_low": CHARACTER_GUID, "legit_characters_admission": True,
        },
        map_insertion_prefix_value=["SMSG_LOGIN_VERIFY_WORLD", "SMSG_UPDATE_OBJECT"],
        map_insertion_marker_count_value=1,
    )
    assert map_insertion_evidence["forbidden_opcodes"] == []
    assert map_insertion_evidence["map_insertion_packet_prefix"] == ["SMSG_LOGIN_VERIFY_WORLD", "SMSG_UPDATE_OBJECT"]
    assert plan_number(MAP_INSERTION_MODE) == "12"
    in_world_control_generation = dict(selection_generation)
    in_world_control_generation["mode"] = IN_WORLD_CONTROL_MODE
    in_world_control_generation["post_marker_hold_seconds"] = 5
    in_world_control_generation["post_marker_snapshots"] = 2
    in_world_control_evidence = sanitized_evidence(
        in_world_control_generation, [name for name, _ in CHARACTER_MILESTONES],
        [{"direction": "c2s", "opcode": "CMSG_CHAR_ENUM"},
         {"direction": "s2c", "opcode": "SMSG_CHAR_ENUM"},
         {"direction": "c2s", "opcode": "CMSG_PLAYER_LOGIN"}],
        character_rows=1, realm_count=1, enumerated=expected_character, screen_confirmed=True,
        selection={
            "action": "enter", "seeded_guid_low": CHARACTER_GUID,
            "enumerated_guid_low": CHARACTER_GUID, "request_guid_low": CHARACTER_GUID,
            "callback_guid_low": CHARACTER_GUID, "legit_characters_admission": True,
        },
        in_world_control_prefix_value=["S->C:SMSG_TIME_SYNC_REQ", "C->S:CMSG_TIME_SYNC_RESP"],
        in_world_control_marker_count_value=1,
    )
    assert in_world_control_evidence["forbidden_opcodes"] == []
    assert in_world_control_evidence["in_world_control_packet_prefix"] == [
        "S->C:SMSG_TIME_SYNC_REQ", "C->S:CMSG_TIME_SYNC_RESP",
    ]
    assert plan_number(IN_WORLD_CONTROL_MODE) == "13"
    assert not selection_proof_is_complete(selection_evidence["selection"], [], [])
    seed_sql = populated_character_seed_sql()
    assert "INSERT INTO `characters`" in seed_sql and "`order`,`innTriggerId`" in seed_sql
    assert "INSERT INTO `characters` VALUES" not in seed_sql
    assert replace_config("# Key = old\nOther=1\n", {"Key": "new"}) == "Key = new\nOther=1\n"
    with tempfile.TemporaryDirectory() as temporary:
        root = Path(temporary)
        sql_root = root / "sql"
        sql_root.mkdir()
        (sql_root / "one.sql").write_text("SELECT 1;\n")
        cache_key = database_cache_key("mysql-image", (("auth-base", sql_root),))
        assert cache_key == database_cache_key("mysql-image", (("auth-base", sql_root),))
        assert cache_key != database_cache_key("other-image", (("auth-base", sql_root),))
        (sql_root / "one.sql").write_text("SELECT 2;\n")
        assert cache_key != database_cache_key("mysql-image", (("auth-base", sql_root),))
        changed_key = database_cache_key("mysql-image", (("auth-base", sql_root),))
        nested = sql_root / "nested"
        nested.mkdir()
        (nested / "ignored.sql").write_text("SELECT 3;\n")
        assert changed_key == database_cache_key("mysql-image", (("auth-base", sql_root),))
        dump = root / "database-cache.sql"
        dump.write_bytes(b"database cache")
        cache_manifest: Manifest = {
            "root": str(root),
            "generations": [{"state": "reset"}],
            "database_cache": {
                "path": str(dump), "sha256": sha256(dump), "purged": False,
            },
        }
        cache_manifest["database_cache"]["state"] = "ready"
        cache_manifest_path = root / "manifest.json"
        save_manifest(cache_manifest_path, cache_manifest)
        purge_database_cache(cache_manifest_path, cache_manifest)
        assert not dump.exists() and "database_cache" not in cache_manifest
        dump.write_bytes(b"partial final")
        database_cache_staging_path(cache_manifest).write_bytes(b"partial staging")
        cache_manifest["database_cache"] = {
            "path": str(dump), "key": "cache-key", "state": "building",
        }
        save_manifest(cache_manifest_path, cache_manifest)
        assert reconcile_database_cache(cache_manifest_path, cache_manifest, "cache-key") is None
        assert not dump.exists() and not database_cache_staging_path(cache_manifest).exists()
        dump.write_bytes(b"corrupt")
        cache_manifest["database_cache"] = {
            "path": str(dump), "key": "cache-key", "sha256": "0" * 64, "state": "ready",
        }
        save_manifest(cache_manifest_path, cache_manifest)
        assert reconcile_database_cache(cache_manifest_path, cache_manifest, "cache-key") is None
        assert not dump.exists() and "database_cache" not in cache_manifest
        base = root / "base"
        base.mkdir()
        (base / "Wow-64.exe").write_bytes(b"client")
        (base / "Data/enUS").mkdir(parents=True)
        (base / "Data/enUS/realmlist.wtf").write_text("source realm\n")
        (base / "Data/enUS/locale-enUS.MPQ").write_bytes(b"locale")
        link_client_base(base, root / "client")
        assert (root / "client/Wow-64.exe").is_symlink()
        assert not (root / "client/WTF").is_symlink()
        assert not (root / "client/Data").is_symlink()
        assert (root / "client/Data/enUS/locale-enUS.MPQ").is_symlink()
        assert not (root / "client/Data/enUS/realmlist.wtf").exists()
        raw = root / "raw"
        raw.mkdir()
        (raw / "WorldServer.log").write_text(
            "Enumerated account 900000 character GUID Full: 0x0000000001020304 "
            "Type: Player Low: 16909060 at list position 7.\n"
        )
        enum_generation: Generation = {"paths": {"raw_evidence": str(raw), "logs": str(root / "logs")}}
        assert enumerated_characters(enum_generation) == [{
            "account_id": ACCOUNT_ID, "guid_low": CHARACTER_GUID, "list_position": CHARACTER_LIST_POSITION,
        }]
    auth_keys = (
        "RealmServerPort", "BindIP", "LogsDir", "PidFile", "RealmsStateUpdateDelay",
        "LoginDatabaseInfo", "Updates.EnableDatabases", "Updates.AutoSetup", "StrictVersionCheck",
        "SourceDirectory", "Appender.Auth", "Logger.root",
    )
    world_keys = (
        "RealmID", "WorldServerPort", "BindIP", "LoginDatabaseInfo", "WorldDatabaseInfo",
        "CharacterDatabaseInfo", "DataDir", "LogsDir", "PidFile", "Console.Enable",
        "Updates.EnableDatabases", "Updates.AutoSetup", "Expansion", "MoveMaps.Enable",
        "vmap.enableLOS", "vmap.enableHeight", "Warden.Enabled", "Ra.Enable", "SOAP.Enabled",
        "Cluster.Enabled", "Appender.Server", "Logger.network", "Logger.network.opcode",
    )
    replace_config(
        (REPO_ROOT / "src/server/apps/authserver/authserver.conf.dist").read_text(),
        {key: "test" for key in auth_keys},
    )
    replace_config(
        (REPO_ROOT / "src/server/apps/worldserver/worldserver.conf.dist").read_text(),
        {key: "test" for key in world_keys},
    )
    assert client_login_points(60, 1, 1800, 1042) == ((971, 560), (971, 650), (971, 785))
    assert x_keysym_name("A") == "a" and x_keysym_name("Escape") == "Escape"
    window_sample = "0x08400003 0 3597195 124 4 1800 1042 steam_proton.steam_proton host World of Warcraft"
    assert owned_wow_window(window_sample, {3597195}) == ("0x08400003", 124, 4, 1800, 1042)
    assert owned_wow_window(window_sample, {1}) is None
    state: Generation = {"state": "allocating"}
    set_state(state, "prepared")
    try:
        set_state(state, "accepted")
    except RuntimeError:
        pass
    else:
        raise AssertionError("invalid state transition was accepted")
    print("Plan 7-13 runner self-check passed")


def stability_seconds(value: str) -> int:
    try:
        result = int(value)
    except ValueError as error:
        raise argparse.ArgumentTypeError("stability seconds must be an integer") from error
    if result < 5:
        raise argparse.ArgumentTypeError("stability seconds must be at least 5")
    return result


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    subcommands = result.add_subparsers(dest="command", required=True)
    subcommands.add_parser("self-check")
    prepare_parser = subcommands.add_parser("prepare")
    prepare_parser.add_argument("--manifest", type=Path, required=True)
    prepare_parser.add_argument("--authserver", type=Path, required=True)
    prepare_parser.add_argument("--worldserver", type=Path, required=True)
    prepare_parser.add_argument("--unit-tests", type=Path, required=True)
    prepare_parser.add_argument("--client-root", type=Path, required=True)
    prepare_parser.add_argument("--data-root", type=Path, required=True)
    prepare_parser.add_argument("--server-dbc-root", type=Path)
    prepare_parser.add_argument("--wine-runner", type=Path, required=True)
    prepare_parser.add_argument("--personal-bottle", type=Path, required=True)
    prepare_parser.add_argument("--migration", type=Path, default=DEFAULT_MIGRATION)
    prepare_parser.add_argument("--display", required=True)
    prepare_parser.add_argument("--xauthority", type=Path)
    prepare_parser.add_argument(
        "--mode", choices=(
            "no-login", "authentication", "character-screen", POPULATED_MODE, CHARACTER_SELECTION_MODE,
            INITIAL_POST_LOAD_PACKETS_MODE, MAP_INSERTION_MODE, IN_WORLD_CONTROL_MODE,
        ), default="authentication",
    )
    prepare_parser.add_argument("--minimum-free-gib", type=int, default=25)
    run_parser = subcommands.add_parser("run")
    run_parser.add_argument("--manifest", type=Path, required=True)
    run_parser.add_argument("--timeout", type=int, default=300)
    run_parser.add_argument("--no-login-seconds", type=int, default=20)
    run_parser.add_argument("--stability-seconds", type=stability_seconds, default=10)
    run_parser.add_argument("--auto-login", action="store_true")
    verify_parser = subcommands.add_parser("verify")
    verify_parser.add_argument("--manifest", type=Path, required=True)
    verify_parser.add_argument("--confirm-expected-screen", action="store_true")
    replay_parser = subcommands.add_parser("replay")
    replay_parser.add_argument("--manifest", type=Path, required=True)
    replay_parser.add_argument("--fixture", type=Path, default=DEFAULT_FIXTURE)
    reset_parser = subcommands.add_parser("reset")
    reset_parser.add_argument("--manifest", type=Path, required=True)
    reset_parser.add_argument("--purge-client-base", action="store_true")
    reset_parser.add_argument("--purge-database-cache", action="store_true")
    compare_parser = subcommands.add_parser("compare-last-two")
    compare_parser.add_argument("--manifest", type=Path, required=True)
    return result


def main() -> int:
    args = parser().parse_args()
    actions = {
        "prepare": prepare,
        "run": run_client,
        "verify": verify,
        "replay": replay,
        "reset": reset,
        "compare-last-two": compare_last_two,
    }
    try:
        if args.command == "self-check":
            self_check()
        else:
            actions[args.command](args)
        return 0
    except (OSError, RuntimeError, subprocess.SubprocessError, AssertionError, ValueError, KeyError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
