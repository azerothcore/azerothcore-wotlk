# Plan 18: remaining object update fields

Canonical issue: [#37](https://github.com/trolloks/azerothcore-cata/issues/37).

Status: complete in PR #51. The acceptance record lives in the issue.

The reusable isolated-client fixture is `apps/cata/seed_remaining_object_fields.py`. After preparing
an `in-world-control-bootstrap` generation, pass its manifest to the helper, then use the existing
runner. Open the equipped Small Brown Pouch manually and check the sword and jerky, the inventory
overlay, nearby chest, player corpse, and ground flames. Follow `plan/client-automation.md` for
isolation, capture, verification, and reset. Reuse the prepared database and built binaries.
