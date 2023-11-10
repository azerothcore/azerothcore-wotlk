-- CREATURES SIT:
INSERT INTO creature_addon VALUES
(1970898, 0, 0, 5, 0, 0, 0, NULL),
(1970880, 0, 0, 5, 0, 0, 0, NULL),
(1970879, 0, 0, 5, 0, 0, 0, NULL),
(1970878, 0, 0, 5, 0, 0, 0, NULL),
(1970894, 0, 0, 5, 0, 0, 0, NULL),
(1970895, 0, 0, 5, 0, 0, 0, NULL),
(1970896, 0, 0, 5, 0, 0, 0, NULL),

-- CREATURES SLEEP:
(1970927, 0, 0, 3, 0, 0, 0, NULL),
(1970877, 0, 0, 3, 0, 0, 0, NULL);

-- UNCLICKABLE CHAIRS:
UPDATE `gameobject_template` SET `type` = 5, `Data0` = 0, `Data1` = 0 WHERE `entry` IN
(187521, 187515, 187514, 187512, 187519, 187522, 187523);

-- UNCLICKABLE BED:
UPDATE `gameobject_template` SET `type` = 5, `Data0` = 0, `Data1` = 0 WHERE
(`entry` = 187526 );
