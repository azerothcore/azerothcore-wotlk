-- DB update 2023_04_04_03 -> 2023_04_04_04
--
-- Slows the repeat behavior of NPCs 263 (Lord Ello Ebonlocke), 269 (Role Dreuger), 270 (Councilman Millstripe), 271 (Ambassador Berrybuck), and 325 (Hogan Ference) dialogue to be more correctly timed
UPDATE `smart_scripts` SET `event_param3`=1306000, `event_param4`=1407000 WHERE `entryorguid`=263 AND `source_type`=0 AND `id`=1 AND `link`=0 AND `action_type`=1;
UPDATE `smart_scripts` SET `event_param3`=1052000, `event_param4`=1634000 WHERE `entryorguid`=269 AND `source_type`=0 AND `id`=0 AND `link`=0 AND `action_type`=1;
UPDATE `smart_scripts` SET `event_param3`=1394000, `event_param4`=1604000 WHERE `entryorguid`=270 AND `source_type`=0 AND `id`=0 AND `link`=0 AND `action_type`=1;
UPDATE `smart_scripts` SET `event_param3`=721000, `event_param4`=1607000 WHERE `entryorguid`=271 AND `source_type`=0 AND `id`=0 AND `link`=0 AND `action_type`=1;
UPDATE `smart_scripts` SET `event_param3`=305000, `event_param4`=355000 WHERE `entryorguid`=325 AND `source_type`=0 AND `id`=0 AND `link`=0 AND `action_type`=1;

-- Slows repeat behavior of Commander Althea Ebonlocke (NPC 264) text broadcasts
UPDATE `smart_scripts` SET `event_param3`=1202000, `event_param4`=3026000 WHERE `entryorguid`=264 AND `source_type`=0 AND `id`=1 AND `link`=0 AND `action_type`=1;
