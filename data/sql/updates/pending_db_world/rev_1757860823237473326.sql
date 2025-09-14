--
UPDATE `conditions` 
SET `ConditionTypeOrReference` = 8, 
    `Comment` = 'Show gossip only if Fervor of the Frostborn quest completed'
WHERE `SourceTypeOrReferenceId` = 15 
AND `SourceGroup` = 9891 
AND `SourceEntry` = 0 
AND `ConditionValue1` = 12874;
