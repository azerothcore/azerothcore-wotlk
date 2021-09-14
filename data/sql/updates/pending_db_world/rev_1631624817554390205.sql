INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631624817554390205');

-- Flags: Orc 2, Undead 16, Tauren 32, Troll 128, Blood Elf 512

-- The Mindless Ones and Rattling the Rattlecages are now Horde only from undead only
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|2|16|32|128|512 WHERE (`ID` IN (364, 3901));

-- Simple scroll, Encrypted Scroll, Hallowed Scroll, Glyphic Scroll and Tainted Scroll are now undead only from Horde only
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(2|16|32|128|512) WHERE (`ID` IN (3095, 3096, 3097, 3098, 3099));

-- Remove the prerequisite quest of The Mindless Ones
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE (`ID` = 364);

