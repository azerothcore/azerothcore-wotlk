-- DB update 2026_11_08_02 -> 2026_11_09_00
-- The Beast's Chamber (UBRS): add spell focus spawns so the Brazier of Beckoning (Lord Valthalak)
-- and the Brazier of Invocation work across the whole room, not only near its south end
SET @OGUID := 2434;

DELETE FROM `gameobject` WHERE `id` IN (181050, 181096) AND `guid` BETWEEN @OGUID + 0 AND @OGUID + 15;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,
    `position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,
    `animprogress`,`state`,`ScriptName`,`VerifiedBuild`,`Comment`) VALUES
    -- Lord Valthalak Brazier Spell Focus
    (@OGUID + 0, 181050, 229, 0, 0, 1, 1, 7.8, -531.9, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 1, 181050, 229, 0, 0, 1, 1, 31.8, -531.5, 110.94, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 2, 181050, 229, 0, 0, 1, 1, 55.3, -531.8, 110.94, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 3, 181050, 229, 0, 0, 1, 1, 77.8, -532.1, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 4, 181050, 229, 0, 0, 1, 1, 21.1, -561.2, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 5, 181050, 229, 0, 0, 1, 1, 60.7, -561.7, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 6, 181050, 229, 0, 0, 1, 1, 93.1, -559.4, 110.36, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 7, 181050, 229, 0, 0, 1, 1, 128.0, -570.2, 107.01, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    -- Brazier of Invocation Spell Focus 20 yd
    (@OGUID + 8, 181096, 229, 0, 0, 1, 1, 7.8, -531.9, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 9, 181096, 229, 0, 0, 1, 1, 31.8, -531.5, 110.94, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 10, 181096, 229, 0, 0, 1, 1, 55.3, -531.8, 110.94, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 11, 181096, 229, 0, 0, 1, 1, 77.8, -532.1, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 12, 181096, 229, 0, 0, 1, 1, 21.1, -561.2, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 13, 181096, 229, 0, 0, 1, 1, 60.7, -561.7, 110.93, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 14, 181096, 229, 0, 0, 1, 1, 93.1, -559.4, 110.36, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL),
    (@OGUID + 15, 181096, 229, 0, 0, 1, 1, 128.0, -570.2, 107.01, 0.0, 0.0, 0.0, 0.0, 1.0, 180, 0, 1, '', 0, NULL);

-- Let the braziers reach the Lord Valthalak Trigger from anywhere in the room (farthest corner is ~105 yd away)
UPDATE `conditions` SET `ConditionValue2` = 110
WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 5 AND `SourceEntry` IN (181045, 181051)
AND `ConditionTypeOrReference` = 29 AND `ConditionValue1` = 16048;
