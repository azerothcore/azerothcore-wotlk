INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606881109355464500');

-- Text improvements

UPDATE `creature_text` SET `Text`='The Lich King is here? Then my destiny shall be fulfilled on this day! ' WHERE  `CreatureID`=37223 AND `GroupID`=27 AND `ID`=0;
UPDATE `creature_text` SET `Text`='Aye. ARRRRRRGHHHH... He... He is coming. You... You must...' WHERE  `CreatureID`=37225 AND `GroupID`=35 AND `ID`=0;

