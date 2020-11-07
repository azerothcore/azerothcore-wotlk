INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1604736110768509700');

/* Raise MinCount to match MaxCount for [Emblem of Triumph] in boss loot. */

UPDATE `creature_loot_template` SET `MinCount`=2 WHERE `MinCount`=1 AND `MaxCount`=2 AND `Item`=47241 AND `Entry` IN
(
15989, /* Sapphiron 10-man */
15990, /* Kel'thuzad 10-man */
33885, /* XT-002 Deconstructor 25-man */
34175, /* Auriaya 25-man */
33724, /* Razorscale 25-man */
33694  /* Stormcaller Brundir 25-man */
);
