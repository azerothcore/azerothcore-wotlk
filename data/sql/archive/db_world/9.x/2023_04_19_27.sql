-- DB update 2023_04_19_26 -> 2023_04_19_27
-- Bosses on the Ogrila quest chain
-- Slaag
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|545470038 WHERE `entry` = 22199;
-- Maggoc, Grulloc, Skulloc Soulgrinder
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|579026774 WHERE `entry` IN (20600,20216,22910);
-- Vim'gol the Vile
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|579026775 WHERE `entry` = 22911;
