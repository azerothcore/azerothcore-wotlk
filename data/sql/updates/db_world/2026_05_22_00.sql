-- DB update 2026_05_20_00 -> 2026_05_22_00
--
-- Quest 'The Deadliest Trap Ever Laid' (11097/11101): kill counter survives evade
--

UPDATE `smart_scripts` SET `event_type` = 38, `event_param1` = 1, `event_param2` = 20, `comment` = 'Commander Hobb - On Data Set field=1 value=20 - Run Script (Complete Quest)' WHERE `entryorguid` = 23434 AND `source_type` = 0 AND `id` = 11;
UPDATE `smart_scripts` SET `event_type` = 38, `event_param1` = 1, `event_param2` = 20, `comment` = 'Commander Arcus - On Data Set field=1 value=20 - Run Script (Complete Quest)' WHERE `entryorguid` = 23452 AND `source_type` = 0 AND `id` = 11;
UPDATE `smart_scripts` SET `action_type` = 242, `action_param1` = 1, `action_param2` = 1, `action_param3` = 0, `comment` = 'Dragonmaw Skybreaker - On Just Died - Inc Data field=1 +1 on Commander Hobb' WHERE `entryorguid` = 23440 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `action_type` = 242, `action_param1` = 1, `action_param2` = 1, `action_param3` = 0, `comment` = 'Dragonmaw Skybreaker - On Just Died - Inc Data field=1 +1 on Commander Arcus' WHERE `entryorguid` = 23441 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `action_type` = 45, `action_param1` = 1, `action_param2` = 0, `action_param3` = 0, `comment` = 'Commander Hobb - Actionlist - Seed Data field=1 value=0' WHERE `entryorguid` = 2343400 AND `source_type` = 9 AND `id` = 1;
UPDATE `smart_scripts` SET `action_type` = 45, `action_param1` = 1, `action_param2` = 0, `action_param3` = 0, `comment` = 'Commander Arcus - Actionlist - Seed Data field=1 value=0' WHERE `entryorguid` = 2345200 AND `source_type` = 9 AND `id` = 1;
