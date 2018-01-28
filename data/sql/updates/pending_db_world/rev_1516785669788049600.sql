INSERT INTO version_db_world (`sql_rev`) VALUES ('1516785669788049600');

-- Correct Ashbringer show on Tirion during DK campaign
UPDATE `creature_equip_template` SET `ItemID1` = 13262 WHERE `CreatureID` = 29175 AND `ID` = 1;
