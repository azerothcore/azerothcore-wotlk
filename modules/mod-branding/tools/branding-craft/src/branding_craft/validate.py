"""Drift guard for the craft catalog (#29 "Risks / notes").

Two jobs:

* :func:`validate` -- internal consistency of the catalog (entry bands §16.4, bind model §16.3,
  unique ids, sane skill gates). Run before emitting anything.
* :func:`recipe_mirror_rows` / :func:`diff_recipe_mirror` -- the lockstep check between the catalog's
  reagent counts and an external ``branding_recipe`` row set (e.g. parsed from the committed SQL or
  read from the live world DB). A craft spell whose reagents disagree with its ``branding_recipe``
  mirror is exactly the failure mode the issue warns about; CI runs this so it can never ship.
"""

from __future__ import annotations

from . import constants as C
from .catalog import CATALOG, Catalog


def validate(catalog: Catalog = CATALOG) -> list[str]:
    """Return a list of human-readable problems; empty means the catalog is internally sound."""

    problems: list[str] = []

    # Resources sit in the resource sub-band with the decided bind model.
    for res, want_bind in ((catalog.material, C.BIND_WHEN_EQUIPPED), (catalog.fragment, C.BIND_TO_ACCOUNT)):
        if res.entry not in C.RESOURCE_BAND:
            problems.append(f"resource {res.entry} ({res.name}) outside resource band {C.RESOURCE_BAND}")
        if res.bonding != want_bind:
            problems.append(f"resource {res.name} bonding {res.bonding} != required {want_bind} (§16.3)")

    # Per-school Fragments: one per BrandId, laid out as SCHOOL_FRAGMENT_BASE + school (the C++ adapter
    # depends on this offset), BoA like the generic Fragment, all within the school-Fragment sub-band.
    if len(catalog.school_fragments) != C.BRAND_SCHOOL_COUNT:
        problems.append(
            f"school Fragments: {len(catalog.school_fragments)} entries != {C.BRAND_SCHOOL_COUNT} BrandIds"
        )
    for school, frag in enumerate(catalog.school_fragments):
        want_entry = C.SCHOOL_FRAGMENT_BASE + school
        if frag.entry != want_entry:
            problems.append(f"school Fragment {frag.name}: entry {frag.entry} != base+school {want_entry}")
        if frag.entry not in C.SCHOOL_FRAGMENT_BAND:
            problems.append(f"school Fragment {frag.entry} outside band {C.SCHOOL_FRAGMENT_BAND}")
        if frag.bonding != C.BIND_TO_ACCOUNT:
            problems.append(f"school Fragment {frag.name} bonding {frag.bonding} != BoA (§16.3)")

    seen_recipe_ids: set[int] = set()
    seen_entries: set[int] = {catalog.material.entry, catalog.fragment.entry}
    seen_entries |= {f.entry for f in catalog.school_fragments}
    seen_spells: set[int] = set()
    seen_sla: set[int] = set()

    for r in catalog.recipes:
        ctx = f"recipe {r.id} ({r.name})"

        if r.id in seen_recipe_ids:
            problems.append(f"{ctx}: duplicate recipe id")
        seen_recipe_ids.add(r.id)

        # Band membership (§16.4) for every emitted entry / id.
        if r.output.entry not in C.OUTPUT_BAND:
            problems.append(f"{ctx}: output {r.output.entry} outside output band {C.OUTPUT_BAND}")
        if r.pattern_entry not in C.PATTERN_BAND:
            problems.append(f"{ctx}: pattern {r.pattern_entry} outside pattern band {C.PATTERN_BAND}")
        if r.spell_id not in C.CRAFT_SPELL_BAND:
            problems.append(f"{ctx}: spell {r.spell_id} outside craft-spell band {C.CRAFT_SPELL_BAND}")
        if r.skill_line_ability_id not in C.SKILL_LINE_ABILITY_BAND:
            problems.append(f"{ctx}: skilllineability id {r.skill_line_ability_id} outside band")

        # Uniqueness across the whole catalog.
        for value, pool, label in (
            (r.output.entry, seen_entries, "item entry"),
            (r.pattern_entry, seen_entries, "item entry"),
            (r.spell_id, seen_spells, "spell id"),
            (r.skill_line_ability_id, seen_sla, "skilllineability id"),
        ):
            if value in pool:
                problems.append(f"{ctx}: duplicate {label} {value}")
            pool.add(value)

        # Reagents: must consume something, counts non-negative.
        if r.material_count < 0 or r.fragment_count < 0:
            problems.append(f"{ctx}: negative reagent count")
        if r.material_count == 0 and r.fragment_count == 0:
            problems.append(f"{ctx}: no reagents -- a free craft is not allowed")

        # School: a real BrandId (per-school Fragment) or the generic sentinel (generic Fragment).
        if not (r.school < C.BRAND_SCHOOL_COUNT or r.school == C.BRAND_GENERIC):
            problems.append(f"{ctx}: school {r.school} is neither a BrandId (<{C.BRAND_SCHOOL_COUNT}) nor generic")

        # Skill gate sanity: learnable at req, greys out at/after trivial_high.
        if r.trivial_high < r.req_skill_value:
            problems.append(f"{ctx}: trivial_high {r.trivial_high} < req_skill_value {r.req_skill_value}")

        # The output's RequiredSkill must match the recipe's profession so the gate holds without #29.
        if r.output.required_skill != r.skill_line:
            problems.append(
                f"{ctx}: output RequiredSkill {r.output.required_skill} != recipe skill_line {r.skill_line}"
            )

    return problems


def assert_valid(catalog: Catalog = CATALOG) -> None:
    problems = validate(catalog)
    if problems:
        raise ValueError("invalid craft catalog:\n  " + "\n  ".join(problems))


def recipe_mirror_rows(catalog: Catalog = CATALOG) -> dict[int, dict[str, int]]:
    """The ``branding_recipe`` rows the catalog implies, keyed by recipe id.

    Matches the #09 loader query exactly: id, materials, fragments, output_item, char_xp.
    """

    return {
        r.id: {
            "materials": r.material_count,
            "fragments": r.fragment_count,
            "output_item": r.output.entry,
            "char_xp": r.char_xp,
            "school": r.school,
        }
        for r in catalog.recipes
    }


def diff_recipe_mirror(actual: dict[int, dict[str, int]], catalog: Catalog = CATALOG) -> list[str]:
    """Compare an external ``branding_recipe`` row set to the catalog; return drift descriptions.

    ``actual`` maps recipe id -> {materials, fragments, output_item, char_xp}. This is the lockstep
    guard: any difference means the server mirror and the (catalog-generated) craft-spell reagents
    have drifted apart.
    """

    problems: list[str] = []
    expected = recipe_mirror_rows(catalog)

    for rid in sorted(set(expected) | set(actual)):
        if rid not in actual:
            problems.append(f"recipe {rid}: missing from branding_recipe (catalog expects it)")
            continue
        if rid not in expected:
            problems.append(f"recipe {rid}: present in branding_recipe but not in catalog")
            continue
        for col, want in expected[rid].items():
            got = actual[rid].get(col)
            if got != want:
                problems.append(f"recipe {rid}: {col} = {got} but catalog says {want}")

    return problems
