-- DB update 2026_07_24_02 -> 2026_07_24_03
-- Higher Learning
UPDATE `smart_scripts` SET
    `action_type` = 41,
    `action_param1` = 0,
    `action_param2` = 0,
    `action_param3` = 0,
    `action_param4` = 0,
    `action_param5` = 0,
    `action_param6` = 0,
    `comment` = 'Higher Learning - Timed Event Triggered - Force Despawn'
WHERE `entryorguid` IN (
    192708, 192706, 192871, 192905,
    192710, 192886, 192869, 192880, 192895,
    192713, 192889, 192890, 192894, 192884,
    192866, 192891, 192872, 192881,
    192709, 192883, 192651, 192888,
    192711, 192653, 192887, 192652,
    192865, 192874, 192868, 192870, 192885,
    192867, 192882, 192707, 192896
)
  AND `source_type` = 1
  AND `id` = 1
  AND `link` = 0
  AND `event_type` = 59
  AND `event_param1` = 1
  AND `action_type` = 99
  AND `action_param1` = 3
  AND `target_type` = 1;
