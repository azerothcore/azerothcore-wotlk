-- DB update 2026_02_19_05 -> 2026_02_19_06
-- Blood Presence (63611): rename script to match new class name
UPDATE `spell_script_names` SET `ScriptName` = 'spell_dk_improved_blood_presence_triggered' WHERE `spell_id` = 63611;
