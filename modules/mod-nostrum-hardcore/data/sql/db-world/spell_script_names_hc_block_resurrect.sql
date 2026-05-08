-- mod-nostrum-hardcore: block resurrection casts on fallen HC players
-- Registers all class resurrection spells + jumper cables (WoTLK 3.3.5a)
-- to the spell_hc_block_resurrect SpellScript which fires in CheckCast,
-- before cast time begins, giving immediate feedback to the caster.

USE acore_world;

INSERT IGNORE INTO spell_script_names (spell_id, ScriptName) VALUES
-- Priest - Resurrection (ranks 1-7)
(2006,  'spell_hc_block_resurrect'),
(2010,  'spell_hc_block_resurrect'),
(10880, 'spell_hc_block_resurrect'),
(10881, 'spell_hc_block_resurrect'),
(20770, 'spell_hc_block_resurrect'),
(48948, 'spell_hc_block_resurrect'),
(48949, 'spell_hc_block_resurrect'),
-- Shaman - Ancestral Spirit (ranks 1-7)
(2008,  'spell_hc_block_resurrect'),
(20609, 'spell_hc_block_resurrect'),
(20610, 'spell_hc_block_resurrect'),
(20776, 'spell_hc_block_resurrect'),
(20777, 'spell_hc_block_resurrect'),
(20778, 'spell_hc_block_resurrect'),
(25590, 'spell_hc_block_resurrect'),
-- Paladin - Redemption (ranks 1-6)
(7328,  'spell_hc_block_resurrect'),
(10322, 'spell_hc_block_resurrect'),
(10324, 'spell_hc_block_resurrect'),
(20772, 'spell_hc_block_resurrect'),
(48952, 'spell_hc_block_resurrect'),
(48953, 'spell_hc_block_resurrect'),
-- Druid - Revive
(50769, 'spell_hc_block_resurrect'),
-- Druid - Rebirth (ranks 1-3)
(20484, 'spell_hc_block_resurrect'),
(26997, 'spell_hc_block_resurrect'),
(48477, 'spell_hc_block_resurrect'),
-- Death Knight - Raise Ally
(61999, 'spell_hc_block_resurrect'),
-- Items - Goblin Jumper Cables / XL
(8344,  'spell_hc_block_resurrect'),
(23725, 'spell_hc_block_resurrect');
