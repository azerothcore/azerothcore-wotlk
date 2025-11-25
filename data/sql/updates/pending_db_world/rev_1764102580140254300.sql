-- flight animation correction
-- https://www.wowhead.com/npc=37230/spire-frostwyrm
-- https://www.wowhead.com/npc=37533/rimefang
-- https://www.wowhead.com/npc=37534/spinestalker
-- https://www.wowhead.com/npc=36853/sindragosa

UPDATE `creature_template_addon` SET `bytes1` = 50331648 WHERE (`entry` = 37230);
UPDATE `creature_template_addon` SET `bytes1` = 50331648 WHERE (`entry` = 37533);
UPDATE `creature_template_addon` SET `bytes1` = 50331648 WHERE (`entry` = 37534);
UPDATE `creature_template_addon` SET `bytes1` = 50331648 WHERE (`entry` = 36853);