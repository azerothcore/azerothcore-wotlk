SET @NEW_ENTRY = (SELECT MAX(entry) FROM `gameobject_template`) + 1;

INSERT INTO `gameobject_template` 
SELECT 
    @NEW_ENTRY AS entry,
    type, displayId, 'Dalaran Forge Spell Focus2' as name, IconName, castBarCaption, unk1, size,
    Data0, 16 AS Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9,
    Data10, Data11, Data12, Data13, Data14, Data15, Data16, Data17, Data18, Data19,
    Data20, Data21, Data22, Data23, AIName, ScriptName, VerifiedBuild
FROM `gameobject_template` 
WHERE `entry` = 30;

INSERT INTO `gameobject_template_locale` 
SELECT 
    @NEW_ENTRY AS entry,
    locale, name, castBarCaption, VerifiedBuild
FROM `gameobject_template_locale` 
WHERE `entry` = 30;

UPDATE `gameobject` 
SET `id` = @NEW_ENTRY 
WHERE `guid` = 5271;
