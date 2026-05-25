-- DB update 2024_06_21_01 -> 2024_06_21_02
-- add TRIGGER flag to 'Ribbon Pole Fire Spiral Bunny'
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 128) WHERE (`entry` = 25303);
