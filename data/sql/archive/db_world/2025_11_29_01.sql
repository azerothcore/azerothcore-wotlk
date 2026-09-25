-- DB update 2025_11_29_00 -> 2025_11_29_01
--
SET @REPTRASH := 1;
SET @REPREGULAR := 18;
SET @REPBOSS := 275;
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPTRASH, `RewOnKillRepValue2` = @REPTRASH WHERE `creature_id` IN (30902, 30903);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPREGULAR, `RewOnKillRepValue2` = @REPREGULAR WHERE `creature_id` IN (30901, 30904, 30905, 30915, 30916, 30906, 30913, 30907, 30908, 30909, 30910, 30911, 30912, 30914);
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = @REPBOSS, `RewOnKillRepValue2` = @REPBOSS WHERE `creature_id` IN (31558, 31559, 31560, 31561);
