DELETE FROM dungeonrespawn_playerinfo;

ALTER TABLE dungeonrespawn_playerinfo
MODIFY guid BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY;