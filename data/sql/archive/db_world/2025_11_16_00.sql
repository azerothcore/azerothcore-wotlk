-- DB update 2025_11_15_15 -> 2025_11_16_00
--
SET @REPTRASH := 1;
SET @REPREGULAR := 5;
SET @REPHULK := 10;
SET @REPBOSS := 50;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPTRASH, `RewOnKillRepValue2` = @REPTRASH WHERE `creature_id` IN (27636, 27638);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPREGULAR, `RewOnKillRepValue2` = @REPREGULAR WHERE `creature_id` IN (26550, 26553, 26554, 26669, 26670, 26672, 26685, 26683, 26684, 26686, 28368, 26696, 26694); -- UP
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPREGULAR, `RewOnKillRepValue2` = @REPREGULAR WHERE `creature_id` IN (27635, 27633, 27641, 27639, 27640, 27653, 27651, 27650, 27648, 27647, 27649, 27645, 27644, 27642); -- Oculus
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPBOSS, `RewOnKillRepValue2` = @REPBOSS WHERE `creature_id` IN (27654, 27447, 27655, 27656);
