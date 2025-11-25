--
-- flight animation correction
-- https://www.wowhead.com/npc=37230/spire-frostwyrm
-- https://www.wowhead.com/npc=37533/rimefang
-- https://www.wowhead.com/npc=37534/spinestalker
-- https://www.wowhead.com/npc=36853/sindragosa
UPDATE `creature_template_addon` SET `bytes1` = `bytes1` | 16777216 | 33554432 WHERE `entry` IN (37230, 37533, 37534, 36853);
