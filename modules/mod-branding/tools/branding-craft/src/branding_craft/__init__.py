"""Single source of truth for mod-branding native profession crafting (#29).

The :mod:`branding_craft.catalog` module defines every Branded recipe exactly once. All shipped
artifacts -- the server world SQL (``spell_dbc``, ``skilllineability_dbc``, ``item_template``,
``branding_recipe``) and the client ``Spell.dbc`` patch -- are *generated* from that catalog, so the
client and server reagent definitions cannot drift (see #29 "Risks / notes").
"""

from .catalog import CATALOG, Catalog

__all__ = ["CATALOG", "Catalog"]
