-- DB/Gameobject: Recalculate quaternion rotation values from orientation (TrinityCore commit 02cef6f034)
UPDATE `gameobject` SET `rotation2` = SIN(`orientation` / 2), `rotation3` = COS(`orientation` / 2) WHERE `rotation0` = 0 AND `rotation1` = 0;
