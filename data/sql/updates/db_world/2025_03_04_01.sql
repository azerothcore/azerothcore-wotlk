UPDATE creature_template
SET AIName = '', ScriptName = CASE
    WHEN entry = 3274 THEN 'quest_Kolkar_Pack_Runner'
    WHEN entry = 3275 THEN 'quest_Kolkar_Marauder'
    WHEN entry = 3397 THEN 'quest_Kolkar_Bloodcharger'
    ELSE ScriptName
END
WHERE entry IN (3274, 3275, 3397);
