INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629485842027723200');

ALTER TABLE `playercreateinfo_item`
    CHANGE `amount` `amount` TINYINT(4) SIGNED NOT NULL DEFAULT 1;

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`) VALUES (0, 6, 40582, -1, "[PH] Scrouge Hearthstone");
