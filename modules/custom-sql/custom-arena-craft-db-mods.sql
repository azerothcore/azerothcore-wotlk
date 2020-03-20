use acore_world;

update playercreateinfo set map=530, zone=3523, position_x=4119.16, position_y=2931.40, position_z=354.5232, orientation=4.665; 
delete from playercreateinfo_item;  


-- GLYPH VENDOR

START TRANSACTION;

set @GLYPH_VENDOR_ID = 65002;
set @GLYPH_MENU_ID = 57020;

insert into `creature_template` (
    `entry`,
    `modelid1`,
    `gossip_menu_id`,
    `name`,
    `subname`,
    `minlevel`, `maxlevel`,
    `ScriptName`,
    `VerifiedBuild`,
    `npcflag`
) values (
    @GLYPH_VENDOR_ID, 
    19960,
    @GLYPH_MENU_ID,
    'Glypheer',
    'Glyph vendor',
    80, 80,
    '',
    12340,
    129
);

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

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GLYPH_MENU_ID, 1, 3, 'Glyph - DEATH KNIGHT', 3, 128, @GLYPH_DK, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 2, 3, 'Glyph - DRUID', 3, 128, @GLYPH_DRUID, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 3, 3, 'Glyph - HUNTER', 3, 128, @GLYPH_HUNTER, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 4, 3, 'Glyph - MAGE', 3, 128, @GLYPH_MAGE, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 5, 3, 'Glyph - PALADIN', 3, 128, @GLYPH_PALA, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 6, 3, 'Glyph - PRIEST', 3, 128, @GLYPH_PRIEST, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 7, 3, 'Glyph - ROGUE', 3, 128, @GLYPH_ROG, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 8, 3, 'Glyph - SHAMAN', 3, 128, @GLYPH_SHAM, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 9, 3, 'Glyph - WARLOCK', 3, 128, @GLYPH_WL, 0, 0, 0, ''),
(@GLYPH_MENU_ID, 10, 3, 'Glyph - WARRIOR', 3, 128, @GLYPH_WAR, 0, 0, 0, '');

insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_DK, 0, 43533, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43534, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43536, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43537, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43538, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43541, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43542, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43543, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43545, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43546, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43547, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43548, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43549, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43550, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43551, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43552, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43553, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43554, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43825, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43826, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43827, 0, 0, 0, 0),
(@GLYPH_DK, 0, 44432, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45799, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45800, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45803, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45804, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45805, 0, 0, 0, 0),
(@GLYPH_DK, 0, 45806, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43535, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43539, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43544, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43671, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43672, 0, 0, 0, 0),
(@GLYPH_DK, 0, 43673, 0, 0, 0, 0);

insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_DRUID, 0, 40915, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 44928, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40921, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40900, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40906, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40908, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40920, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45601, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45602, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45603, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45604, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45622, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 45623, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40896, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40903, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40901, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40902, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40909, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40916, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40919, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 46372, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 48720, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40912, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40899, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40923, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40897, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40914, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40924, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40913, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 50125, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 40922, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 44922, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43334, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43331, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43316, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43674, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43332, 0, 0, 0, 0),
(@GLYPH_DRUID, 0, 43335, 0, 0, 0, 0);


insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_HUNTER, 0, 42913, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42914, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42902, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42915, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42916, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42917, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45625, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45731, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45732, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45733, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45734, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 45735, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43355, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42899, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43351, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42906, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42911, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42897, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42903, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42904, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42905, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42910, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42908, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42901, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42909, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43338, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43354, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43356, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 43350, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42898, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42907, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42900, 0, 0, 0, 0),
(@GLYPH_HUNTER, 0, 42912, 0, 0, 0, 0);


insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_MAGE, 0, 44684, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42748, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42745, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 44920, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42751, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 44955, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42754, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 50045, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42736, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 45736, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 45737, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 45738, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 45739, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 45740, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42749, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42744, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42750, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42737, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42738, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42746, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42747, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42753, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43360, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43357, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42734, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42741, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42743, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42735, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42752, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43364, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42740, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42742, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43361, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43362, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 42739, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43339, 0, 0, 0, 0),
(@GLYPH_MAGE, 0, 43359, 0, 0, 0, 0);



insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_PALA, 0, 41107, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41101, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43867, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43868, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43869, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41097, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45741, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45742, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45743, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45744, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45745, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45746, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 45747, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41109, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41104, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41110, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43369, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41102, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41094, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41098, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41099, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41103, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41105, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43365, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43368, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41100, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41096, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41108, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43366, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41095, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43367, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41092, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 41106, 0, 0, 0, 0),
(@GLYPH_PALA, 0, 43340, 0, 0, 0, 0);


insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_PRIEST, 0, 42404, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42414, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43374, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42396, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42403, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45753, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45755, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45756, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45757, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45758, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 45760, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42405, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42409, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42417, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43370, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43372, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42399, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42400, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42401, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42407, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42412, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42397, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42415, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43373, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42410, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42402, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42406, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42398, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42411, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42408, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43342, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 42416, 0, 0, 0, 0),
(@GLYPH_PRIEST, 0, 43371, 0, 0, 0, 0);



insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_ROG, 0, 42971, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42959, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42954, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45761, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45762, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45764, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45766, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45767, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45768, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45769, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 45908, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43378, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42957, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42967, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42968, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42958, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42965, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42969, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42955, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43376, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43380, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42963, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42962, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42964, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43377, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42970, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42973, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42974, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42960, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42966, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43379, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42956, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42961, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 42972, 0, 0, 0, 0),
(@GLYPH_ROG, 0, 43343, 0, 0, 0, 0);



insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_SHAM, 0, 41529, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41524, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 44923, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41552, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41517, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41538, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41539, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45770, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45771, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45772, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45775, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45776, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45777, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 45778, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41518, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41527, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41542, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43381, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43385, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43388, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41533, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41535, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41541, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41547, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43344, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43384, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43386, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41530, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 43725, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41531, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41532, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41540, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41537, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41526, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41534, 0, 0, 0, 0),
(@GLYPH_SHAM, 0, 41536, 0, 0, 0, 0);


insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_WL, 0, 43392, 0, 0, 0, 0),
(@GLYPH_WL, 0, 43394, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42459, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42472, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42457, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42454, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42463, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45779, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45780, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45781, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45782, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45783, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45785, 0, 0, 0, 0),
(@GLYPH_WL, 0, 45789, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42460, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42469, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42453, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42471, 0, 0, 0, 0),
(@GLYPH_WL, 0, 43393, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42468, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42466, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42470, 0, 0, 0, 0),
(@GLYPH_WL, 0, 43391, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42461, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42455, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42462, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42473, 0, 0, 0, 0),
(@GLYPH_WL, 0, 50077, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42456, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42458, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42465, 0, 0, 0, 0),
(@GLYPH_WL, 0, 43390, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42464, 0, 0, 0, 0),
(@GLYPH_WL, 0, 42467, 0, 0, 0, 0),
(@GLYPH_WL, 0, 43389, 0, 0, 0, 0);



insert into npc_vendor (
    `entry`,
    `slot`,
    `item`,
    `maxcount`,
    `incrtime`,
    `ExtendedCost`,
    `VerifiedBuild`
) values 
(@GLYPH_WAR, 0, 43419, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 49084, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43400, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43415, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45790, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45792, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45793, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45794, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45795, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 45797, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43412, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43421, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43425, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43432, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43428, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43416, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43414, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43426, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43398, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43420, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43431, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43424, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43422, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43396, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43427, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43429, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43417, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43399, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43430, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43397, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43413, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43423, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43395, 0, 0, 0, 0),
(@GLYPH_WAR, 0, 43418, 0, 0, 0, 0);

-- glyph end


COMMIT;


START TRANSACTION;

set @GENERAL_VENDOR_ID = 66002;
set @GENERAL_MENU_ID = 58020;

insert into `creature_template` (
    `entry`,
    `modelid1`,
    `gossip_menu_id`,
    `name`,
    `subname`,
    `minlevel`, `maxlevel`,
    `ScriptName`,
    `VerifiedBuild`,
    `npcflag`
) values (
    @GENERAL_VENDOR_ID, 
    19959,
    @GENERAL_MENU_ID,
    'Dealer Najeeb',
    'Gear vendor',
    80, 80,
    '',
    12340,
    129
);


set @ENCHANT_SCROLLS = 91001;


INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 1, 3, 'Enchanting scrolls', 3, 128, @ENCHANT_SCROLLS, 0, 0, 0, '');


insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) values 
(@ENCHANT_SCROLLS, 0, 38374, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38925, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38948, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38949, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38953, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38959, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38963, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38966, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38967, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38973, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38975, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38976, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38979, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38986, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38993, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 38998, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 39003, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 39005, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 39006, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 41602, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 41604, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 41611, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 41976, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 43987, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44067, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44068, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44069, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44075, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44458, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44465, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44467, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44469, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44470, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44493, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44701, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44702, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44815, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44957, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 44963, 0, 0, 0, 0),
(@ENCHANT_SCROLLS, 0, 45056, 0, 0, 0, 0);

set @GEMS = 91002;


INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 2, 3, 'Gems', 3, 128, @GEMS, 0, 0, 0, '');

insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) values 
(@GEMS, 0, 40111, 0, 0, 0, 0),
(@GEMS, 0, 40113, 0, 0, 0, 0),
(@GEMS, 0, 40114, 0, 0, 0, 0),
(@GEMS, 0, 40117, 0, 0, 0, 0),
(@GEMS, 0, 40112, 0, 0, 0, 0),
(@GEMS, 0, 40119, 0, 0, 0, 0),
(@GEMS, 0, 40120, 0, 0, 0, 0),
(@GEMS, 0, 40121, 0, 0, 0, 0),
(@GEMS, 0, 40122, 0, 0, 0, 0),
(@GEMS, 0, 40124, 0, 0, 0, 0),
(@GEMS, 0, 40125, 0, 0, 0, 0),
(@GEMS, 0, 40128, 0, 0, 0, 0),
(@GEMS, 0, 40133, 0, 0, 0, 0),
(@GEMS, 0, 40134, 0, 0, 0, 0),
(@GEMS, 0, 40135, 0, 0, 0, 0),
(@GEMS, 0, 40168, 0, 0, 0, 0),
(@GEMS, 0, 40173, 0, 0, 0, 0),
(@GEMS, 0, 40174, 0, 0, 0, 0),
(@GEMS, 0, 40178, 0, 0, 0, 0),
(@GEMS, 0, 40179, 0, 0, 0, 0),
(@GEMS, 0, 40180, 0, 0, 0, 0),
(@GEMS, 0, 40181, 0, 0, 0, 0),
(@GEMS, 0, 40182, 0, 0, 0, 0),
(@GEMS, 0, 40142, 0, 0, 0, 0),
(@GEMS, 0, 40143, 0, 0, 0, 0),
(@GEMS, 0, 40145, 0, 0, 0, 0),
(@GEMS, 0, 40146, 0, 0, 0, 0),
(@GEMS, 0, 40152, 0, 0, 0, 0),
(@GEMS, 0, 40153, 0, 0, 0, 0),
(@GEMS, 0, 40154, 0, 0, 0, 0),
(@GEMS, 0, 40155, 0, 0, 0, 0),
(@GEMS, 0, 40158, 0, 0, 0, 0),
(@GEMS, 0, 49110, 0, 0, 0, 0),
(@GEMS, 0, 40157, 0, 0, 0, 0);


set @META_GEMS = 91003;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 3, 3, 'Meta Gems', 3, 128, @META_GEMS, 0, 0, 0, '');

insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) values 
(@META_GEMS, 0, 41266, 0, 0, 0, 0),
(@META_GEMS, 0, 41285, 0, 0, 0, 0),
(@META_GEMS, 0, 41307, 0, 0, 0, 0),
(@META_GEMS, 0, 41333, 0, 0, 0, 0),
(@META_GEMS, 0, 41334, 0, 0, 0, 0),
(@META_GEMS, 0, 41335, 0, 0, 0, 0),
(@META_GEMS, 0, 41339, 0, 0, 0, 0),
(@META_GEMS, 0, 41375, 0, 0, 0, 0),
(@META_GEMS, 0, 41376, 0, 0, 0, 0),
(@META_GEMS, 0, 41377, 0, 0, 0, 0),
(@META_GEMS, 0, 41378, 0, 0, 0, 0),
(@META_GEMS, 0, 41379, 0, 0, 0, 0),
(@META_GEMS, 0, 41380, 0, 0, 0, 0),
(@META_GEMS, 0, 41381, 0, 0, 0, 0),
(@META_GEMS, 0, 41382, 0, 0, 0, 0),
(@META_GEMS, 0, 41385, 0, 0, 0, 0),
(@META_GEMS, 0, 41389, 0, 0, 0, 0),
(@META_GEMS, 0, 41395, 0, 0, 0, 0),
(@META_GEMS, 0, 41396, 0, 0, 0, 0),
(@META_GEMS, 0, 41397, 0, 0, 0, 0),
(@META_GEMS, 0, 41398, 0, 0, 0, 0),
(@META_GEMS, 0, 41400, 0, 0, 0, 0),
(@META_GEMS, 0, 41401, 0, 0, 0, 0),
(@META_GEMS, 0, 44076, 0, 0, 0, 0),
(@META_GEMS, 0, 44078, 0, 0, 0, 0),
(@META_GEMS, 0, 44081, 0, 0, 0, 0),
(@META_GEMS, 0, 44082, 0, 0, 0, 0),
(@META_GEMS, 0, 44084, 0, 0, 0, 0),
(@META_GEMS, 0, 44087, 0, 0, 0, 0),
(@META_GEMS, 0, 44088, 0, 0, 0, 0),
(@META_GEMS, 0, 44089, 0, 0, 0, 0);


set @PVP = 91004;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 4, 1, 'PVP Set + offparts', 3, 128, @PVP, 0, 0, 0, '');


insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) 
(select @PVP, 0, `entry`, 0, 0, 0, 0 from item_template where `ItemLevel` = 245 and class = 4 and name like 'Rele%' and `VerifiedBuild` > 1)
union
(select @PVP, 0, `entry`, 0, 0, 0, 0 from item_template where `ItemLevel` = 232 and class = 4 and name like 'Furious%' and `VerifiedBuild` > 1 and `InventoryType` in (1,3,5,7,10))

set @WEP = 91005;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 5, 1, 'Weapons', 3, 128, @WEP, 0, 0, 0, '');

insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) 
(select @WEP, 0, `entry`, 0, 0, 0, 0 from item_template where `InventoryType` in (28, 17, 13, 14, 15, 26, 21, 25, 23, 22)  and `ItemLevel` = 245 and `VerifiedBuild` > 1)
union
(select @WEP, 0, `entry`, 0, 0, 0, 0 from item_template where `InventoryType` in (14, 23)  and `ItemLevel` = 251 and `VerifiedBuild`
                                > 1 and name like 'Rele%');


set @PVE_SET_HEAD = 91006;
set @PVE_SET_SH = 91007;
set @PVE_SET_CHEST = 91008;
set @PVE_SET_HAND = 91009;
set @PVE_SET_LEG = 91010;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 6, 1,  'PVE Head', 3, 128, @PVE_SET_HEAD, 0, 0, 0, ''),
(@GENERAL_MENU_ID, 7, 1,  'PVE Shoulder', 3, 128, @PVE_SET_SH, 0, 0, 0, ''),
(@GENERAL_MENU_ID, 8, 1,  'PVE Chest', 3, 128, @PVE_SET_CHEST, 0, 0, 0, ''),
(@GENERAL_MENU_ID, 9, 1,  'PVE Hand', 3, 128, @PVE_SET_HAND, 0, 0, 0, ''),
(@GENERAL_MENU_ID, 10, 1, 'PVE Leg', 3, 128, @PVE_SET_LEG, 0, 0, 0, '');


insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) values 
(@PVE_SET_CHEST, 0, 47739, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47749, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47776, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47786, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47799, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47811, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47838, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47887, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47896, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47906, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 47936, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48070, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48075, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48100, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48129, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48156, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48159, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48186, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48189, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48216, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48219, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48243, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48251, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48275, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48281, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48295, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48310, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48336, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48341, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48366, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48372, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48386, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48436, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48456, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48474, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48501, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48531, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48558, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48566, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48599, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48602, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48631, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48632, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 48652, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50213, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50266, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50272, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50285, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50294, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50297, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50300, 0, 0, 0, 0),
(@PVE_SET_CHEST, 0, 50312, 0, 0, 0, 0), -- CHEST
(@PVE_SET_HEAD, 0, 47717, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47718, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47746, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47748, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47774, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47784, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47801, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47813, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47875, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47876, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47891, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47897, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 47914, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48068, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48073, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48098, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48102, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48154, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48158, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48184, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48188, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48214, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48218, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48245, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48250, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48277, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48280, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48297, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48313, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48338, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48343, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48368, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48371, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48388, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48429, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48458, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48472, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48503, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48529, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48560, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48564, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48597, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48604, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48629, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48634, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 48654, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49315, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49316, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49317, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49318, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49319, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49320, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49321, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49322, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49323, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49324, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49325, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49326, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49327, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49328, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49329, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49330, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49331, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49332, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 49333, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 50197, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 50206, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 50214, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 50298, 0, 0, 0, 0),
(@PVE_SET_HEAD, 0, 50311, 0, 0, 0, 0), -- HEAD
(@PVE_SET_SH, 0, 47613, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47616, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47720, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47751, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47777, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47787, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47798, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47829, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47832, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47857, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47860, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47877, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47901, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47904, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 47981, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48071, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48076, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48101, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48131, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48157, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48161, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48187, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48191, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48217, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48221, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48247, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48253, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48279, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48283, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48299, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48315, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48340, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48345, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48370, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48374, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48390, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48448, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48460, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48478, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48505, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48535, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48562, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48572, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48595, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48606, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48627, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48636, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 48656, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 50193, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 50208, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 50233, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 50234, 0, 0, 0, 0),
(@PVE_SET_SH, 0, 50293, 0, 0, 0, 0), -- shoulder
(@PVE_SET_HAND, 0, 47609, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47719, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47744, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47745, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47752, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47773, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47783, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47802, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47851, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47878, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47889, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47893, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 47982, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48067, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48072, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48097, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48132, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48153, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48162, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48183, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48192, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48213, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48222, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48244, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48254, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48276, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48284, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48296, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48312, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48337, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48342, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48367, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48375, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48387, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48449, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48457, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48480, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48502, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48537, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48559, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48574, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48598, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48603, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48630, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48633, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 48653, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 50194, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 50212, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 50284, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 50299, 0, 0, 0, 0),
(@PVE_SET_HAND, 0, 50304, 0, 0, 0, 0), -- hands
(@PVE_SET_LEG, 0, 47620, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47750, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47775, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47785, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47800, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47830, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47836, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47865, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47902, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47908, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 47980, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48069, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48074, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48099, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48130, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48155, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48160, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48185, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48190, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48215, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48220, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48246, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48252, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48278, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48282, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48298, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48314, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48339, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48344, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48369, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48373, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48389, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48445, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48459, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48476, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48504, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48533, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48561, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48568, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48596, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48605, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48628, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48635, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48655, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48983, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48987, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48988, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48990, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48991, 0, 0, 0, 0),
(@PVE_SET_LEG, 0, 48992, 0, 0, 0, 0); -- legs


set @PVE_OFFPART = 91011;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 11, 1,  'PVE Offpart', 3, 128, @PVE_OFFPART, 0, 0, 0, '');

insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) 
select @PVE_OFFPART, 0, `entry`, 0, 0, 0, 0 
from item_template
where `ItemLevel` = 245 and `name` not like 'Relen%' and `name` not like 'Titan%' and InventoryType in (2, 16, 9, 6, 8, 11); 


SET @TRINKETS = 91012;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@GENERAL_MENU_ID, 12, 1,  'Trinkets', 3, 128, @TRINKETS, 0, 0, 0, '');

COMMIT;


START TRANSACTION;

-- usables vendor

SET @USABLES_MENU_ID = 8576;
SET @GENERAL_GOODS_VEND = 92012;

INSERT INTO `gossip_menu_option` (`menuid`, `optionid`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES
(@USABLES_MENU_ID, 1, 1,  'General Goods', 3, 128, @GENERAL_GOODS_VEND, 0, 0, 0, '');

insert into npc_vendor ( 
`entry`, 
`slot`, 
`item`, 
`maxcount`, 
`incrtime`, 
`ExtendedCost`, 
`VerifiedBuild` 
) values 
(@GENERAL_GOODS_VEND, 0, 3775, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 5237, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 6265, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 17020, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 18714, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 21177, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 23162, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 41597, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 43231, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 43233, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 43235, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 43236, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 43237, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 44447, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 44605, 0, 0, 0, 0),                                                                                                                                                     
(@GENERAL_GOODS_VEND, 0, 44614, 0, 0, 0, 0),       
(@GENERAL_GOODS_VEND, 0, 44615, 0, 0, 0, 0),
(@GENERAL_GOODS_VEND, 0, 46778, 0, 0, 0, 0),
(@GENERAL_GOODS_VEND, 0, 52020, 0, 0, 0, 0),
(@GENERAL_GOODS_VEND, 0, 5202, 0, 0, 0, 0);

COMMIT;
