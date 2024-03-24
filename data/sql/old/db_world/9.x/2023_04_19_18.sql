-- DB update 2023_04_19_17 -> 2023_04_19_18
--
UPDATE `smart_scripts` SET `event_flags`=0, `event_param1`=8000, `event_param2`=12000, `event_param3`=28000, `event_param4`=32000, `target_type`=6, `comment`='Fel Overseer - In Combat - Cast \'Frightening Shout\'' WHERE `entryorguid`=18796 AND `source_type`=0 AND `id`=3 AND `link`=0;

