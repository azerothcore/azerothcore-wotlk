-- DB update 2022_12_06_19 -> 2022_12_06_20
--
UPDATE `smart_scripts` SET `event_phase_mask`=0, `event_flags`=1, `event_param2`=20 WHERE `entryorguid`=18311 AND `source_type`=0 AND `id`=3;
