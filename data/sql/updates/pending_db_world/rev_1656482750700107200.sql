--
-- Mar'li - Gri'lek
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~256 WHERE `entry` IN (14510, 15082);
