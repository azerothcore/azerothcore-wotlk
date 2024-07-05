-- DB update 2023_04_22_09 -> 2023_04_22_10
--
ALTER TABLE `creature_onkill_reputation` MODIFY `RewOnKillRepValue1` FLOAT NOT NULL DEFAULT 0;
ALTER TABLE `creature_onkill_reputation` MODIFY `RewOnKillRepValue2` FLOAT NOT NULL DEFAULT 0;
