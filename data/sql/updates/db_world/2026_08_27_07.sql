-- DB update 2026_08_27_06 -> 2026_08_27_07
-- [Howling Fjord] The Delicate Sound of Thunder - Part 1 (flying spline): mark the six Rocket
-- Jump escort paths as flying so the construct flies along the path instead of falling. The C++
-- side adds FORCED_MOVEMENT_FLY and EscortMovementGenerator now calls MoveSplineInit::SetFly()
-- for it. Applied on top of the Part 2 revision, which owns the full smart_scripts block for
-- (24825, 0); this only flips the SMART_ACTION_ESCORT_START rows to forcedMovement = 3 (fly).
UPDATE `smart_scripts` SET `action_param1` = 3
WHERE `entryorguid` = 24825 AND `source_type` = 0
  AND `action_type` = 53
  AND `action_param2` IN (24826, 24827, 24828, 24831, 24829, 24832);
