-- Gnomeregan: place players on the floor when entering through the main entrance.
UPDATE `areatrigger_teleport` SET
    `target_position_x` = -329.098,
    `target_position_y` = -3.20722,
    `target_position_z` = -152.851,
    `target_orientation` = 2.96706
WHERE `ID` = 324;
