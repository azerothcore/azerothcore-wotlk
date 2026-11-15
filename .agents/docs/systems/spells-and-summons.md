# Spells and summons

## Spell scripts and data

- A `SpellScript`/`AuraScript` without a matching `spell_script_names` row is inert: ship the binding SQL update in
  the same change as the C++ registration.
