import dataclasses

from branding_craft.catalog import CATALOG
from branding_craft.validate import diff_recipe_mirror, recipe_mirror_rows, validate


def test_shipped_catalog_is_valid():
    assert validate() == []


def test_duplicate_spell_id_is_caught():
    bad = dataclasses.replace(CATALOG, recipes=[
        CATALOG.recipes[0],
        dataclasses.replace(CATALOG.recipes[1], spell_id=CATALOG.recipes[0].spell_id),
    ])
    problems = validate(bad)
    assert any("duplicate spell id" in p for p in problems)


def test_free_craft_is_rejected():
    bad = dataclasses.replace(CATALOG, recipes=[
        dataclasses.replace(CATALOG.recipes[0], material_count=0, fragment_count=0),
    ])
    assert any("no reagents" in p for p in validate(bad))


def test_out_of_band_output_is_caught():
    bad = dataclasses.replace(CATALOG, recipes=[
        dataclasses.replace(
            CATALOG.recipes[0],
            output=dataclasses.replace(CATALOG.recipes[0].output, entry=12345),
        ),
    ])
    assert any("outside output band" in p for p in validate(bad))


def test_recipe_mirror_matches_itself():
    # The catalog must agree with the branding_recipe rows it implies (lockstep, #29).
    assert diff_recipe_mirror(recipe_mirror_rows()) == []


def test_recipe_mirror_detects_reagent_drift():
    actual = recipe_mirror_rows()
    actual[1]["materials"] += 1  # simulate hand-edited SQL drifting from the craft spell
    problems = diff_recipe_mirror(actual)
    assert any("recipe 1: materials" in p for p in problems)


def test_recipe_mirror_detects_missing_row():
    actual = recipe_mirror_rows()
    del actual[2]
    assert any("recipe 2: missing" in p for p in diff_recipe_mirror(actual))
