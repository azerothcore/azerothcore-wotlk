-- Bosses on the Ogrila quest chain
-- Slaag + no dodge
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|545470038, `flags_extra` = `flags_extra`|8388608 WHERE `entry` = 22199;
-- Maggoc, Grulloc, Skulloc Soulgrinder
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|579026774 WHERE `entry` IN (20600,20216,22910);
-- Vim'gol the Vile
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|579026775 WHERE `entry` = 22911;
