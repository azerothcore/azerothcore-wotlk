-- might not undo everything
-- only enough to be able to fully rerun custom-arena-craft-db.mods.sql

START TRANSACTION;

set @GLYPH_VENDOR_ID = 65002;
set @GLYPH_MENU_ID = 57020;


delete from `creature_template` where `entry` = @GLYPH_VENDOR_ID;
delete from `gossip_menu_option` where `menuid` = @GLYPH_MENU_ID;


SET @GLYPH_DK = 90001;
SET @GLYPH_DRUID = 90002;
SET @GLYPH_HUNTER = 90003;
SET @GLYPH_MAGE = 90004;
SET @GLYPH_PALA = 90005;
SET @GLYPH_PRIEST = 90006;
SET @GLYPH_ROG = 90007;
SET @GLYPH_SHAM = 90008;
SET @GLYPH_WL = 90009;
SET @GLYPH_WAR = 90010;

delete from `npc_vendor` where `entry`= @GLYPH_DK;
delete from `npc_vendor` where `entry` = @GLYPH_DRUID;
delete from `npc_vendor` where `entry` = @GLYPH_HUNTER;
delete from `npc_vendor` where `entry` = @GLYPH_MAGE;
delete from `npc_vendor` where `entry` = @GLYPH_PALA;
delete from `npc_vendor` where `entry` = @GLYPH_PRIEST;
delete from `npc_vendor` where `entry` = @GLYPH_ROG;
delete from `npc_vendor` where `entry` = @GLYPH_SHAM;
delete from `npc_vendor` where `entry` = @GLYPH_WL;
delete from `npc_vendor` where `entry` = @GLYPH_WAR;

COMMIT;
