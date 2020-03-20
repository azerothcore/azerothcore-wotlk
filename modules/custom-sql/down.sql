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


set @GENERAL_VENDOR_ID = 66002;
set @GENERAL_MENU_ID = 58020;

delete from `creature_template` where `entry` = @GENERAL_VENDOR_ID;
delete from `gossip_menu_option` where `menuid` = @GENERAL_MENU_ID;

set @WEP = 91005;
set @PVP = 91004;
set @META_GEMS = 91003;
set @GEMS = 91002;
set @ENCHANT_SCROLLS = 91001;
set @PVE_SET_HEAD = 91006;
set @PVE_SET_SH = 91007;
set @PVE_SET_CHEST = 91008;
set @PVE_SET_HAND = 91009;
set @PVE_SET_LEG = 91010;
set @PVE_OFFPART = 91011;
SET @TRINKETS = 91012;

delete from `npc_vendor` where `entry`= @META_GEMS;
delete from `npc_vendor` where `entry`= @GEMS;
delete from `npc_vendor` where `entry`= @ENCHANT_SCROLLS;
delete from `npc_vendor` where `entry`= @PVP;
delete from `npc_vendor` where `entry`= @WEP;
delete from `npc_vendor` where `entry`= @PVE_SET_HEAD;
delete from `npc_vendor` where `entry`= @PVE_SET_SH;
delete from `npc_vendor` where `entry`= @PVE_SET_CHEST;
delete from `npc_vendor` where `entry`= @PVE_SET_HAND;
delete from `npc_vendor` where `entry`= @PVE_SET_LEG;
delete from `npc_vendor` where `entry`= @PVE_OFFPART;
delete from `npc_vendor` where `entry`= @TRINKETS;

COMMIT;

