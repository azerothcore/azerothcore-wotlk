from invasion_authoring.model import EventDef, EventType, Invasion, Project, Spawn
from invasion_authoring.storage import load_project, save_project


def test_save_load_round_trip(tmp_path):
    proj = Project(
        name="demo",
        invasions=[
            Invasion(
                name="inv",
                event=EventDef(zone_id=12, event_type=EventType.INVASION),
                spawns=[Spawn(local_id=1, template_id=299, x=1.0, y=2.0, z=3.0)],
            )
        ],
    )
    path = tmp_path / "demo.invasion"
    save_project(proj, path)
    assert path.exists()
    assert load_project(path) == proj
