-- DB update 2022_07_02_02 -> 2022_07_03_00
--
UPDATE `smart_scripts` SET `event_flags`=512 WHERE `entryorguid`=24823 AND `source_type`=0;
UPDATE `smart_scripts` SET `event_phase_mask`=0, `event_param3`=5000, `event_param4`=5000 WHERE `entryorguid`=24718 AND `source_type`=0 AND `id`=1;
