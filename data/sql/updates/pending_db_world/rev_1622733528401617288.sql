INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622733528401617288');

UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1
WHERE `guid` IN (
    SELECT c.guid 
    FROM 
	`creature` c 
	JOIN `creature_template` ct ON c.id = ct.entry
    WHERE c.wander_distance = 0 
    AND c.MovementType = 0 
    AND (ct.name LIKE "%Razormaw%" OR ct.name LIKE "%Bloodfen%" OR ct.name = "Goreclaw the Ravenous")
);
