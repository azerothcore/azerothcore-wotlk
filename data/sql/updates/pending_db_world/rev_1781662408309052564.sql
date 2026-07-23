-- Flesh Giant Spine (44009) - drop on quest Neutralizing the Plague
UPDATE `creature_loot_template` SET `QuestRequired` = 0 WHERE `Entry` = 31139 AND `Item` = 44009;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 31139 AND `SourceEntry` = 44009;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`,
    `ConditionTypeOrReference`, `ConditionValue1`, `Comment`)
VALUES (1, 31139, 44009, 9, 13281, 'Pustulent Horror - Flesh Giant Spine requires quest Neutralizing the Plague');
