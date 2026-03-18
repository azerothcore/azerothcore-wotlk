-- DB update 2026_03_13_04 -> 2026_03_13_05
-- Update npc (koKR) ; from WowHead Wotlk > TBC > Classic > Cata > Mop > Retail
-- If locale datas strictly equals AC enUS, or if locale datas strictly equals to Wowhead enUS, then we use AC fallback to enUS
-- Disclaimer : Datas of technical NPCs (Theoretically not visible to players) could be wrong, here we strictly align with WoWHead datas

-- Entries without any translation datas, on any version
-- AC datas : OLD Name : "XT:4", Name AC enUS : "XT:4" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 4073;
-- AC datas : OLD Name : "XT:9", Name AC enUS : "XT:9" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 4074;
-- AC datas : OLD Name : "Eric Maloof Test Guy", Name AC enUS : "Eric Maloof Test Guy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 15985;
-- AC datas : OLD Name : "Flesh Giant B [PH]", Name AC enUS : "Flesh Giant B [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16026;
-- AC datas : OLD Name : "Pack Trainer [PH]", Name AC enUS : "Pack Trainer [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16039;
-- AC datas : OLD Name : "Pack Handler [PH]", Name AC enUS : "Pack Handler [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16040;
-- AC datas : OLD Name : "Naxxramas Trigger", Name AC enUS : "Naxxramas Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16082;
-- AC datas : OLD Name : "Naxxramas Military Sub-Boss Trigger", Name AC enUS : "Naxxramas Military Sub-Boss Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16137;
-- AC datas : OLD Name : "[UNUSED] Scourge Invasion Guardian", Name AC enUS : "[UNUSED] Scourge Invasion Guardian" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16138;
-- AC datas : OLD Name : "[UNUSED] Necropolis Crystal, Buttress", Name AC enUS : "[UNUSED] Necropolis Crystal, Buttress" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16140;
-- AC datas : OLD Name : "[UNUSED] Buttress Channeler", Name AC enUS : "[UNUSED] Buttress Channeler" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16188;
-- AC datas : OLD Name : "Raw Meat Rack Trigger", Name AC enUS : "Raw Meat Rack Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16465;
-- AC datas : OLD Name : "Fresh Fish Rack Trigger", Name AC enUS : "Fresh Fish Rack Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16467;
-- AC datas : OLD Name : "Scryers Faction Tester", Name AC enUS : "Scryers Faction Tester" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16497;
-- AC datas : OLD Name : "Consortium Faction Tester", Name AC enUS : "Consortium Faction Tester" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16498;
-- AC datas : OLD Name : "Leapgate", Name AC enUS : "Leapgate" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16532;
-- AC datas : OLD Name : "test: saved world state", Name AC enUS : "test: saved world state" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16536;
-- AC datas : OLD Name : "[PH] Goblin Savage", Name AC enUS : "[PH] Goblin Savage" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 16608;
-- AC datas : OLD Name : "Mirren Longbeard No Hat (DND)", Name AC enUS : "Mirren Longbeard No Hat (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17091;
-- AC datas : OLD Name : "Sedai Trigger", Name AC enUS : "Sedai Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17107;
-- AC datas : OLD Name : "Captured Tarantula Trigger", Name AC enUS : "Captured Tarantula Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17124;
-- AC datas : OLD Name : "Captured Jaguar Trigger", Name AC enUS : "Captured Jaguar Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17125;
-- AC datas : OLD Name : "Captured Crocolisk Trigger", Name AC enUS : "Captured Crocolisk Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17126;
-- AC datas : OLD Name : "Worm Target (DND)", Name AC enUS : "Worm Target (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17163;
-- AC datas : OLD Name : "[Unused] Tunneler Visual", Name AC enUS : "[Unused] Tunneler Visual" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17234;
-- AC datas : OLD Name : "Defile Uther's Tomb Trigger", Name AC enUS : "Defile Uther's Tomb Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17253;
-- AC datas : OLD Name : "Nightbane Helper Target", Name AC enUS : "Nightbane Helper Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17260;
-- AC datas : OLD Name : "Temper's Target", Name AC enUS : "Temper's Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17274;
-- AC datas : OLD Name : "Hellfire Military Hard Mode Timer", Name AC enUS : "Hellfire Military Hard Mode Timer" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17302;
-- AC datas : OLD Name : "Hellfire Raid Trigger", Name AC enUS : "Hellfire Raid Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17376;
-- AC datas : OLD Name : "Sedai Quest Credit Marker", Name AC enUS : "Sedai Quest Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17413;
-- AC datas : OLD Name : "Invisible Test Aggressor", Name AC enUS : "Invisible Test Aggressor" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17428;
-- AC datas : OLD Name : "Actor Good (DND)", Name AC enUS : "Actor Good (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17456;
-- AC datas : OLD Name : "Actor Evil (DND)", Name AC enUS : "Actor Evil (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17457;
-- AC datas : OLD Name : "[UNUSED] Shadowmoon Firestarter", Name AC enUS : "[UNUSED] Shadowmoon Firestarter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17463;
-- AC datas : OLD Name : "Shadowmoon Summon Visual", Name AC enUS : "Shadowmoon Summon Visual" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17473;
-- AC datas : OLD Name : "Target Trigger", Name AC enUS : "Target Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17474;
-- AC datas : OLD Name : "Monster Spar", Name AC enUS : "Monster Spar" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17501;
-- AC datas : OLD Name : "Monster Spar Buddy", Name AC enUS : "Monster Spar Buddy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17502;
-- AC datas : OLD Name : "[PH]Channel Target", Name AC enUS : "[PH]Channel Target" OLD Subname : "You shouldn't see me", Subname AC enUS : "You shouldn't see me" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17529;
-- AC datas : OLD Name : "Eric Maloof Test Critter", Name AC enUS : "Eric Maloof Test Critter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17575;
-- AC datas : OLD Name : "Sandworm Missile Target (DND)", Name AC enUS : "Sandworm Missile Target (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17590;
-- AC datas : OLD Name : "Infernal Target", Name AC enUS : "Infernal Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17644;
-- AC datas : OLD Name : "Arcanagos Credit Marker", Name AC enUS : "Arcanagos Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17665;
-- AC datas : OLD Name : "Arcanagos Spell Dummy", Name AC enUS : "Arcanagos Spell Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17677;
-- AC datas : OLD Name : "[UNUSED] Lost Goblin [PH]", Name AC enUS : "[UNUSED] Lost Goblin [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17813;
-- AC datas : OLD Name : "[PH]Ye Olde Channel Imp", Name AC enUS : "[PH]Ye Olde Channel Imp" OLD Subname : "You shouldn't see me", Subname AC enUS : "You shouldn't see me" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17847;
-- AC datas : OLD Name : "Alex Test Quest Flagging NPC", Name AC enUS : "Alex Test Quest Flagging NPC" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17859;
-- AC datas : OLD Name : "Waterpump Investigation Credit Marker", Name AC enUS : "Waterpump Investigation Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17861;
-- AC datas : OLD Name : "Matis Credit Marker", Name AC enUS : "Matis Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17863;
-- AC datas : OLD Name : "Coilfang Periodic Bat Trigger", Name AC enUS : "Coilfang Periodic Bat Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17867;
-- AC datas : OLD Name : "Silithus Spice Worm Mortar Target", Name AC enUS : "Silithus Spice Worm Mortar Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17868;
-- AC datas : OLD Name : "[PH] Invis Paladin Quest Credit", Name AC enUS : "[PH] Invis Paladin Quest Credit" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17915;
-- AC datas : OLD Name : "[UNUSED] Coilfang Watcher [PH]", Name AC enUS : "[UNUSED] Coilfang Watcher [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17939;
-- AC datas : OLD Name : "[PH] Invis Stillblade Credit", Name AC enUS : "[PH] Invis Stillblade Credit" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17950;
-- AC datas : OLD Name : "Invisible Mount Speed 30", Name AC enUS : "Invisible Mount Speed 30" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17972;
-- AC datas : OLD Name : "As the Crow Flies Credit Marker", Name AC enUS : "As the Crow Flies Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17985;
-- AC datas : OLD Name : "Grand Finale Event Manager", Name AC enUS : "Grand Finale Event Manager" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17988;
-- AC datas : OLD Name : "Coilfang Invisible Vacuum Dummy", Name AC enUS : "Coilfang Invisible Vacuum Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17992;
-- AC datas : OLD Name : "Umbrafen Steam Pump Credit Marker", Name AC enUS : "Umbrafen Steam Pump Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 17998;
-- AC datas : OLD Name : "Serpent Steam Pump Credit Marker", Name AC enUS : "Serpent Steam Pump Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18000;
-- AC datas : OLD Name : "Marshlight Steam Pump Credit Marker", Name AC enUS : "Marshlight Steam Pump Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18002;
-- AC datas : OLD Name : "Elemental Throne Event Handler", Name AC enUS : "Elemental Throne Event Handler" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18085;
-- AC datas : OLD Name : "Coilfang Underbog Hydra Trigger", Name AC enUS : "Coilfang Underbog Hydra Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18108;
-- AC datas : OLD Name : "Windyreed Quest Credit (Big Hut)", Name AC enUS : "Windyreed Quest Credit (Big Hut)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18110;
-- AC datas : OLD Name : "Windyreed Quest Credit (Hut 01)", Name AC enUS : "Windyreed Quest Credit (Hut 01)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18142;
-- AC datas : OLD Name : "Windyreed Quest Credit (Hut 02)", Name AC enUS : "Windyreed Quest Credit (Hut 02)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18143;
-- AC datas : OLD Name : "Windyreed Quest Credit (Hut 03)", Name AC enUS : "Windyreed Quest Credit (Hut 03)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18144;
-- AC datas : OLD Name : "Outland Wrathguard PH Test Size/Model/NoAnim", Name AC enUS : "Outland Wrathguard PH Test Size/Model/NoAnim" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18148;
-- AC datas : OLD Name : "Underground Well Credit Marker", Name AC enUS : "Underground Well Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18161;
-- AC datas : OLD Name : "Underground Pond Credit Marker", Name AC enUS : "Underground Pond Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18162;
-- AC datas : OLD Name : "Gurok Event Controller", Name AC enUS : "Gurok Event Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18196;
-- AC datas : OLD Name : "Murkblood Event Controller", Name AC enUS : "Murkblood Event Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18208;
-- AC datas : OLD Name : "Murkblood Target Dummy", Name AC enUS : "Murkblood Target Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18215;
-- AC datas : OLD Name : "Fire Bomb Target", Name AC enUS : "Fire Bomb Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18225;
-- AC datas : OLD Name : "Garadar Event Controller (Farseer)", Name AC enUS : "Garadar Event Controller (Farseer)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18228;
-- AC datas : OLD Name : "Infernal Relay (Hyjal)", Name AC enUS : "Infernal Relay (Hyjal)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18242;
-- AC datas : OLD Name : "Nagrand Spawn Trigger", Name AC enUS : "Nagrand Spawn Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18263;
-- AC datas : OLD Name : "Nagrand Spawn Timer", Name AC enUS : "Nagrand Spawn Timer" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18264;
-- AC datas : OLD Name : "Invis Ball Game Referee", Name AC enUS : "Invis Ball Game Referee" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18275;
-- AC datas : OLD Name : "Building", Name AC enUS : "Building" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18304;
-- AC datas : OLD Name : "[UNUSED] Sethekk Magelord", Name AC enUS : "[UNUSED] Sethekk Magelord" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18329;
-- AC datas : OLD Name : "Lump's Quest Credit", Name AC enUS : "Lump's Quest Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18354;
-- AC datas : OLD Name : "[UNUSED] Dusty Skeleton [PH]", Name AC enUS : "[UNUSED] Dusty Skeleton [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18355;
-- AC datas : OLD Name : "[UNUSED] Draenei Spirit [PH]", Name AC enUS : "[UNUSED] Draenei Spirit [PH]" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18367;
-- AC datas : OLD Name : "Shadow Council Credit Marker", Name AC enUS : "Shadow Council Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18388;
-- AC datas : OLD Name : "Invisible Man Mount 30", Name AC enUS : "Invisible Man Mount 30" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18392;
-- AC datas : OLD Name : "Warmaul Ogre Credit Marker", Name AC enUS : "Warmaul Ogre Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18393;
-- AC datas : OLD Name : "Warmaul Pyre Credit Marker", Name AC enUS : "Warmaul Pyre Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18395;
-- AC datas : OLD Name : "Large AOI Underbat", Name AC enUS : "Large AOI Underbat" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18409;
-- AC datas : OLD Name : "Hyjal Despawn Trigger Unit", Name AC enUS : "Hyjal Despawn Trigger Unit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18410;
-- AC datas : OLD Name : "Corki Event Controller", Name AC enUS : "Corki Event Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18444;
-- AC datas : OLD Name : "Veil Shalas Ward", Name AC enUS : "Veil Shalas Ward" OLD Subname : "You shouldn't see me", Subname AC enUS : "You shouldn't see me" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18458;
-- AC datas : OLD Name : "Vazruden Fire Trap", Name AC enUS : "Vazruden Fire Trap" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18479;
-- AC datas : OLD Name : "Forge Camp: Hate - Event Generator", Name AC enUS : "Forge Camp: Hate - Event Generator" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18532;
-- AC datas : OLD Name : "Altruis Kill Credit", Name AC enUS : "Altruis Kill Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18551;
-- AC datas : OLD Name : "Dark Portal Black Crystal Invisible Stalker", Name AC enUS : "Dark Portal Black Crystal Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18553;
-- AC datas : OLD Name : "Dark Portal Beam Invisible Stalker", Name AC enUS : "Dark Portal Beam Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18555;
-- AC datas : OLD Name : "Justin's Bunny Target", Name AC enUS : "Justin's Bunny Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18560;
-- AC datas : OLD Name : "Justin's Bunny Channeler", Name AC enUS : "Justin's Bunny Channeler" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18563;
-- AC datas : OLD Name : "Dark Portal Emitter Invisible Stalker", Name AC enUS : "Dark Portal Emitter Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18582;
-- AC datas : OLD Name : "Forge Camp: Hate Quest Credit", Name AC enUS : "Forge Camp: Hate Quest Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18589;
-- AC datas : OLD Name : "Forge Camp: Fear Quest Credit", Name AC enUS : "Forge Camp: Fear Quest Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18590;
-- AC datas : OLD Name : "Crowd Murmur Helper", Name AC enUS : "Crowd Murmur Helper" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18654;
-- AC datas : OLD Name : "Overrun Target", Name AC enUS : "Overrun Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18665;
-- AC datas : OLD Name : "World Trigger (Friendly + Invis Man)", Name AC enUS : "World Trigger (Friendly + Invis Man)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18721;
-- AC datas : OLD Name : "Infernal Rain (Hellfire)", Name AC enUS : "Infernal Rain (Hellfire)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18729;
-- AC datas : OLD Name : "Zangarmarsh PvP Beam (Red)", Name AC enUS : "Zangarmarsh PvP Beam (Red)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18757;
-- AC datas : OLD Name : "Zangarmarsh PvP Beam (Blue)", Name AC enUS : "Zangarmarsh PvP Beam (Blue)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18759;
-- AC datas : OLD Name : "Silvermoon Ritual of Summoning Dummy", Name AC enUS : "Silvermoon Ritual of Summoning Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18782;
-- AC datas : OLD Name : "Invisible Target", Name AC enUS : "Invisible Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18793;
-- AC datas : OLD Name : "Exodar Invisible Stalker", Name AC enUS : "Exodar Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18814;
-- AC datas : OLD Name : "Invis Horde Siege Engine - East", Name AC enUS : "Invis Horde Siege Engine - East" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18818;
-- AC datas : OLD Name : "Sunspring Post Credit Marker", Name AC enUS : "Sunspring Post Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18840;
-- AC datas : OLD Name : "Laughing Skull Clan Ruins Credit Marker", Name AC enUS : "Laughing Skull Clan Ruins Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18841;
-- AC datas : OLD Name : "Garadar Credit Marker", Name AC enUS : "Garadar Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18842;
-- AC datas : OLD Name : "Bleeding Hollow Clan Ruins Credit Marker", Name AC enUS : "Bleeding Hollow Clan Ruins Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18843;
-- AC datas : OLD Name : "Invis Alliance Siege Engine - East", Name AC enUS : "Invis Alliance Siege Engine - East" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18849;
-- AC datas : OLD Name : "Astromancer Solarian Spotlight", Name AC enUS : "Astromancer Solarian Spotlight" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18928;
-- AC datas : OLD Name : "Astromancer Trigger", Name AC enUS : "Astromancer Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18932;
-- AC datas : OLD Name : "[PH] Gossip NPC, Human Female", Name AC enUS : "[PH] Gossip NPC, Human Female" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18935;
-- AC datas : OLD Name : "[PH] Gossip NPC, Human Male", Name AC enUS : "[PH] Gossip NPC, Human Male" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18936;
-- AC datas : OLD Name : "[PH] Gossip NPC, Human, Specific Look", Name AC enUS : "[PH] Gossip NPC, Human, Specific Look" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18941;
-- AC datas : OLD Name : "Void Spawner", Name AC enUS : "Void Spawner" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18961;
-- AC datas : OLD Name : "Dark Assault - Alliance Portal - Invisible Stalker", Name AC enUS : "Dark Assault - Alliance Portal - Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18967;
-- AC datas : OLD Name : "Dark Assault - Horde Portal - Invisible Stalker", Name AC enUS : "Dark Assault - Horde Portal - Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 18968;
-- AC datas : OLD Name : "Invis Alliance Siege Engine - West", Name AC enUS : "Invis Alliance Siege Engine - West" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19008;
-- AC datas : OLD Name : "Invis Horde Siege Engine - West", Name AC enUS : "Invis Horde Siege Engine - West" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19009;
-- AC datas : OLD Name : "The Overlook Capture Credit Marker", Name AC enUS : "The Overlook Capture Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19028;
-- AC datas : OLD Name : "The Stadium Capture Credit Marker", Name AC enUS : "The Stadium Capture Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19029;
-- AC datas : OLD Name : "Broken Hill Capture Credit Marker", Name AC enUS : "Broken Hill Capture Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19032;
-- AC datas : OLD Name : "[PH] Gossip NPC Human Male, Christmas", Name AC enUS : "[PH] Gossip NPC Human Male, Christmas" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19060;
-- AC datas : OLD Name : "[PH] Gossip NPC Draenei Male, Lunar Festival", Name AC enUS : "[PH] Gossip NPC Draenei Male, Lunar Festival" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19100;
-- AC datas : OLD Name : "[PH] Gossip NPC Night Elf Male, Lunar Festival", Name AC enUS : "[PH] Gossip NPC Night Elf Male, Lunar Festival" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19102;
-- AC datas : OLD Name : "[PH] Gossip NPC Orc Male, Lunar Festival", Name AC enUS : "[PH] Gossip NPC Orc Male, Lunar Festival" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19103;
-- AC datas : OLD Name : "[PH] Gossip NPC Tauren Male, Lunar Festival", Name AC enUS : "[PH] Gossip NPC Tauren Male, Lunar Festival" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19104;
-- AC datas : OLD Name : "[PH] Gossip NPC Undead Male, Lunar Festival", Name AC enUS : "[PH] Gossip NPC Undead Male, Lunar Festival" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19105;
-- AC datas : OLD Name : "Invisible Tractor Beam Source", Name AC enUS : "Invisible Tractor Beam Source" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19198;
-- AC datas : OLD Name : "Infernal Relay (Hellfire)", Name AC enUS : "Infernal Relay (Hellfire)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19215;
-- AC datas : OLD Name : "Dark Assault - Legion Portal - Invisible Stalker", Name AC enUS : "Dark Assault - Legion Portal - Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19230;
-- AC datas : OLD Name : "Test - Voidwalker Spawn Portal", Name AC enUS : "Test - Voidwalker Spawn Portal" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19237;
-- AC datas : OLD Name : "[PH]Dynamite Target", Name AC enUS : "[PH]Dynamite Target" OLD Subname : "You shouldn't see me", Subname AC enUS : "You shouldn't see me" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19297;
-- AC datas : OLD Name : "Dan Reed Magical Reflection Dummy", Name AC enUS : "Dan Reed Magical Reflection Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19313;
-- AC datas : OLD Name : "Dan Reed Uber-resist Test Dummy", Name AC enUS : "Dan Reed Uber-resist Test Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19323;
-- AC datas : OLD Name : "Honor Hold Target Dummy Tower", Name AC enUS : "Honor Hold Target Dummy Tower" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19376;
-- AC datas : OLD Name : "Wildhammer Stronghold Target Dummy Left", Name AC enUS : "Wildhammer Stronghold Target Dummy Left" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19387;
-- AC datas : OLD Name : "Wildhammer Stronghold Target Dummy Right", Name AC enUS : "Wildhammer Stronghold Target Dummy Right" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19388;
-- AC datas : OLD Name : "Netherstorm Crystal Target", Name AC enUS : "Netherstorm Crystal Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19421;
-- AC datas : OLD Name : "CoT Hillsbrad Despawn Trigger Unit", Name AC enUS : "CoT Hillsbrad Despawn Trigger Unit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19433;
-- AC datas : OLD Name : "Netherstorm Kneel Target", Name AC enUS : "Netherstorm Kneel Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19437;
-- AC datas : OLD Name : "Netherstorm Work Mining Target", Name AC enUS : "Netherstorm Work Mining Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19439;
-- AC datas : OLD Name : "Netherstorm Use Standing Target", Name AC enUS : "Netherstorm Use Standing Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19483;
-- AC datas : OLD Name : "Netherstorm Repair Target", Name AC enUS : "Netherstorm Repair Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19484;
-- AC datas : OLD Name : "Invis Bookshelf", Name AC enUS : "Invis Bookshelf" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19547;
-- AC datas : OLD Name : "Invis Dresser", Name AC enUS : "Invis Dresser" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19548;
-- AC datas : OLD Name : "Invis Weapon Rack", Name AC enUS : "Invis Weapon Rack" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19549;
-- AC datas : OLD Name : "Invis Footlocker", Name AC enUS : "Invis Footlocker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19550;
-- AC datas : OLD Name : "Dimensius Quest Enabler", Name AC enUS : "Dimensius Quest Enabler" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19563;
-- AC datas : OLD Name : "Arcane Orb Target", Name AC enUS : "Arcane Orb Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19577;
-- AC datas : OLD Name : "Thrall Event Generator", Name AC enUS : "Thrall Event Generator" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19590;
-- AC datas : OLD Name : "Thrall's Hero Music", Name AC enUS : "Thrall's Hero Music" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19597;
-- AC datas : OLD Name : "Mo'arg Engineer Transform (Drill)", Name AC enUS : "Mo'arg Engineer Transform (Drill)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19609;
-- AC datas : OLD Name : "Warpmaster Lyssendra Credit", Name AC enUS : "Warpmaster Lyssendra Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19618;
-- AC datas : OLD Name : "Commander Dawnforge Credit", Name AC enUS : "Commander Dawnforge Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19619;
-- AC datas : OLD Name : "Thrall Event Dummy", Name AC enUS : "Thrall Event Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19646;
-- AC datas : OLD Name : "Disrupt the Communications Quest Credit Marker North", Name AC enUS : "Disrupt the Communications Quest Credit Marker North" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19652;
-- AC datas : OLD Name : "Consortium Spell Marker", Name AC enUS : "Consortium Spell Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19677;
-- AC datas : OLD Name : "Void Spawner L", Name AC enUS : "Void Spawner L" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19681;
-- AC datas : OLD Name : "Disrupt the Communications Quest Credit Marker South", Name AC enUS : "Disrupt the Communications Quest Credit Marker South" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19717;
-- AC datas : OLD Name : "Invis BE Ballista", Name AC enUS : "Invis BE Ballista" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19723;
-- AC datas : OLD Name : "Invis BE Tent", Name AC enUS : "Invis BE Tent" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19724;
-- AC datas : OLD Name : "Netherstorm Shoot Target", Name AC enUS : "Netherstorm Shoot Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19727;
-- AC datas : OLD Name : "Hellfire Quest - Explosion Visual (DND)", Name AC enUS : "Hellfire Quest - Explosion Visual (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19838;
-- AC datas : OLD Name : "Invis KV Defender", Name AC enUS : "Invis KV Defender" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19842;
-- AC datas : OLD Name : "Invis East KV Rune", Name AC enUS : "Invis East KV Rune" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19866;
-- AC datas : OLD Name : "Invis NE KV Rune", Name AC enUS : "Invis NE KV Rune" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19867;
-- AC datas : OLD Name : "Invis West KV Rune", Name AC enUS : "Invis West KV Rune" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19868;
-- AC datas : OLD Name : "Invis KV Shield Generator", Name AC enUS : "Invis KV Shield Generator" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19870;
-- AC datas : OLD Name : "Netherstorm Nether Beast Target", Name AC enUS : "Netherstorm Nether Beast Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 19939;
-- AC datas : OLD Name : "Blade's Edge Kneel Target 01", Name AC enUS : "Blade's Edge Kneel Target 01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20003;
-- AC datas : OLD Name : "Blade's Edge Kneel Target 02", Name AC enUS : "Blade's Edge Kneel Target 02" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20023;
-- AC datas : OLD Name : "Blade's Edge Kneel Target 03", Name AC enUS : "Blade's Edge Kneel Target 03" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20024;
-- AC datas : OLD Name : "UNUSED - Golem Crafter", Name AC enUS : "UNUSED - Golem Crafter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20051;
-- AC datas : OLD Name : "Frostbite Invisible Stalker", Name AC enUS : "Frostbite Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20061;
-- AC datas : OLD Name : "Infernal Invasion Hero Say Director", Name AC enUS : "Infernal Invasion Hero Say Director" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20085;
-- AC datas : OLD Name : "Netherstorm Triangulation Point One Trigger", Name AC enUS : "Netherstorm Triangulation Point One Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20086;
-- AC datas : OLD Name : "Blade's Edge - Arakkoa Spell Origin", Name AC enUS : "Blade's Edge - Arakkoa Spell Origin" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20093;
-- AC datas : OLD Name : "Arakkoa Test Summon Bird", Name AC enUS : "Arakkoa Test Summon Bird" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20094;
-- AC datas : OLD Name : "Netherstorm Triangulation Point Two Trigger", Name AC enUS : "Netherstorm Triangulation Point Two Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20114;
-- AC datas : OLD Name : "Netherstorm Triangulation Point Three Trigger", Name AC enUS : "Netherstorm Triangulation Point Three Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20128;
-- AC datas : OLD Name : "Void Spawner - Quest - Warp Rifts", Name AC enUS : "Void Spawner - Quest - Warp Rifts" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20143;
-- AC datas : OLD Name : "Invis Teleporter", Name AC enUS : "Invis Teleporter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20153;
-- AC datas : OLD Name : "Hillsbrad Internment Lodge Quest Trigger", Name AC enUS : "Hillsbrad Internment Lodge Quest Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20155;
-- AC datas : OLD Name : "Thrall Quest Trigger", Name AC enUS : "Thrall Quest Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20156;
-- AC datas : OLD Name : "Mask of Deception (Test)", Name AC enUS : "Mask of Deception (Test)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20219;
-- AC datas : OLD Name : "Manaforge Visual Trigger", Name AC enUS : "Manaforge Visual Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20226;
-- AC datas : OLD Name : "Void Spawner - Quest - Void Ridge - Galaxis", Name AC enUS : "Void Spawner - Quest - Void Ridge - Galaxis" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20229;
-- AC datas : OLD Name : "Neutralizing Emote Placeholder", Name AC enUS : "Neutralizing Emote Placeholder" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20239;
-- AC datas : OLD Name : "Honor Hold Scout Archery Target", Name AC enUS : "Honor Hold Scout Archery Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20251;
-- AC datas : OLD Name : "Pat's Vendor Test Guy", Name AC enUS : "Pat's Vendor Test Guy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20282;
-- AC datas : OLD Name : "Illadari Point - Succubi Spell Orgin 001", Name AC enUS : "Illadari Point - Succubi Spell Orgin 001" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20286;
-- AC datas : OLD Name : "Illadari Point - Succubi Caster Position 01", Name AC enUS : "Illadari Point - Succubi Caster Position 01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20288;
-- AC datas : OLD Name : "Illadari Point - Succubi Caster Position 02", Name AC enUS : "Illadari Point - Succubi Caster Position 02" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20289;
-- AC datas : OLD Name : "Northern Pipe Credit Marker", Name AC enUS : "Northern Pipe Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20333;
-- AC datas : OLD Name : "Eastern Pipe Credit Marker", Name AC enUS : "Eastern Pipe Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20336;
-- AC datas : OLD Name : "Southern Pipe Credit Marker", Name AC enUS : "Southern Pipe Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20337;
-- AC datas : OLD Name : "Western Pipe Credit Marker", Name AC enUS : "Western Pipe Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20338;
-- AC datas : OLD Name : "Event Generator Old Hillsbrad", Name AC enUS : "Event Generator Old Hillsbrad" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20391;
-- AC datas : OLD Name : "Boom Bot Target", Name AC enUS : "Boom Bot Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20392;
-- AC datas : OLD Name : "Eclipse Point - Bloodcrystal Spell Orgin", Name AC enUS : "Eclipse Point - Bloodcrystal Spell Orgin" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20431;
-- AC datas : OLD Name : "Invis Bessy Credit", Name AC enUS : "Invis Bessy Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20469;
-- AC datas : OLD Name : "Invisible Stalker (Scale x5)", Name AC enUS : "Invisible Stalker (Scale x5)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20562;
-- AC datas : OLD Name : "Flame Patch (Al'ar)", Name AC enUS : "Flame Patch (Al'ar)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20602;
-- AC datas : OLD Name : "Blade's Edge - Orb Trigger 01", Name AC enUS : "Blade's Edge - Orb Trigger 01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20666;
-- AC datas : OLD Name : "Blade's Edge - Flesh Beast Zap Trigger", Name AC enUS : "Blade's Edge - Flesh Beast Zap Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20670;
-- AC datas : OLD Name : "Legion Hold - Infernal Dummy", Name AC enUS : "Legion Hold - Infernal Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20675;
-- AC datas : OLD Name : "Walla's Damage Dealer", Name AC enUS : "Walla's Damage Dealer" OLD Subname : "Lord of Stuff", Subname AC enUS : "Lord of Stuff" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20733;
-- AC datas : OLD Name : "Blade's Edge - Legion - Invis Bunny", Name AC enUS : "Blade's Edge - Legion - Invis Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20736;
-- AC datas : OLD Name : "Ethereum Energy Cell", Name AC enUS : "Ethereum Energy Cell" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20755;
-- AC datas : OLD Name : "Mana Bomb Explosion Trigger", Name AC enUS : "Mana Bomb Explosion Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20767;
-- AC datas : OLD Name : "Salaadin's Energy Ball", Name AC enUS : "Salaadin's Energy Ball" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20769;
-- AC datas : OLD Name : "Razaani Light Orb - Mini", Name AC enUS : "Razaani Light Orb - Mini" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20771;
-- AC datas : OLD Name : "Seed of Revitalization Target Trigger", Name AC enUS : "Seed of Revitalization Target Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20781;
-- AC datas : OLD Name : "Ethereum Archon Energy Cell", Name AC enUS : "Ethereum Archon Energy Cell" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20782;
-- AC datas : OLD Name : "Netherstorm Target", Name AC enUS : "Netherstorm Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20796;
-- AC datas : OLD Name : "Netherstorm Moarg Work Target", Name AC enUS : "Netherstorm Moarg Work Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20804;
-- AC datas : OLD Name : "Mana Bomb Channel Trigger", Name AC enUS : "Mana Bomb Channel Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20809;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, Barracks", Name AC enUS : "Zeth'Gor Quest Credit Marker, Barracks" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20813;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, Stable", Name AC enUS : "Zeth'Gor Quest Credit Marker, Stable" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20814;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, East Hovel", Name AC enUS : "Zeth'Gor Quest Credit Marker, East Hovel" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20815;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, West Hovel", Name AC enUS : "Zeth'Gor Quest Credit Marker, West Hovel" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20816;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb", Name AC enUS : "Blade's Edge - Deadsoul Orb" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20845;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb Flight 01", Name AC enUS : "Blade's Edge - Deadsoul Orb Flight 01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20851;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb Flight 02", Name AC enUS : "Blade's Edge - Deadsoul Orb Flight 02" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20852;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb Flight 03", Name AC enUS : "Blade's Edge - Deadsoul Orb Flight 03" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20853;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb Flight 04", Name AC enUS : "Blade's Edge - Deadsoul Orb Flight 04" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20855;
-- AC datas : OLD Name : "Blade's Edge - Deadsoul Orb Flight 05", Name AC enUS : "Blade's Edge - Deadsoul Orb Flight 05" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20856;
-- AC datas : OLD Name : "Pet Book DEM", Name AC enUS : "Pet Book DEM" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20863;
-- AC datas : OLD Name : "Camera Shakers Manaforge Ultris", Name AC enUS : "Camera Shakers Manaforge Ultris" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20933;
-- AC datas : OLD Name : "Stormwind Flavor - Alliance Portal - Invisible Stalker", Name AC enUS : "Stormwind Flavor - Alliance Portal - Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20979;
-- AC datas : OLD Name : "Invis Talbuk Credit", Name AC enUS : "Invis Talbuk Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20982;
-- AC datas : OLD Name : "Invis Dome Caster", Name AC enUS : "Invis Dome Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 20991;
-- AC datas : OLD Name : "Mana Bomb Kill Credit Trigger", Name AC enUS : "Mana Bomb Kill Credit Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21039;
-- AC datas : OLD Name : "Blade's Edge - Orb Trigger 02", Name AC enUS : "Blade's Edge - Orb Trigger 02" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21051;
-- AC datas : OLD Name : "Camera Shaker - Altar of Damnation", Name AC enUS : "Camera Shaker - Altar of Damnation" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21052;
-- AC datas : OLD Name : "Blade's Edge - Orb Trigger 03", Name AC enUS : "Blade's Edge - Orb Trigger 03" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21053;
-- AC datas : OLD Name : "Blade's Edge - Orb Trigger 04", Name AC enUS : "Blade's Edge - Orb Trigger 04" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21054;
-- AC datas : OLD Name : "Living Grove Defender Trigger", Name AC enUS : "Living Grove Defender Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21074;
-- AC datas : OLD Name : "Infernal Target (Hyjal)", Name AC enUS : "Infernal Target (Hyjal)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21075;
-- AC datas : OLD Name : "Bonechewer Quest credit marker", Name AC enUS : "Bonechewer Quest credit marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21121;
-- AC datas : OLD Name : "OLDWorld Trigger (Large AOI) (DO NOT DELETE)", Name AC enUS : "OLDWorld Trigger (Large AOI) (DO NOT DELETE)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21122;
-- AC datas : OLD Name : "Dire Timber Wolf Trigger", Name AC enUS : "Dire Timber Wolf Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21142;
-- AC datas : OLD Name : "Culuthas Scan Target Dummy", Name AC enUS : "Culuthas Scan Target Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21157;
-- AC datas : OLD Name : "Containment Beam", Name AC enUS : "Containment Beam" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21159;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, They Must Burn", Name AC enUS : "Zeth'Gor Quest Credit Marker, They Must Burn" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21173;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower South", Name AC enUS : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower South" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21182;
-- AC datas : OLD Name : "Blade's Edge - Rock Flayer Target", Name AC enUS : "Blade's Edge - Rock Flayer Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21203;
-- AC datas : OLD Name : "Invis Deathforge Caster", Name AC enUS : "Invis Deathforge Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21210;
-- AC datas : OLD Name : "Invis Deathforge Target", Name AC enUS : "Invis Deathforge Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21211;
-- AC datas : OLD Name : "Blade's Edge Invisible Stalker", Name AC enUS : "Blade's Edge Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21234;
-- AC datas : OLD Name : "Invis Horde Siege Engine - West 02", Name AC enUS : "Invis Horde Siege Engine - West 02" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21236;
-- AC datas : OLD Name : "Invis Horde Siege Engine - East 02", Name AC enUS : "Invis Horde Siege Engine - East 02" OLD Subname : "Nothing to See Here", Subname AC enUS : "Nothing to See Here" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21237;
-- AC datas : OLD Name : "Bloodmaul Brutebane Stout Trigger", Name AC enUS : "Bloodmaul Brutebane Stout Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21241;
-- AC datas : OLD Name : "Big Wagon Full of Explosives Trigger", Name AC enUS : "Big Wagon Full of Explosives Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21261;
-- AC datas : OLD Name : "Goblin Equipment Trigger", Name AC enUS : "Goblin Equipment Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21262;
-- AC datas : OLD Name : "Designer Island Gnome Spell Target", Name AC enUS : "Designer Island Gnome Spell Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21281;
-- AC datas : OLD Name : "Invis Invisibility Caster", Name AC enUS : "Invis Invisibility Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21297;
-- AC datas : OLD Name : "Shadowmoon Valley Invisible Trigger (Tiny)", Name AC enUS : "Shadowmoon Valley Invisible Trigger (Tiny)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21310;
-- AC datas : OLD Name : "Vision Guide Kill Credit Trigger", Name AC enUS : "Vision Guide Kill Credit Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21321;
-- AC datas : OLD Name : "JAB Nether Serpent", Name AC enUS : "JAB Nether Serpent" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21329;
-- AC datas : OLD Name : "Shadowmoon Trigger", Name AC enUS : "Shadowmoon Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21348;
-- AC datas : OLD Name : "Ogre Building Bunny Large", Name AC enUS : "Ogre Building Bunny Large" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21351;
-- AC datas : OLD Name : "Ogre Building Bunny Summoner", Name AC enUS : "Ogre Building Bunny Summoner" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21352;
-- AC datas : OLD Name : "Terokkar - Bone Wastes - Soul Trigger", Name AC enUS : "Terokkar - Bone Wastes - Soul Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21353;
-- AC datas : OLD Name : "Invisible Man Mount 20", Name AC enUS : "Invisible Man Mount 20" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21355;
-- AC datas : OLD Name : "Terokkar - Bone Wastes - Nether Orb Blue", Name AC enUS : "Terokkar - Bone Wastes - Nether Orb Blue" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21360;
-- AC datas : OLD Name : "Terokkar - Bone Wastes - Portal Trigger", Name AC enUS : "Terokkar - Bone Wastes - Portal Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21363;
-- AC datas : OLD Name : "Flame Strike Trigger (Kael)", Name AC enUS : "Flame Strike Trigger (Kael)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21369;
-- AC datas : OLD Name : "Scarab Bunny", Name AC enUS : "Scarab Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21391;
-- AC datas : OLD Name : "Invisible Mount Speed 20", Name AC enUS : "Invisible Mount Speed 20" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21396;
-- AC datas : OLD Name : "Invis Legion Hold Caster", Name AC enUS : "Invis Legion Hold Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21403;
-- AC datas : OLD Name : "Invis Infernal Caster", Name AC enUS : "Invis Infernal Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21417;
-- AC datas : OLD Name : "Invis Infernal Target", Name AC enUS : "Invis Infernal Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21418;
-- AC datas : OLD Name : "Blade's Edge - Toshley's - Invisible Stalker - Atk Target", Name AC enUS : "Blade's Edge - Toshley's - Invisible Stalker - Atk Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21422;
-- AC datas : OLD Name : "Terokkar - Bone Wastes - Draenei Soul", Name AC enUS : "Terokkar - Bone Wastes - Draenei Soul" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21424;
-- AC datas : OLD Name : "Tempest Keep Prison Alpha Pod Target", Name AC enUS : "Tempest Keep Prison Alpha Pod Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21436;
-- AC datas : OLD Name : "Tempest Keep Prison Beta Pod Target", Name AC enUS : "Tempest Keep Prison Beta Pod Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21437;
-- AC datas : OLD Name : "Tempest Keep Prison Delta Pod Target", Name AC enUS : "Tempest Keep Prison Delta Pod Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21438;
-- AC datas : OLD Name : "Tempest Keep Prison Gamma Pod Target", Name AC enUS : "Tempest Keep Prison Gamma Pod Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21439;
-- AC datas : OLD Name : "Tempest Keep Prison Boss Pod Target", Name AC enUS : "Tempest Keep Prison Boss Pod Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21440;
-- AC datas : OLD Name : "Bone Wastes - White Nether Orb", Name AC enUS : "Bone Wastes - White Nether Orb" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21445;
-- AC datas : OLD Name : "Blade's Edge - Toshley's - Def Gun Attack Origin", Name AC enUS : "Blade's Edge - Toshley's - Def Gun Attack Origin" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21447;
-- AC datas : OLD Name : "Bone Wastes - Event Trigger A", Name AC enUS : "Bone Wastes - Event Trigger A" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21451;
-- AC datas : OLD Name : "Ogre Building Bunny Small", Name AC enUS : "Ogre Building Bunny Small" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21456;
-- AC datas : OLD Name : "Bone Wastes - Portal Trigger", Name AC enUS : "Bone Wastes - Portal Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21463;
-- AC datas : OLD Name : "Ogre Building Cursed Spirit Bunny", Name AC enUS : "Ogre Building Cursed Spirit Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21498;
-- AC datas : OLD Name : "[DND]Kaliri Aura Dispel", Name AC enUS : "[DND]Kaliri Aura Dispel" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21511;
-- AC datas : OLD Name : "Invis Legion Hold Glyph", Name AC enUS : "Invis Legion Hold Glyph" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21512;
-- AC datas : OLD Name : "Nether Cloud", Name AC enUS : "Nether Cloud" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21632;
-- AC datas : OLD Name : "Skettis Followers Spawner", Name AC enUS : "Skettis Followers Spawner" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21654;
-- AC datas : OLD Name : "[DND]Mok'Nathal Wand 1", Name AC enUS : "[DND]Mok'Nathal Wand 1" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21713;
-- AC datas : OLD Name : "[DND]Mok'Nathal Wand 2", Name AC enUS : "[DND]Mok'Nathal Wand 2" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21714;
-- AC datas : OLD Name : "[DND]Mok'Nathal Wand 3", Name AC enUS : "[DND]Mok'Nathal Wand 3" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21715;
-- AC datas : OLD Name : "[DND]Mok'Nathal Wand 4", Name AC enUS : "[DND]Mok'Nathal Wand 4" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21716;
-- AC datas : OLD Name : "Oscillating Frequency Scanner Base Bunny", Name AC enUS : "Oscillating Frequency Scanner Base Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21758;
-- AC datas : OLD Name : "Oscillating Frequency Scanner Top Bunny (Caster)", Name AC enUS : "Oscillating Frequency Scanner Top Bunny (Caster)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21759;
-- AC datas : OLD Name : "Oscillating Frequency Scanner Master Bunny", Name AC enUS : "Oscillating Frequency Scanner Master Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21760;
-- AC datas : OLD Name : "Travis' Loot Tester (63)", Name AC enUS : "Travis' Loot Tester (63)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21764;
-- AC datas : OLD Name : "Travis' Loot Tester (68)", Name AC enUS : "Travis' Loot Tester (68)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21765;
-- AC datas : OLD Name : "Oscillating Frequency Scanner Top Bunny (Target)", Name AC enUS : "Oscillating Frequency Scanner Top Bunny (Target)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21781;
-- AC datas : OLD Name : "Singing Ridge Summon Bunny", Name AC enUS : "Singing Ridge Summon Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21800;
-- AC datas : OLD Name : "Invis Legion Teleporter", Name AC enUS : "Invis Legion Teleporter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21807;
-- AC datas : OLD Name : "Nether Drake Egg Bunny", Name AC enUS : "Nether Drake Egg Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21814;
-- AC datas : OLD Name : "Blade's Edge - Toshley's - Invisible Stalker - Def Gun Target", Name AC enUS : "Blade's Edge - Toshley's - Invisible Stalker - Def Gun Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21819;
-- AC datas : OLD Name : "Beholder (beige)", Name AC enUS : "Beholder (beige)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21830;
-- AC datas : OLD Name : "Beholder (blue)", Name AC enUS : "Beholder (blue)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21831;
-- AC datas : OLD Name : "Beholder (black)", Name AC enUS : "Beholder (black)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21832;
-- AC datas : OLD Name : "Beholder (gray)", Name AC enUS : "Beholder (gray)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21833;
-- AC datas : OLD Name : "Beholder (green)", Name AC enUS : "Beholder (green)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21834;
-- AC datas : OLD Name : "Beholder (red)", Name AC enUS : "Beholder (red)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21835;
-- AC datas : OLD Name : "Beholder (spittle)", Name AC enUS : "Beholder (spittle)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21836;
-- AC datas : OLD Name : "Dark Portal Dummy 1.30", Name AC enUS : "Dark Portal Dummy 1.30" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21862;
-- AC datas : OLD Name : "Azaloth Credit Marker", Name AC enUS : "Azaloth Credit Marker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21892;
-- AC datas : OLD Name : "Altruis Conversation Credit", Name AC enUS : "Altruis Conversation Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21893;
-- AC datas : OLD Name : "Ride the Lightning Kill Credit Trigger", Name AC enUS : "Ride the Lightning Kill Credit Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21910;
-- AC datas : OLD Name : "Multi-Spectrum Light Trap Bunny", Name AC enUS : "Multi-Spectrum Light Trap Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21926;
-- AC datas : OLD Name : "Trapping the Light Kill Credit Trigger", Name AC enUS : "Trapping the Light Kill Credit Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21929;
-- AC datas : OLD Name : "Hydross Beam Helper", Name AC enUS : "Hydross Beam Helper" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21933;
-- AC datas : OLD Name : "Hydross Cleansing Field Helper", Name AC enUS : "Hydross Cleansing Field Helper" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21934;
-- AC datas : OLD Name : "Invis Illidari Blade Target", Name AC enUS : "Invis Illidari Blade Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21939;
-- AC datas : OLD Name : "Invis Illidari Bane Caster", Name AC enUS : "Invis Illidari Bane Caster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 21940;
-- AC datas : OLD Name : "O'Mally's Instrument Bunny", Name AC enUS : "O'Mally's Instrument Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22021;
-- AC datas : OLD Name : "[DND]Spirit 1", Name AC enUS : "[DND]Spirit 1" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22023;
-- AC datas : OLD Name : "Crazed Colossus Kill Credit", Name AC enUS : "Crazed Colossus Kill Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22051;
-- AC datas : OLD Name : "Heart of Fury Visual Trigger", Name AC enUS : "Heart of Fury Visual Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22058;
-- AC datas : OLD Name : "Shadowlord Deathwail Visual Trigger", Name AC enUS : "Shadowlord Deathwail Visual Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22096;
-- AC datas : OLD Name : "Skald Bunny", Name AC enUS : "Skald Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22109;
-- AC datas : OLD Name : "Zeth'Gor Must Burn Bunny", Name AC enUS : "Zeth'Gor Must Burn Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22111;
-- AC datas : OLD Name : "[DND]Whisper Spying Credit Marker 1", Name AC enUS : "[DND]Whisper Spying Credit Marker 1" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22116;
-- AC datas : OLD Name : "[DND]Whisper Spying Credit Marker 2", Name AC enUS : "[DND]Whisper Spying Credit Marker 2" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22117;
-- AC datas : OLD Name : "[DND]Whisper Spying Credit Marker 3", Name AC enUS : "[DND]Whisper Spying Credit Marker 3" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22118;
-- AC datas : OLD Name : "Netherwing Event Pinger", Name AC enUS : "Netherwing Event Pinger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22131;
-- AC datas : OLD Name : "Invis Arakkoa Target", Name AC enUS : "Invis Arakkoa Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22139;
-- AC datas : OLD Name : "Eye of Grillok Quest Credit Bunny", Name AC enUS : "Eye of Grillok Quest Credit Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22177;
-- AC datas : OLD Name : "Spore Drop Trigger", Name AC enUS : "Spore Drop Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22207;
-- AC datas : OLD Name : "Leafbeard Flavor Event Channel Bunny", Name AC enUS : "Leafbeard Flavor Event Channel Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22240;
-- AC datas : OLD Name : "Leafbeard Flavor Event Particle Bunny", Name AC enUS : "Leafbeard Flavor Event Particle Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22246;
-- AC datas : OLD Name : "Magic Sucker Device Spawner", Name AC enUS : "Magic Sucker Device Spawner" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22260;
-- AC datas : OLD Name : "High Astromancer Solarian Transform Visual", Name AC enUS : "High Astromancer Solarian Transform Visual" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22290;
-- AC datas : OLD Name : "<NOT USED>Mystery Mask Summon Bunny", Name AC enUS : "<NOT USED>Mystery Mask Summon Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22296;
-- AC datas : OLD Name : "Western Gehenna Teleporter Credit", Name AC enUS : "Western Gehenna Teleporter Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22348;
-- AC datas : OLD Name : "[DND]Green Spot Grog Keg Relay", Name AC enUS : "[DND]Green Spot Grog Keg Relay" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22349;
-- AC datas : OLD Name : "Central Gehenna Teleporter Credit", Name AC enUS : "Central Gehenna Teleporter Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22350;
-- AC datas : OLD Name : "Eastern Gehenna Teleporter Credit", Name AC enUS : "Eastern Gehenna Teleporter Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22351;
-- AC datas : OLD Name : "[DND]Green Spot Grog Keg Credit", Name AC enUS : "[DND]Green Spot Grog Keg Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22356;
-- AC datas : OLD Name : "Nether Gas Visual Trigger", Name AC enUS : "Nether Gas Visual Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22358;
-- AC datas : OLD Name : "[DND]Ripe Moonshine Keg Credit", Name AC enUS : "[DND]Ripe Moonshine Keg Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22367;
-- AC datas : OLD Name : "[DND]Fermented Seed Beer Keg Credit", Name AC enUS : "[DND]Fermented Seed Beer Keg Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22368;
-- AC datas : OLD Name : "Terokkar Forest Ground Shaker Bunny", Name AC enUS : "Terokkar Forest Ground Shaker Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22371;
-- AC datas : OLD Name : "[DND]Bloodmaul Chatter Credit", Name AC enUS : "[DND]Bloodmaul Chatter Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22383;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower North", Name AC enUS : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower North" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22401;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower Forge", Name AC enUS : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower Forge" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22402;
-- AC datas : OLD Name : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower Foothill", Name AC enUS : "Zeth'Gor Quest Credit Marker, They Must Burn, Tower Foothill" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22403;
-- AC datas : OLD Name : "ZZZ - Dan Reed Test", Name AC enUS : "ZZZ - Dan Reed Test" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22409;
-- AC datas : OLD Name : "Blade's Edge - Legion - Anger Camp - Invis Bunny", Name AC enUS : "Blade's Edge - Legion - Anger Camp - Invis Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22422;
-- AC datas : OLD Name : "Smoke Beacon Bunny", Name AC enUS : "Smoke Beacon Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22428;
-- AC datas : OLD Name : "[DND]Ogre Pike Planted Credit", Name AC enUS : "[DND]Ogre Pike Planted Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22434;
-- AC datas : OLD Name : "[DND]Rexxar's Wyvern Freed Credit", Name AC enUS : "[DND]Rexxar's Wyvern Freed Credit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22435;
-- AC datas : OLD Name : "[DND]Sablemane's Trap Target", Name AC enUS : "[DND]Sablemane's Trap Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22447;
-- AC datas : OLD Name : "Fei Fei Stash Bunny", Name AC enUS : "Fei Fei Stash Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22467;
-- AC datas : OLD Name : "Death's Door Fel Cannon Target Bunny", Name AC enUS : "Death's Door Fel Cannon Target Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22495;
-- AC datas : OLD Name : "Death's Door Warp-Gate Explosion Bunny", Name AC enUS : "Death's Door Warp-Gate Explosion Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22502;
-- AC datas : OLD Name : "Warp-Gate North Kill Bunny", Name AC enUS : "Warp-Gate North Kill Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22503;
-- AC datas : OLD Name : "Warp-Gate South Kill Bunny", Name AC enUS : "Warp-Gate South Kill Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22504;
-- AC datas : OLD Name : "The Exorcism Bubbling Slimer Bunny (DND)", Name AC enUS : "The Exorcism Bubbling Slimer Bunny (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22505;
-- AC datas : OLD Name : "The Exorcism Lightning Cloud Bunny", Name AC enUS : "The Exorcism Lightning Cloud Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22508;
-- AC datas : OLD Name : "World Trigger", Name AC enUS : "World Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22515;
-- AC datas : OLD Name : "World Trigger (Large AOI)", Name AC enUS : "World Trigger (Large AOI)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22517;
-- AC datas : OLD Name : "Chess Piece: Karazhan Invisible Stalker", Name AC enUS : "Chess Piece: Karazhan Invisible Stalker" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22519;
-- AC datas : OLD Name : "Chess Piece: Status Bar", Name AC enUS : "Chess Piece: Status Bar" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22520;
-- AC datas : OLD Name : "Karazhan - Chess, Medivh CHEAT: Fury of Medivh Visual (DND)", Name AC enUS : "Karazhan - Chess, Medivh CHEAT: Fury of Medivh Visual (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22521;
-- AC datas : OLD Name : "Karazhan - Chess, Victory Dummy Tool", Name AC enUS : "Karazhan - Chess, Victory Dummy Tool" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22523;
-- AC datas : OLD Name : "Karazhan - Chess, Victory Controller", Name AC enUS : "Karazhan - Chess, Victory Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22524;
-- AC datas : OLD Name : "Outland Children's Week Auchindoun Trigger", Name AC enUS : "Outland Children's Week Auchindoun Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22831;
-- AC datas : OLD Name : "Outland Children's Week Dark Portal Trigger", Name AC enUS : "Outland Children's Week Dark Portal Trigger" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 22833;
-- AC datas : OLD Name : "Legion Ring Event InvisMan", Name AC enUS : "Legion Ring Event InvisMan" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23059;
-- AC datas : OLD Name : "Legion Ring Event InvisMan Lg", Name AC enUS : "Legion Ring Event InvisMan Lg" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23260;
-- AC datas : OLD Name : "Simon Unit", Name AC enUS : "Simon Unit" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23385;
-- AC datas : OLD Name : "Invisible Stalker - Large AOI (Scale x3)", Name AC enUS : "Invisible Stalker - Large AOI (Scale x3)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23409;
-- AC datas : OLD Name : "BurkeTest01", Name AC enUS : "BurkeTest01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23526;
-- AC datas : OLD Name : "ELM General Purpose Bunny", Name AC enUS : "ELM General Purpose Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 23837;
-- AC datas : OLD Name : "ELM General Purpose Bunny (scale x0.01)", Name AC enUS : "ELM General Purpose Bunny (scale x0.01)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24021;
-- AC datas : OLD Name : "ELM General Purpose Bunny Large", Name AC enUS : "ELM General Purpose Bunny Large" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24110;
-- AC datas : OLD Name : "ELM General Purpose Bunny Hide Body", Name AC enUS : "ELM General Purpose Bunny Hide Body" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24288;
-- AC datas : OLD Name : "BLB Bunny - Kickoff Target - to Team A", Name AC enUS : "BLB Bunny - Kickoff Target - to Team A" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24903;
-- AC datas : OLD Name : "BLB Bunny - Kickoff Target - to Team B", Name AC enUS : "BLB Bunny - Kickoff Target - to Team B" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24904;
-- AC datas : OLD Name : "BLB Bunny - Center Field", Name AC enUS : "BLB Bunny - Center Field" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24908;
-- AC datas : OLD Name : "Sunwell Daily Bunny x 1.00", Name AC enUS : "Sunwell Daily Bunny x 1.00" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24928;
-- AC datas : OLD Name : "Sunwell Daily Bunny x 0.01", Name AC enUS : "Sunwell Daily Bunny x 0.01" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24936;
-- AC datas : OLD Name : "Generic Quest Trigger - LAB", Name AC enUS : "Generic Quest Trigger - LAB" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 24959;
-- AC datas : OLD Name : "Bridge Marksman Target Bunny", Name AC enUS : "Bridge Marksman Target Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25192;
-- AC datas : OLD Name : "[PH] Torch Target", Name AC enUS : "[PH] Torch Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25218;
-- AC datas : OLD Name : "Ribbon Pole Fire Spiral Bunny", Name AC enUS : "Ribbon Pole Fire Spiral Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25303;
-- AC datas : OLD Name : "(PH) DEPRECATED", Name AC enUS : "(PH) DEPRECATED" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25366;
-- AC datas : OLD Name : "[DNT] Torch Tossing Target Bunny", Name AC enUS : "[DNT] Torch Tossing Target Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25535;
-- AC datas : OLD Name : "[DNT] Torch Tossing Target Bunny Controller", Name AC enUS : "[DNT] Torch Tossing Target Bunny Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25536;
-- AC datas : OLD Name : "ELM General Purpose Bunny (scale x3)", Name AC enUS : "ELM General Purpose Bunny (scale x3)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25670;
-- AC datas : OLD Name : "[PH] Ahune Summon Loc Bunny", Name AC enUS : "[PH] Ahune Summon Loc Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25745;
-- AC datas : OLD Name : "[PH] Ahune Loot Loc Bunny", Name AC enUS : "[PH] Ahune Loot Loc Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25746;
-- AC datas : OLD Name : "X-42B", Name AC enUS : "X-42B" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25787;
-- AC datas : OLD Name : "ED-210", Name AC enUS : "ED-210" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25831;
-- AC datas : OLD Name : "Ahune Ice Spear Bunny", Name AC enUS : "Ahune Ice Spear Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 25985;
-- AC datas : OLD Name : "Wisp Dest Bunny", Name AC enUS : "Wisp Dest Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26120;
-- AC datas : OLD Name : "Wisp Source Bunny", Name AC enUS : "Wisp Source Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26121;
-- AC datas : OLD Name : "[PH] Tom Test", Name AC enUS : "[PH] Tom Test" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26176;
-- AC datas : OLD Name : "2.4 Sunwell 5 Man Tradeskill Bunny [PH]", Name AC enUS : "2.4 Sunwell 5 Man Tradeskill Bunny [PH]" OLD Subname : "Kill Me", Subname AC enUS : "Kill Me" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26177;
-- AC datas : OLD Name : "[PH] Torch Catching Target Bunny", Name AC enUS : "[PH] Torch Catching Target Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26188;
-- AC datas : OLD Name : "[PH] Spank Target Bunny", Name AC enUS : "[PH] Spank Target Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26190;
-- AC datas : OLD Name : "[DND] Midsummer Bonfire Faction Bunny - A", Name AC enUS : "[DND] Midsummer Bonfire Faction Bunny - A" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26258;
-- AC datas : OLD Name : "[DND] Midsummer Bonfire Faction Bunny - H", Name AC enUS : "[DND] Midsummer Bonfire Faction Bunny - H" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26355;
-- AC datas : OLD Name : "[PH] Ice Chest Bunny", Name AC enUS : "[PH] Ice Chest Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26391;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Armor, Cloth & Leather", Name AC enUS : "[DND] TAR Pedestal - Armor, Cloth & Leather" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26724;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Accessories", Name AC enUS : "[DND] TAR Pedestal - Accessories" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26738;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Enchantments", Name AC enUS : "[DND] TAR Pedestal - Enchantments" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26739;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Gems", Name AC enUS : "[DND] TAR Pedestal - Gems" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26740;
-- AC datas : OLD Name : "[DND] TAR Pedestal - General Goods", Name AC enUS : "[DND] TAR Pedestal - General Goods" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26741;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Armor, Mail & Plate", Name AC enUS : "[DND] TAR Pedestal - Armor, Mail & Plate" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26742;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Glyph, Cloth & Leather", Name AC enUS : "[DND] TAR Pedestal - Glyph, Cloth & Leather" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26743;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Glyph, Mail & Plate", Name AC enUS : "[DND] TAR Pedestal - Glyph, Mail & Plate" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26744;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Weapons", Name AC enUS : "[DND] TAR Pedestal - Weapons" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26745;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Arena Organizer", Name AC enUS : "[DND] TAR Pedestal - Arena Organizer" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26747;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Beastmaster", Name AC enUS : "[DND] TAR Pedestal - Beastmaster" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26748;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Teleporter", Name AC enUS : "[DND] TAR Pedestal - Teleporter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26750;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Druid", Name AC enUS : "[DND] TAR Pedestal - Trainer, Druid" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26751;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Hunter", Name AC enUS : "[DND] TAR Pedestal - Trainer, Hunter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26752;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Mage", Name AC enUS : "[DND] TAR Pedestal - Trainer, Mage" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26753;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Paladin", Name AC enUS : "[DND] TAR Pedestal - Trainer, Paladin" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26754;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Priest", Name AC enUS : "[DND] TAR Pedestal - Trainer, Priest" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26755;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Rogue", Name AC enUS : "[DND] TAR Pedestal - Trainer, Rogue" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26756;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Shaman", Name AC enUS : "[DND] TAR Pedestal - Trainer, Shaman" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26757;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Warlock", Name AC enUS : "[DND] TAR Pedestal - Trainer, Warlock" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26758;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Warrior", Name AC enUS : "[DND] TAR Pedestal - Trainer, Warrior" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26759;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Fight Promoter", Name AC enUS : "[DND] TAR Pedestal - Fight Promoter" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 26765;
-- AC datas : OLD Name : "Vic's Self Replicating Abomination (DND)", Name AC enUS : "Vic's Self Replicating Abomination (DND)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 28645;
-- AC datas : OLD Name : "Scarlet Cover Dummy", Name AC enUS : "Scarlet Cover Dummy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 28839;
-- AC datas : OLD Name : "[DND] Dockhand w/Bag", Name AC enUS : "[DND] Dockhand w/Bag" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 29020;
-- AC datas : OLD Name : "[DND] Icecrown Flight To Airship Bunny (A)", Name AC enUS : "[DND] Icecrown Flight To Airship Bunny (A)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 30476;
-- AC datas : OLD Name : "[DND] Icecrown Flight To Airship Bunny (A) Teleport Target", Name AC enUS : "[DND] Icecrown Flight To Airship Bunny (A) Teleport Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 30559;
-- AC datas : OLD Name : "[DND] Icecrown Flight To Airship Bunny (H)", Name AC enUS : "[DND] Icecrown Flight To Airship Bunny (H)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 30588;
-- AC datas : OLD Name : "[DND] Icecrown Flight To Airship Bunny (H) Teleport Target", Name AC enUS : "[DND] Icecrown Flight To Airship Bunny (H) Teleport Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 30589;
-- AC datas : OLD Name : "[DND] Icecrown Airship (A) - Cannon Target", Name AC enUS : "[DND] Icecrown Airship (A) - Cannon Target" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 30640;
-- AC datas : OLD Name : "ELM General Purpose Bunny Gigantic", Name AC enUS : "ELM General Purpose Bunny Gigantic" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 31047;
-- AC datas : OLD Name : "Cosmetic Trigger - Phase 1 - LAB", Name AC enUS : "Cosmetic Trigger - Phase 1 - LAB" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 31644;
-- AC datas : OLD Name : "Cosmetic Trigger - Phase 2 - LAB", Name AC enUS : "Cosmetic Trigger - Phase 2 - LAB" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 31645;
-- AC datas : OLD Name : "Cosmetic Trigger - Phase 3 - LAB", Name AC enUS : "Cosmetic Trigger - Phase 3 - LAB" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 31646;
-- AC datas : OLD Name : "[DND] Icecrown Airship Bomb", Name AC enUS : "[DND] Icecrown Airship Bomb" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 32193;
-- AC datas : OLD Name : "[DND] Dalaran Sewer Arena - Controller - Death", Name AC enUS : "[DND] Dalaran Sewer Arena - Controller - Death" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 32328;
-- AC datas : OLD Name : "[DND] Dalaran Sewer Arena - Controller", Name AC enUS : "[DND] Dalaran Sewer Arena - Controller" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 32339;
-- AC datas : OLD Name : "Totally Generic Bunny (All Phase)", Name AC enUS : "Totally Generic Bunny (All Phase)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 32520;
-- AC datas : OLD Name : "ELM General Purpose Bunny Large (scale x5)", Name AC enUS : "ELM General Purpose Bunny Large (scale x5)" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33045;
-- AC datas : OLD Name : "Thorim Trap Bunny", Name AC enUS : "Thorim Trap Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33054;
-- AC datas : OLD Name : "[DND] TAR Pedestal - Trainer, Death Knight", Name AC enUS : "[DND] TAR Pedestal - Trainer, Death Knight" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33252;
-- AC datas : OLD Name : "[DND] Tournament - Ranged Target Dummy - Bunny", Name AC enUS : "[DND] Tournament - Ranged Target Dummy - Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33339;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny", Name AC enUS : "[DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33340;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Target Dummy - Block Bunny", Name AC enUS : "[DND] Tournament - Mounted Melee - Target Dummy - Block Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33341;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy", Name AC enUS : "[DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33489;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy", Name AC enUS : "[DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33490;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy", Name AC enUS : "[DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33491;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy", Name AC enUS : "[DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33492;
-- AC datas : OLD Name : "[DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate", Name AC enUS : "[DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 33493;
-- AC datas : OLD Name : "[DND] Valentine Boss - Vial Bunny", Name AC enUS : "[DND] Valentine Boss - Vial Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 36530;
-- AC datas : OLD Name : "[DND]Something Stinks Kill Credit Bunny", Name AC enUS : "[DND]Something Stinks Kill Credit Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 37558;
-- AC datas : OLD Name : "[DND] Bunny", Name AC enUS : "[DND] Bunny" OLD Subname : "", Subname AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR' AND `entry` = 40617;

-- Update existing entries, from WOTLK
-- AC datas : OLD Name : "칸레타드", Name AC enUS : "Kanrethad" ; Wowhead enUS : "Kanrethad"
UPDATE `creature_template_locale` SET `Name` = '용혈족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29;
-- AC datas : OLD Name : "하찮은 폭력배", Name AC enUS : "Defias Thug" ; Wowhead enUS : "Defias Thug"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38;
-- AC datas : OLD Name : "투로스 라이트핑거스", Name AC enUS : "Thuros Lightfingers" ; Wowhead enUS : "Thuros Lightfingers"
UPDATE `creature_template_locale` SET `Name` = '투로스 라이트핑거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 61;
-- AC datas : OLD Name : "병에 걸린 회갈색 늑대", Name AC enUS : "Diseased Timber Wolf" ; Wowhead enUS : "Diseased Timber Wolf"
UPDATE `creature_template_locale` SET `Name` = '병에 걸린 회색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 69;
-- AC datas : OLD Name : "소매치기", Name AC enUS : "Defias Cutpurse" ; Wowhead enUS : "Defias Cutpurse"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 소매치기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 94;
-- AC datas : OLD Name : "갈퀴발 심부름꾼", Name AC enUS : "Riverpaw Runt" ; Wowhead enUS : "Riverpaw Runt"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 심부름꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 97;
-- AC datas : OLD Name : "갈퀴발 전사", Name AC enUS : "Riverpaw Taskmaster" ; Wowhead enUS : "Riverpaw Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 98;
-- AC datas : OLD Name : "청동 용혈족", Name AC enUS : "Bronze Dragonspawn" ; Wowhead enUS : "Bronze Dragonspawn"
UPDATE `creature_template_locale` SET `Name` = '청동용혈족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 102;
-- AC datas : OLD Name : "녹색 용혈족", Name AC enUS : "Green Dragonspawn" ; Wowhead enUS : "Green Dragonspawn"
UPDATE `creature_template_locale` SET `Name` = '녹색용혈족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 108;
-- AC datas : OLD Name : "백색 용혈족", Name AC enUS : "White Dragonspawn" ; Wowhead enUS : "White Dragonspawn"
UPDATE `creature_template_locale` SET `Name` = '백색용혈족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 109;
-- AC datas : OLD Name : "좀도둑", Name AC enUS : "Defias Bandit" ; Wowhead enUS : "Defias Bandit"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 좀도둑', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 116;
-- AC datas : OLD Name : "갈퀴발 싸움꾼", Name AC enUS : "Riverpaw Mongrel" ; Wowhead enUS : "Riverpaw Mongrel"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 123;
-- AC datas : OLD Name : "갈퀴발 투사", Name AC enUS : "Riverpaw Brute" ; Wowhead enUS : "Riverpaw Brute"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 124;
-- AC datas : OLD Name : "갈퀴발 우두머리", Name AC enUS : "Riverpaw Overseer" ; Wowhead enUS : "Riverpaw Overseer"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 125;
-- AC datas : OLD Name : "썩어가는 좀비", Name AC enUS : "Skeletal Horror" ; Wowhead enUS : "Skeletal Horror"
UPDATE `creature_template_locale` SET `Name` = '해골 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 202;
-- AC datas : OLD Name : "파멸어둠 암흑길잡이", Name AC enUS : "Nightbane Dark Runner" ; Wowhead enUS : "Nightbane Dark Runner"
UPDATE `creature_template_locale` SET `Name` = '파멸의어둠일족 암흑길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 205;
-- AC datas : OLD Name : "파멸어둠 송곳니투사", Name AC enUS : "Nightbane Vile Fang" ; Wowhead enUS : "Nightbane Vile Fang"
UPDATE `creature_template_locale` SET `Name` = '파멸의어둠일족 송곳니투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 206;
-- AC datas : OLD Name : "망치주먹 전사", Name AC enUS : "Splinter Fist Warrior" ; Wowhead enUS : "Splinter Fist Warrior"
UPDATE `creature_template_locale` SET `Name` = '망치주먹일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 212;
-- AC datas : OLD Name : "데피아즈단 어둠추적자", Name AC enUS : "Defias Night Runner" ; Wowhead enUS : "Defias Night Runner"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 어둠의추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 215;
-- AC datas : OLD Name : "치안대장 그라이언 스타우트맨틀", Name AC enUS : "Gryan Stoutmantle" ; Wowhead enUS : "Gryan Stoutmantle",  OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Name` = '그라이언 스타우트맨틀', `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 234;
-- AC datas : OLD Name : "농부 펄브라우", Name AC enUS : "Farmer Furlbrow" ; Wowhead enUS : "Farmer Furlbrow"
UPDATE `creature_template_locale` SET `Name` = '농부 펄브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 237;
-- AC datas : OLD Name : "베르나 펄브라우", Name AC enUS : "Verna Furlbrow" ; Wowhead enUS : "Verna Furlbrow"
UPDATE `creature_template_locale` SET `Name` = '베르나 펄브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 238;
-- AC datas : OLD Name : "빌리 매클루어", Name AC enUS : "Billy Maclure" ; Wowhead enUS : "Billy Maclure"
UPDATE `creature_template_locale` SET `Name` = '빌리 맥클루어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 247;
-- AC datas : OLD Name : "파 매클루어", Name AC enUS : "Pa Maclure" ; Wowhead enUS : "Pa Maclure"
UPDATE `creature_template_locale` SET `Name` = '파 맥클루어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 250;
-- AC datas : OLD Name : "메이벨 매클루어", Name AC enUS : "Maybell Maclure" ; Wowhead enUS : "Maybell Maclure"
UPDATE `creature_template_locale` SET `Name` = '메이벨 맥클루어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 251;
-- AC datas : OLD Name : "조슈아 매클루어", Name AC enUS : "Joshua Maclure" ; Wowhead enUS : "Joshua Maclure"
UPDATE `creature_template_locale` SET `Name` = '조슈아 맥클루어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 258;
-- AC datas : OLD Name : "[DND] 부상당한 사자의 보병", Name AC enUS : "Half-eaten body" ; Wowhead enUS : "Half-eaten body"
UPDATE `creature_template_locale` SET `Name` = '반쯤 파먹힌 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 262;
-- AC datas : OLD Subname : "어둠골 시장", Subname AC enUS : "Mayor of Darkshire" ; Wowhead enUS : "Mayor of Darkshire"
UPDATE `creature_template_locale` SET `Title` = '다크샤이어 시장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 263;
-- AC datas : OLD Subname : "어둠골 사학자", Subname AC enUS : "Historian of Darkshire" ; Wowhead enUS : "Historian of Darkshire"
UPDATE `creature_template_locale` SET `Title` = '다크샤이어 사학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 268;
-- AC datas : OLD Subname : "어둠골 부시장", Subname AC enUS : "Deputy Mayor of Darkshire" ; Wowhead enUS : "Deputy Mayor of Darkshire"
UPDATE `creature_template_locale` SET `Title` = '다크샤이어 부시장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 269;
-- AC datas : OLD Subname : "어둠골 의회", Subname AC enUS : "Council of Darkshire" ; Wowhead enUS : "Council of Darkshire"
UPDATE `creature_template_locale` SET `Title` = '다크샤이어 의회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 270;
-- AC datas : OLD Subname : "어둠골 의회", Subname AC enUS : "Council of Darkshire" ; Wowhead enUS : "Council of Darkshire"
UPDATE `creature_template_locale` SET `Title` = '다크샤이어 의회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 271;
-- AC datas : OLD Name : "로베르토 퍼플리버보스", Name AC enUS : "Roberto Pupellyverbos" ; Wowhead enUS : "Roberto Pupellyverbos"
UPDATE `creature_template_locale` SET `Name` = '로베르토 푸펠리베르보스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 277;
-- AC datas : OLD Name : "애버크롬비", Name AC enUS : "Abercrombie" ; Wowhead enUS : "Abercrombie"
UPDATE `creature_template_locale` SET `Name` = '에이버크롬비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 289;
-- AC datas : OLD Name : "어린 늑대", Name AC enUS : "Diseased Young Wolf" ; Wowhead enUS : "Diseased Young Wolf"
UPDATE `creature_template_locale` SET `Name` = '병에 걸린 새끼 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 299;
-- AC datas : OLD Name : "눈먼 메리", Name AC enUS : "Blind Mary" ; Wowhead enUS : "Blind Mary"
UPDATE `creature_template_locale` SET `Name` = '눈먼 매리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 302;
-- AC datas : OLD Name : "백마", Name AC enUS : "White Stallion" ; Wowhead enUS : "White Stallion"
UPDATE `creature_template_locale` SET `Name` = '길들인 백마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 305;
-- AC datas : OLD Name : "황토마", Name AC enUS : "Palomino" ; Wowhead enUS : "Palomino"
UPDATE `creature_template_locale` SET `Name` = '길들인 황토마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 306;
-- AC datas : OLD Name : ""뒤집혀 파묻힌" 탈것", Name AC enUS : "Rolf's corpse" ; Wowhead enUS : "Rolf's corpse"
UPDATE `creature_template_locale` SET `Name` = '롤프의 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 309;
-- AC datas : OLD Subname : "검은바위 부족 대족장", Subname AC enUS : "Warlord of the Blackrock Clan" ; Wowhead enUS : "Warlord of the Blackrock Clan"
UPDATE `creature_template_locale` SET `Title` = '검은바위부족 대족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 334;
-- AC datas : OLD Name : "주방장 브리아나", Name AC enUS : "Chef Breanna" ; Wowhead enUS : "Chef Breanna"
UPDATE `creature_template_locale` SET `Name` = '주방장 브리나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 343;
-- AC datas : OLD Name : "바텐더 다니엘스", Name AC enUS : "Barkeep Daniels" ; Wowhead enUS : "Barkeep Daniels"
UPDATE `creature_template_locale` SET `Name` = '바텐더 대니얼스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 346;
-- AC datas : OLD Name : "회갈색 늑대", Name AC enUS : "Timber Wolf" ; Wowhead enUS : "Timber Wolf"
UPDATE `creature_template_locale` SET `Name` = '회색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 358;
-- AC datas : OLD Name : "겨울늑대", Name AC enUS : "Winter Wolf" ; Wowhead enUS : "Winter Wolf"
UPDATE `creature_template_locale` SET `Name` = '길들인 흰색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 359;
-- AC datas : OLD Name : "진흙괴물", Name AC enUS : "Slime" ; Wowhead enUS : "Slime"
UPDATE `creature_template_locale` SET `Name` = '점액', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 364;
-- AC datas : OLD Name : "달시 파커", Name AC enUS : "Darcy" ; Wowhead enUS : "Darcy",  OLD Subname : "", Subname AC enUS : "Waitress" ; Wowhead enUS : "Waitress"
UPDATE `creature_template_locale` SET `Name` = '달시', `Title` = '여종업원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 379;
-- AC datas : OLD Name : "대학자 도운", Name AC enUS : "Morganth" ; Wowhead enUS : "Morganth"
UPDATE `creature_template_locale` SET `Name` = '모건스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 397;
-- AC datas : OLD Name : "하급 공허방랑자", Name AC enUS : "Lesser Voidwalker" ; Wowhead enUS : "Lesser Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '하급 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 418;
-- AC datas : OLD Name : "붉은마루 싸움꾼", Name AC enUS : "Redridge Mongrel" ; Wowhead enUS : "Redridge Mongrel"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 423;
-- AC datas : OLD Name : "붉은마루 밀렵꾼", Name AC enUS : "Redridge Poacher" ; Wowhead enUS : "Redridge Poacher"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 밀렵꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 424;
-- AC datas : OLD Name : "붉은마루 투사", Name AC enUS : "Redridge Brute" ; Wowhead enUS : "Redridge Brute"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 426;
-- AC datas : OLD Name : "잿빛가죽 흑마술사", Name AC enUS : "Shadowhide Darkweaver" ; Wowhead enUS : "Shadowhide Darkweaver"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽일족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 429;
-- AC datas : OLD Name : "붉은마루 비술사", Name AC enUS : "Redridge Mystic" ; Wowhead enUS : "Redridge Mystic"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 430;
-- AC datas : OLD Name : "잿빛가죽 척살자", Name AC enUS : "Shadowhide Slayer" ; Wowhead enUS : "Shadowhide Slayer"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽일족 척살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 431;
-- AC datas : OLD Name : "잿빛가죽 투사", Name AC enUS : "Shadowhide Brute" ; Wowhead enUS : "Shadowhide Brute"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 432;
-- AC datas : OLD Name : "잿빛가죽 놀", Name AC enUS : "Shadowhide Gnoll" ; Wowhead enUS : "Shadowhide Gnoll"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽놀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 433;
-- AC datas : OLD Name : "광포한 잿빛가죽 놀", Name AC enUS : "Rabid Shadowhide Gnoll" ; Wowhead enUS : "Rabid Shadowhide Gnoll"
UPDATE `creature_template_locale` SET `Name` = '광포한 잿빛가죽놀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 434;
-- AC datas : OLD Name : "검은바위 용사", Name AC enUS : "Blackrock Champion" ; Wowhead enUS : "Blackrock Champion"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 435;
-- AC datas : OLD Name : "검은바위 흑마술사", Name AC enUS : "Blackrock Shadowcaster" ; Wowhead enUS : "Blackrock Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 436;
-- AC datas : OLD Name : "검은바위 보초병", Name AC enUS : "Blackrock Renegade" ; Wowhead enUS : "Blackrock Renegade"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 보초병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 437;
-- AC datas : OLD Name : "검은바위 그런트", Name AC enUS : "Blackrock Grunt" ; Wowhead enUS : "Blackrock Grunt"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 440;
-- AC datas : OLD Name : "붉은마루 부대장", Name AC enUS : "Redridge Alpha" ; Wowhead enUS : "Redridge Alpha"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 부대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 445;
-- AC datas : OLD Name : "붉은마루 전사", Name AC enUS : "Redridge Basher" ; Wowhead enUS : "Redridge Basher"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 446;
-- AC datas : OLD Name : "갈퀴발 무법자", Name AC enUS : "Riverpaw Bandit" ; Wowhead enUS : "Riverpaw Bandit"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 무법자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 452;
-- AC datas : OLD Name : "갈퀴발 비술사", Name AC enUS : "Riverpaw Mystic" ; Wowhead enUS : "Riverpaw Mystic"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 453;
-- AC datas : OLD Name : "파수대장 파커", Name AC enUS : "Guard Parker" ; Wowhead enUS : "Guard Parker"
UPDATE `creature_template_locale` SET `Name` = '경비병 파커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 464;
-- AC datas : OLD Name : "이단마술사", Name AC enUS : "Defias Rogue Wizard" ; Wowhead enUS : "Defias Rogue Wizard"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 수습마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 474;
-- AC datas : OLD Name : "갈퀴발 길잡이", Name AC enUS : "Riverpaw Outrunner" ; Wowhead enUS : "Riverpaw Outrunner"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 478;
-- AC datas : OLD Name : "검은바위 길잡이", Name AC enUS : "Blackrock Outrunner" ; Wowhead enUS : "Blackrock Outrunner"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 485;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 487;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 488;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 489;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 490;
-- AC datas : OLD Subname : "병참장교", Subname AC enUS : "Quartermaster" ; Wowhead enUS : "Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '병참 장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 491;
-- AC datas : OLD Name : "갈퀴발 정찰병", Name AC enUS : "Riverpaw Scout" ; Wowhead enUS : "Riverpaw Scout"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 500;
-- AC datas : OLD Name : "갈퀴발 약초채집꾼", Name AC enUS : "Riverpaw Herbalist" ; Wowhead enUS : "Riverpaw Herbalist"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 약초채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 501;
-- AC datas : OLD Name : "광기 어린 구울", Name AC enUS : "Insane Ghoul" ; Wowhead enUS : "Insane Ghoul"
UPDATE `creature_template_locale` SET `Name` = '광기어린 구울', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 511;
-- AC datas : OLD Name : "파멸어둠 흑마술사", Name AC enUS : "Nightbane Shadow Weaver" ; Wowhead enUS : "Nightbane Shadow Weaver"
UPDATE `creature_template_locale` SET `Name` = '파멸의어둠일족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 533;
-- AC datas : OLD Subname : "야수 관리인", Subname AC enUS : "Pet Trainer" ; Wowhead enUS : "Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '야수 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 543;
-- AC datas : OLD Name : "잿빛가죽 전사", Name AC enUS : "Shadowhide Warrior" ; Wowhead enUS : "Shadowhide Warrior"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 568;
-- AC datas : OLD Name : "잿빛가죽 암살자", Name AC enUS : "Shadowhide Assassin" ; Wowhead enUS : "Shadowhide Assassin"
UPDATE `creature_template_locale` SET `Name` = '잿빛가죽일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 579;
-- AC datas : OLD Name : "붉은마루 노역꾼", Name AC enUS : "Redridge Drudger" ; Wowhead enUS : "Redridge Drudger"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 노역꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 580;
-- AC datas : OLD Name : "복병", Name AC enUS : "Defias Ambusher" ; Wowhead enUS : "Defias Ambusher"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 583;
-- AC datas : OLD Name : "붉은머리 전사", Name AC enUS : "Bloodscalp Warrior" ; Wowhead enUS : "Bloodscalp Warrior"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 587;
-- AC datas : OLD Name : "붉은머리 정찰병", Name AC enUS : "Bloodscalp Scout" ; Wowhead enUS : "Bloodscalp Scout"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 588;
-- AC datas : OLD Name : "붉은머리 사냥꾼", Name AC enUS : "Bloodscalp Hunter" ; Wowhead enUS : "Bloodscalp Hunter"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 595;
-- AC datas : OLD Name : "붉은머리 광전사", Name AC enUS : "Bloodscalp Berserker" ; Wowhead enUS : "Bloodscalp Berserker"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 597;
-- AC datas : OLD Name : "악당 카포 [미사용]", Name AC enUS : "Capo the Mean" ; Wowhead enUS : "Capo the Mean"
UPDATE `creature_template_locale` SET `Name` = '악당 카포', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 601;
-- AC datas : OLD Name : "검은바위 추적자", Name AC enUS : "Blackrock Tracker" ; Wowhead enUS : "Blackrock Tracker"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 615;
-- AC datas : OLD Name : "스마이트 씨", Name AC enUS : "Mr. Smite" ; Wowhead enUS : "Mr. Smite"
UPDATE `creature_template_locale` SET `Name` = '미스터 스마이트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 646;
-- AC datas : OLD Name : "붉은머리 의술사", Name AC enUS : "Bloodscalp Witch Doctor" ; Wowhead enUS : "Bloodscalp Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 660;
-- AC datas : OLD Name : "백골가루 전사", Name AC enUS : "Skullsplitter Warrior" ; Wowhead enUS : "Skullsplitter Warrior"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 667;
-- AC datas : OLD Name : "백골가루 사냥꾼", Name AC enUS : "Skullsplitter Hunter" ; Wowhead enUS : "Skullsplitter Hunter"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 669;
-- AC datas : OLD Name : "백골가루 의술사", Name AC enUS : "Skullsplitter Witch Doctor" ; Wowhead enUS : "Skullsplitter Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 670;
-- AC datas : OLD Name : "붉은머리 인간사냥꾼", Name AC enUS : "Bloodscalp Headhunter" ; Wowhead enUS : "Bloodscalp Headhunter"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 671;
-- AC datas : OLD Name : "백골가루 유령사냥꾼", Name AC enUS : "Skullsplitter Spiritchaser" ; Wowhead enUS : "Skullsplitter Spiritchaser"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 유령사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 672;
-- AC datas : OLD Name : "모쉬오그 싸움꾼", Name AC enUS : "Mosh'Ogg Mauler" ; Wowhead enUS : "Mosh'Ogg Mauler"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 678;
-- AC datas : OLD Name : "모쉬오그 주술사", Name AC enUS : "Mosh'Ogg Shaman" ; Wowhead enUS : "Mosh'Ogg Shaman"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 679;
-- AC datas : OLD Name : "모쉬오그 우두머리", Name AC enUS : "Mosh'Ogg Lord" ; Wowhead enUS : "Mosh'Ogg Lord"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 680;
-- AC datas : OLD Name : "바위턱바실리스크", Name AC enUS : "Stone Maw Basilisk" ; Wowhead enUS : "Stone Maw Basilisk"
UPDATE `creature_template_locale` SET `Name` = '바위턱 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 688;
-- AC datas : OLD Name : "수정가시바실리스크", Name AC enUS : "Crystal Spine Basilisk" ; Wowhead enUS : "Crystal Spine Basilisk"
UPDATE `creature_template_locale` SET `Name` = '수정가시 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 689;
-- AC datas : OLD Name : "얼음눈바실리스크", Name AC enUS : "Cold Eye Basilisk" ; Wowhead enUS : "Cold Eye Basilisk"
UPDATE `creature_template_locale` SET `Name` = '얼음눈 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 690;
-- AC datas : OLD Name : "워즈 리튼", Name AC enUS : "Secondary Skill Trainer" ; Wowhead enUS : "Secondary Skill Trainer",  OLD Subname : "", Subname AC enUS : "Trainer" ; Wowhead enUS : "Trainer"
UPDATE `creature_template_locale` SET `Name` = '보조 기술 트레이너', `Title` = '자물쇠 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 693;
-- AC datas : OLD Name : "붉은머리 도끼투척병", Name AC enUS : "Bloodscalp Axe Thrower" ; Wowhead enUS : "Bloodscalp Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 694;
-- AC datas : OLD Name : "백골가루 도끼투척병", Name AC enUS : "Skullsplitter Axe Thrower" ; Wowhead enUS : "Skullsplitter Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 696;
-- AC datas : OLD Name : "붉은머리 주술사", Name AC enUS : "Bloodscalp Shaman" ; Wowhead enUS : "Bloodscalp Shaman"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 697;
-- AC datas : OLD Name : "붉은머리의 호랑이", Name AC enUS : "Bloodscalp Tiger" ; Wowhead enUS : "Bloodscalp Tiger"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족의 호랑이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 698;
-- AC datas : OLD Name : "붉은머리 야수조련사", Name AC enUS : "Bloodscalp Beastmaster" ; Wowhead enUS : "Bloodscalp Beastmaster"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 야수조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 699;
-- AC datas : OLD Name : "붉은머리의 퓨마", Name AC enUS : "Bloodscalp Panther" ; Wowhead enUS : "Bloodscalp Panther"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족의 퓨마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 700;
-- AC datas : OLD Name : "붉은머리 비술사", Name AC enUS : "Bloodscalp Mystic" ; Wowhead enUS : "Bloodscalp Mystic"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 701;
-- AC datas : OLD Name : "붉은머리 청소부", Name AC enUS : "Bloodscalp Scavenger" ; Wowhead enUS : "Bloodscalp Scavenger"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 702;
-- AC datas : OLD Name : "장군 살벌송곳니", Name AC enUS : "Lieutenant Fangore" ; Wowhead enUS : "Lieutenant Fangore"
UPDATE `creature_template_locale` SET `Name` = '부대장 붉은송곳니', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 703;
-- AC datas : OLD Name : "어린 서리갈기 트롤", Name AC enUS : "Frostmane Troll Whelp" ; Wowhead enUS : "Frostmane Troll Whelp"
UPDATE `creature_template_locale` SET `Name` = '어린 서리갈기트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 706;
-- AC datas : OLD Name : "모쉬오그 전사", Name AC enUS : "Mosh'Ogg Warmonger" ; Wowhead enUS : "Mosh'Ogg Warmonger"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 709;
-- AC datas : OLD Name : "모쉬오그 마법사", Name AC enUS : "Mosh'Ogg Spellcrafter" ; Wowhead enUS : "Mosh'Ogg Spellcrafter"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 710;
-- AC datas : OLD Name : "붉은마루 약탈자", Name AC enUS : "Redridge Thrasher" ; Wowhead enUS : "Redridge Thrasher"
UPDATE `creature_template_locale` SET `Name` = '붉은마루일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 712;
-- AC datas : OLD Name : "모쉬오그 도살꾼", Name AC enUS : "Mosh'Ogg Butcher" ; Wowhead enUS : "Mosh'Ogg Butcher"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 도살꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 723;
-- AC datas : OLD Name : "늪지 멀록", Name AC enUS : "Marsh Murloc" ; Wowhead enUS : "Marsh Murloc"
UPDATE `creature_template_locale` SET `Name` = '늪지멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 747;
-- AC datas : OLD Name : "늪지 땅꾼", Name AC enUS : "Marsh Murkdweller" ; Wowhead enUS : "Marsh Murkdweller"
UPDATE `creature_template_locale` SET `Name` = '늪지멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 749;
-- AC datas : OLD Name : "늪지 먹물쟁이", Name AC enUS : "Marsh Inkspewer" ; Wowhead enUS : "Marsh Inkspewer"
UPDATE `creature_template_locale` SET `Name` = '늪지멀록 먹물쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 750;
-- AC datas : OLD Name : "늪지 청소부", Name AC enUS : "Marsh Flesheater" ; Wowhead enUS : "Marsh Flesheater"
UPDATE `creature_template_locale` SET `Name` = '늪지멀록 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 751;
-- AC datas : OLD Name : "늪지 점쟁이", Name AC enUS : "Marsh Oracle" ; Wowhead enUS : "Marsh Oracle"
UPDATE `creature_template_locale` SET `Name` = '늪지멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 752;
-- AC datas : OLD Name : "잃어버린 드레나이 청소부", Name AC enUS : "Lost One Mudlurker" ; Wowhead enUS : "Lost One Mudlurker"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 755;
-- AC datas : OLD Name : "백골가루 퓨마", Name AC enUS : "Skullsplitter Panther" ; Wowhead enUS : "Skullsplitter Panther"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 퓨마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 756;
-- AC datas : OLD Name : "잃어버린 드레나이 낚시꾼", Name AC enUS : "Lost One Fisherman" ; Wowhead enUS : "Lost One Fisherman"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 낚시꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 757;
-- AC datas : OLD Name : "백골가루 호랑이", Name AC enUS : "Skullsplitter Tiger" ; Wowhead enUS : "Skullsplitter Tiger"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 호랑이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 758;
-- AC datas : OLD Name : "잃어버린 드레나이 사냥꾼", Name AC enUS : "Lost One Hunter" ; Wowhead enUS : "Lost One Hunter"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 759;
-- AC datas : OLD Name : "잃어버린 드레나이 땅꾼", Name AC enUS : "Lost One Muckdweller" ; Wowhead enUS : "Lost One Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 760;
-- AC datas : OLD Name : "잃어버린 드레나이 점쟁이", Name AC enUS : "Lost One Seer" ; Wowhead enUS : "Lost One Seer"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 761;
-- AC datas : OLD Name : "잃어버린 드레나이 길잡이", Name AC enUS : "Lost One Riftseeker" ; Wowhead enUS : "Lost One Riftseeker"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 762;
-- AC datas : OLD Name : "잃어버린 드레나이 족장", Name AC enUS : "Lost One Chieftain" ; Wowhead enUS : "Lost One Chieftain"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 763;
-- AC datas : OLD Name : "백골가루 비술사", Name AC enUS : "Skullsplitter Mystic" ; Wowhead enUS : "Skullsplitter Mystic"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 780;
-- AC datas : OLD Name : "백골가루 인간사냥꾼", Name AC enUS : "Skullsplitter Headhunter" ; Wowhead enUS : "Skullsplitter Headhunter"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 781;
-- AC datas : OLD Name : "백골가루 정찰병", Name AC enUS : "Skullsplitter Scout" ; Wowhead enUS : "Skullsplitter Scout"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 782;
-- AC datas : OLD Name : "백골가루 광전사", Name AC enUS : "Skullsplitter Berserker" ; Wowhead enUS : "Skullsplitter Berserker"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 783;
-- AC datas : OLD Name : "백골가루 야수조련사", Name AC enUS : "Skullsplitter Beastmaster" ; Wowhead enUS : "Skullsplitter Beastmaster"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 야수조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 784;
-- AC datas : OLD Subname : "활 상인", Subname AC enUS : "Fletcher" ; Wowhead enUS : "Fletcher"
UPDATE `creature_template_locale` SET `Title` = '화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 789;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 820;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 821;
-- AC datas : OLD Name : "새끼 숲곰", Name AC enUS : "Young Forest Bear" ; Wowhead enUS : "Young Forest Bear"
UPDATE `creature_template_locale` SET `Name` = '새끼곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 822;
-- AC datas : OLD Name : "하사관 윌렘", Name AC enUS : "Deputy Willem" ; Wowhead enUS : "Deputy Willem"
UPDATE `creature_template_locale` SET `Name` = '부관 윌렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 823;
-- AC datas : OLD Name : "속박 풀린 소용돌이", Name AC enUS : "Dust Devil" ; Wowhead enUS : "Dust Devil"
UPDATE `creature_template_locale` SET `Name` = '먼지 악령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 832;
-- AC datas : OLD Name : "눈마루 산악경비대", Name AC enUS : "Coldridge Mountaineer" ; Wowhead enUS : "Coldridge Mountaineer"
UPDATE `creature_template_locale` SET `Name` = '눈마루골짜기 산악경비대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 853;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 869;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 870;
-- AC datas : OLD Name : "소금비늘 전사", Name AC enUS : "Saltscale Warrior" ; Wowhead enUS : "Saltscale Warrior"
UPDATE `creature_template_locale` SET `Name` = '소금비늘멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 871;
-- AC datas : OLD Name : "소금비늘 점쟁이", Name AC enUS : "Saltscale Oracle" ; Wowhead enUS : "Saltscale Oracle"
UPDATE `creature_template_locale` SET `Name` = '소금비늘멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 873;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 874;
-- AC datas : OLD Name : "소금비늘 우두머리", Name AC enUS : "Saltscale Tide Lord" ; Wowhead enUS : "Saltscale Tide Lord"
UPDATE `creature_template_locale` SET `Name` = '소금비늘멀록 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 875;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 876;
-- AC datas : OLD Name : "소금비늘 채집꾼", Name AC enUS : "Saltscale Forager" ; Wowhead enUS : "Saltscale Forager"
UPDATE `creature_template_locale` SET `Name` = '소금비늘멀록 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 877;
-- AC datas : OLD Subname : "서부 몰락지대 여단", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 878;
-- AC datas : OLD Name : "소금비늘 사냥꾼", Name AC enUS : "Saltscale Hunter" ; Wowhead enUS : "Saltscale Hunter"
UPDATE `creature_template_locale` SET `Name` = '소금비늘멀록 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 879;
-- AC datas : OLD Name : "망치주먹 불마술사", Name AC enUS : "Splinter Fist Fire Weaver" ; Wowhead enUS : "Splinter Fist Fire Weaver"
UPDATE `creature_template_locale` SET `Name` = '망치주먹일족 불마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 891;
-- AC datas : OLD Name : "망치주먹 싸움꾼", Name AC enUS : "Splinter Fist Taskmaster" ; Wowhead enUS : "Splinter Fist Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '망치주먹일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 892;
-- AC datas : OLD Name : "파멸어둠 늑대인간", Name AC enUS : "Nightbane Worgen" ; Wowhead enUS : "Nightbane Worgen"
UPDATE `creature_template_locale` SET `Name` = '파멸의어둠일족 늑대인간', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 898;
-- AC datas : OLD Name : "톱니광포어", Name AC enUS : "Sharptooth Frenzy" ; Wowhead enUS : "Sharptooth Frenzy"
UPDATE `creature_template_locale` SET `Name` = '톱니프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 905;
-- AC datas : OLD Name : "파멸어둠 타락전사", Name AC enUS : "Nightbane Tainted One" ; Wowhead enUS : "Nightbane Tainted One"
UPDATE `creature_template_locale` SET `Name` = '파멸의어둠일족 타락전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 920;
-- AC datas : OLD Name : "공포의 군주 말가니스", Name AC enUS : "Dreadlord Malganis" ; Wowhead enUS : "Dreadlord Malganis"
UPDATE `creature_template_locale` SET `Name` = '공포의군주 말가니스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 929;
-- AC datas : OLD Name : "서리갈기 수습마법사", Name AC enUS : "Frostmane Novice" ; Wowhead enUS : "Frostmane Novice"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 수습마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 946;
-- AC datas : OLD Name : "수다쟁이 늪지 멀록", Name AC enUS : "Swamp Talker" ; Wowhead enUS : "Swamp Talker"
UPDATE `creature_template_locale` SET `Name` = '수다쟁이 늪지멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 950;
-- AC datas : OLD Subname : "", Subname AC enUS : "Librarian" ; Wowhead enUS : "Librarian"
UPDATE `creature_template_locale` SET `Title` = '사서', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 951;
-- AC datas : OLD Name : "길 잃은 나흐렉", Name AC enUS : "Nahr'ek da Howler" ; Wowhead enUS : "Nahr'ek da Howler"
UPDATE `creature_template_locale` SET `Name` = '길잃은 나흐렉', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 994;
-- AC datas : OLD Name : "에릭 도즈 3세", Name AC enUS : "Master Tailor" ; Wowhead enUS : "Master Tailor"
UPDATE `creature_template_locale` SET `Name` = '전문 재봉사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 996;
-- AC datas : OLD Name : "죽어라때려보라지", Name AC enUS : "Unkillable Test Dummy" ; Wowhead enUS : "Unkillable Test Dummy",  OLD Subname : "", Subname AC enUS : "" ; Wowhead enUS : ""
UPDATE `creature_template_locale` SET `Name` = '순찰대원 블롬버그', `Title` = '어둠의 순찰대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1000;
-- AC datas : OLD Name : "이끼가죽 싸움꾼", Name AC enUS : "Mosshide Mongrel" ; Wowhead enUS : "Mosshide Mongrel"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1008;
-- AC datas : OLD Name : "이끼가죽 안개마술사", Name AC enUS : "Mosshide Mistweaver" ; Wowhead enUS : "Mosshide Mistweaver"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 안개마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1009;
-- AC datas : OLD Name : "이끼가죽 길잡이", Name AC enUS : "Mosshide Fenrunner" ; Wowhead enUS : "Mosshide Fenrunner"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1010;
-- AC datas : OLD Name : "이끼가죽 덫사냥꾼", Name AC enUS : "Mosshide Trapper" ; Wowhead enUS : "Mosshide Trapper"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 덫사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1011;
-- AC datas : OLD Name : "이끼가죽 투사", Name AC enUS : "Mosshide Brute" ; Wowhead enUS : "Mosshide Brute"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1012;
-- AC datas : OLD Name : "이끼가죽 비술사", Name AC enUS : "Mosshide Mystic" ; Wowhead enUS : "Mosshide Mystic"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1013;
-- AC datas : OLD Name : "이끼가죽 우두머리", Name AC enUS : "Mosshide Alpha" ; Wowhead enUS : "Mosshide Alpha"
UPDATE `creature_template_locale` SET `Name` = '이끼가죽일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1014;
-- AC datas : OLD Name : "푸른아가미 멀록", Name AC enUS : "Bluegill Murloc" ; Wowhead enUS : "Bluegill Murloc"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1024;
-- AC datas : OLD Name : "푸른아가미 보초", Name AC enUS : "Bluegill Puddlejumper" ; Wowhead enUS : "Bluegill Puddlejumper"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1025;
-- AC datas : OLD Name : "푸른아가미 채집꾼", Name AC enUS : "Bluegill Forager" ; Wowhead enUS : "Bluegill Forager"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1026;
-- AC datas : OLD Name : "푸른아가미 전사", Name AC enUS : "Bluegill Warrior" ; Wowhead enUS : "Bluegill Warrior"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1027;
-- AC datas : OLD Name : "푸른아가미 땅꾼", Name AC enUS : "Bluegill Muckdweller" ; Wowhead enUS : "Bluegill Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1028;
-- AC datas : OLD Name : "푸른아가미 점쟁이", Name AC enUS : "Bluegill Oracle" ; Wowhead enUS : "Bluegill Oracle"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1029;
-- AC datas : OLD Name : "용아귀 약탈자", Name AC enUS : "Dragonmaw Raider" ; Wowhead enUS : "Dragonmaw Raider"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1034;
-- AC datas : OLD Name : "용아귀 늪길잡이", Name AC enUS : "Dragonmaw Swamprunner" ; Wowhead enUS : "Dragonmaw Swamprunner"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 늪길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1035;
-- AC datas : OLD Name : "용아귀 백인대장", Name AC enUS : "Dragonmaw Centurion" ; Wowhead enUS : "Dragonmaw Centurion"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 백인대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1036;
-- AC datas : OLD Name : "용아귀 지휘관", Name AC enUS : "Dragonmaw Battlemaster" ; Wowhead enUS : "Dragonmaw Battlemaster"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 지휘관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1037;
-- AC datas : OLD Name : "용아귀 어둠보초병", Name AC enUS : "Dragonmaw Shadowwarder" ; Wowhead enUS : "Dragonmaw Shadowwarder"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 어둠보초병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1038;
-- AC datas : OLD Name : "길 잃은 새끼용", Name AC enUS : "Lost Whelp" ; Wowhead enUS : "Lost Whelp"
UPDATE `creature_template_locale` SET `Name` = '길잃은 새끼용', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1043;
-- AC datas : OLD Name : "검은무쇠 드워프", Name AC enUS : "Dark Iron Dwarf" ; Wowhead enUS : "Dark Iron Dwarf"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 드워프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1051;
-- AC datas : OLD Name : "검은무쇠 투사", Name AC enUS : "Dark Iron Saboteur" ; Wowhead enUS : "Dark Iron Saboteur"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1052;
-- AC datas : OLD Name : "검은무쇠 채굴꾼", Name AC enUS : "Dark Iron Tunneler" ; Wowhead enUS : "Dark Iron Tunneler"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1053;
-- AC datas : OLD Name : "검은무쇠 폭파병", Name AC enUS : "Dark Iron Demolitionist" ; Wowhead enUS : "Dark Iron Demolitionist"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 폭파병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1054;
-- AC datas : OLD Name : "용아귀 해골감시자", Name AC enUS : "Dragonmaw Bonewarder" ; Wowhead enUS : "Dragonmaw Bonewarder"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 해골감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1057;
-- AC datas : OLD Subname : "백골가루 부족 의술사", Subname AC enUS : "Skullsplitter Clan Witchdoctor" ; Wowhead enUS : "Skullsplitter Clan Witchdoctor"
UPDATE `creature_template_locale` SET `Title` = '백골가루부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1060;
-- AC datas : OLD Subname : "붉은머리 부족장", Subname AC enUS : "Bloodscalp Chief" ; Wowhead enUS : "Bloodscalp Chief"
UPDATE `creature_template_locale` SET `Title` = '붉은머리부족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1061;
-- AC datas : OLD Subname : "붉은머리 부족 의술사", Subname AC enUS : "Bloodscalp Clan Witchdoctor" ; Wowhead enUS : "Bloodscalp Clan Witchdoctor"
UPDATE `creature_template_locale` SET `Title` = '붉은머리부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1062;
-- AC datas : OLD Name : "갈퀴발 주술사", Name AC enUS : "Riverpaw Shaman" ; Wowhead enUS : "Riverpaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1065;
-- AC datas : OLD Name : "갈퀴발 청소부", Name AC enUS : "Riverpaw Scavenger" ; Wowhead enUS : "Riverpaw Scavenger"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1067;
-- AC datas : OLD Name : "로고 할배로우", Name AC enUS : "Roggo Harlbarrow" ; Wowhead enUS : "Roggo Harlbarrow"
UPDATE `creature_template_locale` SET `Name` = '로고 할바로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1072;
-- AC datas : OLD Name : "산악경비대 그래블고", Name AC enUS : "Mountaineer Gravelgaw" ; Wowhead enUS : "Mountaineer Gravelgaw"
UPDATE `creature_template_locale` SET `Name` = '산악경비대 그레이블고', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1091;
-- AC datas : OLD Name : "잃어버린 드레나이 요리사", Name AC enUS : "Lost One Cook" ; Wowhead enUS : "Lost One Cook"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1106;
-- AC datas : OLD Name : "바위턱 망치잡이", Name AC enUS : "Rockjaw Skullthumper" ; Wowhead enUS : "Rockjaw Skullthumper"
UPDATE `creature_template_locale` SET `Name` = '바위턱일족 망치잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1115;
-- AC datas : OLD Name : "바위턱 잠복꾼", Name AC enUS : "Rockjaw Ambusher" ; Wowhead enUS : "Rockjaw Ambusher"
UPDATE `creature_template_locale` SET `Name` = '바위턱일족 잠복꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1116;
-- AC datas : OLD Name : "바위턱 뼈다귀싸움꾼", Name AC enUS : "Rockjaw Bonesnapper" ; Wowhead enUS : "Rockjaw Bonesnapper"
UPDATE `creature_template_locale` SET `Name` = '바위턱일족 뼈다귀싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1117;
-- AC datas : OLD Name : "바위턱 투사", Name AC enUS : "Rockjaw Backbreaker" ; Wowhead enUS : "Rockjaw Backbreaker"
UPDATE `creature_template_locale` SET `Name` = '바위턱일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1118;
-- AC datas : OLD Name : "서리갈기 트롤", Name AC enUS : "Frostmane Troll" ; Wowhead enUS : "Frostmane Troll"
UPDATE `creature_template_locale` SET `Name` = '서리갈기트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1120;
-- AC datas : OLD Name : "서리갈기 길잡이", Name AC enUS : "Frostmane Snowstrider" ; Wowhead enUS : "Frostmane Snowstrider"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1121;
-- AC datas : OLD Name : "서리갈기 무두장이", Name AC enUS : "Frostmane Hideskinner" ; Wowhead enUS : "Frostmane Hideskinner"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 무두장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1122;
-- AC datas : OLD Name : "서리갈기 인간사냥꾼", Name AC enUS : "Frostmane Headhunter" ; Wowhead enUS : "Frostmane Headhunter"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1123;
-- AC datas : OLD Name : "서리갈기 흑마술사", Name AC enUS : "Frostmane Shadowcaster" ; Wowhead enUS : "Frostmane Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1124;
-- AC datas : OLD Name : "눈추적늑대", Name AC enUS : "Snow Tracker Wolf" ; Wowhead enUS : "Snow Tracker Wolf"
UPDATE `creature_template_locale` SET `Name` = '새끼 겨울늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1138;
-- AC datas : OLD Name : "모쉬오그 투사", Name AC enUS : "Mosh'Ogg Brute" ; Wowhead enUS : "Mosh'Ogg Brute"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1142;
-- AC datas : OLD Name : "모쉬오그 의술사", Name AC enUS : "Mosh'Ogg Witch Doctor" ; Wowhead enUS : "Mosh'Ogg Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '모쉬오그일족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1144;
-- AC datas : OLD Name : "무쇠턱악어", Name AC enUS : "Snapjaw Crocolisk" ; Wowhead enUS : "Snapjaw Crocolisk"
UPDATE `creature_template_locale` SET `Name` = '무쇠턱 악어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1152;
-- AC datas : OLD Name : "가루바위 정찰병", Name AC enUS : "Stonesplinter Scout" ; Wowhead enUS : "Stonesplinter Scout"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1162;
-- AC datas : OLD Name : "가루바위 망치잡이", Name AC enUS : "Stonesplinter Skullthumper" ; Wowhead enUS : "Stonesplinter Skullthumper"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 망치잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1163;
-- AC datas : OLD Name : "가루바위 뼈다귀싸움꾼", Name AC enUS : "Stonesplinter Bonesnapper" ; Wowhead enUS : "Stonesplinter Bonesnapper"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 뼈다귀싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1164;
-- AC datas : OLD Name : "가루바위 흙점쟁이", Name AC enUS : "Stonesplinter Geomancer" ; Wowhead enUS : "Stonesplinter Geomancer"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1165;
-- AC datas : OLD Name : "가루바위 점쟁이", Name AC enUS : "Stonesplinter Seer" ; Wowhead enUS : "Stonesplinter Seer"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1166;
-- AC datas : OLD Name : "가루바위 채굴꾼", Name AC enUS : "Stonesplinter Digger" ; Wowhead enUS : "Stonesplinter Digger"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1167;
-- AC datas : OLD Name : "검은무쇠 폭도", Name AC enUS : "Dark Iron Insurgent" ; Wowhead enUS : "Dark Iron Insurgent"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 폭도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1169;
-- AC datas : OLD Name : "검은무쇠 게릴라", Name AC enUS : "Dark Iron Guerrilla" ; Wowhead enUS : "Dark Iron Guerrilla"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 게릴라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1171;
-- AC datas : OLD Name : "동굴쥐 졸개", Name AC enUS : "Tunnel Rat Vermin" ; Wowhead enUS : "Tunnel Rat Vermin"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 졸개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1172;
-- AC datas : OLD Name : "동굴쥐 정찰병", Name AC enUS : "Tunnel Rat Scout" ; Wowhead enUS : "Tunnel Rat Scout"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1173;
-- AC datas : OLD Name : "동굴쥐 흙점쟁이", Name AC enUS : "Tunnel Rat Geomancer" ; Wowhead enUS : "Tunnel Rat Geomancer"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1174;
-- AC datas : OLD Name : "동굴쥐 채굴꾼", Name AC enUS : "Tunnel Rat Digger" ; Wowhead enUS : "Tunnel Rat Digger"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1175;
-- AC datas : OLD Name : "동굴쥐 약탈꾼", Name AC enUS : "Tunnel Rat Forager" ; Wowhead enUS : "Tunnel Rat Forager"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1176;
-- AC datas : OLD Name : "동굴쥐 땜장이", Name AC enUS : "Tunnel Rat Surveyor" ; Wowhead enUS : "Tunnel Rat Surveyor"
UPDATE `creature_template_locale` SET `Name` = '동굴쥐일족 땜장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1177;
-- AC datas : OLD Name : "모그로쉬 집행자", Name AC enUS : "Mo'grosh Enforcer" ; Wowhead enUS : "Mo'grosh Enforcer"
UPDATE `creature_template_locale` SET `Name` = '모그로쉬일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1179;
-- AC datas : OLD Name : "모그로쉬 투사", Name AC enUS : "Mo'grosh Brute" ; Wowhead enUS : "Mo'grosh Brute"
UPDATE `creature_template_locale` SET `Name` = '모그로쉬일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1180;
-- AC datas : OLD Name : "모그로쉬 주술사", Name AC enUS : "Mo'grosh Shaman" ; Wowhead enUS : "Mo'grosh Shaman"
UPDATE `creature_template_locale` SET `Name` = '모그로쉬일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1181;
-- AC datas : OLD Name : "모그로쉬 비술사", Name AC enUS : "Mo'grosh Mystic" ; Wowhead enUS : "Mo'grosh Mystic"
UPDATE `creature_template_locale` SET `Name` = '모그로쉬일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1183;
-- AC datas : OLD Name : "검은곰", Name AC enUS : "Elder Black Bear" ; Wowhead enUS : "Elder Black Bear"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 검은곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1186;
-- AC datas : OLD Name : "호수광포어", Name AC enUS : "Loch Frenzy" ; Wowhead enUS : "Loch Frenzy"
UPDATE `creature_template_locale` SET `Name` = '호수프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1193;
-- AC datas : OLD Name : "가루바위 주술사", Name AC enUS : "Stonesplinter Shaman" ; Wowhead enUS : "Stonesplinter Shaman"
UPDATE `creature_template_locale` SET `Name` = '가루바위일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1197;
-- AC datas : OLD Name : "그로머그", Name AC enUS : "Grawmug" ; Wowhead enUS : "Grawmug"
UPDATE `creature_template_locale` SET `Name` = '그로우머그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1205;
-- AC datas : OLD Name : "글로린 스틸브라우", Name AC enUS : "Glorin Steelbrow" ; Wowhead enUS : "Glorin Steelbrow"
UPDATE `creature_template_locale` SET `Name` = '글로린 스틸브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1217;
-- AC datas : OLD Name : "검은무쇠 공병", Name AC enUS : "Dark Iron Sapper" ; Wowhead enUS : "Dark Iron Sapper"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 공병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1222;
-- AC datas : OLD Name : "큰곰 숯검댕이", Name AC enUS : "Ol' Sooty" ; Wowhead enUS : "Ol' Sooty"
UPDATE `creature_template_locale` SET `Name` = '늙은곰 수티', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1225;
-- AC datas : OLD Name : "신록수호자 레시엘", Name AC enUS : "Rethiel the Greenwarden" ; Wowhead enUS : "Rethiel the Greenwarden"
UPDATE `creature_template_locale` SET `Name` = '신록의수호자 레시엘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1244;
-- AC datas : OLD Subname : "일용품 및 직업용품 상인", Subname AC enUS : "General & Trade Supplies" ; Wowhead enUS : "General & Trade Supplies"
UPDATE `creature_template_locale` SET `Title` = '일용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1250;
-- AC datas : OLD Name : "망치주먹 화염마법사", Name AC enUS : "Splinter Fist Firemonger" ; Wowhead enUS : "Splinter Fist Firemonger"
UPDATE `creature_template_locale` SET `Name` = '망치주먹일족 화염마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1251;
-- AC datas : OLD Name : "현장감독 스톤브라우", Name AC enUS : "Foreman Stonebrow" ; Wowhead enUS : "Foreman Stonebrow"
UPDATE `creature_template_locale` SET `Name` = '현장감독 스톤브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1254;
-- AC datas : OLD Name : "흰색 산양 X", Name AC enUS : "White Ram X" ; Wowhead enUS : "White Ram X"
UPDATE `creature_template_locale` SET `Name` = '흰색 산양', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1262;
-- AC datas : OLD Name : "프레더릭 스토버", Name AC enUS : "Frederick Stover" ; Wowhead enUS : "Frederick Stover",  OLD Subname : "활 상인", Subname AC enUS : "Bow & Arrow Merchant" ; Wowhead enUS : "Bow & Arrow Merchant"
UPDATE `creature_template_locale` SET `Name` = '프레데릭 스토버', `Title` = '화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1298;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '약초 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1303;
-- AC datas : OLD Name : "산악경비대 해머폴", Name AC enUS : "Mountaineer Hammerfall" ; Wowhead enUS : "Mountaineer Hammerfall"
UPDATE `creature_template_locale` SET `Name` = '산악경비대 함메르팔', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1334;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1355;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Superior Cook" ; Wowhead enUS : "Superior Cook"
UPDATE `creature_template_locale` SET `Title` = '고급 요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1382;
-- AC datas : OLD Name : "스날", Name AC enUS : "Snarl" ; Wowhead enUS : "Snarl"
UPDATE `creature_template_locale` SET `Name` = '스나알', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1383;
-- AC datas : OLD Name : "서리갈기 예언자", Name AC enUS : "Frostmane Seer" ; Wowhead enUS : "Frostmane Seer"
UPDATE `creature_template_locale` SET `Name` = '서리갈기부족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1397;
-- AC datas : OLD Subname : "가루바위 족장", Subname AC enUS : "Stonesplinter Chieftain" ; Wowhead enUS : "Stonesplinter Chieftain"
UPDATE `creature_template_locale` SET `Title` = '가루바위일족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1398;
-- AC datas : OLD Subname : "가루바위 주술사", Subname AC enUS : "Stonesplinter Tribal Shaman" ; Wowhead enUS : "Stonesplinter Tribal Shaman"
UPDATE `creature_template_locale` SET `Title` = '가루바위일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1399;
-- AC datas : OLD Name : "이언 스트롬", Name AC enUS : "Ian Strom" ; Wowhead enUS : "Ian Strom"
UPDATE `creature_template_locale` SET `Name` = '이안 스트롬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1411;
-- AC datas : OLD Name : "푸른아가미 약탈꾼", Name AC enUS : "Bluegill Raider" ; Wowhead enUS : "Bluegill Raider"
UPDATE `creature_template_locale` SET `Name` = '푸른아가미멀록 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1418;
-- AC datas : OLD Name : "커브", Name AC enUS : "Grizlak" ; Wowhead enUS : "Grizlak"
UPDATE `creature_template_locale` SET `Name` = '그리즐락', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1425;
-- AC datas : OLD Name : "갈퀴발 광부", Name AC enUS : "Riverpaw Miner" ; Wowhead enUS : "Riverpaw Miner"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발일족 광부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1426;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1430;
-- AC datas : OLD Name : "데윈 쉬머돈", Name AC enUS : "Dewin Shimmerdawn" ; Wowhead enUS : "Dewin Shimmerdawn"
UPDATE `creature_template_locale` SET `Name` = '데윈 쉼머돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1453;
-- AC datas : OLD Subname : "활 상인", Subname AC enUS : "Fletcher" ; Wowhead enUS : "Fletcher"
UPDATE `creature_template_locale` SET `Title` = '화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1462;
-- AC datas : OLD Name : "망치주먹 노예사냥꾼", Name AC enUS : "Splinter Fist Enslaver" ; Wowhead enUS : "Splinter Fist Enslaver"
UPDATE `creature_template_locale` SET `Name` = '망치주먹일족 노예사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1487;
-- AC datas : OLD Name : "큰망치 모크라쉬", Name AC enUS : "Mok'rash" ; Wowhead enUS : "Mok'rash"
UPDATE `creature_template_locale` SET `Name` = '모크라쉬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1493;
-- AC datas : OLD Name : "죽음경비병 리니아", Name AC enUS : "Deathguard Linnea" ; Wowhead enUS : "Deathguard Linnea"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 리니아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1495;
-- AC datas : OLD Name : "죽음경비병 딜링거", Name AC enUS : "Deathguard Dillinger" ; Wowhead enUS : "Deathguard Dillinger"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 딜링거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1496;
-- AC datas : OLD Name : "흉측한 구울", Name AC enUS : "Wretched Ghoul" ; Wowhead enUS : "Wretched Ghoul"
UPDATE `creature_template_locale` SET `Name` = '흉측한 좀비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1502;
-- AC datas : OLD Name : "죽음경비병 시머", Name AC enUS : "Deathguard Simmer" ; Wowhead enUS : "Deathguard Simmer"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 시머', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1519;
-- AC datas : OLD Name : "휘청거리는 괴물", Name AC enUS : "Shambling Horror" ; Wowhead enUS : "Shambling Horror"
UPDATE `creature_template_locale` SET `Name` = '휘청거리는 좀비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1528;
-- AC datas : OLD Name : "길 잃은 영혼", Name AC enUS : "Lost Soul" ; Wowhead enUS : "Lost Soul"
UPDATE `creature_template_locale` SET `Name` = '길잃은 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1531;
-- AC datas : OLD Name : "썩은지느러미 멀록", Name AC enUS : "Vile Fin Murloc" ; Wowhead enUS : "Vile Fin Murloc"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1541;
-- AC datas : OLD Name : "썩은지느러미 보초", Name AC enUS : "Vile Fin Puddlejumper" ; Wowhead enUS : "Vile Fin Puddlejumper"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1543;
-- AC datas : OLD Name : "썩은지느러미 수련사", Name AC enUS : "Vile Fin Minor Oracle" ; Wowhead enUS : "Vile Fin Minor Oracle"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 수련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1544;
-- AC datas : OLD Name : "썩은지느러미 땅꾼", Name AC enUS : "Vile Fin Muckdweller" ; Wowhead enUS : "Vile Fin Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1545;
-- AC datas : OLD Name : "무쇠꼬리바실리스크", Name AC enUS : "Thrashtail Basilisk" ; Wowhead enUS : "Thrashtail Basilisk"
UPDATE `creature_template_locale` SET `Name` = '무쇠꼬리 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1550;
-- AC datas : OLD Name : "무쇠턱바실리스크", Name AC enUS : "Ironjaw Basilisk" ; Wowhead enUS : "Ironjaw Basilisk"
UPDATE `creature_template_locale` SET `Name` = '무쇠턱 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1551;
-- AC datas : OLD Name : "밀림의 왕 무클라", Name AC enUS : "King Mukla" ; Wowhead enUS : "King Mukla"
UPDATE `creature_template_locale` SET `Name` = '밀림의왕 무클라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1559;
-- AC datas : OLD Name : "어둠의 사제 사비스", Name AC enUS : "Shadow Priest Sarvis" ; Wowhead enUS : "Shadow Priest Sarvis"
UPDATE `creature_template_locale` SET `Name` = '어둠의사제 사비스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1569;
-- AC datas : OLD Name : "슬림의 시험용 도적", Name AC enUS : "Slim's Test Rogue" ; Wowhead enUS : "Slim's Test Rogue"
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1601;
-- AC datas : OLD Name : "북녘골 경비병", Name AC enUS : "Northshire Guard" ; Wowhead enUS : "Northshire Guard"
UPDATE `creature_template_locale` SET `Name` = '노스샤이어 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1642;
-- AC datas : OLD Name : "죽음경비병 버제스", Name AC enUS : "Deathguard Burgess" ; Wowhead enUS : "Deathguard Burgess"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 버제스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1652;
-- AC datas : OLD Name : "썩은가죽 싸움꾼", Name AC enUS : "Rot Hide Mongrel" ; Wowhead enUS : "Rot Hide Mongrel"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1675;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '전문 요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1677;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1699;
-- AC datas : OLD Name : "복역수", Name AC enUS : "Defias Prisoner" ; Wowhead enUS : "Defias Prisoner"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 복역수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1706;
-- AC datas : OLD Name : "무기징역수", Name AC enUS : "Defias Convict" ; Wowhead enUS : "Defias Convict"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 무기징역수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1711;
-- AC datas : OLD Name : "덩치 큰 그림자퓨마", Name AC enUS : "Elder Shadowmaw Panther" ; Wowhead enUS : "Elder Shadowmaw Panther"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 그림자퓨마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1713;
-- AC datas : OLD Name : "반역자", Name AC enUS : "Defias Insurgent" ; Wowhead enUS : "Defias Insurgent"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 반역자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1715;
-- AC datas : OLD Name : "바위턱 약탈자", Name AC enUS : "Rockjaw Raider" ; Wowhead enUS : "Rockjaw Raider"
UPDATE `creature_template_locale` SET `Name` = '바위턱일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1718;
-- AC datas : OLD Name : "데피아즈단 돌풍술사", Name AC enUS : "Defias Squallshaper" ; Wowhead enUS : "Defias Squallshaper"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 얼음마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1732;
-- AC datas : OLD Name : "죽음경비병 아브라함", Name AC enUS : "Deathguard Abraham" ; Wowhead enUS : "Deathguard Abraham"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 아브라함', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1735;
-- AC datas : OLD Name : "죽음경비병 란돌프", Name AC enUS : "Deathguard Randolph" ; Wowhead enUS : "Deathguard Randolph"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 란돌프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1736;
-- AC datas : OLD Name : "죽음경비병 올리버", Name AC enUS : "Deathguard Oliver" ; Wowhead enUS : "Deathguard Oliver"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 올리버', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1737;
-- AC datas : OLD Name : "죽음경비병 테렌스", Name AC enUS : "Deathguard Terrence" ; Wowhead enUS : "Deathguard Terrence"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 테렌스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1738;
-- AC datas : OLD Name : "죽음경비병 필립", Name AC enUS : "Deathguard Phillip" ; Wowhead enUS : "Deathguard Phillip"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 필립', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1739;
-- AC datas : OLD Name : "죽음경비병 살테인", Name AC enUS : "Deathguard Saltain" ; Wowhead enUS : "Deathguard Saltain"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 살테인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1740;
-- AC datas : OLD Name : "죽음경비병 바트런드", Name AC enUS : "Deathguard Bartrand" ; Wowhead enUS : "Deathguard Bartrand"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 바트런드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1741;
-- AC datas : OLD Name : "죽음경비병 바톨로뮤", Name AC enUS : "Deathguard Bartholomew" ; Wowhead enUS : "Deathguard Bartholomew"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 바르솔로뮤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1742;
-- AC datas : OLD Name : "죽음경비병 로렌스", Name AC enUS : "Deathguard Lawrence" ; Wowhead enUS : "Deathguard Lawrence"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 로렌스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1743;
-- AC datas : OLD Name : "죽음경비병 모트", Name AC enUS : "Deathguard Mort" ; Wowhead enUS : "Deathguard Mort"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 모트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1744;
-- AC datas : OLD Name : "죽음경비병 모리스", Name AC enUS : "Deathguard Morris" ; Wowhead enUS : "Deathguard Morris"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 모리스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1745;
-- AC datas : OLD Name : "죽음경비병 키루스", Name AC enUS : "Deathguard Cyrus" ; Wowhead enUS : "Deathguard Cyrus"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 키루스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1746;
-- AC datas : OLD Name : "대제독 제스테레스", Name AC enUS : "Grand Admiral Jes-Tereth" ; Wowhead enUS : "Grand Admiral Jes-Tereth"
UPDATE `creature_template_locale` SET `Name` = '총사령관 제스테레스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1750;
-- AC datas : OLD Name : "광포한 검은늑대", Name AC enUS : "Mottled Worg" ; Wowhead enUS : "Mottled Worg"
UPDATE `creature_template_locale` SET `Name` = '점박이 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1766;
-- AC datas : OLD Name : "썩은지느러미 갈퀴잡이", Name AC enUS : "Vile Fin Shredder" ; Wowhead enUS : "Vile Fin Shredder"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 갈퀴잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1767;
-- AC datas : OLD Name : "썩은지느러미 바다사냥꾼", Name AC enUS : "Vile Fin Tidehunter" ; Wowhead enUS : "Vile Fin Tidehunter"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 바다사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1768;
-- AC datas : OLD Name : "달분노 백발전사", Name AC enUS : "Moonrage Whitescalp" ; Wowhead enUS : "Moonrage Whitescalp"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 백발전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1769;
-- AC datas : OLD Name : "달분노 어둠의길잡이", Name AC enUS : "Moonrage Darkrunner" ; Wowhead enUS : "Moonrage Darkrunner"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 어둠의길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1770;
-- AC datas : OLD Name : "썩은가죽 길잡이", Name AC enUS : "Rot Hide Gladerunner" ; Wowhead enUS : "Rot Hide Gladerunner"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1772;
-- AC datas : OLD Name : "썩은가죽 비술사", Name AC enUS : "Rot Hide Mystic" ; Wowhead enUS : "Rot Hide Mystic"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1773;
-- AC datas : OLD Name : "달분노 광신도", Name AC enUS : "Moonrage Glutton" ; Wowhead enUS : "Moonrage Glutton"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1779;
-- AC datas : OLD Name : "병정 땅거미", Name AC enUS : "Moss Stalker" ; Wowhead enUS : "Moss Stalker"
UPDATE `creature_template_locale` SET `Name` = '이끼땅거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1780;
-- AC datas : OLD Name : "은신 땅거미", Name AC enUS : "Mist Creeper" ; Wowhead enUS : "Mist Creeper"
UPDATE `creature_template_locale` SET `Name` = '안개땅거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1781;
-- AC datas : OLD Name : "달분노 검은영혼", Name AC enUS : "Moonrage Darksoul" ; Wowhead enUS : "Moonrage Darksoul"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 검은영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1782;
-- AC datas : OLD Name : "거대하고 광포한 곰", Name AC enUS : "Giant Grizzled Bear" ; Wowhead enUS : "Giant Grizzled Bear"
UPDATE `creature_template_locale` SET `Name` = '거대한 불곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1797;
-- AC datas : OLD Name : "썩어가는 대머리수리", Name AC enUS : "Rotting Condor" ; Wowhead enUS : "Rotting Condor"
UPDATE `creature_template_locale` SET `Name` = '썩어가는 독수리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1810;
-- AC datas : OLD Name : "덩치 큰 썩은구렁 히드라", Name AC enUS : "Elder Foulmaw Hydra" ; Wowhead enUS : "Elder Foulmaw Hydra"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 썩은구렁 히드라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1820;
-- AC datas : OLD Name : "공허방랑자", Name AC enUS : "Voidwalker" ; Wowhead enUS : "Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1860;
-- AC datas : OLD Name : "상급 공허방랑자", Name AC enUS : "Greater Voidwalker" ; Wowhead enUS : "Greater Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '상급 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1861;
-- AC datas : OLD Name : "노마 블런트노즈", Name AC enUS : "Noma Bluntnose" ; Wowhead enUS : "Noma Bluntnose"
UPDATE `creature_template_locale` SET `Name` = '노마 블런트노우즈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1879;
-- AC datas : OLD Name : "호박색 농장 파수꾼", Name AC enUS : "Dalaran Watcher" ; Wowhead enUS : "Dalaran Watcher"
UPDATE `creature_template_locale` SET `Name` = '달라란 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1888;
-- AC datas : OLD Name : "호박색 농장 마술사", Name AC enUS : "Dalaran Wizard" ; Wowhead enUS : "Dalaran Wizard"
UPDATE `creature_template_locale` SET `Name` = '달라란 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1889;
-- AC datas : OLD Name : "달분노 정찰꾼", Name AC enUS : "Moonrage Watcher" ; Wowhead enUS : "Moonrage Watcher"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1892;
-- AC datas : OLD Name : "달분노 보초", Name AC enUS : "Moonrage Sentry" ; Wowhead enUS : "Moonrage Sentry"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1893;
-- AC datas : OLD Name : "달분노 장로", Name AC enUS : "Moonrage Elder" ; Wowhead enUS : "Moonrage Elder"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 장로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1896;
-- AC datas : OLD Name : "썩은지느러미 점쟁이", Name AC enUS : "Vile Fin Oracle" ; Wowhead enUS : "Vile Fin Oracle"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1908;
-- AC datas : OLD Name : "썩은지느러미 호수추적자", Name AC enUS : "Vile Fin Lakestalker" ; Wowhead enUS : "Vile Fin Lakestalker"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1909;
-- AC datas : OLD Name : "호박색 농장 수호병", Name AC enUS : "Dalaran Protector" ; Wowhead enUS : "Dalaran Protector"
UPDATE `creature_template_locale` SET `Name` = '달라란 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1912;
-- AC datas : OLD Name : "호박색 농장 보초병", Name AC enUS : "Dalaran Warder" ; Wowhead enUS : "Dalaran Warder"
UPDATE `creature_template_locale` SET `Name` = '달라란 보초병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1913;
-- AC datas : OLD Name : "호박색 농장 마법학자", Name AC enUS : "Dalaran Mage" ; Wowhead enUS : "Dalaran Mage"
UPDATE `creature_template_locale` SET `Name` = '달라란 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1914;
-- AC datas : OLD Name : "호박색 농장 요술사", Name AC enUS : "Dalaran Conjuror" ; Wowhead enUS : "Dalaran Conjuror"
UPDATE `creature_template_locale` SET `Name` = '달라란 요술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1915;
-- AC datas : OLD Name : "스티븐 바텍", Name AC enUS : "Stephen Bhartec" ; Wowhead enUS : "Stephen Bhartec"
UPDATE `creature_template_locale` SET `Name` = '스테판 바텍', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1916;
-- AC datas : OLD Name : "호박색 농장 역술사", Name AC enUS : "Dalaran Spellscribe" ; Wowhead enUS : "Dalaran Spellscribe"
UPDATE `creature_template_locale` SET `Name` = '달라란 역술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1920;
-- AC datas : OLD Name : "달분노 혈투사", Name AC enUS : "Moonrage Bloodhowler" ; Wowhead enUS : "Moonrage Bloodhowler"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 혈투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1924;
-- AC datas : OLD Name : "썩은가죽 곤봉잡이", Name AC enUS : "Rot Hide Brute" ; Wowhead enUS : "Rot Hide Brute"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 곤봉잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1939;
-- AC datas : OLD Name : "썩은가죽 역병술사", Name AC enUS : "Rot Hide Plague Weaver" ; Wowhead enUS : "Rot Hide Plague Weaver"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 역병술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1940;
-- AC datas : OLD Name : "썩은가죽 도굴꾼", Name AC enUS : "Rot Hide Graverobber" ; Wowhead enUS : "Rot Hide Graverobber"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 도굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1941;
-- AC datas : OLD Name : "썩은가죽 야만전사", Name AC enUS : "Rot Hide Savage" ; Wowhead enUS : "Rot Hide Savage"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 야만전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1942;
-- AC datas : OLD Name : "썩은가죽 투사", Name AC enUS : "Rot Hide Bruiser" ; Wowhead enUS : "Rot Hide Bruiser"
UPDATE `creature_template_locale` SET `Name` = '썩은가죽일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1944;
-- AC datas : OLD Name : "나무 변신 0.33", Name AC enUS : "Tree Form 0.33" ; Wowhead enUS : "Tree Form 0.33"
UPDATE `creature_template_locale` SET `Name` = '나무 0.33', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1945;
-- AC datas : OLD Subname : "죽음추적자", Subname AC enUS : "Deathstalker" ; Wowhead enUS : "Deathstalker"
UPDATE `creature_template_locale` SET `Title` = '죽음의추종자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1950;
-- AC datas : OLD Name : "퀸 요릭", Name AC enUS : "Quinn Yorick" ; Wowhead enUS : "Quinn Yorick",  OLD Subname : "죽음추적자", Subname AC enUS : "Deathstalker" ; Wowhead enUS : "Deathstalker"
UPDATE `creature_template_locale` SET `Name` = '쿠인 요릭', `Title` = '죽음의추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1951;
-- AC datas : OLD Name : "덩치 큰 호수덤불괴물", Name AC enUS : "Elder Lake Skulker" ; Wowhead enUS : "Elder Lake Skulker"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 호수덤불괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1954;
-- AC datas : OLD Name : "덩치 큰 호수늪지괴물", Name AC enUS : "Elder Lake Creeper" ; Wowhead enUS : "Elder Lake Creeper"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 호수늪지괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1956;
-- AC datas : OLD Name : "썩은지느러미 호수잠복꾼", Name AC enUS : "Vile Fin Shorecreeper" ; Wowhead enUS : "Vile Fin Shorecreeper"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 호수잠복꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1957;
-- AC datas : OLD Name : "썩은지느러미 파도술사", Name AC enUS : "Vile Fin Tidecaller" ; Wowhead enUS : "Vile Fin Tidecaller"
UPDATE `creature_template_locale` SET `Name` = '썩은지느러미멀록 파도술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1958;
-- AC datas : OLD Name : "비드라 하스스토브", Name AC enUS : "Vidra Hearthstove" ; Wowhead enUS : "Vidra Hearthstove"
UPDATE `creature_template_locale` SET `Name` = '비드라 하트스토브', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1963;
-- AC datas : OLD Name : "동쪽계곡 나무꾼", Name AC enUS : "Eastvale Lumberjack" ; Wowhead enUS : "Eastvale Lumberjack"
UPDATE `creature_template_locale` SET `Name` = '동부벌목지 나무꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1975;
-- AC datas : OLD Name : "죽음추적자 엘런드", Name AC enUS : "Deathstalker Erland" ; Wowhead enUS : "Deathstalker Erland"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 엘런드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1978;
-- AC datas : OLD Name : "검은무쇠 복병", Name AC enUS : "Dark Iron Ambusher" ; Wowhead enUS : "Dark Iron Ambusher"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1981;
-- AC datas : OLD Name : "푸른발", Name AC enUS : "Greenpaw" ; Wowhead enUS : "Greenpaw"
UPDATE `creature_template_locale` SET `Name` = '그린포우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 1993;
-- AC datas : OLD Name : "거대한 나무그물거미", Name AC enUS : "Giant Webwood Spider" ; Wowhead enUS : "Giant Webwood Spider"
UPDATE `creature_template_locale` SET `Name` = '거대한 나무그물 거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2001;
-- AC datas : OLD Name : "나무옹이 펄볼그", Name AC enUS : "Gnarlpine Ursa" ; Wowhead enUS : "Gnarlpine Ursa"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2006;
-- AC datas : OLD Name : "나무옹이 정원사", Name AC enUS : "Gnarlpine Gardener" ; Wowhead enUS : "Gnarlpine Gardener"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 정원사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2007;
-- AC datas : OLD Name : "나무옹이 전사", Name AC enUS : "Gnarlpine Warrior" ; Wowhead enUS : "Gnarlpine Warrior"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2008;
-- AC datas : OLD Name : "나무옹이 주술사", Name AC enUS : "Gnarlpine Shaman" ; Wowhead enUS : "Gnarlpine Shaman"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2009;
-- AC datas : OLD Name : "나무옹이 파수꾼", Name AC enUS : "Gnarlpine Defender" ; Wowhead enUS : "Gnarlpine Defender"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2010;
-- AC datas : OLD Name : "나무옹이 점쟁이", Name AC enUS : "Gnarlpine Augur" ; Wowhead enUS : "Gnarlpine Augur"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2011;
-- AC datas : OLD Name : "나무옹이 길잡이", Name AC enUS : "Gnarlpine Pathfinder" ; Wowhead enUS : "Gnarlpine Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2012;
-- AC datas : OLD Name : "나무옹이 복수자", Name AC enUS : "Gnarlpine Avenger" ; Wowhead enUS : "Gnarlpine Avenger"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 복수자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2013;
-- AC datas : OLD Name : "나무옹이 토템술사", Name AC enUS : "Gnarlpine Totemic" ; Wowhead enUS : "Gnarlpine Totemic"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2014;
-- AC datas : OLD Name : "붉은깃털 하피", Name AC enUS : "Bloodfeather Harpy" ; Wowhead enUS : "Bloodfeather Harpy"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2015;
-- AC datas : OLD Name : "붉은깃털 약탈자", Name AC enUS : "Bloodfeather Rogue" ; Wowhead enUS : "Bloodfeather Rogue"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2017;
-- AC datas : OLD Name : "붉은깃털 마법사", Name AC enUS : "Bloodfeather Sorceress" ; Wowhead enUS : "Bloodfeather Sorceress"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털일족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2018;
-- AC datas : OLD Name : "붉은깃털 여전사", Name AC enUS : "Bloodfeather Fury" ; Wowhead enUS : "Bloodfeather Fury"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털일족 여전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2019;
-- AC datas : OLD Name : "붉은깃털 바람 마녀", Name AC enUS : "Bloodfeather Wind Witch" ; Wowhead enUS : "Bloodfeather Wind Witch"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2020;
-- AC datas : OLD Name : "붉은깃털 우두머리", Name AC enUS : "Bloodfeather Matriarch" ; Wowhead enUS : "Bloodfeather Matriarch"
UPDATE `creature_template_locale` SET `Name` = '붉은깃털일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2021;
-- AC datas : OLD Name : "덩치 큰 나무괴물", Name AC enUS : "Elder Timberling" ; Wowhead enUS : "Elder Timberling"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 나무괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2030;
-- AC datas : OLD Name : "새끼 밤호랑이", Name AC enUS : "Young Nightsaber" ; Wowhead enUS : "Young Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '새끼 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2031;
-- AC datas : OLD Name : "병든 밤호랑이", Name AC enUS : "Mangy Nightsaber" ; Wowhead enUS : "Mangy Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '병든 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2032;
-- AC datas : OLD Name : "덩치 큰 밤호랑이", Name AC enUS : "Elder Nightsaber" ; Wowhead enUS : "Elder Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2033;
-- AC datas : OLD Name : "흉포한 밤호랑이", Name AC enUS : "Feral Nightsaber" ; Wowhead enUS : "Feral Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '흉포한 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2034;
-- AC datas : OLD Name : "고대 수호정령", Name AC enUS : "Ancient Protector" ; Wowhead enUS : "Ancient Protector"
UPDATE `creature_template_locale` SET `Name` = '고대 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2041;
-- AC datas : OLD Name : "긴발톱밤호랑이", Name AC enUS : "Nightsaber Stalker" ; Wowhead enUS : "Nightsaber Stalker"
UPDATE `creature_template_locale` SET `Name` = '긴발톱 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2043;
-- AC datas : OLD Name : "죽음추적자 페를레이아", Name AC enUS : "Deathstalker Faerleia" ; Wowhead enUS : "Deathstalker Faerleia"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 페를레이아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2058;
-- AC datas : OLD Name : "멜리타 스태그헬름", Name AC enUS : "Melithar Staghelm" ; Wowhead enUS : "Melithar Staghelm"
UPDATE `creature_template_locale` SET `Name` = '멜리타 스테그헬름', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2077;
-- AC datas : OLD Name : "일사레인", Name AC enUS : "Conservator Ilthalaine" ; Wowhead enUS : "Conservator Ilthalaine"
UPDATE `creature_template_locale` SET `Name` = '관리인 일사레인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2079;
-- AC datas : OLD Subname : "용아귀 부족 장군", Subname AC enUS : "Dragonmaw Warlord" ; Wowhead enUS : "Dragonmaw Warlord"
UPDATE `creature_template_locale` SET `Title` = '용아귀부족 장군', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2090;
-- AC datas : OLD Name : "용아귀 그런트", Name AC enUS : "Dragonmaw Grunt" ; Wowhead enUS : "Dragonmaw Grunt"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2102;
-- AC datas : OLD Name : "용아귀 정찰병", Name AC enUS : "Dragonmaw Scout" ; Wowhead enUS : "Dragonmaw Scout"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2103;
-- AC datas : OLD Name : "대마법사 아태릭", Name AC enUS : "Archmage Ataeric" ; Wowhead enUS : "Archmage Ataeric"
UPDATE `creature_template_locale` SET `Name` = '대마법사 아테릭', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2120;
-- AC datas : OLD Name : "어둠의 사제 알리스터", Name AC enUS : "Shadow Priest Allister" ; Wowhead enUS : "Shadow Priest Allister"
UPDATE `creature_template_locale` SET `Name` = '어둠의사제 알리스터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2121;
-- AC datas : OLD Name : "어둠의 사제 듀스텐", Name AC enUS : "Dark Cleric Duesten" ; Wowhead enUS : "Dark Cleric Duesten"
UPDATE `creature_template_locale` SET `Name` = '어둠의사제 듀스텐', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2123;
-- AC datas : OLD Name : "어둠의 사제 베릴", Name AC enUS : "Dark Cleric Beryl" ; Wowhead enUS : "Dark Cleric Beryl"
UPDATE `creature_template_locale` SET `Name` = '어둠의사제 베릴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2129;
-- AC datas : OLD Name : "검은무쇠 약탈자", Name AC enUS : "Dark Iron Raider" ; Wowhead enUS : "Dark Iron Raider"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2149;
-- AC datas : OLD Name : "나무옹이 복병", Name AC enUS : "Gnarlpine Ambusher" ; Wowhead enUS : "Gnarlpine Ambusher"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2152;
-- AC datas : OLD Name : "자갈부싯돌 정찰병", Name AC enUS : "Gravelflint Scout" ; Wowhead enUS : "Gravelflint Scout"
UPDATE `creature_template_locale` SET `Name` = '자갈부싯돌일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2158;
-- AC datas : OLD Name : "자갈부싯돌 망치잡이", Name AC enUS : "Gravelflint Bonesnapper" ; Wowhead enUS : "Gravelflint Bonesnapper"
UPDATE `creature_template_locale` SET `Name` = '자갈부싯돌일족 망치잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2159;
-- AC datas : OLD Name : "자갈부싯돌 흙점쟁이", Name AC enUS : "Gravelflint Geomancer" ; Wowhead enUS : "Gravelflint Geomancer"
UPDATE `creature_template_locale` SET `Name` = '자갈부싯돌일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2160;
-- AC datas : OLD Name : "검은나무 길잡이", Name AC enUS : "Blackwood Pathfinder" ; Wowhead enUS : "Blackwood Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2167;
-- AC datas : OLD Name : "검은나무 전사", Name AC enUS : "Blackwood Warrior" ; Wowhead enUS : "Blackwood Warrior"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2168;
-- AC datas : OLD Name : "검은나무 토템술사", Name AC enUS : "Blackwood Totemic" ; Wowhead enUS : "Blackwood Totemic"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2169;
-- AC datas : OLD Name : "검은나무 펄볼그", Name AC enUS : "Blackwood Ursa" ; Wowhead enUS : "Blackwood Ursa"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2170;
-- AC datas : OLD Name : "검은나무 주술사", Name AC enUS : "Blackwood Shaman" ; Wowhead enUS : "Blackwood Shaman"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2171;
-- AC datas : OLD Name : "모래톱광포어", Name AC enUS : "Reef Frenzy" ; Wowhead enUS : "Reef Frenzy"
UPDATE `creature_template_locale` SET `Name` = '모래톱프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2173;
-- AC datas : OLD Name : "바다광포어", Name AC enUS : "Coastal Frenzy" ; Wowhead enUS : "Coastal Frenzy"
UPDATE `creature_template_locale` SET `Name` = '바다프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2174;
-- AC datas : OLD Name : "폭풍비늘 바다전사", Name AC enUS : "Stormscale Wave Rider" ; Wowhead enUS : "Stormscale Wave Rider"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 바다전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2179;
-- AC datas : OLD Name : "폭풍비늘 세이렌", Name AC enUS : "Stormscale Siren" ; Wowhead enUS : "Stormscale Siren"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2180;
-- AC datas : OLD Name : "폭풍비늘 미르미돈", Name AC enUS : "Stormscale Myrmidon" ; Wowhead enUS : "Stormscale Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2181;
-- AC datas : OLD Name : "폭풍비늘 여마법사", Name AC enUS : "Stormscale Sorceress" ; Wowhead enUS : "Stormscale Sorceress"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2182;
-- AC datas : OLD Name : "폭풍비늘 전사", Name AC enUS : "Stormscale Warrior" ; Wowhead enUS : "Stormscale Warrior"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2183;
-- AC datas : OLD Name : "어둠해안 트레샤돈", Name AC enUS : "Darkshore Thresher" ; Wowhead enUS : "Darkshore Thresher"
UPDATE `creature_template_locale` SET `Name` = '어둠의해안 트레샤돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2185;
-- AC datas : OLD Name : "덩치 큰 어둠해안 트레샤돈", Name AC enUS : "Elder Darkshore Thresher" ; Wowhead enUS : "Elder Darkshore Thresher"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 어둠의해안 트레샤돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2187;
-- AC datas : OLD Name : "광기 어린 그렐", Name AC enUS : "Wild Grell" ; Wowhead enUS : "Wild Grell"
UPDATE `creature_template_locale` SET `Name` = '광기어린 그렐', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2190;
-- AC datas : OLD Name : "잿빛안개 약탈꾼", Name AC enUS : "Greymist Raider" ; Wowhead enUS : "Greymist Raider"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2201;
-- AC datas : OLD Name : "잿빛안개 길잡이", Name AC enUS : "Greymist Coastrunner" ; Wowhead enUS : "Greymist Coastrunner"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2202;
-- AC datas : OLD Name : "잿빛안개 점쟁이", Name AC enUS : "Greymist Seer" ; Wowhead enUS : "Greymist Seer"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2203;
-- AC datas : OLD Name : "잿빛안개 그물낚시꾼", Name AC enUS : "Greymist Netter" ; Wowhead enUS : "Greymist Netter"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 그물낚시꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2204;
-- AC datas : OLD Name : "잿빛안개 전사", Name AC enUS : "Greymist Warrior" ; Wowhead enUS : "Greymist Warrior"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2205;
-- AC datas : OLD Name : "잿빛안개 사냥꾼", Name AC enUS : "Greymist Hunter" ; Wowhead enUS : "Greymist Hunter"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2206;
-- AC datas : OLD Name : "잿빛안개 점술사", Name AC enUS : "Greymist Oracle" ; Wowhead enUS : "Greymist Oracle"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 점술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2207;
-- AC datas : OLD Name : "잿빛안개 바다사냥꾼", Name AC enUS : "Greymist Tidehunter" ; Wowhead enUS : "Greymist Tidehunter"
UPDATE `creature_template_locale` SET `Name` = '잿빛안개멀록 바다사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2208;
-- AC datas : OLD Name : "죽음경비병 가빈", Name AC enUS : "Deathguard Gavin" ; Wowhead enUS : "Deathguard Gavin"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 가빈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2209;
-- AC datas : OLD Name : "죽음경비병 로얀", Name AC enUS : "Deathguard Royann" ; Wowhead enUS : "Deathguard Royann"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 로얀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2210;
-- AC datas : OLD Name : "죽음추적자 레시", Name AC enUS : "Deathstalker Lesh" ; Wowhead enUS : "Deathstalker Lesh"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 레시', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2214;
-- AC datas : OLD Name : "언데드 상급 주술사", Name AC enUS : "Undead Shaman Trainer" ; Wowhead enUS : "Undead Shaman Trainer"
UPDATE `creature_template_locale` SET `Name` = '언데드 상급 샤먼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2219;
-- AC datas : OLD Subname : "", Subname AC enUS : "Blacksmith Trainer" ; Wowhead enUS : "Blacksmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2220;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2223;
-- AC datas : OLD Name : "작은 파도게", Name AC enUS : "Pygmy Tide Crawler" ; Wowhead enUS : "Pygmy Tide Crawler"
UPDATE `creature_template_locale` SET `Name` = '새끼 왕바닷게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2231;
-- AC datas : OLD Name : "파도게", Name AC enUS : "Tide Crawler" ; Wowhead enUS : "Tide Crawler"
UPDATE `creature_template_locale` SET `Name` = '왕바닷게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2232;
-- AC datas : OLD Name : "등껍질 파도게", Name AC enUS : "Encrusted Tide Crawler" ; Wowhead enUS : "Encrusted Tide Crawler"
UPDATE `creature_template_locale` SET `Name` = '등껍질 왕바닷게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2233;
-- AC datas : OLD Name : "산사태 투사", Name AC enUS : "Crushridge Brute" ; Wowhead enUS : "Crushridge Brute"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2253;
-- AC datas : OLD Name : "산사태 싸움꾼", Name AC enUS : "Crushridge Mauler" ; Wowhead enUS : "Crushridge Mauler"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2254;
-- AC datas : OLD Name : "산사태 마법사", Name AC enUS : "Crushridge Mage" ; Wowhead enUS : "Crushridge Mage"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2255;
-- AC datas : OLD Name : "산사태 집행자", Name AC enUS : "Crushridge Enforcer" ; Wowhead enUS : "Crushridge Enforcer"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2256;
-- AC datas : OLD Name : "마가라크", Name AC enUS : "Stone Fury" ; Wowhead enUS : "Stone Fury"
UPDATE `creature_template_locale` SET `Name` = '분노한 바위 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2258;
-- AC datas : OLD Name : "언덕마루 재봉사", Name AC enUS : "Hillsbrad Tailor" ; Wowhead enUS : "Hillsbrad Tailor"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 재봉사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2264;
-- AC datas : OLD Name : "언덕마루 수습대장장이", Name AC enUS : "Hillsbrad Apprentice Blacksmith" ; Wowhead enUS : "Hillsbrad Apprentice Blacksmith"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 수습대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2265;
-- AC datas : OLD Name : "언덕마루 농부", Name AC enUS : "Hillsbrad Farmer" ; Wowhead enUS : "Hillsbrad Farmer"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 농부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2266;
-- AC datas : OLD Name : "언덕마루 소작농", Name AC enUS : "Hillsbrad Peasant" ; Wowhead enUS : "Hillsbrad Peasant"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 소작농', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2267;
-- AC datas : OLD Name : "언덕마루 보병", Name AC enUS : "Hillsbrad Footman" ; Wowhead enUS : "Hillsbrad Footman"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2268;
-- AC datas : OLD Name : "언덕마루 광부", Name AC enUS : "Hillsbrad Miner" ; Wowhead enUS : "Hillsbrad Miner"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 광부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2269;
-- AC datas : OLD Name : "언덕마루 보초", Name AC enUS : "Hillsbrad Sentry" ; Wowhead enUS : "Hillsbrad Sentry"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2270;
-- AC datas : OLD Name : "산사태 전사", Name AC enUS : "Crushridge Warmonger" ; Wowhead enUS : "Crushridge Warmonger"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2287;
-- AC datas : OLD Name : "보르구스 스타우트암", Name AC enUS : "Borgus Stoutarm" ; Wowhead enUS : "Borgus Stoutarm"
UPDATE `creature_template_locale` SET `Name` = '보거스 스타우트암', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2299;
-- AC datas : OLD Name : "토마스 알렌토", Name AC enUS : "Thomas Arlento" ; Wowhead enUS : "Thomas Arlento"
UPDATE `creature_template_locale` SET `Name` = '토마스 알렌도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2309;
-- AC datas : OLD Name : "사반 블러드섀도", Name AC enUS : "Sahvan Bloodshadow" ; Wowhead enUS : "Sahvan Bloodshadow"
UPDATE `creature_template_locale` SET `Name` = '사반 블러드섀도우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2314;
-- AC datas : OLD Name : "검은나무 풍수사", Name AC enUS : "Blackwood Windtalker" ; Wowhead enUS : "Blackwood Windtalker"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 풍수사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2324;
-- AC datas : OLD Name : "황혼의 신도", Name AC enUS : "Twilight Disciple" ; Wowhead enUS : "Twilight Disciple"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2338;
-- AC datas : OLD Name : "황혼의 암살단원", Name AC enUS : "Twilight Thug" ; Wowhead enUS : "Twilight Thug"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 암살단원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2339;
-- AC datas : OLD Name : "길들인 이끼거미", Name AC enUS : "Giant Moss Creeper" ; Wowhead enUS : "Giant Moss Creeper"
UPDATE `creature_template_locale` SET `Name` = '거대한 이끼거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2349;
-- AC datas : OLD Name : "숲거미", Name AC enUS : "Forest Moss Creeper" ; Wowhead enUS : "Forest Moss Creeper"
UPDATE `creature_template_locale` SET `Name` = '숲이끼거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2350;
-- AC datas : OLD Name : "역병 걸린 곰", Name AC enUS : "Gray Bear" ; Wowhead enUS : "Gray Bear"
UPDATE `creature_template_locale` SET `Name` = '회색곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2351;
-- AC datas : OLD Name : "언덕마루 농장 일꾼", Name AC enUS : "Hillsbrad Farmhand" ; Wowhead enUS : "Hillsbrad Farmhand"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 농노', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2360;
-- AC datas : OLD Name : "수습생 허니웰", Name AC enUS : "Apprentice Honeywell" ; Wowhead enUS : "Apprentice Honeywell"
UPDATE `creature_template_locale` SET `Name` = '수습생 하니웰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2363;
-- AC datas : OLD Name : "도널드 라본느", Name AC enUS : "Donald Rabonne" ; Wowhead enUS : "Donald Rabonne"
UPDATE `creature_template_locale` SET `Name` = '도날드 라본느', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2367;
-- AC datas : OLD Name : "비수가시 바다추적자", Name AC enUS : "Daggerspine Shorestalker" ; Wowhead enUS : "Daggerspine Shorestalker"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 바다추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2368;
-- AC datas : OLD Name : "비수가시 바다사냥꾼", Name AC enUS : "Daggerspine Shorehunter" ; Wowhead enUS : "Daggerspine Shorehunter"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 바다사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2369;
-- AC datas : OLD Name : "비수가시 비명술사", Name AC enUS : "Daggerspine Screamer" ; Wowhead enUS : "Daggerspine Screamer"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 비명술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2370;
-- AC datas : OLD Name : "비수가시 세이렌", Name AC enUS : "Daggerspine Siren" ; Wowhead enUS : "Daggerspine Siren"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2371;
-- AC datas : OLD Name : "진흙주둥이 주술사", Name AC enUS : "Mudsnout Shaman" ; Wowhead enUS : "Mudsnout Shaman"
UPDATE `creature_template_locale` SET `Name` = '진흙주둥이일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2373;
-- AC datas : OLD Name : "너덜지느러미 땅꾼", Name AC enUS : "Torn Fin Muckdweller" ; Wowhead enUS : "Torn Fin Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '너덜지느러미멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2374;
-- AC datas : OLD Name : "너덜지느러미 길잡이", Name AC enUS : "Torn Fin Coastrunner" ; Wowhead enUS : "Torn Fin Coastrunner"
UPDATE `creature_template_locale` SET `Name` = '너덜지느러미멀록 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2375;
-- AC datas : OLD Name : "너덜지느러미 점쟁이", Name AC enUS : "Torn Fin Oracle" ; Wowhead enUS : "Torn Fin Oracle"
UPDATE `creature_template_locale` SET `Name` = '너덜지느러미멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2376;
-- AC datas : OLD Name : "너덜지느러미 바다사냥꾼", Name AC enUS : "Torn Fin Tidehunter" ; Wowhead enUS : "Torn Fin Tidehunter"
UPDATE `creature_template_locale` SET `Name` = '너덜지느러미멀록 바다사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2377;
-- AC datas : OLD Name : "대런 말뷰", Name AC enUS : "Darren Malvew" ; Wowhead enUS : "Darren Malvew"
UPDATE `creature_template_locale` SET `Name` = '다렌 말뷰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2382;
-- AC datas : OLD Name : "구릉지 추적자", Name AC enUS : "Feral Mountain Lion" ; Wowhead enUS : "Feral Mountain Lion"
UPDATE `creature_template_locale` SET `Name` = '흉포한 산사자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2385;
-- AC datas : OLD Name : "얼라이언스 수비대", Name AC enUS : "Southshore Guard" ; Wowhead enUS : "Southshore Guard"
UPDATE `creature_template_locale` SET `Name` = '사우스쇼어 수비대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2386;
-- AC datas : OLD Name : "언덕마루 원로", Name AC enUS : "Hillsbrad Councilman" ; Wowhead enUS : "Hillsbrad Councilman"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 원로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2387;
-- AC datas : OLD Name : "타렌 제분소 죽음경비병", Name AC enUS : "Tarren Mill Deathguard" ; Wowhead enUS : "Tarren Mill Deathguard"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 죽음의경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2405;
-- AC datas : OLD Name : "산사태 약탈자", Name AC enUS : "Crushridge Plunderer" ; Wowhead enUS : "Crushridge Plunderer"
UPDATE `creature_template_locale` SET `Name` = '산사태일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2416;
-- AC datas : OLD Name : "죽음경비병 삼사", Name AC enUS : "Deathguard Samsa" ; Wowhead enUS : "Deathguard Samsa"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 삼사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2418;
-- AC datas : OLD Name : "죽음경비병 험버트", Name AC enUS : "Deathguard Humbert" ; Wowhead enUS : "Deathguard Humbert"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 험버트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2419;
-- AC datas : OLD Name : "남녘해안 포고꾼", Name AC enUS : "Southshore Crier" ; Wowhead enUS : "Southshore Crier"
UPDATE `creature_template_locale` SET `Name` = '사우스쇼어 포고꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2435;
-- AC datas : OLD Name : "술 취한 노상강도", Name AC enUS : "Drunken Footpad" ; Wowhead enUS : "Drunken Footpad"
UPDATE `creature_template_locale` SET `Name` = '술취한 노상강도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2440;
-- AC datas : OLD Name : "란돌프 몬테규", Name AC enUS : "Randolph Montague" ; Wowhead enUS : "Randolph Montague"
UPDATE `creature_template_locale` SET `Name` = '란돌프 몬테그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2458;
-- AC datas : OLD Name : "모티머 몬테규", Name AC enUS : "Mortimer Montague" ; Wowhead enUS : "Mortimer Montague"
UPDATE `creature_template_locale` SET `Name` = '모르티머 몬테그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2459;
-- AC datas : OLD Name : "고쉬할디르", Name AC enUS : "Large Loch Crocolisk" ; Wowhead enUS : "Large Loch Crocolisk"
UPDATE `creature_template_locale` SET `Name` = '큰 호수악어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2476;
-- AC datas : OLD Name : "언덕마루 현장감독", Name AC enUS : "Hillsbrad Foreman" ; Wowhead enUS : "Hillsbrad Foreman"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 현장감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2503;
-- AC datas : OLD Name : "바닷물 무쇠턱거북", Name AC enUS : "Saltwater Snapjaw" ; Wowhead enUS : "Saltwater Snapjaw"
UPDATE `creature_template_locale` SET `Name` = '무쇠턱 바다거북', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2505;
-- AC datas : OLD Name : "하늘갈기 고릴라", Name AC enUS : "Skymane Gorilla" ; Wowhead enUS : "Skymane Gorilla"
UPDATE `creature_template_locale` SET `Name` = '하늘갈기고릴라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2521;
-- AC datas : OLD Subname : "잔질의 사절", Subname AC enUS : "Darkspear Hostage" ; Wowhead enUS : "Darkspear Hostage"
UPDATE `creature_template_locale` SET `Title` = '검은창부족 인질', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2530;
-- AC datas : OLD Name : "도운의 앞잡이", Name AC enUS : "Minion of Morganth" ; Wowhead enUS : "Minion of Morganth"
UPDATE `creature_template_locale` SET `Name` = '모건스의 앞잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2531;
-- AC datas : OLD Name : "호박색 농장 독사", Name AC enUS : "Dalaran Serpent" ; Wowhead enUS : "Dalaran Serpent"
UPDATE `creature_template_locale` SET `Name` = '달라란 독사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2540;
-- AC datas : OLD Name : "선장 킬홀", Name AC enUS : "Captain Keelhaul" ; Wowhead enUS : "Captain Keelhaul"
UPDATE `creature_template_locale` SET `Name` = '선장 킬하울', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2548;
-- AC datas : OLD Name : "마른나무껍질 흑마술사", Name AC enUS : "Witherbark Shadowcaster" ; Wowhead enUS : "Witherbark Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2553;
-- AC datas : OLD Name : "마른나무껍질 도끼투척병", Name AC enUS : "Witherbark Axe Thrower" ; Wowhead enUS : "Witherbark Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2554;
-- AC datas : OLD Name : "마른나무껍질 의술사", Name AC enUS : "Witherbark Witch Doctor" ; Wowhead enUS : "Witherbark Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2555;
-- AC datas : OLD Name : "마른나무껍질 인간사냥꾼", Name AC enUS : "Witherbark Headhunter" ; Wowhead enUS : "Witherbark Headhunter"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2556;
-- AC datas : OLD Name : "마른나무껍질 어둠사냥꾼", Name AC enUS : "Witherbark Shadow Hunter" ; Wowhead enUS : "Witherbark Shadow Hunter"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2557;
-- AC datas : OLD Name : "마른나무껍질 광전사", Name AC enUS : "Witherbark Berserker" ; Wowhead enUS : "Witherbark Berserker"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2558;
-- AC datas : OLD Name : "돌주먹 집행자", Name AC enUS : "Boulderfist Enforcer" ; Wowhead enUS : "Boulderfist Enforcer"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2564;
-- AC datas : OLD Name : "돌주먹 투사", Name AC enUS : "Boulderfist Brute" ; Wowhead enUS : "Boulderfist Brute"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2566;
-- AC datas : OLD Name : "돌주먹 사제", Name AC enUS : "Boulderfist Magus" ; Wowhead enUS : "Boulderfist Magus"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2567;
-- AC datas : OLD Name : "돌주먹 싸움꾼", Name AC enUS : "Boulderfist Mauler" ; Wowhead enUS : "Boulderfist Mauler"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2569;
-- AC datas : OLD Name : "돌주먹 주술사", Name AC enUS : "Boulderfist Shaman" ; Wowhead enUS : "Boulderfist Shaman"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2570;
-- AC datas : OLD Name : "돌주먹 우두머리", Name AC enUS : "Boulderfist Lord" ; Wowhead enUS : "Boulderfist Lord"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2571;
-- AC datas : OLD Name : "마른수염 흙점쟁이", Name AC enUS : "Drywhisker Surveyor" ; Wowhead enUS : "Drywhisker Surveyor"
UPDATE `creature_template_locale` SET `Name` = '마른수염일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2573;
-- AC datas : OLD Name : "마른수염 채굴꾼", Name AC enUS : "Drywhisker Digger" ; Wowhead enUS : "Drywhisker Digger"
UPDATE `creature_template_locale` SET `Name` = '마른수염일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2574;
-- AC datas : OLD Name : "검은무쇠 보급병", Name AC enUS : "Dark Iron Supplier" ; Wowhead enUS : "Dark Iron Supplier"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 보급병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2575;
-- AC datas : OLD Name : "검은무쇠 흑마술사", Name AC enUS : "Dark Iron Shadowcaster" ; Wowhead enUS : "Dark Iron Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2577;
-- AC datas : OLD Name : "스트롬가드 병사", Name AC enUS : "Stromgarde Vindicator" ; Wowhead enUS : "Stromgarde Vindicator"
UPDATE `creature_template_locale` SET `Name` = '스트롬가드 성기사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2585;
-- AC datas : OLD Name : "비수가시 침략자", Name AC enUS : "Daggerspine Raider" ; Wowhead enUS : "Daggerspine Raider"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 침략자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2595;
-- AC datas : OLD Name : "비수가시 여마법사", Name AC enUS : "Daggerspine Sorceress" ; Wowhead enUS : "Daggerspine Sorceress"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2596;
-- AC datas : OLD Subname : "", Subname AC enUS : "Shadow Council Warlock" ; Wowhead enUS : "Shadow Council Warlock"
UPDATE `creature_template_locale` SET `Title` = '어둠의 의회 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2598;
-- AC datas : OLD Name : "망치 주둔지 일꾼", Name AC enUS : "Hammerfall Peon" ; Wowhead enUS : "Hammerfall Peon"
UPDATE `creature_template_locale` SET `Name` = '해머폴 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2618;
-- AC datas : OLD Name : "망치 주둔지 그런트", Name AC enUS : "Hammerfall Grunt" ; Wowhead enUS : "Hammerfall Grunt"
UPDATE `creature_template_locale` SET `Name` = '해머폴 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2619;
-- AC datas : OLD Name : "망치 주둔지 수호병", Name AC enUS : "Hammerfall Guardian" ; Wowhead enUS : "Hammerfall Guardian"
UPDATE `creature_template_locale` SET `Name` = '해머폴 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2621;
-- AC datas : OLD Name : "덩치 큰 무쇠턱악어", Name AC enUS : "Elder Saltwater Crocolisk" ; Wowhead enUS : "Elder Saltwater Crocolisk"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 바다악어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2635;
-- AC datas : OLD Name : "썩은가지 도끼투척병", Name AC enUS : "Vilebranch Axe Thrower" ; Wowhead enUS : "Vilebranch Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2639;
-- AC datas : OLD Name : "썩은가지 의술사", Name AC enUS : "Vilebranch Witch Doctor" ; Wowhead enUS : "Vilebranch Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2640;
-- AC datas : OLD Name : "썩은가지 인간사냥꾼", Name AC enUS : "Vilebranch Headhunter" ; Wowhead enUS : "Vilebranch Headhunter"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2641;
-- AC datas : OLD Name : "썩은가지 흑마술사", Name AC enUS : "Vilebranch Shadowcaster" ; Wowhead enUS : "Vilebranch Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2642;
-- AC datas : OLD Name : "썩은가지 광전사", Name AC enUS : "Vilebranch Berserker" ; Wowhead enUS : "Vilebranch Berserker"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2643;
-- AC datas : OLD Name : "썩은가지 암살자", Name AC enUS : "Vilebranch Hideskinner" ; Wowhead enUS : "Vilebranch Hideskinner"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2644;
-- AC datas : OLD Name : "썩은가지 어둠사냥꾼", Name AC enUS : "Vilebranch Shadow Hunter" ; Wowhead enUS : "Vilebranch Shadow Hunter"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2645;
-- AC datas : OLD Name : "썩은가지 혈투사", Name AC enUS : "Vilebranch Blood Drinker" ; Wowhead enUS : "Vilebranch Blood Drinker"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 혈투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2646;
-- AC datas : OLD Name : "썩은가지 영혼사냥꾼", Name AC enUS : "Vilebranch Soul Eater" ; Wowhead enUS : "Vilebranch Soul Eater"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 영혼사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2647;
-- AC datas : OLD Name : "썩은가지 아만자시 경비병", Name AC enUS : "Vilebranch Aman'zasi Guard" ; Wowhead enUS : "Vilebranch Aman'zasi Guard"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 아만자시 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2648;
-- AC datas : OLD Name : "마른나무껍질 무두장이", Name AC enUS : "Witherbark Scalper" ; Wowhead enUS : "Witherbark Scalper"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 무두장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2649;
-- AC datas : OLD Name : "마른나무껍질 광신도", Name AC enUS : "Witherbark Zealot" ; Wowhead enUS : "Witherbark Zealot"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2650;
-- AC datas : OLD Name : "마른나무껍질 암살자", Name AC enUS : "Witherbark Hideskinner" ; Wowhead enUS : "Witherbark Hideskinner"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2651;
-- AC datas : OLD Name : "마른나무껍질 맹독전사", Name AC enUS : "Witherbark Venomblood" ; Wowhead enUS : "Witherbark Venomblood"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 맹독전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2652;
-- AC datas : OLD Name : "마른나무껍질 야만전사", Name AC enUS : "Witherbark Sadist" ; Wowhead enUS : "Witherbark Sadist"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 야만전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2653;
-- AC datas : OLD Name : "마른나무껍질 소환사", Name AC enUS : "Witherbark Caller" ; Wowhead enUS : "Witherbark Caller"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2654;
-- AC datas : OLD Name : "근접 폭발 폭탄", Name AC enUS : "Proximity Bomb" ; Wowhead enUS : "Proximity Bomb"
UPDATE `creature_template_locale` SET `Name` = '원격폭탄', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2665;
-- AC datas : OLD Name : "소형 허수아비골렘 수확기", Name AC enUS : "Compact Harvest Reaper" ; Wowhead enUS : "Compact Harvest Reaper"
UPDATE `creature_template_locale` SET `Name` = '소형 허수아비골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2676;
-- AC datas : OLD Name : "썩은가지 새끼 늑대", Name AC enUS : "Vilebranch Wolf Pup" ; Wowhead enUS : "Vilebranch Wolf Pup"
UPDATE `creature_template_locale` SET `Name` = '썩은가지일족 새끼 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2680;
-- AC datas : OLD Name : "길들인 썩은가지 늑대", Name AC enUS : "Vilebranch Raiding Wolf" ; Wowhead enUS : "Vilebranch Raiding Wolf"
UPDATE `creature_template_locale` SET `Name` = '썩은가지일족의 길들인 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2681;
-- AC datas : OLD Name : "마른나무껍질 혈거미", Name AC enUS : "Witherbark Broodguard" ; Wowhead enUS : "Witherbark Broodguard"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 혈거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2686;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2704;
-- AC datas : OLD Name : "공허방랑자 트레이너", Name AC enUS : "Voidwalker Trainer" ; Wowhead enUS : "Voidwalker Trainer"
UPDATE `creature_template_locale` SET `Name` = '보이드워커 트레이너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2710;
-- AC datas : OLD Name : "먼지목도리 투사", Name AC enUS : "Dustbelcher Brute" ; Wowhead enUS : "Dustbelcher Brute"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2715;
-- AC datas : OLD Name : "먼지목도리 고룡사냥꾼", Name AC enUS : "Dustbelcher Wyrmhunter" ; Wowhead enUS : "Dustbelcher Wyrmhunter"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 고룡사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2716;
-- AC datas : OLD Name : "먼지목도리 싸움꾼", Name AC enUS : "Dustbelcher Mauler" ; Wowhead enUS : "Dustbelcher Mauler"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2717;
-- AC datas : OLD Name : "먼지목도리 주술사", Name AC enUS : "Dustbelcher Shaman" ; Wowhead enUS : "Dustbelcher Shaman"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2718;
-- AC datas : OLD Name : "먼지목도리 우두머리", Name AC enUS : "Dustbelcher Lord" ; Wowhead enUS : "Dustbelcher Lord"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2719;
-- AC datas : OLD Name : "먼지목도리 오우거 마법사", Name AC enUS : "Dustbelcher Ogre Mage" ; Wowhead enUS : "Dustbelcher Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 오우거 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2720;
-- AC datas : OLD Name : "끓어오르는 새끼비룡", Name AC enUS : "Scalding Whelp" ; Wowhead enUS : "Scalding Whelp"
UPDATE `creature_template_locale` SET `Name` = '화염의 새끼비룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2725;
-- AC datas : OLD Name : "어둠괴철로 채굴꾼", Name AC enUS : "Shadowforge Tunneler" ; Wowhead enUS : "Shadowforge Tunneler"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2739;
-- AC datas : OLD Name : "어둠괴철로 흑마술사", Name AC enUS : "Shadowforge Darkweaver" ; Wowhead enUS : "Shadowforge Darkweaver"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2740;
-- AC datas : OLD Name : "어둠괴철로 굴착자", Name AC enUS : "Shadowforge Excavator" ; Wowhead enUS : "Shadowforge Excavator"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 굴착자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2741;
-- AC datas : OLD Name : "어둠괴철로 마술사", Name AC enUS : "Shadowforge Chanter" ; Wowhead enUS : "Shadowforge Chanter"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2742;
-- AC datas : OLD Name : "어둠괴철로 전사", Name AC enUS : "Shadowforge Warrior" ; Wowhead enUS : "Shadowforge Warrior"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2743;
-- AC datas : OLD Name : "어둠괴철로 사령관", Name AC enUS : "Shadowforge Commander" ; Wowhead enUS : "Shadowforge Commander"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2744;
-- AC datas : OLD Name : "철옹성", Name AC enUS : "Siege Golem" ; Wowhead enUS : "Siege Golem"
UPDATE `creature_template_locale` SET `Name` = '공성용 골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2749;
-- AC datas : OLD Name : "전쟁 골렘", Name AC enUS : "War Golem" ; Wowhead enUS : "War Golem"
UPDATE `creature_template_locale` SET `Name` = '전투골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2751;
-- AC datas : OLD Name : "비수가시 약탈자", Name AC enUS : "Daggerspine Marauder" ; Wowhead enUS : "Daggerspine Marauder"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2775;
-- AC datas : OLD Subname : "마법 재료 상인", Subname AC enUS : "Reagents" ; Wowhead enUS : "Reagents"
UPDATE `creature_template_locale` SET `Title` = '두루마리 및 물약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2805;
-- AC datas : OLD Name : "비수가시 파도술사", Name AC enUS : "Daggerspine Wavecaller" ; Wowhead enUS : "Daggerspine Wavecaller"
UPDATE `creature_template_locale` SET `Name` = '비수가시일족 파도술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2807;
-- AC datas : OLD Name : "바짝 마른 대머리수리", Name AC enUS : "Buzzard" ; Wowhead enUS : "Buzzard"
UPDATE `creature_template_locale` SET `Name` = '대머리수리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2830;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '수습 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2857;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crocilisk Trainer" ; Wowhead enUS : "Crocilisk Trainer"
UPDATE `creature_template_locale` SET `Title` = '악어 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2876;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ranged Skills Trainer" ; Wowhead enUS : "Ranged Skills Trainer"
UPDATE `creature_template_locale` SET `Title` = '원거리 기술 트레이너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2886;
-- AC datas : OLD Name : "바위동굴 정찰병", Name AC enUS : "Stonevault Scout" ; Wowhead enUS : "Stonevault Scout"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2890;
-- AC datas : OLD Name : "바위동굴 망치잡이", Name AC enUS : "Stonevault Skullthumper" ; Wowhead enUS : "Stonevault Skullthumper"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 망치잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2891;
-- AC datas : OLD Name : "바위동굴 점쟁이", Name AC enUS : "Stonevault Seer" ; Wowhead enUS : "Stonevault Seer"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2892;
-- AC datas : OLD Name : "바위동굴 뼈다귀싸움꾼", Name AC enUS : "Stonevault Bonesnapper" ; Wowhead enUS : "Stonevault Bonesnapper"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 뼈다귀싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2893;
-- AC datas : OLD Name : "바위동굴 주술사", Name AC enUS : "Stonevault Shaman" ; Wowhead enUS : "Stonevault Shaman"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2894;
-- AC datas : OLD Name : "먼지목도리 전사", Name AC enUS : "Dustbelcher Warrior" ; Wowhead enUS : "Dustbelcher Warrior"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2906;
-- AC datas : OLD Name : "먼지목도리 비술사", Name AC enUS : "Dustbelcher Mystic" ; Wowhead enUS : "Dustbelcher Mystic"
UPDATE `creature_template_locale` SET `Name` = '먼지목도리일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2907;
-- AC datas : OLD Name : "역사가 카르닉", Name AC enUS : "Historian Karnik" ; Wowhead enUS : "Historian Karnik"
UPDATE `creature_template_locale` SET `Name` = '역사학자 카르닉', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2916;
-- AC datas : OLD Name : "루시앙 토슬렌치", Name AC enUS : "Lucien Tosselwrench" ; Wowhead enUS : "Lucien Tosselwrench"
UPDATE `creature_template_locale` SET `Name` = '루시앙 토셀렌치', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2920;
-- AC datas : OLD Subname : "", Subname AC enUS : "" ; Wowhead enUS : ""
UPDATE `creature_template_locale` SET `Title` = '악마 훈련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2935;
-- AC datas : OLD Subname : "", Subname AC enUS : "Bear Trainer" ; Wowhead enUS : "Bear Trainer"
UPDATE `creature_template_locale` SET `Title` = '곰 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2938;
-- AC datas : OLD Name : "딜런 비셸", Name AC enUS : "Dylan Bissel" ; Wowhead enUS : "Dylan Bissel",  OLD Subname : "", Subname AC enUS : "Wolf Trainer" ; Wowhead enUS : "Wolf Trainer"
UPDATE `creature_template_locale` SET `Name` = '다이랜 비셸', `Title` = '늑대 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2942;
-- AC datas : OLD Name : "회색갈기 무두장이", Name AC enUS : "Palemane Tanner" ; Wowhead enUS : "Palemane Tanner"
UPDATE `creature_template_locale` SET `Name` = '회색갈기일족 무두장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2949;
-- AC datas : OLD Name : "회색갈기 가죽장이", Name AC enUS : "Palemane Skinner" ; Wowhead enUS : "Palemane Skinner"
UPDATE `creature_template_locale` SET `Name` = '회색갈기일족 가죽장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2950;
-- AC datas : OLD Name : "회색갈기 밀렵꾼", Name AC enUS : "Palemane Poacher" ; Wowhead enUS : "Palemane Poacher"
UPDATE `creature_template_locale` SET `Name` = '회색갈기일족 밀렵꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2951;
-- AC datas : OLD Name : "뾰족털 침략자", Name AC enUS : "Bristleback Quilboar" ; Wowhead enUS : "Bristleback Quilboar"
UPDATE `creature_template_locale` SET `Name` = '뾰족털 가시멧돼지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2952;
-- AC datas : OLD Name : "뾰족털 주술사", Name AC enUS : "Bristleback Shaman" ; Wowhead enUS : "Bristleback Shaman"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2953;
-- AC datas : OLD Name : "뾰족털 전투멧돼지", Name AC enUS : "Bristleback Battleboar" ; Wowhead enUS : "Bristleback Battleboar"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 전투멧돼지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2954;
-- AC datas : OLD Name : "성난바람 하피", Name AC enUS : "Windfury Harpy" ; Wowhead enUS : "Windfury Harpy"
UPDATE `creature_template_locale` SET `Name` = '성난바람하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2962;
-- AC datas : OLD Name : "성난바람 바람 마녀", Name AC enUS : "Windfury Wind Witch" ; Wowhead enUS : "Windfury Wind Witch"
UPDATE `creature_template_locale` SET `Name` = '성난바람일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2963;
-- AC datas : OLD Name : "성난바람 마법사", Name AC enUS : "Windfury Sorceress" ; Wowhead enUS : "Windfury Sorceress"
UPDATE `creature_template_locale` SET `Name` = '성난바람일족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2964;
-- AC datas : OLD Name : "성난바람 우두머리", Name AC enUS : "Windfury Matriarch" ; Wowhead enUS : "Windfury Matriarch"
UPDATE `creature_template_locale` SET `Name` = '성난바람일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2965;
-- AC datas : OLD Name : "새끼 전투멧돼지", Name AC enUS : "Battleboar" ; Wowhead enUS : "Battleboar"
UPDATE `creature_template_locale` SET `Name` = '전투멧돼지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2966;
-- AC datas : OLD Name : "갈라크 정찰꾼", Name AC enUS : "Galak Outrunner" ; Wowhead enUS : "Galak Outrunner"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2968;
-- AC datas : OLD Subname : "가죽세공용품 상인", Subname AC enUS : "Apprentice Leatherworker" ; Wowhead enUS : "Apprentice Leatherworker"
UPDATE `creature_template_locale` SET `Title` = '수습 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3008;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3014;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3026;
-- AC datas : OLD Name : "싱", Name AC enUS : "Synge" ; Wowhead enUS : "Synge"
UPDATE `creature_template_locale` SET `Name` = '신게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3053;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3067;
-- AC datas : OLD Subname : "수습 연금술사", Subname AC enUS : "Alchemist <Needs Model>" ; Wowhead enUS : "Alchemist <Needs Model>"
UPDATE `creature_template_locale` SET `Title` = '연금술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3070;
-- AC datas : OLD Name : "제럴드 크롤리", Name AC enUS : "Gerald Crawley" ; Wowhead enUS : "Gerald Crawley",  OLD Subname : "독극물 상인", Subname AC enUS : "Poison Supplies" ; Wowhead enUS : "Poison Supplies"
UPDATE `creature_template_locale` SET `Name` = '제랄드 크롤리', `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3090;
-- AC datas : OLD Name : "붉은톱니게", Name AC enUS : "Pygmy Surf Crawler" ; Wowhead enUS : "Pygmy Surf Crawler"
UPDATE `creature_template_locale` SET `Name` = '새끼 붉은톱니게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3106;
-- AC datas : OLD Name : "다 자란 붉은톱니게", Name AC enUS : "Surf Crawler" ; Wowhead enUS : "Surf Crawler"
UPDATE `creature_template_locale` SET `Name` = '붉은톱니게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3107;
-- AC datas : OLD Name : "서슬갈기 정찰병", Name AC enUS : "Razormane Scout" ; Wowhead enUS : "Razormane Scout"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3112;
-- AC datas : OLD Name : "서슬갈기 사막길잡이", Name AC enUS : "Razormane Dustrunner" ; Wowhead enUS : "Razormane Dustrunner"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 사막길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3113;
-- AC datas : OLD Name : "서슬갈기 전투호위병", Name AC enUS : "Razormane Battleguard" ; Wowhead enUS : "Razormane Battleguard"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3114;
-- AC datas : OLD Name : "먼지바람 하피", Name AC enUS : "Dustwind Harpy" ; Wowhead enUS : "Dustwind Harpy"
UPDATE `creature_template_locale` SET `Name` = '먼지바람하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3115;
-- AC datas : OLD Name : "먼지바람 약탈자", Name AC enUS : "Dustwind Pillager" ; Wowhead enUS : "Dustwind Pillager"
UPDATE `creature_template_locale` SET `Name` = '먼지바람일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3116;
-- AC datas : OLD Name : "먼지바람 여전사", Name AC enUS : "Dustwind Savage" ; Wowhead enUS : "Dustwind Savage"
UPDATE `creature_template_locale` SET `Name` = '먼지바람일족 여전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3117;
-- AC datas : OLD Name : "먼지바람 폭풍 마녀", Name AC enUS : "Dustwind Storm Witch" ; Wowhead enUS : "Dustwind Storm Witch"
UPDATE `creature_template_locale` SET `Name` = '먼지바람일족 폭풍마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3118;
-- AC datas : OLD Name : "콜카르 싸움꾼", Name AC enUS : "Kolkar Drudge" ; Wowhead enUS : "Kolkar Drudge"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3119;
-- AC datas : OLD Name : "콜카르 정찰꾼", Name AC enUS : "Kolkar Outrunner" ; Wowhead enUS : "Kolkar Outrunner"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3120;
-- AC datas : OLD Name : "오그닐 소울스카", Name AC enUS : "Orgnil Soulscar" ; Wowhead enUS : "Orgnil Soulscar"
UPDATE `creature_template_locale` SET `Name` = '오르그닐 소울스카', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3142;
-- AC datas : OLD Name : "펄 스콘브라우", Name AC enUS : "Furl Scornbrow" ; Wowhead enUS : "Furl Scornbrow"
UPDATE `creature_template_locale` SET `Name` = '펄 스콘브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3147;
-- AC datas : OLD Subname : "듀로타행 비행선 기장", Subname AC enUS : "Durotar Zeppelin Master" ; Wowhead enUS : "Durotar Zeppelin Master"
UPDATE `creature_template_locale` SET `Title` = '오그리마행 비행선 기장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3149;
-- AC datas : OLD Name : "검은무쇠 중개업자", Name AC enUS : "Dark Iron Entrepreneur" ; Wowhead enUS : "Dark Iron Entrepreneur"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 중개업자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3180;
-- AC datas : OLD Name : "미샤 톨크렌", Name AC enUS : "Misha Tor'kren" ; Wowhead enUS : "Misha Tor'kren"
UPDATE `creature_template_locale` SET `Name` = '미샤 토크렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3193;
-- AC datas : OLD Name : "스콧 머서", Name AC enUS : "Scott Mercer" ; Wowhead enUS : "Scott Mercer"
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3201;
-- AC datas : OLD Name : "피즐 다크클로", Name AC enUS : "Fizzle Darkstorm" ; Wowhead enUS : "Fizzle Darkstorm"
UPDATE `creature_template_locale` SET `Name` = '피즐 다크스톰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3203;
-- AC datas : OLD Name : "사술에 걸린 트롤", Name AC enUS : "Hexed Troll" ; Wowhead enUS : "Hexed Troll"
UPDATE `creature_template_locale` SET `Name` = '주술에 걸린 트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3207;
-- AC datas : OLD Name : "뾰족털 약탈자", Name AC enUS : "Bristleback Interloper" ; Wowhead enUS : "Bristleback Interloper"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3232;
-- AC datas : OLD Name : "길 잃은 불모의 땅 코도", Name AC enUS : "Lost Barrens Kodo" ; Wowhead enUS : "Lost Barrens Kodo"
UPDATE `creature_template_locale` SET `Name` = '길잃은 황무지 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3234;
-- AC datas : OLD Name : "거대한 불모의 땅 코도", Name AC enUS : "Greater Barrens Kodo" ; Wowhead enUS : "Greater Barrens Kodo"
UPDATE `creature_template_locale` SET `Name` = '거대한 황무지 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3235;
-- AC datas : OLD Name : "불모의 땅 코도", Name AC enUS : "Barrens Kodo" ; Wowhead enUS : "Barrens Kodo"
UPDATE `creature_template_locale` SET `Name` = '황무지 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3236;
-- AC datas : OLD Name : "불모의 땅 기린", Name AC enUS : "Barrens Giraffe" ; Wowhead enUS : "Barrens Giraffe"
UPDATE `creature_template_locale` SET `Name` = '황무지 기린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3248;
-- AC datas : OLD Name : "채찍꼬리 해비늘랩터", Name AC enUS : "Sunscale Lashtail" ; Wowhead enUS : "Sunscale Lashtail"
UPDATE `creature_template_locale` SET `Name` = '채찍꼬리 열대초원랩터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3254;
-- AC datas : OLD Name : "긴송곳니 해비늘랩터", Name AC enUS : "Sunscale Screecher" ; Wowhead enUS : "Sunscale Screecher"
UPDATE `creature_template_locale` SET `Name` = '긴송곳니 열대초원랩터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3255;
-- AC datas : OLD Name : "갈퀴발톱 해비늘랩터", Name AC enUS : "Sunscale Scytheclaw" ; Wowhead enUS : "Sunscale Scytheclaw"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발톱 열대초원랩터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3256;
-- AC datas : OLD Name : "뾰족털 사냥꾼", Name AC enUS : "Bristleback Hunter" ; Wowhead enUS : "Bristleback Hunter"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3258;
-- AC datas : OLD Name : "뾰족털 파수병", Name AC enUS : "Bristleback Defender" ; Wowhead enUS : "Bristleback Defender"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3259;
-- AC datas : OLD Name : "뾰족털 풍수사", Name AC enUS : "Bristleback Water Seeker" ; Wowhead enUS : "Bristleback Water Seeker"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 풍수사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3260;
-- AC datas : OLD Name : "뾰족털 가시마술사", Name AC enUS : "Bristleback Thornweaver" ; Wowhead enUS : "Bristleback Thornweaver"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 가시마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3261;
-- AC datas : OLD Name : "뾰족털 비술사", Name AC enUS : "Bristleback Mystic" ; Wowhead enUS : "Bristleback Mystic"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3262;
-- AC datas : OLD Name : "뾰족털 흙점쟁이", Name AC enUS : "Bristleback Geomancer" ; Wowhead enUS : "Bristleback Geomancer"
UPDATE `creature_template_locale` SET `Name` = '뾰족털일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3263;
-- AC datas : OLD Name : "서슬갈기 사냥꾼", Name AC enUS : "Razormane Hunter" ; Wowhead enUS : "Razormane Hunter"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3265;
-- AC datas : OLD Name : "서슬갈기 파수병", Name AC enUS : "Razormane Defender" ; Wowhead enUS : "Razormane Defender"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3266;
-- AC datas : OLD Name : "서슬갈기 약탈자", Name AC enUS : "Razormane Water Seeker" ; Wowhead enUS : "Razormane Water Seeker"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 풍수사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3267;
-- AC datas : OLD Name : "서슬갈기 가시마술사", Name AC enUS : "Razormane Thornweaver" ; Wowhead enUS : "Razormane Thornweaver"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 가시마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3268;
-- AC datas : OLD Name : "서슬갈기 흙점쟁이", Name AC enUS : "Razormane Geomancer" ; Wowhead enUS : "Razormane Geomancer"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3269;
-- AC datas : OLD Name : "서슬갈기 비술사", Name AC enUS : "Razormane Mystic" ; Wowhead enUS : "Razormane Mystic"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3271;
-- AC datas : OLD Name : "콜카르 사냥꾼", Name AC enUS : "Kolkar Wrangler" ; Wowhead enUS : "Kolkar Wrangler"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3272;
-- AC datas : OLD Name : "콜카르 번개술사", Name AC enUS : "Kolkar Stormer" ; Wowhead enUS : "Kolkar Stormer"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 번개술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3273;
-- AC datas : OLD Name : "콜카르 조련사", Name AC enUS : "Kolkar Pack Runner" ; Wowhead enUS : "Kolkar Pack Runner"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3274;
-- AC datas : OLD Name : "콜카르 약탈자", Name AC enUS : "Kolkar Marauder" ; Wowhead enUS : "Kolkar Marauder"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3275;
-- AC datas : OLD Name : "칼날바람 하피", Name AC enUS : "Witchwing Harpy" ; Wowhead enUS : "Witchwing Harpy"
UPDATE `creature_template_locale` SET `Name` = '칼날바람하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3276;
-- AC datas : OLD Name : "칼날바람 약탈자", Name AC enUS : "Witchwing Roguefeather" ; Wowhead enUS : "Witchwing Roguefeather"
UPDATE `creature_template_locale` SET `Name` = '칼날바람일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3277;
-- AC datas : OLD Name : "칼날바람 암살자", Name AC enUS : "Witchwing Slayer" ; Wowhead enUS : "Witchwing Slayer"
UPDATE `creature_template_locale` SET `Name` = '칼날바람일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3278;
-- AC datas : OLD Name : "칼날바람 복병", Name AC enUS : "Witchwing Ambusher" ; Wowhead enUS : "Witchwing Ambusher"
UPDATE `creature_template_locale` SET `Name` = '칼날바람일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3279;
-- AC datas : OLD Name : "칼날바람 바람소환사", Name AC enUS : "Witchwing Windcaller" ; Wowhead enUS : "Witchwing Windcaller"
UPDATE `creature_template_locale` SET `Name` = '칼날바람일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3280;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3290;
-- AC datas : OLD Name : "양조사 드론", Name AC enUS : "Brewmaster Drohn" ; Wowhead enUS : "Brewmaster Drohn"
UPDATE `creature_template_locale` SET `Name` = '양조업자 드론', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3292;
-- AC datas : OLD Name : "살무사", Name AC enUS : "Adder" ; Wowhead enUS : "Adder"
UPDATE `creature_template_locale` SET `Name` = '살모사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3300;
-- AC datas : OLD Subname : "천 방어구 상인", Subname AC enUS : "Light Armor Merchant" ; Wowhead enUS : "Light Armor Merchant"
UPDATE `creature_template_locale` SET `Title` = '천 및 가죽 방어구 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3317;
-- AC datas : OLD Subname : "활 및 총기류 상인", Subname AC enUS : "Guns & Ammunition" ; Wowhead enUS : "Guns & Ammunition"
UPDATE `creature_template_locale` SET `Title` = '총기류 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3322;
-- AC datas : OLD Name : "살렉", Name AC enUS : "Sarlek" ; Wowhead enUS : "Sarlek"
UPDATE `creature_template_locale` SET `Name` = '사르렉', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3372;
-- AC datas : OLD Name : "남쪽바다 강도", Name AC enUS : "Southsea Brigand" ; Wowhead enUS : "Southsea Brigand"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 강도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3381;
-- AC datas : OLD Name : "남쪽바다 포병", Name AC enUS : "Southsea Cannoneer" ; Wowhead enUS : "Southsea Cannoneer"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 포병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3382;
-- AC datas : OLD Name : "남쪽바다 자객", Name AC enUS : "Southsea Cutthroat" ; Wowhead enUS : "Southsea Cutthroat"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 자객', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3383;
-- AC datas : OLD Name : "남쪽바다 선원", Name AC enUS : "Southsea Privateer" ; Wowhead enUS : "Southsea Privateer"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 선원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3384;
-- AC datas : OLD Name : "콜카르 흑마술사", Name AC enUS : "Kolkar Bloodcharger" ; Wowhead enUS : "Kolkar Bloodcharger"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3397;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3399;
-- AC datas : OLD Subname : "마법 재료 및 독극물 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3405;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '숙련 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3412;
-- AC datas : OLD Name : "추방자 피글리 (구)", Name AC enUS : "Feegly the Exiled" ; Wowhead enUS : "Feegly the Exiled"
UPDATE `creature_template_locale` SET `Name` = '추방자 피글리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3421;
-- AC datas : OLD Subname : "독립 사업자", Subname AC enUS : "Tinkers' Union" ; Wowhead enUS : "Tinkers' Union"
UPDATE `creature_template_locale` SET `Title` = '땜장이 조합', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3442;
-- AC datas : OLD Name : "서슬갈기 길잡이", Name AC enUS : "Razormane Pathfinder" ; Wowhead enUS : "Razormane Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3456;
-- AC datas : OLD Name : "서슬갈기 정찰꾼", Name AC enUS : "Razormane Stalker" ; Wowhead enUS : "Razormane Stalker"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3457;
-- AC datas : OLD Name : "서슬갈기 점쟁이", Name AC enUS : "Razormane Seer" ; Wowhead enUS : "Razormane Seer"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3458;
-- AC datas : OLD Name : "서슬갈기 광전사", Name AC enUS : "Razormane Warfrenzy" ; Wowhead enUS : "Razormane Warfrenzy"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기일족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3459;
-- AC datas : OLD Name : "덩치 큰 불모의 땅 기린", Name AC enUS : "Elder Barrens Giraffe" ; Wowhead enUS : "Elder Barrens Giraffe"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 기린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3462;
-- AC datas : OLD Name : "떠도는 불모의 땅 기린", Name AC enUS : "Wandering Barrens Giraffe" ; Wowhead enUS : "Wandering Barrens Giraffe"
UPDATE `creature_template_locale` SET `Name` = '떠도는 기린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3463;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3494;
-- AC datas : OLD Name : "대드루이드 판드랄 스태그헬름", Name AC enUS : "Arch Druid Fandral Staghelm" ; Wowhead enUS : "Arch Druid Fandral Staghelm"
UPDATE `creature_template_locale` SET `Name` = '대드루이드 판드랄 스테그헬름', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3516;
-- AC datas : OLD Name : "렐리안 그린스파이어", Name AC enUS : "Rellian Greenspyre" ; Wowhead enUS : "Rellian Greenspyre"
UPDATE `creature_template_locale` SET `Name` = '레엘리안 그린스파이어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3517;
-- AC datas : OLD Name : "파수꾼 아리니아 클라우즈브레이크", Name AC enUS : "Sentinel Arynia Cloudsbreak" ; Wowhead enUS : "Sentinel Arynia Cloudsbreak"
UPDATE `creature_template_locale` SET `Name` = '파수꾼 아리니아 클라우드브레이크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3519;
-- AC datas : OLD Name : "달분노 대장장이", Name AC enUS : "Moonrage Armorer" ; Wowhead enUS : "Moonrage Armorer"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3529;
-- AC datas : OLD Name : "달분노 재봉사", Name AC enUS : "Moonrage Tailor" ; Wowhead enUS : "Moonrage Tailor"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 재봉사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3531;
-- AC datas : OLD Name : "달분노 가죽세공사", Name AC enUS : "Moonrage Leatherworker" ; Wowhead enUS : "Moonrage Leatherworker"
UPDATE `creature_template_locale` SET `Name` = '달의분노일족 가죽세공사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3533;
-- AC datas : OLD Name : "장님 월리스", Name AC enUS : "Wallace the Blind" ; Wowhead enUS : "Wallace the Blind"
UPDATE `creature_template_locale` SET `Name` = '장님 왈레스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3534;
-- AC datas : OLD Subname : "연금술 및 약초채집용품 상인", Subname AC enUS : "Alchemy & Herbalism Supplies" ; Wowhead enUS : "Alchemy & Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3548;
-- AC datas : OLD Name : "셸렌 로바트", Name AC enUS : "Shelene Rhobart" ; Wowhead enUS : "Shelene Rhobart"
UPDATE `creature_template_locale` SET `Name` = '셸렌 로버트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3549;
-- AC datas : OLD Name : "안드레아 보인톤", Name AC enUS : "Andrea Boynton" ; Wowhead enUS : "Andrea Boynton"
UPDATE `creature_template_locale` SET `Name` = '안드리아 보인톤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3554;
-- AC datas : OLD Subname : "독극물 상인", Subname AC enUS : "Poison Supplies" ; Wowhead enUS : "Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3558;
-- AC datas : OLD Subname : "독극물 상인", Subname AC enUS : "Poison Supplies" ; Wowhead enUS : "Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3559;
-- AC datas : OLD Name : "호박색 농장 양조사", Name AC enUS : "Dalaran Brewmaster" ; Wowhead enUS : "Dalaran Brewmaster"
UPDATE `creature_template_locale` SET `Name` = '달라란 양조장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3577;
-- AC datas : OLD Name : "호박색 농장 광부", Name AC enUS : "Dalaran Miner" ; Wowhead enUS : "Dalaran Miner"
UPDATE `creature_template_locale` SET `Name` = '달라란 광부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3578;
-- AC datas : OLD Name : "신드라 카인드위스퍼", Name AC enUS : "Cyndra Kindwhisper" ; Wowhead enUS : "Cyndra Kindwhisper"
UPDATE `creature_template_locale` SET `Name` = '킨드라 카인드위스퍼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3603;
-- AC datas : OLD Name : "세렐리안 화이트클로", Name AC enUS : "Cerellean Whiteclaw" ; Wowhead enUS : "Cerellean Whiteclaw"
UPDATE `creature_template_locale` SET `Name` = '셀렐리안 화이트클로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3644;
-- AC datas : OLD Name : "무요", Name AC enUS : "Disciple of Naralex" ; Wowhead enUS : "Disciple of Naralex"
UPDATE `creature_template_locale` SET `Name` = '나랄렉스의 신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3678;
-- AC datas : OLD Name : "잔혹발톱", Name AC enUS : "Grimclaw" ; Wowhead enUS : "Grimclaw"
UPDATE `creature_template_locale` SET `Name` = '그림클로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3695;
-- AC datas : OLD Subname : "", Subname AC enUS : "Pet Trainer" ; Wowhead enUS : "Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '야수 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3698;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cat Trainer" ; Wowhead enUS : "Cat Trainer"
UPDATE `creature_template_locale` SET `Title` = '살쾡이 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3699;
-- AC datas : OLD Name : "자덴비스 시워처", Name AC enUS : "Jadenvis Seawatcher" ; Wowhead enUS : "Jadenvis Seawatcher"
UPDATE `creature_template_locale` SET `Name` = '자덴비스 시와처', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3700;
-- AC datas : OLD Name : "성난지느러미 미르미돈", Name AC enUS : "Wrathtail Myrmidon" ; Wowhead enUS : "Wrathtail Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3711;
-- AC datas : OLD Name : "성난지느러미 가시전사", Name AC enUS : "Wrathtail Razortail" ; Wowhead enUS : "Wrathtail Razortail"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 가시전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3712;
-- AC datas : OLD Name : "성난지느러미 바다전사", Name AC enUS : "Wrathtail Wave Rider" ; Wowhead enUS : "Wrathtail Wave Rider"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 바다전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3713;
-- AC datas : OLD Name : "성난지느러미 바다 마녀", Name AC enUS : "Wrathtail Sea Witch" ; Wowhead enUS : "Wrathtail Sea Witch"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 바다마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3715;
-- AC datas : OLD Name : "성난지느러미 여마법사", Name AC enUS : "Wrathtail Sorceress" ; Wowhead enUS : "Wrathtail Sorceress"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3717;
-- AC datas : OLD Name : "포세이큰 수색꾼[미사용]", Name AC enUS : "Forsaken Seeker" ; Wowhead enUS : "Forsaken Seeker"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 수색꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3732;
-- AC datas : OLD Name : "포세이큰 약초채집가", Name AC enUS : "Forsaken Herbalist" ; Wowhead enUS : "Forsaken Herbalist"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 약초채집사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3733;
-- AC datas : OLD Name : "오크 감독관", Name AC enUS : "Forsaken Thug" ; Wowhead enUS : "Forsaken Thug"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 암살단원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3734;
-- AC datas : OLD Name : "소금거품 보초", Name AC enUS : "Saltspittle Puddlejumper" ; Wowhead enUS : "Saltspittle Puddlejumper"
UPDATE `creature_template_locale` SET `Name` = '소금거품멀록 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3737;
-- AC datas : OLD Name : "소금거품 전사", Name AC enUS : "Saltspittle Warrior" ; Wowhead enUS : "Saltspittle Warrior"
UPDATE `creature_template_locale` SET `Name` = '소금거품멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3739;
-- AC datas : OLD Name : "소금거품 땅꾼", Name AC enUS : "Saltspittle Muckdweller" ; Wowhead enUS : "Saltspittle Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '소금거품멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3740;
-- AC datas : OLD Name : "소금거품 점쟁이", Name AC enUS : "Saltspittle Oracle" ; Wowhead enUS : "Saltspittle Oracle"
UPDATE `creature_template_locale` SET `Name` = '소금거품멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3742;
-- AC datas : OLD Name : "썩은나무 전사", Name AC enUS : "Foulweald Warrior" ; Wowhead enUS : "Foulweald Warrior"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3743;
-- AC datas : OLD Name : "썩은나무 길잡이", Name AC enUS : "Foulweald Pathfinder" ; Wowhead enUS : "Foulweald Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3745;
-- AC datas : OLD Name : "썩은나무 보초", Name AC enUS : "Foulweald Den Watcher" ; Wowhead enUS : "Foulweald Den Watcher"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3746;
-- AC datas : OLD Name : "썩은나무 주술사", Name AC enUS : "Foulweald Shaman" ; Wowhead enUS : "Foulweald Shaman"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3748;
-- AC datas : OLD Name : "썩은나무 펄볼그", Name AC enUS : "Foulweald Ursa" ; Wowhead enUS : "Foulweald Ursa"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3749;
-- AC datas : OLD Name : "썩은나무 토템술사", Name AC enUS : "Foulweald Totemic" ; Wowhead enUS : "Foulweald Totemic"
UPDATE `creature_template_locale` SET `Name` = '썩은나무일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3750;
-- AC datas : OLD Name : "하급 지옥수호병", Name AC enUS : "Lesser Felguard" ; Wowhead enUS : "Lesser Felguard"
UPDATE `creature_template_locale` SET `Name` = '하급 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3772;
-- AC datas : OLD Name : "그을린 이끼늪괴물", Name AC enUS : "Shadethicket Moss Eater" ; Wowhead enUS : "Shadethicket Moss Eater"
UPDATE `creature_template_locale` SET `Name` = '그늘덤불 이끼늪괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3780;
-- AC datas : OLD Name : "포세이큰 침투요원", Name AC enUS : "Forsaken Infiltrator" ; Wowhead enUS : "Forsaken Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3806;
-- AC datas : OLD Name : "포세이큰 어둠추적자", Name AC enUS : "Forsaken Dark Stalker" ; Wowhead enUS : "Forsaken Dark Stalker"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 어둠의추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3808;
-- AC datas : OLD Name : "잿빛 골짜기 곰", Name AC enUS : "Ashenvale Bear" ; Wowhead enUS : "Ashenvale Bear"
UPDATE `creature_template_locale` SET `Name` = '잿빛골짜기곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3809;
-- AC datas : OLD Name : "덩치 큰 잿빛 골짜기 곰", Name AC enUS : "Elder Ashenvale Bear" ; Wowhead enUS : "Elder Ashenvale Bear"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 잿빛골짜기곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3810;
-- AC datas : OLD Name : "거대한 잿빛 골짜기 곰", Name AC enUS : "Giant Ashenvale Bear" ; Wowhead enUS : "Giant Ashenvale Bear"
UPDATE `creature_template_locale` SET `Name` = '거대한 잿빛골짜기곰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3811;
-- AC datas : OLD Name : "광기 어린 고대정령", Name AC enUS : "Crazed Ancient" ; Wowhead enUS : "Crazed Ancient"
UPDATE `creature_template_locale` SET `Name` = '광기어린 고대정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3834;
-- AC datas : OLD Name : "공허방랑자", Name AC enUS : "Voidlasher" ; Wowhead enUS : "Voidlasher"
UPDATE `creature_template_locale` SET `Name` = '보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3839;
-- AC datas : OLD Name : "텔디라 문페더", Name AC enUS : "Caylais Moonfeather" ; Wowhead enUS : "Caylais Moonfeather"
UPDATE `creature_template_locale` SET `Name` = '케이레이 문피더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3841;
-- AC datas : OLD Name : "죽음추적자 아다만트", Name AC enUS : "Deathstalker Adamant" ; Wowhead enUS : "Deathstalker Adamant"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 아다만트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3849;
-- AC datas : OLD Name : "그림자송곳니 백발전사", Name AC enUS : "Shadowfang Whitescalp" ; Wowhead enUS : "Shadowfang Whitescalp"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 백발전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3851;
-- AC datas : OLD Name : "[미사용] 그림자송곳니 혈투사", Name AC enUS : "Shadowfang Bloodhowler" ; Wowhead enUS : "Shadowfang Bloodhowler"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 혈투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3852;
-- AC datas : OLD Name : "그림자송곳니 달전사", Name AC enUS : "Shadowfang Moonwalker" ; Wowhead enUS : "Shadowfang Moonwalker"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 달전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3853;
-- AC datas : OLD Name : "그림자송곳니 늑대투사", Name AC enUS : "Shadowfang Wolfguard" ; Wowhead enUS : "Shadowfang Wolfguard"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 늑대투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3854;
-- AC datas : OLD Name : "그림자송곳니 검은영혼", Name AC enUS : "Shadowfang Darksoul" ; Wowhead enUS : "Shadowfang Darksoul"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 검은영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3855;
-- AC datas : OLD Name : "그림자송곳니 광신도", Name AC enUS : "Shadowfang Glutton" ; Wowhead enUS : "Shadowfang Glutton"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3857;
-- AC datas : OLD Name : "그림자송곳니 송곳니투사", Name AC enUS : "Shadowfang Ragetooth" ; Wowhead enUS : "Shadowfang Ragetooth"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 송곳니투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3859;
-- AC datas : OLD Name : "[미사용] 그림자송곳니 타락전사", Name AC enUS : "Shadowfang Tainted One" ; Wowhead enUS : "Shadowfang Tainted One"
UPDATE `creature_template_locale` SET `Name` = '그림자송곳니일족 타락전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3860;
-- AC datas : OLD Name : "침 흘리는 검은늑대", Name AC enUS : "Slavering Worg" ; Wowhead enUS : "Slavering Worg"
UPDATE `creature_template_locale` SET `Name` = '굶주린 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3862;
-- AC datas : OLD Name : "[미사용] 충격에 휩싸인 영혼", Name AC enUS : "Traumatized Spirit" ; Wowhead enUS : "Traumatized Spirit"
UPDATE `creature_template_locale` SET `Name` = '충격에 휩싸인 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3876;
-- AC datas : OLD Name : "마그스룰의 파멸의 수호병", Name AC enUS : "Magthrull's Doomguard" ; Wowhead enUS : "Magthrull's Doomguard"
UPDATE `creature_template_locale` SET `Name` = '마그스룰의 파멸의수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3878;
-- AC datas : OLD Subname : "레이네의 소환수", Subname AC enUS : "Raene's Pet" ; Wowhead enUS : "Raene's Pet"
UPDATE `creature_template_locale` SET `Title` = '레이네의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3915;
-- AC datas : OLD Name : "엉겅퀴 펄볼그", Name AC enUS : "Thistlefur Ursa" ; Wowhead enUS : "Thistlefur Ursa"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3921;
-- AC datas : OLD Name : "엉겅퀴 토템술사", Name AC enUS : "Thistlefur Totemic" ; Wowhead enUS : "Thistlefur Totemic"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3922;
-- AC datas : OLD Name : "엉겅퀴 보초", Name AC enUS : "Thistlefur Den Watcher" ; Wowhead enUS : "Thistlefur Den Watcher"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3923;
-- AC datas : OLD Name : "엉겅퀴 주술사", Name AC enUS : "Thistlefur Shaman" ; Wowhead enUS : "Thistlefur Shaman"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3924;
-- AC datas : OLD Name : "엉겅퀴 복수자", Name AC enUS : "Thistlefur Avenger" ; Wowhead enUS : "Thistlefur Avenger"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 복수자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3925;
-- AC datas : OLD Name : "엉겅퀴 길잡이", Name AC enUS : "Thistlefur Pathfinder" ; Wowhead enUS : "Thistlefur Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '엉겅퀴일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3926;
-- AC datas : OLD Name : "핏빛이빨 경비병", Name AC enUS : "Bloodtooth Guard" ; Wowhead enUS : "Bloodtooth Guard"
UPDATE `creature_template_locale` SET `Name` = '붉은송곳니 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3932;
-- AC datas : OLD Subname : "파수대 사령관", Subname AC enUS : "General of the Sentinel Army" ; Wowhead enUS : "General of the Sentinel Army"
UPDATE `creature_template_locale` SET `Title` = '센티널 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3936;
-- AC datas : OLD Name : "서슬갈기 늑대", Name AC enUS : "Razormane Wolf" ; Wowhead enUS : "Razormane Wolf"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3939;
-- AC datas : OLD Name : "성난지느러미 여사제", Name AC enUS : "Wrathtail Priestess" ; Wowhead enUS : "Wrathtail Priestess"
UPDATE `creature_template_locale` SET `Name` = '성난지느러미일족 여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3944;
-- AC datas : OLD Name : "투자개발회사 경비원", Name AC enUS : "Venture Co. Engineer" ; Wowhead enUS : "Venture Co. Engineer"
UPDATE `creature_template_locale` SET `Name` = '투자개발회사 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3992;
-- AC datas : OLD Name : "칼바람 졸개", Name AC enUS : "Windshear Vermin" ; Wowhead enUS : "Windshear Vermin"
UPDATE `creature_template_locale` SET `Name` = '칼바람일족 졸개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3998;
-- AC datas : OLD Name : "칼바람 채굴꾼", Name AC enUS : "Windshear Digger" ; Wowhead enUS : "Windshear Digger"
UPDATE `creature_template_locale` SET `Name` = '칼바람일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 3999;
-- AC datas : OLD Name : "칼바람 석공", Name AC enUS : "Windshear Stonecutter" ; Wowhead enUS : "Windshear Stonecutter"
UPDATE `creature_template_locale` SET `Name` = '칼바람일족 석공', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4002;
-- AC datas : OLD Name : "칼바람 흙점쟁이", Name AC enUS : "Windshear Geomancer" ; Wowhead enUS : "Windshear Geomancer"
UPDATE `creature_template_locale` SET `Name` = '칼바람일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4003;
-- AC datas : OLD Name : "칼바람 우두머리", Name AC enUS : "Windshear Overlord" ; Wowhead enUS : "Windshear Overlord"
UPDATE `creature_template_locale` SET `Name` = '칼바람일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4004;
-- AC datas : OLD Name : "타락한 수액괴물", Name AC enUS : "Corrosive Sap Beast" ; Wowhead enUS : "Corrosive Sap Beast"
UPDATE `creature_template_locale` SET `Name` = '부식성 수액괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4021;
-- AC datas : OLD Name : "혈폭풍 하피", Name AC enUS : "Bloodfury Harpy" ; Wowhead enUS : "Bloodfury Harpy"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4022;
-- AC datas : OLD Name : "혈폭풍 약탈자", Name AC enUS : "Bloodfury Roguefeather" ; Wowhead enUS : "Bloodfury Roguefeather"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4023;
-- AC datas : OLD Name : "혈폭풍 암살자", Name AC enUS : "Bloodfury Slayer" ; Wowhead enUS : "Bloodfury Slayer"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4024;
-- AC datas : OLD Name : "혈폭풍 복병", Name AC enUS : "Bloodfury Ambusher" ; Wowhead enUS : "Bloodfury Ambusher"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4025;
-- AC datas : OLD Name : "혈폭풍 바람소환사", Name AC enUS : "Bloodfury Windcaller" ; Wowhead enUS : "Bloodfury Windcaller"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4026;
-- AC datas : OLD Name : "혈폭풍 폭풍 마녀", Name AC enUS : "Bloodfury Storm Witch" ; Wowhead enUS : "Bloodfury Storm Witch"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 폭풍마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4027;
-- AC datas : OLD Name : "난폭한 화염 정령", Name AC enUS : "Rogue Flame Spirit" ; Wowhead enUS : "Rogue Flame Spirit"
UPDATE `creature_template_locale` SET `Name` = '난폭한 불의 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4036;
-- AC datas : OLD Name : "땅거미 숲순찰자", Name AC enUS : "Mirkfallon Glade Strider" ; Wowhead enUS : "Mirkfallon Glade Strider"
UPDATE `creature_template_locale` SET `Name` = '땅거미호수 숲순찰자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4055;
-- AC datas : OLD Name : "땅거미 문지기", Name AC enUS : "Mirkfallon Keeper" ; Wowhead enUS : "Mirkfallon Keeper"
UPDATE `creature_template_locale` SET `Name` = '땅거미호수 문지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4056;
-- AC datas : OLD Name : "땅거미 드리아드", Name AC enUS : "Mirkfallon Dryad" ; Wowhead enUS : "Mirkfallon Dryad"
UPDATE `creature_template_locale` SET `Name` = '땅거미호수 드리아드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4061;
-- AC datas : OLD Name : "검은무쇠 폭격수", Name AC enUS : "Dark Iron Bombardier" ; Wowhead enUS : "Dark Iron Bombardier"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 폭격수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4062;
-- AC datas : OLD Name : "검은바위 정찰병", Name AC enUS : "Blackrock Scout" ; Wowhead enUS : "Blackrock Scout"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4064;
-- AC datas : OLD Name : "검은바위 파수병", Name AC enUS : "Blackrock Sentry" ; Wowhead enUS : "Blackrock Sentry"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4065;
-- AC datas : OLD Name : "바퀴", Name AC enUS : "Roach" ; Wowhead enUS : "Roach"
UPDATE `creature_template_locale` SET `Name` = '바퀴벌레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4076;
-- AC datas : OLD Name : "갈라크 사냥꾼", Name AC enUS : "Galak Wrangler" ; Wowhead enUS : "Galak Wrangler"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4093;
-- AC datas : OLD Name : "갈라크 척후병", Name AC enUS : "Galak Scout" ; Wowhead enUS : "Galak Scout"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4094;
-- AC datas : OLD Name : "갈라크 투사", Name AC enUS : "Galak Mauler" ; Wowhead enUS : "Galak Mauler"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4095;
-- AC datas : OLD Name : "갈라크 바람전사", Name AC enUS : "Galak Windchaser" ; Wowhead enUS : "Galak Windchaser"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 바람전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4096;
-- AC datas : OLD Name : "갈라크 번개술사", Name AC enUS : "Galak Stormer" ; Wowhead enUS : "Galak Stormer"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 번개술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4097;
-- AC datas : OLD Name : "갈라크 조련사", Name AC enUS : "Galak Pack Runner" ; Wowhead enUS : "Galak Pack Runner"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4098;
-- AC datas : OLD Name : "갈라크 약탈자", Name AC enUS : "Galak Marauder" ; Wowhead enUS : "Galak Marauder"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4099;
-- AC datas : OLD Name : "비명 하피", Name AC enUS : "Screeching Harpy" ; Wowhead enUS : "Screeching Harpy"
UPDATE `creature_template_locale` SET `Name` = '회오리 하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4100;
-- AC datas : OLD Name : "비명 약탈자", Name AC enUS : "Screeching Roguefeather" ; Wowhead enUS : "Screeching Roguefeather"
UPDATE `creature_template_locale` SET `Name` = '회오리일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4101;
-- AC datas : OLD Name : "비명 바람소환사", Name AC enUS : "Screeching Windcaller" ; Wowhead enUS : "Screeching Windcaller"
UPDATE `creature_template_locale` SET `Name` = '회오리일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4104;
-- AC datas : OLD Name : "자갈주둥이 코볼트", Name AC enUS : "Gravelsnout Kobold" ; Wowhead enUS : "Gravelsnout Kobold"
UPDATE `creature_template_locale` SET `Name` = '자갈주둥이일족 코볼트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4111;
-- AC datas : OLD Name : "자갈주둥이 졸개", Name AC enUS : "Gravelsnout Vermin" ; Wowhead enUS : "Gravelsnout Vermin"
UPDATE `creature_template_locale` SET `Name` = '자갈주둥이일족 졸개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4112;
-- AC datas : OLD Name : "자갈주둥이 채굴꾼", Name AC enUS : "Gravelsnout Digger" ; Wowhead enUS : "Gravelsnout Digger"
UPDATE `creature_template_locale` SET `Name` = '자갈주둥이일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4113;
-- AC datas : OLD Name : "자갈주둥이 채집꾼", Name AC enUS : "Gravelsnout Forager" ; Wowhead enUS : "Gravelsnout Forager"
UPDATE `creature_template_locale` SET `Name` = '자갈주둥이일족 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4114;
-- AC datas : OLD Name : "자갈주둥이 흙점쟁이", Name AC enUS : "Gravelsnout Surveyor" ; Wowhead enUS : "Gravelsnout Surveyor"
UPDATE `creature_template_locale` SET `Name` = '자갈주둥이일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4116;
-- AC datas : OLD Name : "크륵큭스", Name AC enUS : "Silithid Ravager" ; Wowhead enUS : "Silithid Ravager"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발톱 실리시드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4132;
-- AC datas : OLD Name : "[미사용]일꾼 실리시드", Name AC enUS : "Silithid Hive Drone" ; Wowhead enUS : "Silithid Hive Drone"
UPDATE `creature_template_locale` SET `Name` = '일꾼 실리시드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4133;
-- AC datas : OLD Subname : "", Subname AC enUS : "Foraging Trainer" ; Wowhead enUS : "Foraging Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 식량채집사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4149;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cat Trainer" ; Wowhead enUS : "Cat Trainer"
UPDATE `creature_template_locale` SET `Title` = '살쾡이 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4153;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cartography Trainer" ; Wowhead enUS : "Cartography Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 지도제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4157;
-- AC datas : OLD Name : "할론 쏜가드", Name AC enUS : "Harlon Thornguard" ; Wowhead enUS : "Harlon Thornguard"
UPDATE `creature_template_locale` SET `Name` = '하론 쏜가드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4187;
-- AC datas : OLD Name : "일리아니", Name AC enUS : "Illyanie" ; Wowhead enUS : "Illyanie"
UPDATE `creature_template_locale` SET `Name` = '일랴니', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4188;
-- AC datas : OLD Subname : "", Subname AC enUS : "Bear Trainer" ; Wowhead enUS : "Bear Trainer"
UPDATE `creature_template_locale` SET `Title` = '곰 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4206;
-- AC datas : OLD Subname : "", Subname AC enUS : "Wolf Trainer" ; Wowhead enUS : "Wolf Trainer"
UPDATE `creature_template_locale` SET `Title` = '늑대 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4207;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4210;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4216;
-- AC datas : OLD Subname : "진라의 소환수", Subname AC enUS : "Jeen'ra's Pet" ; Wowhead enUS : "Jeen'ra's Pet"
UPDATE `creature_template_locale` SET `Title` = '진라의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4243;
-- AC datas : OLD Subname : "도리온의 소환수", Subname AC enUS : "Dorion's Pet" ; Wowhead enUS : "Dorion's Pet"
UPDATE `creature_template_locale` SET `Title` = '도리온의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4244;
-- AC datas : OLD Subname : "발옌의 소환수", Subname AC enUS : "Valyen's Pet" ; Wowhead enUS : "Valyen's Pet"
UPDATE `creature_template_locale` SET `Title` = '발옌의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4245;
-- AC datas : OLD Subname : "키샨디아의 소환수", Subname AC enUS : "Kysandia's Pet" ; Wowhead enUS : "Kysandia's Pet"
UPDATE `creature_template_locale` SET `Title` = '키샨디아의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4246;
-- AC datas : OLD Subname : "탈라르의 소환수", Subname AC enUS : "Talar's Pet" ; Wowhead enUS : "Talar's Pet"
UPDATE `creature_template_locale` SET `Title` = '탈라르의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4247;
-- AC datas : OLD Name : "갈라크 하이에나", Name AC enUS : "Galak Packhound" ; Wowhead enUS : "Galak Packhound"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4250;
-- AC datas : OLD Name : "지오프람 볼더토", Name AC enUS : "Geofram Bouldertoe" ; Wowhead enUS : "Geofram Bouldertoe"
UPDATE `creature_template_locale` SET `Name` = '지오프람 보울더토', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4254;
-- AC datas : OLD Name : "골니르 볼더토", Name AC enUS : "Golnir Bouldertoe" ; Wowhead enUS : "Golnir Bouldertoe"
UPDATE `creature_template_locale` SET `Name` = '골니르 보울더토', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4256;
-- AC datas : OLD Name : "회색 늑대", Name AC enUS : "Gray Wolf" ; Wowhead enUS : "Gray Wolf"
UPDATE `creature_template_locale` SET `Name` = '길들인 회색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4268;
-- AC datas : OLD Name : "붉은 늑대", Name AC enUS : "Red Wolf" ; Wowhead enUS : "Red Wolf"
UPDATE `creature_template_locale` SET `Name` = '길들인 붉은색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4270;
-- AC datas : OLD Name : "갈색 늑대", Name AC enUS : "Brown Wolf" ; Wowhead enUS : "Brown Wolf"
UPDATE `creature_template_locale` SET `Name` = '길들인 암갈색 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4272;
-- AC datas : OLD Name : "붉은십자군 기원사", Name AC enUS : "Scarlet Evoker" ; Wowhead enUS : "Scarlet Evoker"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 강령사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4289;
-- AC datas : OLD Name : "붉은십자군 방어병", Name AC enUS : "Scarlet Defender" ; Wowhead enUS : "Scarlet Defender"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4298;
-- AC datas : OLD Name : "붉은십자군 추적용 사냥개", Name AC enUS : "Scarlet Tracking Hound" ; Wowhead enUS : "Scarlet Tracking Hound"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 추적용 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4304;
-- AC datas : OLD Name : "콜카르 하이에나", Name AC enUS : "Kolkar Packhound" ; Wowhead enUS : "Kolkar Packhound"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4316;
-- AC datas : OLD Name : "[미사용]니세", Name AC enUS : "Nyse" ; Wowhead enUS : "Nyse"
UPDATE `creature_template_locale` SET `Name` = '니세', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4317;
-- AC datas : OLD Name : "[미사용]티시아나", Name AC enUS : "Thyssiana" ; Wowhead enUS : "Thyssiana"
UPDATE `creature_template_locale` SET `Name` = '티시아나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4319;
-- AC datas : OLD Name : "화염갈기혈족 잿불꼬리", Name AC enUS : "Firemane Ash Tail" ; Wowhead enUS : "Firemane Ash Tail"
UPDATE `creature_template_locale` SET `Name` = '화염갈기혈족 불꽃술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4331;
-- AC datas : OLD Name : "진흙아가미 보초", Name AC enUS : "Mirefin Puddlejumper" ; Wowhead enUS : "Mirefin Puddlejumper"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4358;
-- AC datas : OLD Name : "진흙아가미 멀록", Name AC enUS : "Mirefin Murloc" ; Wowhead enUS : "Mirefin Murloc"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4359;
-- AC datas : OLD Name : "진흙아가미 전사", Name AC enUS : "Mirefin Warrior" ; Wowhead enUS : "Mirefin Warrior"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4360;
-- AC datas : OLD Name : "진흙아가미 땅꾼", Name AC enUS : "Mirefin Muckdweller" ; Wowhead enUS : "Mirefin Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4361;
-- AC datas : OLD Name : "진흙아가미 길잡이", Name AC enUS : "Mirefin Coastrunner" ; Wowhead enUS : "Mirefin Coastrunner"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4362;
-- AC datas : OLD Name : "진흙아가미 점쟁이", Name AC enUS : "Mirefin Oracle" ; Wowhead enUS : "Mirefin Oracle"
UPDATE `creature_template_locale` SET `Name` = '진흙아가미멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4363;
-- AC datas : OLD Name : "암흑안개거미", Name AC enUS : "Darkmist Spider" ; Wowhead enUS : "Darkmist Spider"
UPDATE `creature_template_locale` SET `Name` = '암흑안개 거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4376;
-- AC datas : OLD Name : "그늘 암흑안개거미", Name AC enUS : "Darkmist Recluse" ; Wowhead enUS : "Darkmist Recluse"
UPDATE `creature_template_locale` SET `Name` = '암흑안개 그늘거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4378;
-- AC datas : OLD Name : "비단 암흑안개거미", Name AC enUS : "Darkmist Silkspinner" ; Wowhead enUS : "Darkmist Silkspinner"
UPDATE `creature_template_locale` SET `Name` = '암흑안개 비단거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4379;
-- AC datas : OLD Name : "과부 암흑안개거미", Name AC enUS : "Darkmist Widow" ; Wowhead enUS : "Darkmist Widow"
UPDATE `creature_template_locale` SET `Name` = '암흑안개 과부거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4380;
-- AC datas : OLD Name : "경주진행자 크롱크라이더", Name AC enUS : "Race Master Kronkrider" ; Wowhead enUS : "Race Master Kronkrider"
UPDATE `creature_template_locale` SET `Name` = '경주진행자 크론크라이더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4419;
-- AC datas : OLD Name : "다르나서스 수호정령", Name AC enUS : "Darnassian Protector" ; Wowhead enUS : "Darnassian Protector"
UPDATE `creature_template_locale` SET `Name` = '나이트 엘프 수호정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4423;
-- AC datas : OLD Name : "아겜 쏜커스", Name AC enUS : "Aggem Thorncurse" ; Wowhead enUS : "Aggem Thorncurse"
UPDATE `creature_template_locale` SET `Name` = '저주의가시 아겜', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4424;
-- AC datas : OLD Name : "죽음예언자 잘그바", Name AC enUS : "Death Speaker Jargba" ; Wowhead enUS : "Death Speaker Jargba"
UPDATE `creature_template_locale` SET `Name` = '죽음의예언자 잘그바', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4428;
-- AC datas : OLD Name : "가시덩굴 전사", Name AC enUS : "Razorfen Warrior" ; Wowhead enUS : "Razorfen Warrior"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4435;
-- AC datas : OLD Name : "가시덩굴 가시경비병", Name AC enUS : "Razorfen Quilguard" ; Wowhead enUS : "Razorfen Quilguard"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 가시경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4436;
-- AC datas : OLD Name : "가시덩굴 문지기", Name AC enUS : "Razorfen Warden" ; Wowhead enUS : "Razorfen Warden"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 문지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4437;
-- AC datas : OLD Name : "가시덩굴 가시근위병", Name AC enUS : "Razorfen Spearhide" ; Wowhead enUS : "Razorfen Spearhide"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 가시근위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4438;
-- AC datas : OLD Name : "가시덩굴 토템술사", Name AC enUS : "Razorfen Totemic" ; Wowhead enUS : "Razorfen Totemic"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4440;
-- AC datas : OLD Name : "가시덩굴 파수병", Name AC enUS : "Razorfen Defender" ; Wowhead enUS : "Razorfen Defender"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4442;
-- AC datas : OLD Name : "죽음추적자 빈센트", Name AC enUS : "Deathstalker Vincent" ; Wowhead enUS : "Deathstalker Vincent"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 빈센트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4444;
-- AC datas : OLD Subname : "경주 상인", Subname AC enUS : "Race Vendor" ; Wowhead enUS : "Race Vendor"
UPDATE `creature_template_locale` SET `Title` = '상품권 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4445;
-- AC datas : OLD Subname : "경주 상인", Subname AC enUS : "Race Vendor" ; Wowhead enUS : "Race Vendor"
UPDATE `creature_template_locale` SET `Title` = '상품권 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4446;
-- AC datas : OLD Name : "크래즐 스프리스프로켓", Name AC enUS : "Crazzle Sprysprocket" ; Wowhead enUS : "Crazzle Sprysprocket"
UPDATE `creature_template_locale` SET `Name` = '그레즐 스프리스프로켓', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4449;
-- AC datas : OLD Name : "검은아가미 채집꾼", Name AC enUS : "Murkgill Forager" ; Wowhead enUS : "Murkgill Forager"
UPDATE `creature_template_locale` SET `Name` = '검은아가미멀록 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4457;
-- AC datas : OLD Name : "검은아가미 사냥꾼", Name AC enUS : "Murkgill Hunter" ; Wowhead enUS : "Murkgill Hunter"
UPDATE `creature_template_locale` SET `Name` = '검은아가미멀록 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4458;
-- AC datas : OLD Name : "검은아가미 점쟁이", Name AC enUS : "Murkgill Oracle" ; Wowhead enUS : "Murkgill Oracle"
UPDATE `creature_template_locale` SET `Name` = '검은아가미멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4459;
-- AC datas : OLD Name : "검은아가미 혹한술사", Name AC enUS : "Murkgill Lord" ; Wowhead enUS : "Murkgill Lord"
UPDATE `creature_template_locale` SET `Name` = '검은아가미멀록 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4460;
-- AC datas : OLD Name : "검은아가미 전사", Name AC enUS : "Murkgill Warrior" ; Wowhead enUS : "Murkgill Warrior"
UPDATE `creature_template_locale` SET `Name` = '검은아가미멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4461;
-- AC datas : OLD Name : "검은바위 사냥꾼", Name AC enUS : "Blackrock Hunter" ; Wowhead enUS : "Blackrock Hunter"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4462;
-- AC datas : OLD Name : "검은바위 소환사", Name AC enUS : "Blackrock Summoner" ; Wowhead enUS : "Blackrock Summoner"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4463;
-- AC datas : OLD Name : "검은바위 검투사", Name AC enUS : "Blackrock Gladiator" ; Wowhead enUS : "Blackrock Gladiator"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 검투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4464;
-- AC datas : OLD Name : "썩은가지 전사", Name AC enUS : "Vilebranch Warrior" ; Wowhead enUS : "Vilebranch Warrior"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4465;
-- AC datas : OLD Name : "썩은가지 무두장이", Name AC enUS : "Vilebranch Scalper" ; Wowhead enUS : "Vilebranch Scalper"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 무두장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4466;
-- AC datas : OLD Name : "썩은가지 예언자", Name AC enUS : "Vilebranch Soothsayer" ; Wowhead enUS : "Vilebranch Soothsayer"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4467;
-- AC datas : OLD Name : "음산한 환영", Name AC enUS : "Haunting Vision" ; Wowhead enUS : "Haunting Vision"
UPDATE `creature_template_locale` SET `Name` = '오싹한 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4472;
-- AC datas : OLD Name : "절규하는 귀신", Name AC enUS : "Screaming Haunt" ; Wowhead enUS : "Screaming Haunt"
UPDATE `creature_template_locale` SET `Name` = '절규하는 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4476;
-- AC datas : OLD Name : "마르셀 다비리", Name AC enUS : "Marcel Dabyrie" ; Wowhead enUS : "Marcel Dabyrie"
UPDATE `creature_template_locale` SET `Name` = '마셸 다비리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4481;
-- AC datas : OLD Name : "썩은가지 늑대", Name AC enUS : "Vilebranch Wolf" ; Wowhead enUS : "Vilebranch Wolf"
UPDATE `creature_template_locale` SET `Name` = '썩은가지일족 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4482;
-- AC datas : OLD Name : "피이로 아이언핸드", Name AC enUS : "Feero Ironhand" ; Wowhead enUS : "Feero Ironhand"
UPDATE `creature_template_locale` SET `Name` = '피로 아이언핸드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4484;
-- AC datas : OLD Name : "가시덩굴 흙점쟁이", Name AC enUS : "Razorfen Geomancer" ; Wowhead enUS : "Razorfen Geomancer"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4520;
-- AC datas : OLD Name : "가시덩굴 먼지술사", Name AC enUS : "Razorfen Dustweaver" ; Wowhead enUS : "Razorfen Dustweaver"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 먼지술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4522;
-- AC datas : OLD Name : "가시덩굴 지진술사", Name AC enUS : "Razorfen Groundshaker" ; Wowhead enUS : "Razorfen Groundshaker"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 지진술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4523;
-- AC datas : OLD Name : "가시덩굴 대지술사", Name AC enUS : "Razorfen Earthbreaker" ; Wowhead enUS : "Razorfen Earthbreaker"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 대지술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4525;
-- AC datas : OLD Name : "가시덩굴 조련사", Name AC enUS : "Razorfen Handler" ; Wowhead enUS : "Razorfen Handler"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4530;
-- AC datas : OLD Name : "가시덩굴 사냥꾼", Name AC enUS : "Razorfen Beast Trainer" ; Wowhead enUS : "Razorfen Beast Trainer"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4531;
-- AC datas : OLD Name : "가시덩굴 야수조련사", Name AC enUS : "Razorfen Beastmaster" ; Wowhead enUS : "Razorfen Beastmaster"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 야수조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4532;
-- AC datas : OLD Name : "윌리엄 몬테규", Name AC enUS : "William Montague" ; Wowhead enUS : "William Montague"
UPDATE `creature_template_locale` SET `Name` = '윌리엄 몬테그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4549;
-- AC datas : OLD Name : "오필리아 몬테규", Name AC enUS : "Ophelia Montague" ; Wowhead enUS : "Ophelia Montague"
UPDATE `creature_template_locale` SET `Name` = '오펠리아 몬테그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4550;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4552;
-- AC datas : OLD Name : "고든 웬드햄", Name AC enUS : "Gordon Wendham" ; Wowhead enUS : "Gordon Wendham"
UPDATE `creature_template_locale` SET `Name` = '고든 웬드헴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4556;
-- AC datas : OLD Name : "리처드 켈윈", Name AC enUS : "Richard Kerwin" ; Wowhead enUS : "Richard Kerwin"
UPDATE `creature_template_locale` SET `Name` = '리차드 켈윈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4565;
-- AC datas : OLD Name : "찰스 시톤", Name AC enUS : "Charles Seaton" ; Wowhead enUS : "Charles Seaton"
UPDATE `creature_template_locale` SET `Name` = '탈리스 시톤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4569;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Master Shadoweave Tailor" ; Wowhead enUS : "Master Shadoweave Tailor"
UPDATE `creature_template_locale` SET `Title` = '그림자매듭 재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4578;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cartography Trainer" ; Wowhead enUS : "Cartography Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 지도제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4579;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4586;
-- AC datas : OLD Subname : "수습 대장장이", Subname AC enUS : "Apprentice Blacksmith" ; Wowhead enUS : "Apprentice Blacksmith"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4605;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4615;
-- AC datas : OLD Name : "라비니아 크로", Name AC enUS : "Lavinia Crowe" ; Wowhead enUS : "Lavinia Crowe"
UPDATE `creature_template_locale` SET `Name` = '라비니아 크로위', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4616;
-- AC datas : OLD Subname : "", Subname AC enUS : "Raptor Trainer" ; Wowhead enUS : "Raptor Trainer"
UPDATE `creature_template_locale` SET `Title` = '랩터 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4621;
-- AC datas : OLD Name : "아루갈의 공허방랑자", Name AC enUS : "Arugal's Voidwalker" ; Wowhead enUS : "Arugal's Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '아루갈의 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4627;
-- AC datas : OLD Name : "콜카르 척후병", Name AC enUS : "Kolkar Scout" ; Wowhead enUS : "Kolkar Scout"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4633;
-- AC datas : OLD Name : "콜카르 투사", Name AC enUS : "Kolkar Mauler" ; Wowhead enUS : "Kolkar Mauler"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4634;
-- AC datas : OLD Name : "콜카르 바람전사", Name AC enUS : "Kolkar Windchaser" ; Wowhead enUS : "Kolkar Windchaser"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 바람전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4635;
-- AC datas : OLD Name : "콜카르 전투대장", Name AC enUS : "Kolkar Battle Lord" ; Wowhead enUS : "Kolkar Battle Lord"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 전투대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4636;
-- AC datas : OLD Name : "콜카르 파괴자", Name AC enUS : "Kolkar Destroyer" ; Wowhead enUS : "Kolkar Destroyer"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4637;
-- AC datas : OLD Name : "마그람 척후병", Name AC enUS : "Magram Scout" ; Wowhead enUS : "Magram Scout"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4638;
-- AC datas : OLD Name : "마그람 정찰꾼", Name AC enUS : "Magram Outrunner" ; Wowhead enUS : "Magram Outrunner"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4639;
-- AC datas : OLD Name : "마그람 사냥꾼", Name AC enUS : "Magram Wrangler" ; Wowhead enUS : "Magram Wrangler"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4640;
-- AC datas : OLD Name : "마그람 바람전사", Name AC enUS : "Magram Windchaser" ; Wowhead enUS : "Magram Windchaser"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 바람전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4641;
-- AC datas : OLD Name : "마그람 번개술사", Name AC enUS : "Magram Stormer" ; Wowhead enUS : "Magram Stormer"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 번개술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4642;
-- AC datas : OLD Name : "마그람 조련사", Name AC enUS : "Magram Pack Runner" ; Wowhead enUS : "Magram Pack Runner"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4643;
-- AC datas : OLD Name : "마그람 약탈자", Name AC enUS : "Magram Marauder" ; Wowhead enUS : "Magram Marauder"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4644;
-- AC datas : OLD Name : "마그람 투사", Name AC enUS : "Magram Mauler" ; Wowhead enUS : "Magram Mauler"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4645;
-- AC datas : OLD Name : "겔키스 정찰꾼", Name AC enUS : "Gelkis Outrunner" ; Wowhead enUS : "Gelkis Outrunner"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4646;
-- AC datas : OLD Name : "겔키스 척후병", Name AC enUS : "Gelkis Scout" ; Wowhead enUS : "Gelkis Scout"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4647;
-- AC datas : OLD Name : "겔키스 곤봉잡이", Name AC enUS : "Gelkis Stamper" ; Wowhead enUS : "Gelkis Stamper"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 곤봉잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4648;
-- AC datas : OLD Name : "겔키스 바람전사", Name AC enUS : "Gelkis Windchaser" ; Wowhead enUS : "Gelkis Windchaser"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 바람전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4649;
-- AC datas : OLD Name : "겔키스 대지술사", Name AC enUS : "Gelkis Earthcaller" ; Wowhead enUS : "Gelkis Earthcaller"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 대지술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4651;
-- AC datas : OLD Name : "겔키스 투사", Name AC enUS : "Gelkis Mauler" ; Wowhead enUS : "Gelkis Mauler"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4652;
-- AC datas : OLD Name : "겔키스 약탈자", Name AC enUS : "Gelkis Marauder" ; Wowhead enUS : "Gelkis Marauder"
UPDATE `creature_template_locale` SET `Name` = '겔키스일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4653;
-- AC datas : OLD Name : "마라우돈 척후병", Name AC enUS : "Maraudine Scout" ; Wowhead enUS : "Maraudine Scout"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4654;
-- AC datas : OLD Name : "마라우돈 사냥꾼", Name AC enUS : "Maraudine Wrangler" ; Wowhead enUS : "Maraudine Wrangler"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4655;
-- AC datas : OLD Name : "마라우돈 투사", Name AC enUS : "Maraudine Mauler" ; Wowhead enUS : "Maraudine Mauler"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4656;
-- AC datas : OLD Name : "마라우돈 바람전사", Name AC enUS : "Maraudine Windchaser" ; Wowhead enUS : "Maraudine Windchaser"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 바람전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4657;
-- AC datas : OLD Name : "마라우돈 번개술사", Name AC enUS : "Maraudine Stormer" ; Wowhead enUS : "Maraudine Stormer"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 번개술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4658;
-- AC datas : OLD Name : "마라우돈 약탈자", Name AC enUS : "Maraudine Marauder" ; Wowhead enUS : "Maraudine Marauder"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4659;
-- AC datas : OLD Name : "마라우돈 하이에나", Name AC enUS : "Maraudine Bonepaw" ; Wowhead enUS : "Maraudine Bonepaw"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4660;
-- AC datas : OLD Name : "마그람 하이에나", Name AC enUS : "Magram Bonepaw" ; Wowhead enUS : "Magram Bonepaw"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4662;
-- AC datas : OLD Name : "마라우돈 조련사", Name AC enUS : "Maraudine Pack Runner" ; Wowhead enUS : "Maraudine Pack Runner"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4704;
-- AC datas : OLD Name : "뱀갈퀴 나가", Name AC enUS : "Slitherblade Naga" ; Wowhead enUS : "Slitherblade Naga"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 나가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4711;
-- AC datas : OLD Name : "뱀갈퀴 여마법사", Name AC enUS : "Slitherblade Sorceress" ; Wowhead enUS : "Slitherblade Sorceress"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4712;
-- AC datas : OLD Name : "뱀갈퀴 전사", Name AC enUS : "Slitherblade Warrior" ; Wowhead enUS : "Slitherblade Warrior"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4713;
-- AC datas : OLD Name : "뱀갈퀴 미르미돈", Name AC enUS : "Slitherblade Myrmidon" ; Wowhead enUS : "Slitherblade Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4714;
-- AC datas : OLD Name : "뱀갈퀴 가시전사", Name AC enUS : "Slitherblade Razortail" ; Wowhead enUS : "Slitherblade Razortail"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 가시전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4715;
-- AC datas : OLD Name : "뱀갈퀴 바다사냥꾼", Name AC enUS : "Slitherblade Tidehunter" ; Wowhead enUS : "Slitherblade Tidehunter"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 바다사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4716;
-- AC datas : OLD Name : "뱀갈퀴 해일여사제", Name AC enUS : "Slitherblade Tide Priestess" ; Wowhead enUS : "Slitherblade Tide Priestess"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 바다여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4717;
-- AC datas : OLD Name : "뱀갈퀴 예언자", Name AC enUS : "Slitherblade Oracle" ; Wowhead enUS : "Slitherblade Oracle"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4718;
-- AC datas : OLD Name : "뱀갈퀴 바다 마녀", Name AC enUS : "Slitherblade Sea Witch" ; Wowhead enUS : "Slitherblade Sea Witch"
UPDATE `creature_template_locale` SET `Name` = '뱀갈퀴일족 바다마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4719;
-- AC datas : OLD Name : "흉포한 천둥도마뱀", Name AC enUS : "Raging Thunder Lizard" ; Wowhead enUS : "Raging Thunder Lizard"
UPDATE `creature_template_locale` SET `Name` = '흉포한 번개도마뱀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4726;
-- AC datas : OLD Name : "덩치 큰 천둥도마뱀", Name AC enUS : "Elder Thunder Lizard" ; Wowhead enUS : "Elder Thunder Lizard"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 번개도마뱀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4727;
-- AC datas : OLD Name : "모래턱바실리스크", Name AC enUS : "Gritjaw Basilisk" ; Wowhead enUS : "Gritjaw Basilisk"
UPDATE `creature_template_locale` SET `Name` = '모래턱 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4728;
-- AC datas : OLD Name : "덩치 큰 모래턱바실리스크", Name AC enUS : "Hulking Gritjaw Basilisk" ; Wowhead enUS : "Hulking Gritjaw Basilisk"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 모래턱 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4729;
-- AC datas : OLD Name : "서리 산양", Name AC enUS : "Frost Ram" ; Wowhead enUS : "Frost Ram"
UPDATE `creature_template_locale` SET `Name` = '길들인 푸른 산양', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4778;
-- AC datas : OLD Name : "검은 산양", Name AC enUS : "Black Ram" ; Wowhead enUS : "Black Ram"
UPDATE `creature_template_locale` SET `Name` = '길들인 검은 산양', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4780;
-- AC datas : OLD Name : "악몽마의 환영", Name AC enUS : "Illusionary Nightmare" ; Wowhead enUS : "Illusionary Nightmare"
UPDATE `creature_template_locale` SET `Name` = '나이트메어의 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4785;
-- AC datas : OLD Name : "정찰병 타엘리드", Name AC enUS : "Argent Guard Thaelrid" ; Wowhead enUS : "Argent Guard Thaelrid",  OLD Subname : "", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Name` = '은빛경비병 타엘리드', `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4787;
-- AC datas : OLD Name : "검은심연 해일여사제", Name AC enUS : "Blackfathom Tide Priestess" ; Wowhead enUS : "Blackfathom Tide Priestess"
UPDATE `creature_template_locale` SET `Name` = '검은심연의 바다여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4802;
-- AC datas : OLD Name : "검은심연 예언자", Name AC enUS : "Blackfathom Oracle" ; Wowhead enUS : "Blackfathom Oracle"
UPDATE `creature_template_locale` SET `Name` = '검은심연의 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4803;
-- AC datas : OLD Name : "검은심연 바다 마녀", Name AC enUS : "Blackfathom Sea Witch" ; Wowhead enUS : "Blackfathom Sea Witch"
UPDATE `creature_template_locale` SET `Name` = '검은심연의 바다마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4805;
-- AC datas : OLD Name : "검은심연 미르미돈", Name AC enUS : "Blackfathom Myrmidon" ; Wowhead enUS : "Blackfathom Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '검은심연의 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4807;
-- AC datas : OLD Name : "황혼의 수행사제", Name AC enUS : "Twilight Acolyte" ; Wowhead enUS : "Twilight Acolyte"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 수행사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4809;
-- AC datas : OLD Name : "황혼의 약탈자", Name AC enUS : "Twilight Reaver" ; Wowhead enUS : "Twilight Reaver"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4810;
-- AC datas : OLD Name : "황혼의 정령사", Name AC enUS : "Twilight Aquamancer" ; Wowhead enUS : "Twilight Aquamancer"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 정령사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4811;
-- AC datas : OLD Name : "황혼의 진리탐구자", Name AC enUS : "Twilight Loreseeker" ; Wowhead enUS : "Twilight Loreseeker"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 진리탐구자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4812;
-- AC datas : OLD Name : "황혼의 흑마법사", Name AC enUS : "Twilight Shadowmage" ; Wowhead enUS : "Twilight Shadowmage"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4813;
-- AC datas : OLD Name : "황혼의 정령술사", Name AC enUS : "Twilight Elementalist" ; Wowhead enUS : "Twilight Elementalist"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 원소마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4814;
-- AC datas : OLD Name : "유리비늘 멀록", Name AC enUS : "Blindlight Murloc" ; Wowhead enUS : "Blindlight Murloc"
UPDATE `creature_template_locale` SET `Name` = '유리비늘멀록 멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4818;
-- AC datas : OLD Name : "유리비늘 땅꾼", Name AC enUS : "Blindlight Muckdweller" ; Wowhead enUS : "Blindlight Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '유리비늘멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4819;
-- AC datas : OLD Name : "유리비늘 점쟁이", Name AC enUS : "Blindlight Oracle" ; Wowhead enUS : "Blindlight Oracle"
UPDATE `creature_template_locale` SET `Name` = '유리비늘멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4820;
-- AC datas : OLD Name : "테라모어 침투요원", Name AC enUS : "Theramore Infiltrator" ; Wowhead enUS : "Theramore Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '테라모어 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4834;
-- AC datas : OLD Name : "어둠괴철로 감독관", Name AC enUS : "Shadowforge Surveyor" ; Wowhead enUS : "Shadowforge Surveyor"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4844;
-- AC datas : OLD Name : "어둠괴철로 악당", Name AC enUS : "Shadowforge Ruffian" ; Wowhead enUS : "Shadowforge Ruffian"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 악당', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4845;
-- AC datas : OLD Name : "어둠괴철로 채굴꾼", Name AC enUS : "Shadowforge Digger" ; Wowhead enUS : "Shadowforge Digger"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4846;
-- AC datas : OLD Name : "어둠괴철로 보물사냥꾼", Name AC enUS : "Shadowforge Relic Hunter" ; Wowhead enUS : "Shadowforge Relic Hunter"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 보물사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4847;
-- AC datas : OLD Name : "어둠괴철로 흑마법사", Name AC enUS : "Shadowforge Darkcaster" ; Wowhead enUS : "Shadowforge Darkcaster"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4848;
-- AC datas : OLD Name : "어둠괴철로 고고학자", Name AC enUS : "Shadowforge Archaeologist" ; Wowhead enUS : "Shadowforge Archaeologist"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 고고학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4849;
-- AC datas : OLD Name : "바위동굴 잠복꾼", Name AC enUS : "Stonevault Cave Lurker" ; Wowhead enUS : "Stonevault Cave Lurker"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 잠복꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4850;
-- AC datas : OLD Name : "바위동굴 돌장이", Name AC enUS : "Stonevault Rockchewer" ; Wowhead enUS : "Stonevault Rockchewer"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 돌장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4851;
-- AC datas : OLD Name : "바위동굴 현자", Name AC enUS : "Stonevault Oracle" ; Wowhead enUS : "Stonevault Oracle"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 현자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4852;
-- AC datas : OLD Name : "바위동굴 흙점쟁이", Name AC enUS : "Stonevault Geomancer" ; Wowhead enUS : "Stonevault Geomancer"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4853;
-- AC datas : OLD Subname : "바위동굴 일족 족장", Subname AC enUS : "Stonevault Chieftain" ; Wowhead enUS : "Stonevault Chieftain"
UPDATE `creature_template_locale` SET `Title` = '바위동굴일족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4854;
-- AC datas : OLD Name : "바위동굴 투사", Name AC enUS : "Stonevault Brawler" ; Wowhead enUS : "Stonevault Brawler"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4855;
-- AC datas : OLD Name : "바위동굴 굴사냥꾼", Name AC enUS : "Stonevault Cave Hunter" ; Wowhead enUS : "Stonevault Cave Hunter"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 굴사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4856;
-- AC datas : OLD Name : "비취돌기바실리스크", Name AC enUS : "Jadespine Basilisk" ; Wowhead enUS : "Jadespine Basilisk"
UPDATE `creature_template_locale` SET `Name` = '비취돌기 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4863;
-- AC datas : OLD Subname : "현자", Subname AC enUS : "Lorekeeper" ; Wowhead enUS : "Lorekeeper"
UPDATE `creature_template_locale` SET `Title` = '마법재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4878;
-- AC datas : OLD Subname : "", Subname AC enUS : "Turtle Trainer" ; Wowhead enUS : "Turtle Trainer"
UPDATE `creature_template_locale` SET `Title` = '거북 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4881;
-- AC datas : OLD Subname : "갑옷 및 무기제작자", Subname AC enUS : "Armorer & Shieldsmith" ; Wowhead enUS : "Armorer & Shieldsmith"
UPDATE `creature_template_locale` SET `Title` = '갑옷 및 방패 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4886;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith" ; Wowhead enUS : "Weaponsmith"
UPDATE `creature_template_locale` SET `Title` = '무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4888;
-- AC datas : OLD Name : "옌센 파렌", Name AC enUS : "Jensen Farran" ; Wowhead enUS : "Jensen Farran",  OLD Subname : "상급 사냥꾼 및 활 상인", Subname AC enUS : "Bowyer" ; Wowhead enUS : "Bowyer"
UPDATE `creature_template_locale` SET `Name` = '젠센 파렌', `Title` = '활 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4892;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '음식 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4894;
-- AC datas : OLD Subname : "일용품 및 마법 재료 상인", Subname AC enUS : "General Goods" ; Wowhead enUS : "General Goods"
UPDATE `creature_template_locale` SET `Title` = '일용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4896;
-- AC datas : OLD Subname : "약초채집용품 및 연금술용품 상인", Subname AC enUS : "Herbalism & Alchemy Supplies" ; Wowhead enUS : "Herbalism & Alchemy Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4899;
-- AC datas : OLD Name : "물뱀", Name AC enUS : "Moccasin" ; Wowhead enUS : "Moccasin"
UPDATE `creature_template_locale` SET `Name` = '늪살모사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4953;
-- AC datas : OLD Name : "음산한 영혼", Name AC enUS : "Haunting Spirit" ; Wowhead enUS : "Haunting Spirit"
UPDATE `creature_template_locale` SET `Name` = '저주받은 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4958;
-- AC datas : OLD Name : "구 시가지 흉악범", Name AC enUS : "Old Town Thug" ; Wowhead enUS : "Old Town Thug"
UPDATE `creature_template_locale` SET `Name` = '구시가지 흉악범', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4969;
-- AC datas : OLD Subname : "", Subname AC enUS : "Wolf Pet Trainer" ; Wowhead enUS : "Wolf Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '늑대 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 4994;
-- AC datas : OLD Subname : "", Subname AC enUS : "Bird Pet Trainer" ; Wowhead enUS : "Bird Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '새 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5001;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cat Pet Trainer" ; Wowhead enUS : "Cat Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '살쾡이 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5003;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crawler Pet Trainer" ; Wowhead enUS : "Crawler Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '게 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5004;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crocodile Pet Trainer" ; Wowhead enUS : "Crocodile Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '악어 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5005;
-- AC datas : OLD Subname : "", Subname AC enUS : "" ; Wowhead enUS : ""
UPDATE `creature_template_locale` SET `Title` = '악마 훈련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5006;
-- AC datas : OLD Subname : "", Subname AC enUS : "Gorilla Pet Trainer" ; Wowhead enUS : "Gorilla Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '고릴라 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5008;
-- AC datas : OLD Subname : "", Subname AC enUS : "Horse Pet Trainer" ; Wowhead enUS : "Horse Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '마구간지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5009;
-- AC datas : OLD Subname : "", Subname AC enUS : "Raptor Pet Trainer" ; Wowhead enUS : "Raptor Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '랩터 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5011;
-- AC datas : OLD Subname : "", Subname AC enUS : "Scorpid Pet Trainer" ; Wowhead enUS : "Scorpid Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '전갈 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5012;
-- AC datas : OLD Subname : "", Subname AC enUS : "Spider Pet Trainer" ; Wowhead enUS : "Spider Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '거미 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5013;
-- AC datas : OLD Subname : "", Subname AC enUS : "Tallstrider Pet Trainer" ; Wowhead enUS : "Tallstrider Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '타조 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5015;
-- AC datas : OLD Name : "공용 공허방랑자 트레이너", Name AC enUS : "World Voidwalker Trainer" ; Wowhead enUS : "World Voidwalker Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 보이드워커 트레이너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5016;
-- AC datas : OLD Subname : "", Subname AC enUS : "Turtle Pet Trainer" ; Wowhead enUS : "Turtle Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '거북 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5017;
-- AC datas : OLD Name : "공용 차원문: 다르나서스 트레이너", Name AC enUS : "World Portal: Darnassus Trainer" ; Wowhead enUS : "World Portal: Darnassus Trainer",  OLD Subname : "차원문: 다르나서스", Subname AC enUS : "Portal: Darnassus Trainer" ; Wowhead enUS : "Portal: Darnassus Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 다르나서스 트레이너', `Title` = '차원의 문: 다르나서스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5018;
-- AC datas : OLD Name : "공용 차원문: 아이언포지 트레이너", Name AC enUS : "World Portal: Ironforge Trainer" ; Wowhead enUS : "World Portal: Ironforge Trainer",  OLD Subname : "차원문: 아이언포지", Subname AC enUS : "Portal: Ironforge Trainer" ; Wowhead enUS : "Portal: Ironforge Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 아이언포지 트레이너', `Title` = '차원의 문: 아이언포지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5019;
-- AC datas : OLD Name : "공용 차원문: 오그리마 트레이너", Name AC enUS : "World Portal: Orgrimmar Trainer" ; Wowhead enUS : "World Portal: Orgrimmar Trainer",  OLD Subname : "차원문: 오그리마", Subname AC enUS : "Portal: Orgrimmar Trainer" ; Wowhead enUS : "Portal: Orgrimmar Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 오그리마 트레이너', `Title` = '차원의 문: 오그리마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5020;
-- AC datas : OLD Name : "공용 차원문: 스톰윈드 트레이너", Name AC enUS : "World Portal: Stormwind Trainer" ; Wowhead enUS : "World Portal: Stormwind Trainer",  OLD Subname : "차원문: 스톰윈드", Subname AC enUS : "Portal: Stormwind Trainer" ; Wowhead enUS : "Portal: Stormwind Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 스톰윈드 트레이너', `Title` = '차원의 문: 스톰윈드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5021;
-- AC datas : OLD Name : "공용 차원문: 썬더 블러프 트레이너", Name AC enUS : "World Portal: Thunder Bluff Trainer" ; Wowhead enUS : "World Portal: Thunder Bluff Trainer",  OLD Subname : "차원문: 썬더 블러프", Subname AC enUS : "Portal: Thunder Bluff Trainer" ; Wowhead enUS : "Portal: Thunder Bluff Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 썬더 블러프 트레이너', `Title` = '차원의 문: 썬더 블러프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5022;
-- AC datas : OLD Name : "공용 차원문: 언더시티 트레이너", Name AC enUS : "World Portal: Undercity Trainer" ; Wowhead enUS : "World Portal: Undercity Trainer",  OLD Subname : "차원문: 언더시티", Subname AC enUS : "Portal: Undercity Trainer" ; Wowhead enUS : "Portal: Undercity Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 차원의 문: 언더시티 트레이너', `Title` = '차원의 문: 언더시티', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5023;
-- AC datas : OLD Subname : "", Subname AC enUS : "Horse Riding Trainer" ; Wowhead enUS : "Horse Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 승마 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5026;
-- AC datas : OLD Name : "[임시] 모구 고통 방벽", Name AC enUS : "World Lockpicking Trainer" ; Wowhead enUS : "World Lockpicking Trainer",  OLD Subname : "", Subname AC enUS : "Lockpicking Trainer" ; Wowhead enUS : "Lockpicking Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 자물쇠따기 트레이너', `Title` = '자물쇠 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5027;
-- AC datas : OLD Name : "지밍", Name AC enUS : "World Survival Trainer" ; Wowhead enUS : "World Survival Trainer",  OLD Subname : "", Subname AC enUS : "Survival Trainer" ; Wowhead enUS : "Survival Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 야영 전문가', `Title` = '야영 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5029;
-- AC datas : OLD Subname : "", Subname AC enUS : "Tiger Riding Trainer" ; Wowhead enUS : "Tiger Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 호랑이 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5030;
-- AC datas : OLD Name : "윈와", Name AC enUS : "World Brewing Trainer" ; Wowhead enUS : "World Brewing Trainer",  OLD Subname : "", Subname AC enUS : "Brewing Trainer" ; Wowhead enUS : "Brewing Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 전문 양조장이', `Title` = '전문 양조장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5034;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cartography Trainer" ; Wowhead enUS : "Cartography Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 지도제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5035;
-- AC datas : OLD Name : "공용 전문 기계공학자", Name AC enUS : "World Engineering Trainer" ; Wowhead enUS : "World Engineering Trainer",  OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 전문 기술자', `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5037;
-- AC datas : OLD Name : "공용 상급 흑마법사 미사용", Name AC enUS : "World Tracking Trainer" ; Wowhead enUS : "World Tracking Trainer",  OLD Subname : "상급 흑마법사", Subname AC enUS : "Tracking Trainer" ; Wowhead enUS : "Tracking Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 추적 전문가', `Title` = '추적 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5039;
-- AC datas : OLD Name : "폭도", Name AC enUS : "Defias Rioter" ; Wowhead enUS : "Defias Rioter"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 폭도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5043;
-- AC datas : OLD Name : "리사 스틸브라우", Name AC enUS : "Lyesa Steelbrow" ; Wowhead enUS : "Lyesa Steelbrow"
UPDATE `creature_template_locale` SET `Name` = '리사 스틸브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5049;
-- AC datas : OLD Name : "경리 렌드리", Name AC enUS : "Clerk Lendry" ; Wowhead enUS : "Clerk Lendry"
UPDATE `creature_template_locale` SET `Name` = '서기관 렌드리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5083;
-- AC datas : OLD Name : "경비병 다오", Name AC enUS : "Guard Lana" ; Wowhead enUS : "Guard Lana"
UPDATE `creature_template_locale` SET `Name` = '경비병 라나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5092;
-- AC datas : OLD Name : "경비병 브란스키", Name AC enUS : "Guard Narrisha" ; Wowhead enUS : "Guard Narrisha"
UPDATE `creature_template_locale` SET `Name` = '경비병 나리샤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5093;
-- AC datas : OLD Subname : "", Subname AC enUS : "Gun Trainer" ; Wowhead enUS : "Gun Trainer"
UPDATE `creature_template_locale` SET `Title` = '총기류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5104;
-- AC datas : OLD Name : "욘도르 스틸브라우", Name AC enUS : "Jondor Steelbrow" ; Wowhead enUS : "Jondor Steelbrow"
UPDATE `creature_template_locale` SET `Name` = '욘도르 스틸브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5130;
-- AC datas : OLD Name : "하릭 볼더드럼", Name AC enUS : "Harick Boulderdrum" ; Wowhead enUS : "Harick Boulderdrum"
UPDATE `creature_template_locale` SET `Name` = '하릭 보울더드럼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5133;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5138;
-- AC datas : OLD Name : "쿠르드룸 발리비어드", Name AC enUS : "Kurdrum Barleybeard" ; Wowhead enUS : "Kurdrum Barleybeard",  OLD Subname : "마법 재료 및 독극물 상인", Subname AC enUS : "Reagents & Poison Supplies" ; Wowhead enUS : "Reagents & Poison Supplies"
UPDATE `creature_template_locale` SET `Name` = '쿠르트룸 발리비어드', `Title` = '마법 및 독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5139;
-- AC datas : OLD Name : "벨드룩 둠브라우", Name AC enUS : "Beldruk Doombrow" ; Wowhead enUS : "Beldruk Doombrow"
UPDATE `creature_template_locale` SET `Name` = '벨드룩 둠브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5148;
-- AC datas : OLD Name : "요르문트 스톤브라우", Name AC enUS : "Jormund Stonebrow" ; Wowhead enUS : "Jormund Stonebrow"
UPDATE `creature_template_locale` SET `Name` = '요르문트 스톤브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5153;
-- AC datas : OLD Name : "잉그리스 스톤브라우", Name AC enUS : "Ingrys Stonebrow" ; Wowhead enUS : "Ingrys Stonebrow"
UPDATE `creature_template_locale` SET `Name` = '잉그리스 스톤브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5155;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5159;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmith Trainer" ; Wowhead enUS : "Armorsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5164;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5174;
-- AC datas : OLD Name : "남쪽바다 대포", Name AC enUS : "Southsea Cannon" ; Wowhead enUS : "Southsea Cannon"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 대포', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5187;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5188;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5189;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5190;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5191;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5192;
-- AC datas : OLD Subname : "휘장 도안가", Subname AC enUS : "Tabard Designer" ; Wowhead enUS : "Tabard Designer"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 도안가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5193;
-- AC datas : OLD Name : "간호병 쟈노", Name AC enUS : "Medic Tamberlyn" ; Wowhead enUS : "Medic Tamberlyn"
UPDATE `creature_template_locale` SET `Name` = '간호병 탬버린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5199;
-- AC datas : OLD Name : "간호병 지유스", Name AC enUS : "Medic Helaina" ; Wowhead enUS : "Medic Helaina"
UPDATE `creature_template_locale` SET `Name` = '간호병 헬라이나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5200;
-- AC datas : OLD Name : "골두니 집행자", Name AC enUS : "Gordunni Enforcer" ; Wowhead enUS : "Gordunni Enforcer"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5231;
-- AC datas : OLD Name : "골두니 투사", Name AC enUS : "Gordunni Brute" ; Wowhead enUS : "Gordunni Brute"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5232;
-- AC datas : OLD Name : "골두니 싸움꾼", Name AC enUS : "Gordunni Mauler" ; Wowhead enUS : "Gordunni Mauler"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5234;
-- AC datas : OLD Name : "골두니 주술사", Name AC enUS : "Gordunni Shaman" ; Wowhead enUS : "Gordunni Shaman"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5236;
-- AC datas : OLD Name : "골두니 오우거 마법사", Name AC enUS : "Gordunni Ogre Mage" ; Wowhead enUS : "Gordunni Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 오우거 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5237;
-- AC datas : OLD Name : "골두니 사령관", Name AC enUS : "Gordunni Battlemaster" ; Wowhead enUS : "Gordunni Battlemaster"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5238;
-- AC datas : OLD Name : "골두니 대마법사", Name AC enUS : "Gordunni Mage-Lord" ; Wowhead enUS : "Gordunni Mage-Lord"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 대마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5239;
-- AC datas : OLD Name : "골두니 흑마법사", Name AC enUS : "Gordunni Warlock" ; Wowhead enUS : "Gordunni Warlock"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5240;
-- AC datas : OLD Name : "골두니 장군", Name AC enUS : "Gordunni Warlord" ; Wowhead enUS : "Gordunni Warlord"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 장군', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5241;
-- AC datas : OLD Name : "덩굴발 싸움꾼", Name AC enUS : "Woodpaw Mongrel" ; Wowhead enUS : "Woodpaw Mongrel"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5249;
-- AC datas : OLD Name : "덩굴발 덫사냥꾼", Name AC enUS : "Woodpaw Trapper" ; Wowhead enUS : "Woodpaw Trapper"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 덫사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5251;
-- AC datas : OLD Name : "덩굴발 투사", Name AC enUS : "Woodpaw Brute" ; Wowhead enUS : "Woodpaw Brute"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5253;
-- AC datas : OLD Name : "덩굴발 비술사", Name AC enUS : "Woodpaw Mystic" ; Wowhead enUS : "Woodpaw Mystic"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5254;
-- AC datas : OLD Name : "덩굴발 약탈꾼", Name AC enUS : "Woodpaw Reaver" ; Wowhead enUS : "Woodpaw Reaver"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5255;
-- AC datas : OLD Name : "아탈라이 전사", Name AC enUS : "Atal'ai Warrior" ; Wowhead enUS : "Atal'ai Warrior"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5256;
-- AC datas : OLD Name : "덩굴발 우두머리", Name AC enUS : "Woodpaw Alpha" ; Wowhead enUS : "Woodpaw Alpha"
UPDATE `creature_template_locale` SET `Name` = '덩굴발일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5258;
-- AC datas : OLD Name : "아탈라이 의술사", Name AC enUS : "Atal'ai Witch Doctor" ; Wowhead enUS : "Atal'ai Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5259;
-- AC datas : OLD Name : "아탈라이 사제", Name AC enUS : "Atal'ai Priest" ; Wowhead enUS : "Atal'ai Priest"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5269;
-- AC datas : OLD Name : "아탈라이 식인트롤", Name AC enUS : "Atal'ai Corpse Eater" ; Wowhead enUS : "Atal'ai Corpse Eater"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 식인트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5270;
-- AC datas : OLD Name : "아탈라이 좀비", Name AC enUS : "Atal'ai Deathwalker" ; Wowhead enUS : "Atal'ai Deathwalker"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 좀비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5271;
-- AC datas : OLD Name : "아탈라이 대사제", Name AC enUS : "Atal'ai High Priest" ; Wowhead enUS : "Atal'ai High Priest"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 대사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5273;
-- AC datas : OLD Name : "학카리 서리날개천둥매", Name AC enUS : "Hakkari Frostwing" ; Wowhead enUS : "Hakkari Frostwing"
UPDATE `creature_template_locale` SET `Name` = '학카르 서리날개천둥매', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5291;
-- AC datas : OLD Name : "거친흉터 설인", Name AC enUS : "Feral Scar Yeti" ; Wowhead enUS : "Feral Scar Yeti"
UPDATE `creature_template_locale` SET `Name` = '원시설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5292;
-- AC datas : OLD Name : "덩치 큰 거친흉터 설인", Name AC enUS : "Hulking Feral Scar" ; Wowhead enUS : "Hulking Feral Scar"
UPDATE `creature_template_locale` SET `Name` = '덩치 큰 원시설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5293;
-- AC datas : OLD Name : "광포한 거친흉터 설인", Name AC enUS : "Enraged Feral Scar" ; Wowhead enUS : "Enraged Feral Scar"
UPDATE `creature_template_locale` SET `Name` = '광포한 원시설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5295;
-- AC datas : OLD Name : "덩치 큰 무쇠설인", Name AC enUS : "Elder Rage Scar" ; Wowhead enUS : "Elder Rage Scar"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 무쇠설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5297;
-- AC datas : OLD Name : "레슬라스", Name AC enUS : "Lethlas" ; Wowhead enUS : "Lethlas"
UPDATE `creature_template_locale` SET `Name` = '레살라스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5312;
-- AC datas : OLD Name : "제레미의 시험용 몬스터", Name AC enUS : "Coast Crawl Clacker" ; Wowhead enUS : "Coast Crawl Clacker"
UPDATE `creature_template_locale` SET `Name` = '딸깍이 바다마크루라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5326;
-- AC datas : OLD Name : "증오갈기 전사", Name AC enUS : "Hatecrest Warrior" ; Wowhead enUS : "Hatecrest Warrior"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5331;
-- AC datas : OLD Name : "증오갈기 바다전사", Name AC enUS : "Hatecrest Wave Rider" ; Wowhead enUS : "Hatecrest Wave Rider"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 바다전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5332;
-- AC datas : OLD Name : "증오갈기 수호병", Name AC enUS : "Hatecrest Serpent Guard" ; Wowhead enUS : "Hatecrest Serpent Guard"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5333;
-- AC datas : OLD Name : "증오갈기 미르미돈", Name AC enUS : "Hatecrest Myrmidon" ; Wowhead enUS : "Hatecrest Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5334;
-- AC datas : OLD Name : "증오갈기 비명술사", Name AC enUS : "Hatecrest Screamer" ; Wowhead enUS : "Hatecrest Screamer"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 비명술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5335;
-- AC datas : OLD Name : "증오갈기 여마법사", Name AC enUS : "Hatecrest Sorceress" ; Wowhead enUS : "Hatecrest Sorceress"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5336;
-- AC datas : OLD Name : "증오갈기 세이렌", Name AC enUS : "Hatecrest Siren" ; Wowhead enUS : "Hatecrest Siren"
UPDATE `creature_template_locale` SET `Name` = '증오의갈기일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5337;
-- AC datas : OLD Name : "꿈감시자 갈래혓바닥", Name AC enUS : "Dreamwatcher Forktongue" ; Wowhead enUS : "Dreamwatcher Forktongue"
UPDATE `creature_template_locale` SET `Name` = '꿈의감시자 갈래혓바닥', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5348;
-- AC datas : OLD Name : "나알 리프브라더", Name AC enUS : "Gnarl Leafbrother" ; Wowhead enUS : "Gnarl Leafbrother"
UPDATE `creature_template_locale` SET `Name` = '날 리프브라더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5354;
-- AC datas : OLD Name : "바람계곡 하피", Name AC enUS : "Northspring Harpy" ; Wowhead enUS : "Northspring Harpy"
UPDATE `creature_template_locale` SET `Name` = '바람계곡일족 하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5362;
-- AC datas : OLD Name : "바람계곡 약탈자", Name AC enUS : "Northspring Roguefeather" ; Wowhead enUS : "Northspring Roguefeather"
UPDATE `creature_template_locale` SET `Name` = '바람계곡일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5363;
-- AC datas : OLD Name : "바람계곡 암살자", Name AC enUS : "Northspring Slayer" ; Wowhead enUS : "Northspring Slayer"
UPDATE `creature_template_locale` SET `Name` = '바람계곡일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5364;
-- AC datas : OLD Name : "바람계곡 바람소환사", Name AC enUS : "Northspring Windcaller" ; Wowhead enUS : "Northspring Windcaller"
UPDATE `creature_template_locale` SET `Name` = '바람계곡일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5366;
-- AC datas : OLD Subname : "전문 보석세공인 및 보석세공용품 상인", Subname AC enUS : "Explorers' League" ; Wowhead enUS : "Explorers' League"
UPDATE `creature_template_locale` SET `Title` = '탐험가 연맹', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5388;
-- AC datas : OLD Name : "악몽마", Name AC enUS : "Nightmare" ; Wowhead enUS : "Nightmare"
UPDATE `creature_template_locale` SET `Name` = '나이트메어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5407;
-- AC datas : OLD Name : "사로잡힌 청소부", Name AC enUS : "Harvester Swarm" ; Wowhead enUS : "Harvester Swarm"
UPDATE `creature_template_locale` SET `Name` = '여왕 실리시드 애벌레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5409;
-- AC datas : OLD Name : "침투요원 마크슨", Name AC enUS : "Infiltrator Marksen" ; Wowhead enUS : "Infiltrator Marksen"
UPDATE `creature_template_locale` SET `Name` = '첩보원 마크슨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5416;
-- AC datas : OLD Name : "죽음추적자 즈레더스", Name AC enUS : "Deathstalker Zraedus" ; Wowhead enUS : "Deathstalker Zraedus"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 즈레더스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5418;
-- AC datas : OLD Name : "모래망치 집행자", Name AC enUS : "Dunemaul Enforcer" ; Wowhead enUS : "Dunemaul Enforcer"
UPDATE `creature_template_locale` SET `Name` = '모래망치일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5472;
-- AC datas : OLD Name : "모래망치 오우거 마법사", Name AC enUS : "Dunemaul Ogre Mage" ; Wowhead enUS : "Dunemaul Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '모래망치일족 오우거 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5473;
-- AC datas : OLD Name : "모래망치 투사", Name AC enUS : "Dunemaul Brute" ; Wowhead enUS : "Dunemaul Brute"
UPDATE `creature_template_locale` SET `Name` = '모래망치일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5474;
-- AC datas : OLD Name : "모래망치 흑마법사", Name AC enUS : "Dunemaul Warlock" ; Wowhead enUS : "Dunemaul Warlock"
UPDATE `creature_template_locale` SET `Name` = '모래망치일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5475;
-- AC datas : OLD Name : "스티븐 라이백", Name AC enUS : "Stephen Ryback" ; Wowhead enUS : "Stephen Ryback",  OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Name` = '스테판 라이백', `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5482;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5503;
-- AC datas : OLD Subname : "", Subname AC enUS : "Tallstrider Trainer" ; Wowhead enUS : "Tallstrider Trainer"
UPDATE `creature_template_locale` SET `Title` = '타조 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5507;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5518;
-- AC datas : OLD Subname : "셀모리단의 소환수", Subname AC enUS : "Celmoridan's Pet" ; Wowhead enUS : "Celmoridan's Pet"
UPDATE `creature_template_locale` SET `Title` = '셀모리단의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5521;
-- AC datas : OLD Subname : "스트럼너의 소환수", Subname AC enUS : "Strumner's Pet" ; Wowhead enUS : "Strumner's Pet"
UPDATE `creature_template_locale` SET `Title` = '스트럼너의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5522;
-- AC datas : OLD Name : "사이먼 태너", Name AC enUS : "Simon Tanner" ; Wowhead enUS : "Simon Tanner"
UPDATE `creature_template_locale` SET `Name` = '시몬 터너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5564;
-- AC datas : OLD Name : "질리안 태너", Name AC enUS : "Jillian Tanner" ; Wowhead enUS : "Jillian Tanner"
UPDATE `creature_template_locale` SET `Name` = '질리안 터너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5565;
-- AC datas : OLD Name : "테라모어 원정지 주 제어 프로그램", Name AC enUS : "Theramore Incursion Master Control Program" ; Wowhead enUS : "Theramore Incursion Master Control Program"
UPDATE `creature_template_locale` SET `Name` = '테라모어 습격 주제어 프로그램', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5632;
-- AC datas : OLD Subname : "고위 영주", Subname AC enUS : "High Thane" ; Wowhead enUS : "High Thane"
UPDATE `creature_template_locale` SET `Title` = '대영주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5635;
-- AC datas : OLD Name : "성난모래 무두장이", Name AC enUS : "Sandfury Hideskinner" ; Wowhead enUS : "Sandfury Hideskinner"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 무두장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5645;
-- AC datas : OLD Name : "성난모래 도끼투척병", Name AC enUS : "Sandfury Axe Thrower" ; Wowhead enUS : "Sandfury Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5646;
-- AC datas : OLD Name : "성난모래 불꽃소환사", Name AC enUS : "Sandfury Firecaller" ; Wowhead enUS : "Sandfury Firecaller"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 불꽃소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5647;
-- AC datas : OLD Name : "성난모래 흑마술사", Name AC enUS : "Sandfury Shadowcaster" ; Wowhead enUS : "Sandfury Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5648;
-- AC datas : OLD Name : "성난모래 혈투사", Name AC enUS : "Sandfury Blood Drinker" ; Wowhead enUS : "Sandfury Blood Drinker"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 혈투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5649;
-- AC datas : OLD Name : "성난모래 의술사", Name AC enUS : "Sandfury Witch Doctor" ; Wowhead enUS : "Sandfury Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5650;
-- AC datas : OLD Name : "리처드 반 브런트", Name AC enUS : "Richard Van Brunt" ; Wowhead enUS : "Richard Van Brunt"
UPDATE `creature_template_locale` SET `Name` = '리차드 반 브런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5656;
-- AC datas : OLD Name : "소환된 공허방랑자", Name AC enUS : "Summoned Voidwalker" ; Wowhead enUS : "Summoned Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '소환된 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5676;
-- AC datas : OLD Subname : "제라드의 마음의 포로", Subname AC enUS : "Gerard's Mindslave" ; Wowhead enUS : "Gerard's Experiment"
UPDATE `creature_template_locale` SET `Title` = '제라드의 실험체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5697;
-- AC datas : OLD Name : "사만다 셰클턴", Name AC enUS : "Samantha Shackleton" ; Wowhead enUS : "Samantha Shackleton"
UPDATE `creature_template_locale` SET `Name` = '사만다 셰클톤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5700;
-- AC datas : OLD Name : "빅터 바톨로뮤", Name AC enUS : "Victor Bartholomew" ; Wowhead enUS : "Victor Bartholomew"
UPDATE `creature_template_locale` SET `Name` = '빅터 바르톨로뮤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5705;
-- AC datas : OLD Name : "아제론 카르갈", Name AC enUS : "Ageron Kargal" ; Wowhead enUS : "Ageron Kargal"
UPDATE `creature_template_locale` SET `Name` = '아제론 카갈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5724;
-- AC datas : OLD Name : "죽음경비병 런드마크", Name AC enUS : "Deathguard Lundmark" ; Wowhead enUS : "Deathguard Lundmark"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 런드마크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5725;
-- AC datas : OLD Name : "제젤레의 공허방랑자", Name AC enUS : "Jezelle's Voidwalker" ; Wowhead enUS : "Jezelle's Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '제젤레의 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5729;
-- AC datas : OLD Subname : "그래쉬 썬더브루의 소환수", Subname AC enUS : "Grash Thunderbrew's Pet" ; Wowhead enUS : "Grash Thunderbrew's Pet"
UPDATE `creature_template_locale` SET `Title` = '그래쉬 썬더브루의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5796;
-- AC datas : OLD Name : "하사관 커티스", Name AC enUS : "Watch Commander Zalaphil" ; Wowhead enUS : "Watch Commander Zalaphil"
UPDATE `creature_template_locale` SET `Name` = '경비대장 잘라필', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5809;
-- AC datas : OLD Subname : "수습 가죽세공인", Subname AC enUS : "Apprentice Leatherworker" ; Wowhead enUS : "Apprentice Leatherworker"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5811;
-- AC datas : OLD Subname : "서슬갈기 전투호위대장", Subname AC enUS : "Captain of the Battleguard" ; Wowhead enUS : "Captain of the Battleguard"
UPDATE `creature_template_locale` SET `Title` = '서슬갈기일족 전투호위대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5824;
-- AC datas : OLD Name : "검은무쇠 지질학자", Name AC enUS : "Dark Iron Geologist" ; Wowhead enUS : "Dark Iron Geologist"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 지질학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5839;
-- AC datas : OLD Name : "검은무쇠 증기기술자", Name AC enUS : "Dark Iron Steamsmith" ; Wowhead enUS : "Dark Iron Steamsmith"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 증기기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5840;
-- AC datas : OLD Name : "검은무쇠 노예상인", Name AC enUS : "Dark Iron Slaver" ; Wowhead enUS : "Dark Iron Slaver"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 노예상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5844;
-- AC datas : OLD Name : "검은무쇠 감독관", Name AC enUS : "Dark Iron Taskmaster" ; Wowhead enUS : "Dark Iron Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5846;
-- AC datas : OLD Subname : "서슬갈기 용사", Subname AC enUS : "Razormane Champion" ; Wowhead enUS : "Razormane Champion"
UPDATE `creature_template_locale` SET `Title` = '서슬갈기일족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5859;
-- AC datas : OLD Name : "황혼의 암흑주술사", Name AC enUS : "Twilight Dark Shaman" ; Wowhead enUS : "Twilight Dark Shaman"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 암흑주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5860;
-- AC datas : OLD Name : "황혼의 화염경비병", Name AC enUS : "Twilight Fire Guard" ; Wowhead enUS : "Twilight Fire Guard"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 화염경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5861;
-- AC datas : OLD Name : "황혼의 풍수사", Name AC enUS : "Twilight Geomancer" ; Wowhead enUS : "Twilight Geomancer"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 풍수사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5862;
-- AC datas : OLD Name : "클라라 찰스", Name AC enUS : "Clara Charles" ; Wowhead enUS : "Clara Charles"
UPDATE `creature_template_locale` SET `Name` = '클라라 찰리스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5917;
-- AC datas : OLD Name : "원소 저항 토템", Name AC enUS : "Fire Resistance Totem" ; Wowhead enUS : "Fire Resistance Totem"
UPDATE `creature_template_locale` SET `Name` = '화염 저항 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5927;
-- AC datas : OLD Subname : "재봉용품 및 가죽세공용품 상인", Subname AC enUS : "Tailoring & Leatherworking Supplies" ; Wowhead enUS : "Tailoring & Leatherworking Supplies"
UPDATE `creature_template_locale` SET `Title` = '재봉용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5944;
-- AC datas : OLD Name : "시험의 골짜기 그런트", Name AC enUS : "Den Grunt" ; Wowhead enUS : "Den Grunt"
UPDATE `creature_template_locale` SET `Name` = '시험의골짜기 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5952;
-- AC datas : OLD Name : "칼바위 언덕 그런트", Name AC enUS : "Razor Hill Grunt" ; Wowhead enUS : "Razor Hill Grunt"
UPDATE `creature_template_locale` SET `Name` = '칼바위언덕 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5953;
-- AC datas : OLD Name : "우레망치 오우거", Name AC enUS : "Dreadmaul Ogre" ; Wowhead enUS : "Dreadmaul Ogre"
UPDATE `creature_template_locale` SET `Name` = '우레망치일족 오우거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5974;
-- AC datas : OLD Name : "우레망치 오우거 마법사", Name AC enUS : "Dreadmaul Ogre Mage" ; Wowhead enUS : "Dreadmaul Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '우레망치일족 오우거 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5975;
-- AC datas : OLD Name : "우레망치 투사", Name AC enUS : "Dreadmaul Brute" ; Wowhead enUS : "Dreadmaul Brute"
UPDATE `creature_template_locale` SET `Name` = '우레망치일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5976;
-- AC datas : OLD Name : "우레망치 싸움꾼", Name AC enUS : "Dreadmaul Mauler" ; Wowhead enUS : "Dreadmaul Mauler"
UPDATE `creature_template_locale` SET `Name` = '우레망치일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5977;
-- AC datas : OLD Name : "우레망치 흑마법사", Name AC enUS : "Dreadmaul Warlock" ; Wowhead enUS : "Dreadmaul Warlock"
UPDATE `creature_template_locale` SET `Name` = '우레망치일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5978;
-- AC datas : OLD Name : "비참한 잃어버린 드레나이", Name AC enUS : "Wretched Lost One" ; Wowhead enUS : "Wretched Lost One"
UPDATE `creature_template_locale` SET `Name` = '비참한 드레노어 난민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5979;
-- AC datas : OLD Name : "뒤틀린 드레나이", Name AC enUS : "Broken One" ; Wowhead enUS : "Broken One"
UPDATE `creature_template_locale` SET `Name` = '실의에 빠진 드레노어 난민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5980;
-- AC datas : OLD Name : "차원문 수색꾼", Name AC enUS : "Portal Seeker" ; Wowhead enUS : "Portal Seeker"
UPDATE `creature_template_locale` SET `Name` = '차원의 문 수색꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5981;
-- AC datas : OLD Name : "지옥부리 뼈다귀청소부", Name AC enUS : "Bonepicker" ; Wowhead enUS : "Bonepicker"
UPDATE `creature_template_locale` SET `Name` = '강철부리 대머리수리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 5983;
-- AC datas : OLD Name : "어둠혈맹 신도", Name AC enUS : "Shadowsworn Cultist" ; Wowhead enUS : "Shadowsworn Cultist"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 이교도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6004;
-- AC datas : OLD Name : "어둠혈맹 암살단원", Name AC enUS : "Shadowsworn Thug" ; Wowhead enUS : "Shadowsworn Thug"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 암살단원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6005;
-- AC datas : OLD Name : "어둠혈맹 숙련사제", Name AC enUS : "Shadowsworn Adept" ; Wowhead enUS : "Shadowsworn Adept"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 숙련사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6006;
-- AC datas : OLD Name : "어둠혈맹 집행자", Name AC enUS : "Shadowsworn Enforcer" ; Wowhead enUS : "Shadowsworn Enforcer"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6007;
-- AC datas : OLD Name : "어둠혈맹 흑마법사", Name AC enUS : "Shadowsworn Warlock" ; Wowhead enUS : "Shadowsworn Warlock"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6008;
-- AC datas : OLD Name : "어둠혈맹 공포술사", Name AC enUS : "Shadowsworn Dreadweaver" ; Wowhead enUS : "Shadowsworn Dreadweaver"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 공포술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6009;
-- AC datas : OLD Name : "지옥수호병 보초", Name AC enUS : "Felguard Sentry" ; Wowhead enUS : "Felguard Sentry"
UPDATE `creature_template_locale` SET `Name` = '지옥군단병 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6011;
-- AC datas : OLD Name : "호수광포어", Name AC enUS : "Lake Frenzy" ; Wowhead enUS : "Lake Frenzy"
UPDATE `creature_template_locale` SET `Name` = '호수프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6033;
-- AC datas : OLD Name : "가시덩굴 추종자", Name AC enUS : "Razorfen Stalker" ; Wowhead enUS : "Razorfen Stalker"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 추종자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6035;
-- AC datas : OLD Name : "마라우돈 칸 호위병", Name AC enUS : "Maraudine Khan Guard" ; Wowhead enUS : "Maraudine Khan Guard"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 칸 호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6069;
-- AC datas : OLD Name : "마라우돈 칸 조언가", Name AC enUS : "Maraudine Khan Advisor" ; Wowhead enUS : "Maraudine Khan Advisor"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 칸 조언가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6070;
-- AC datas : OLD Name : "녹색 랩터", Name AC enUS : "Emerald Raptor" ; Wowhead enUS : "Emerald Raptor"
UPDATE `creature_template_locale` SET `Name` = '길들인 랩터 (녹색)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6075;
-- AC datas : OLD Name : "떠도는 지옥수호병", Name AC enUS : "Roaming Felguard" ; Wowhead enUS : "Roaming Felguard"
UPDATE `creature_template_locale` SET `Name` = '떠도는 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6115;
-- AC datas : OLD Name : "검은무쇠 비밀요원", Name AC enUS : "Dark Iron Spy" ; Wowhead enUS : "Dark Iron Spy"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 비밀요원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6123;
-- AC datas : OLD Name : "용혈족 마술군주", Name AC enUS : "Draconic Magelord" ; Wowhead enUS : "Draconic Magelord"
UPDATE `creature_template_locale` SET `Name` = '용혈족 마술사왕', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6129;
-- AC datas : OLD Name : "가시덩굴 하수인", Name AC enUS : "Razorfen Servitor" ; Wowhead enUS : "Razorfen Servitor"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 하수인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6132;
-- AC datas : OLD Name : "아크코란 땅꾼", Name AC enUS : "Arkkoran Muckdweller" ; Wowhead enUS : "Arkkoran Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '아크코란멀록 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6136;
-- AC datas : OLD Name : "아크코란 점쟁이", Name AC enUS : "Arkkoran Oracle" ; Wowhead enUS : "Arkkoran Oracle"
UPDATE `creature_template_locale` SET `Name` = '아크코란멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6138;
-- AC datas : OLD Name : "다프네 스틸웰", Name AC enUS : "Daphne Stilwell" ; Wowhead enUS : "Daphne Stilwell"
UPDATE `creature_template_locale` SET `Name` = '대프니 스틸웰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6182;
-- AC datas : OLD Name : "나무구렁 길잡이", Name AC enUS : "Timbermaw Pathfinder" ; Wowhead enUS : "Timbermaw Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6184;
-- AC datas : OLD Name : "나무구렁 전사", Name AC enUS : "Timbermaw Warrior" ; Wowhead enUS : "Timbermaw Warrior"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6185;
-- AC datas : OLD Name : "나무구렁 토템술사", Name AC enUS : "Timbermaw Totemic" ; Wowhead enUS : "Timbermaw Totemic"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6186;
-- AC datas : OLD Name : "나무구렁 보초", Name AC enUS : "Timbermaw Den Watcher" ; Wowhead enUS : "Timbermaw Den Watcher"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6187;
-- AC datas : OLD Name : "나무구렁 주술사", Name AC enUS : "Timbermaw Shaman" ; Wowhead enUS : "Timbermaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6188;
-- AC datas : OLD Name : "나무구렁 펄볼그", Name AC enUS : "Timbermaw Ursa" ; Wowhead enUS : "Timbermaw Ursa"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6189;
-- AC datas : OLD Name : "원한꼬리 전사", Name AC enUS : "Spitelash Warrior" ; Wowhead enUS : "Spitelash Warrior"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6190;
-- AC datas : OLD Name : "원한꼬리 비명술사", Name AC enUS : "Spitelash Screamer" ; Wowhead enUS : "Spitelash Screamer"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 비명술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6193;
-- AC datas : OLD Name : "원한꼬리 수호병", Name AC enUS : "Spitelash Serpent Guard" ; Wowhead enUS : "Spitelash Serpent Guard"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6194;
-- AC datas : OLD Name : "원한꼬리 세이렌", Name AC enUS : "Spitelash Siren" ; Wowhead enUS : "Spitelash Siren"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6195;
-- AC datas : OLD Name : "원한꼬리 미르미돈", Name AC enUS : "Spitelash Myrmidon" ; Wowhead enUS : "Spitelash Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6196;
-- AC datas : OLD Name : "원한꼬리 여마법사", Name AC enUS : "Spitelash Sorceress" ; Wowhead enUS : "Spitelash Sorceress"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6197;
-- AC datas : OLD Name : "깊은굴 땅꾼", Name AC enUS : "Caverndeep Burrower" ; Wowhead enUS : "Caverndeep Burrower"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6206;
-- AC datas : OLD Name : "깊은굴 복병", Name AC enUS : "Caverndeep Ambusher" ; Wowhead enUS : "Caverndeep Ambusher"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6207;
-- AC datas : OLD Name : "깊은굴 침략꾼", Name AC enUS : "Caverndeep Invader" ; Wowhead enUS : "Caverndeep Invader"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 침략꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6208;
-- AC datas : OLD Name : "깊은굴 노략꾼", Name AC enUS : "Caverndeep Looter" ; Wowhead enUS : "Caverndeep Looter"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 노략꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6209;
-- AC datas : OLD Name : "깊은굴 강탈꾼", Name AC enUS : "Caverndeep Pillager" ; Wowhead enUS : "Caverndeep Pillager"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 강탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6210;
-- AC datas : OLD Name : "깊은굴 약탈꾼", Name AC enUS : "Caverndeep Reaver" ; Wowhead enUS : "Caverndeep Reaver"
UPDATE `creature_template_locale` SET `Name` = '깊은굴일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6211;
-- AC datas : OLD Name : "검은무쇠 첩보원", Name AC enUS : "Dark Iron Agent" ; Wowhead enUS : "Dark Iron Agent"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6212;
-- AC datas : OLD Name : "강철이빨바실리스크", Name AC enUS : "Chomper" ; Wowhead enUS : "Chomper"
UPDATE `creature_template_locale` SET `Name` = '강철이빨 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6215;
-- AC datas : OLD Name : "검은무쇠 사절", Name AC enUS : "Dark Iron Ambassador" ; Wowhead enUS : "Dark Iron Ambassador"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6228;
-- AC datas : OLD Name : "랜드 로바트", Name AC enUS : "Rand Rhobart" ; Wowhead enUS : "Rand Rhobart"
UPDATE `creature_template_locale` SET `Name` = '랜드 로버트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6289;
-- AC datas : OLD Name : "쿠르드람 스톤해머", Name AC enUS : "Kurdram Stonehammer" ; Wowhead enUS : "Kurdram Stonehammer"
UPDATE `creature_template_locale` SET `Name` = '쿠르트람 스톤해머', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6297;
-- AC datas : OLD Name : "폭풍해안 점쟁이", Name AC enUS : "Storm Bay Oracle" ; Wowhead enUS : "Storm Bay Oracle"
UPDATE `creature_template_locale` SET `Name` = '폭풍해안멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6351;
-- AC datas : OLD Name : "폭풍해안 전사", Name AC enUS : "Storm Bay Warrior" ; Wowhead enUS : "Storm Bay Warrior"
UPDATE `creature_template_locale` SET `Name` = '폭풍해안멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6371;
-- AC datas : OLD Name : "죽음경비병 포드리그", Name AC enUS : "Deathguard Podrig" ; Wowhead enUS : "Deathguard Podrig"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 포드리그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6389;
-- AC datas : OLD Name : "음산한 악령", Name AC enUS : "Haunting Phantasm" ; Wowhead enUS : "Haunting Phantasm"
UPDATE `creature_template_locale` SET `Name` = '절규하는 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6427;
-- AC datas : OLD Name : "브리블스워프", Name AC enUS : "Brivelthwerp" ; Wowhead enUS : "Brivelthwerp"
UPDATE `creature_template_locale` SET `Name` = '브리벨스웰프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6496;
-- AC datas : OLD Name : "검은무쇠 소총병", Name AC enUS : "Dark Iron Rifleman" ; Wowhead enUS : "Dark Iron Rifleman"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 소총병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6523;
-- AC datas : OLD Name : "표범 형상 (나이트 엘프 드루이드)", Name AC enUS : "Cat Form (Night Elf Druid)" ; Wowhead enUS : "Cat Form (Night Elf Druid)"
UPDATE `creature_template_locale` SET `Name` = '표범 (나이트 엘프 드루이드)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6571;
-- AC datas : OLD Name : "표범 형상 (타우렌 드루이드)", Name AC enUS : "Cat Form (Tauren Druid)" ; Wowhead enUS : "Cat Form (Tauren Druid)"
UPDATE `creature_template_locale` SET `Name` = '표범 (타우렌 드루이드)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6572;
-- AC datas : OLD Name : "순록 변신 (드루이드)", Name AC enUS : "Travel Form (Druid)" ; Wowhead enUS : "Travel Form (Druid)"
UPDATE `creature_template_locale` SET `Name` = '치타 (드루이드)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6573;
-- AC datas : OLD Name : "징키 트위즐픽싯", Name AC enUS : "Jinky Twizzlefixxit" ; Wowhead enUS : "Jinky Twizzlefixxit"
UPDATE `creature_template_locale` SET `Name` = '진키 트위즐픽시트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6730;
-- AC datas : OLD Name : "할론 다크위브", Name AC enUS : "Harlown Darkweave" ; Wowhead enUS : "Harlown Darkweave"
UPDATE `creature_template_locale` SET `Name` = '하론 다크위브', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6731;
-- AC datas : OLD Name : "바위동굴 전사", Name AC enUS : "Stonevault Basher" ; Wowhead enUS : "Stonevault Basher"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6733;
-- AC datas : OLD Name : "여관주인 하스스토브", Name AC enUS : "Innkeeper Hearthstove" ; Wowhead enUS : "Innkeeper Hearthstove"
UPDATE `creature_template_locale` SET `Name` = '여관주인 하트스토브', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6734;
-- AC datas : OLD Name : "캘빈 몬테규", Name AC enUS : "Calvin Montague" ; Wowhead enUS : "Calvin Montague"
UPDATE `creature_template_locale` SET `Name` = '캘빈 몬테그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6784;
-- AC datas : OLD Name : "여관주인 와일리", Name AC enUS : "Innkeeper Wiley" ; Wowhead enUS : "Innkeeper Wiley"
UPDATE `creature_template_locale` SET `Name` = '여관주인 윌리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6791;
-- AC datas : OLD Name : "물가 게", Name AC enUS : "Crab" ; Wowhead enUS : "Crab"
UPDATE `creature_template_locale` SET `Name` = '게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6827;
-- AC datas : OLD Name : "부두주임", Name AC enUS : "Defias Dockmaster" ; Wowhead enUS : "Defias Dockmaster"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 부두주임', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6846;
-- AC datas : OLD Name : "경호원", Name AC enUS : "Defias Bodyguard" ; Wowhead enUS : "Defias Bodyguard"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 경호원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6866;
-- AC datas : OLD Name : ""날쌘돌이" 에릭", Name AC enUS : "Eric "The Swift"" ; Wowhead enUS : "Eric "The Swift""
UPDATE `creature_template_locale` SET `Name` = '날쌘돌이 에릭', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6907;
-- AC datas : OLD Name : "잃어버린 드레나이 차원여행자", Name AC enUS : "Lost One Rift Traveler" ; Wowhead enUS : "Lost One Rift Traveler"
UPDATE `creature_template_locale` SET `Name` = '드레노어 난민 차원여행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6913;
-- AC datas : OLD Name : "부두일꾼", Name AC enUS : "Defias Dockworker" ; Wowhead enUS : "Defias Dockworker"
UPDATE `creature_template_locale` SET `Name` = '데피아즈단 부두일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 6927;
-- AC datas : OLD Name : "검은바위 암살자", Name AC enUS : "Blackrock Assassin" ; Wowhead enUS : "Blackrock Assassin"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7006;
-- AC datas : OLD Name : "검은바위 약탈자", Name AC enUS : "Blackrock Reaver" ; Wowhead enUS : "Blackrock Reaver"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7008;
-- AC datas : OLD Name : "검은바위 수호자", Name AC enUS : "Blackrock Rampager" ; Wowhead enUS : "Blackrock Rampager"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7013;
-- AC datas : OLD Name : "검은바위 병사", Name AC enUS : "Blackrock Soldier" ; Wowhead enUS : "Blackrock Soldier"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7025;
-- AC datas : OLD Name : "검은바위 마술사", Name AC enUS : "Blackrock Sorcerer" ; Wowhead enUS : "Blackrock Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7026;
-- AC datas : OLD Name : "검은바위 학살자", Name AC enUS : "Blackrock Slayer" ; Wowhead enUS : "Blackrock Slayer"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7027;
-- AC datas : OLD Name : "검은바위 흑마법사", Name AC enUS : "Blackrock Warlock" ; Wowhead enUS : "Blackrock Warlock"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7028;
-- AC datas : OLD Name : "검은바위 지휘관", Name AC enUS : "Blackrock Battlemaster" ; Wowhead enUS : "Blackrock Battlemaster"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 지휘관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7029;
-- AC datas : OLD Name : "어둠괴철로 지질학자", Name AC enUS : "Shadowforge Geologist" ; Wowhead enUS : "Shadowforge Geologist"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 지질학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7030;
-- AC datas : OLD Name : "불자루 오우거", Name AC enUS : "Firegut Ogre" ; Wowhead enUS : "Firegut Ogre"
UPDATE `creature_template_locale` SET `Name` = '불자루일족 오우거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7033;
-- AC datas : OLD Name : "불자루 오우거마법사", Name AC enUS : "Firegut Ogre Mage" ; Wowhead enUS : "Firegut Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '불자루일족 오우거마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7034;
-- AC datas : OLD Name : "불자루 투사", Name AC enUS : "Firegut Brute" ; Wowhead enUS : "Firegut Brute"
UPDATE `creature_template_locale` SET `Name` = '불자루일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7035;
-- AC datas : OLD Name : "끓어오르는 비룡", Name AC enUS : "Scalding Drake" ; Wowhead enUS : "Scalding Drake"
UPDATE `creature_template_locale` SET `Name` = '불타는 비룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7045;
-- AC datas : OLD Name : "끓어오르는 어린 비룡", Name AC enUS : "Scalding Broodling" ; Wowhead enUS : "Scalding Broodling"
UPDATE `creature_template_locale` SET `Name` = '어린 화염비늘 새끼용', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7048;
-- AC datas : OLD Name : "클라벤 몰트웨이크", Name AC enUS : "Klaven Mortwake" ; Wowhead enUS : "Klaven Mortwake"
UPDATE `creature_template_locale` SET `Name` = '클라벤 몰트워크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7053;
-- AC datas : OLD Name : "검은바위 검은늑대", Name AC enUS : "Blackrock Worg" ; Wowhead enUS : "Blackrock Worg"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7055;
-- AC datas : OLD Name : "저주받은 심판관", Name AC enUS : "Cursed Justicar" ; Wowhead enUS : "Cursed Justicar"
UPDATE `creature_template_locale` SET `Name` = '저주받은 사법관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7072;
-- AC datas : OLD Name : "어둠괴철로 복병", Name AC enUS : "Shadowforge Ambusher" ; Wowhead enUS : "Shadowforge Ambusher"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7091;
-- AC datas : OLD Name : "비취불꽃 사티로스", Name AC enUS : "Jadefire Satyr" ; Wowhead enUS : "Jadefire Satyr"
UPDATE `creature_template_locale` SET `Name` = '비취불꽃의 사티로스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7105;
-- AC datas : OLD Name : "비취불꽃 도적", Name AC enUS : "Jadefire Rogue" ; Wowhead enUS : "Jadefire Rogue"
UPDATE `creature_template_locale` SET `Name` = '비취불꽃의 도적', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7106;
-- AC datas : OLD Name : "비취불꽃 배반자", Name AC enUS : "Jadefire Betrayer" ; Wowhead enUS : "Jadefire Betrayer"
UPDATE `creature_template_locale` SET `Name` = '비취불꽃의 배반자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7108;
-- AC datas : OLD Name : "제데나르 이교도", Name AC enUS : "Jaedenar Cultist" ; Wowhead enUS : "Jaedenar Cultist"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 이교도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7112;
-- AC datas : OLD Name : "제데나르 수호병", Name AC enUS : "Jaedenar Guardian" ; Wowhead enUS : "Jaedenar Guardian"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7113;
-- AC datas : OLD Name : "제데나르 집행자", Name AC enUS : "Jaedenar Enforcer" ; Wowhead enUS : "Jaedenar Enforcer"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7114;
-- AC datas : OLD Name : "제데나르 숙련마술사", Name AC enUS : "Jaedenar Adept" ; Wowhead enUS : "Jaedenar Adept"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 숙련마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7115;
-- AC datas : OLD Name : "제데나르 공포술사", Name AC enUS : "Jaedenar Dreadweaver" ; Wowhead enUS : "Jaedenar Dreadweaver"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 공포술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7116;
-- AC datas : OLD Name : "제데나르 지원병", Name AC enUS : "Jaedenar Instigator" ; Wowhead enUS : "Jaedenar Instigator"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 지원병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7117;
-- AC datas : OLD Name : "제데나르 흑마술사", Name AC enUS : "Jaedenar Darkweaver" ; Wowhead enUS : "Jaedenar Darkweaver"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7118;
-- AC datas : OLD Name : "제데나르 소환사", Name AC enUS : "Jaedenar Summoner" ; Wowhead enUS : "Jaedenar Summoner"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7119;
-- AC datas : OLD Name : "제데나르 흑마법사", Name AC enUS : "Jaedenar Warlock" ; Wowhead enUS : "Jaedenar Warlock"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7120;
-- AC datas : OLD Name : "제데나르 대흑마법사", Name AC enUS : "Jaedenar Arch Warlock" ; Wowhead enUS : "Jaedenar Arch Warlock"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 대흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7121;
-- AC datas : OLD Name : "제데나르 사냥개", Name AC enUS : "Jaedenar Hound" ; Wowhead enUS : "Jaedenar Hound"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7125;
-- AC datas : OLD Name : "제데나르 지옥사냥개", Name AC enUS : "Jaedenar Hunter" ; Wowhead enUS : "Jaedenar Hunter"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 지옥사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7126;
-- AC datas : OLD Name : "제데나르 추적사냥개", Name AC enUS : "Jaedenar Stalker" ; Wowhead enUS : "Jaedenar Stalker"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 추적사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7127;
-- AC datas : OLD Name : "제데나르 마나사냥개", Name AC enUS : "Jaedenar Mana Leech" ; Wowhead enUS : "Jaedenar Mana Leech"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 마나사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7128;
-- AC datas : OLD Name : "공허방랑자 종복", Name AC enUS : "Enslaved Voidwalker" ; Wowhead enUS : "Enslaved Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '보이드워커 종복', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7129;
-- AC datas : OLD Name : "공허방랑자 하수인", Name AC enUS : "Voidwalker Servant" ; Wowhead enUS : "Voidwalker Servant"
UPDATE `creature_template_locale` SET `Name` = '보이드워커 하수인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7130;
-- AC datas : OLD Name : "공허방랑자 수호자", Name AC enUS : "Voidwalker Guardian" ; Wowhead enUS : "Voidwalker Guardian"
UPDATE `creature_template_locale` SET `Name` = '보이드워커 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7131;
-- AC datas : OLD Name : "마른가지 전사", Name AC enUS : "Deadwood Warrior" ; Wowhead enUS : "Deadwood Warrior"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7153;
-- AC datas : OLD Name : "마른가지 정원사", Name AC enUS : "Deadwood Gardener" ; Wowhead enUS : "Deadwood Gardener"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 정원사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7154;
-- AC datas : OLD Name : "마른가지 길잡이", Name AC enUS : "Deadwood Pathfinder" ; Wowhead enUS : "Deadwood Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7155;
-- AC datas : OLD Name : "마른가지 보초", Name AC enUS : "Deadwood Den Watcher" ; Wowhead enUS : "Deadwood Den Watcher"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7156;
-- AC datas : OLD Name : "마른가지 복수자", Name AC enUS : "Deadwood Avenger" ; Wowhead enUS : "Deadwood Avenger"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 복수자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7157;
-- AC datas : OLD Name : "마른가지 주술사", Name AC enUS : "Deadwood Shaman" ; Wowhead enUS : "Deadwood Shaman"
UPDATE `creature_template_locale` SET `Name` = '마른가지일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7158;
-- AC datas : OLD Name : "노르간논 지식의 파수꾼", Name AC enUS : "Lore Keeper of Norgannon" ; Wowhead enUS : "Lore Keeper of Norgannon"
UPDATE `creature_template_locale` SET `Name` = '노르간논 지식의파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7172;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmithing Trainer" ; Wowhead enUS : "Armorsmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7174;
-- AC datas : OLD Name : "바위동굴 복병", Name AC enUS : "Stonevault Ambusher" ; Wowhead enUS : "Stonevault Ambusher"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7175;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmith Trainer" ; Wowhead enUS : "Armorsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7230;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith Trainer" ; Wowhead enUS : "Weaponsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7231;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith Trainer" ; Wowhead enUS : "Weaponsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7232;
-- AC datas : OLD Name : "나무옹이 비술사", Name AC enUS : "Gnarlpine Mystic" ; Wowhead enUS : "Gnarlpine Mystic"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7235;
-- AC datas : OLD Name : "성난모래 어둠사냥꾼", Name AC enUS : "Sandfury Shadowhunter" ; Wowhead enUS : "Sandfury Shadowhunter"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7246;
-- AC datas : OLD Name : "성난모래 영혼사냥꾼", Name AC enUS : "Sandfury Soul Eater" ; Wowhead enUS : "Sandfury Soul Eater"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 영혼사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7247;
-- AC datas : OLD Name : "성난모래 수호물", Name AC enUS : "Sandfury Guardian" ; Wowhead enUS : "Sandfury Guardian"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 수호물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7268;
-- AC datas : OLD Name : "성난모래 좀비", Name AC enUS : "Sandfury Zombie" ; Wowhead enUS : "Sandfury Zombie"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 좀비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7270;
-- AC datas : OLD Name : "성난모래 사형집행인", Name AC enUS : "Sandfury Executioner" ; Wowhead enUS : "Sandfury Executioner"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 사형집행인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7274;
-- AC datas : OLD Name : "암흑사제 세즈지즈", Name AC enUS : "Shadowpriest Sezz'ziz" ; Wowhead enUS : "Shadowpriest Sezz'ziz"
UPDATE `creature_template_locale` SET `Name` = '어둠의사제 세즈지즈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7275;
-- AC datas : OLD Name : "어둠괴철로 저격수", Name AC enUS : "Shadowforge Sharpshooter" ; Wowhead enUS : "Shadowforge Sharpshooter"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 저격수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7290;
-- AC datas : OLD Name : "바위동굴 싸움꾼", Name AC enUS : "Stonevault Mauler" ; Wowhead enUS : "Stonevault Mauler"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7320;
-- AC datas : OLD Name : "바위동굴 화염술사", Name AC enUS : "Stonevault Flameweaver" ; Wowhead enUS : "Stonevault Flameweaver"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 화염술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7321;
-- AC datas : OLD Name : "검은밤호랑이", Name AC enUS : "Black Nightsaber" ; Wowhead enUS : "Black Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (검은색)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7322;
-- AC datas : OLD Name : "완전무결한 드레니시스트 구슬", Name AC enUS : "Flawless Draenethyst Sphere" ; Wowhead enUS : "Flawless Draenethyst Sphere"
UPDATE `creature_template_locale` SET `Name` = '완전무결한 드레니시스트 결정', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7364;
-- AC datas : OLD Name : "저승바람 투사", Name AC enUS : "Deadwind Brute" ; Wowhead enUS : "Deadwind Brute"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7369;
-- AC datas : OLD Name : "저승바람 싸움꾼", Name AC enUS : "Deadwind Mauler" ; Wowhead enUS : "Deadwind Mauler"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7371;
-- AC datas : OLD Name : "저승바람 흑마법사", Name AC enUS : "Deadwind Warlock" ; Wowhead enUS : "Deadwind Warlock"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7372;
-- AC datas : OLD Name : "저승바람 집행자", Name AC enUS : "Deadwind Enforcer" ; Wowhead enUS : "Deadwind Enforcer"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7373;
-- AC datas : OLD Name : "덩치 큰 죽음의사냥개", Name AC enUS : "Doomhound Mastiff" ; Wowhead enUS : "Doomhound Mastiff"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 죽음의사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7378;
-- AC datas : OLD Name : "저승바람 오우거마법사", Name AC enUS : "Deadwind Ogre Mage" ; Wowhead enUS : "Deadwind Ogre Mage"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 오우거마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7379;
-- AC datas : OLD Name : "언더시티 바퀴벌레", Name AC enUS : "Cockroach" ; Wowhead enUS : "Cockroach"
UPDATE `creature_template_locale` SET `Name` = '바퀴벌레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7395;
-- AC datas : OLD Name : "갈라크 화염경비병", Name AC enUS : "Galak Flame Guard" ; Wowhead enUS : "Galak Flame Guard"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 화염경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7404;
-- AC datas : OLD Subname : "노움 전문 기계공학자", Subname AC enUS : "Gnomish Engineering Trainer" ; Wowhead enUS : "Gnomish Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '노움 기술자 조합장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7406;
-- AC datas : OLD Name : "어린 눈호랑이", Name AC enUS : "Frostsaber Cub" ; Wowhead enUS : "Frostsaber Cub"
UPDATE `creature_template_locale` SET `Name` = '새끼 눈호랑이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7430;
-- AC datas : OLD Name : "겨울눈 펄볼그", Name AC enUS : "Winterfall Ursa" ; Wowhead enUS : "Winterfall Ursa"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 펄볼그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7438;
-- AC datas : OLD Name : "겨울눈 주술사", Name AC enUS : "Winterfall Shaman" ; Wowhead enUS : "Winterfall Shaman"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7439;
-- AC datas : OLD Name : "겨울눈 보초", Name AC enUS : "Winterfall Den Watcher" ; Wowhead enUS : "Winterfall Den Watcher"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7440;
-- AC datas : OLD Name : "겨울눈 토템술사", Name AC enUS : "Winterfall Totemic" ; Wowhead enUS : "Winterfall Totemic"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 토템술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7441;
-- AC datas : OLD Name : "겨울눈 길잡이", Name AC enUS : "Winterfall Pathfinder" ; Wowhead enUS : "Winterfall Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7442;
-- AC datas : OLD Name : "광기 어린 올빼미야수", Name AC enUS : "Crazed Owlbeast" ; Wowhead enUS : "Crazed Owlbeast"
UPDATE `creature_template_locale` SET `Name` = '광기어린 올빼미야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7452;
-- AC datas : OLD Name : "여명의 설원 올빼미", Name AC enUS : "Winterspring Owl" ; Wowhead enUS : "Winterspring Owl"
UPDATE `creature_template_locale` SET `Name` = '여명의설원 올빼미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7455;
-- AC datas : OLD Name : "여명의 설원 비명올빼미", Name AC enUS : "Winterspring Screecher" ; Wowhead enUS : "Winterspring Screecher"
UPDATE `creature_template_locale` SET `Name` = '비명소리 여명의설원 올빼미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7456;
-- AC datas : OLD Name : "덩치 큰 얼음엉겅퀴설인", Name AC enUS : "Ice Thistle Patriarch" ; Wowhead enUS : "Ice Thistle Patriarch"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 얼음엉겅퀴설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7460;
-- AC datas : OLD Name : "은빛소나무숲 죽음경비병", Name AC enUS : "Silverpine Deathguard" ; Wowhead enUS : "Silverpine Deathguard"
UPDATE `creature_template_locale` SET `Name` = '은빛소나무숲 죽음의경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7489;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Dragonscale Leatherworking Trainer" ; Wowhead enUS : "Dragonscale Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '용비늘 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7525;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Elemental Leatherworking Trainer" ; Wowhead enUS : "Elemental Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '원소 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7526;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Tribal Leatherworking Trainer" ; Wowhead enUS : "Tribal Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전통 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7528;
-- AC datas : OLD Name : "진홍빛 새끼용", Name AC enUS : "Crimson Whelpling" ; Wowhead enUS : "Crimson Whelpling"
UPDATE `creature_template_locale` SET `Name` = '작은 붉은 새끼용', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7544;
-- AC datas : OLD Name : "눈덧신 토끼", Name AC enUS : "Snowshoe Rabbit" ; Wowhead enUS : "Snowshoe Rabbit"
UPDATE `creature_template_locale` SET `Name` = '눈덧신토끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7560;
-- AC datas : OLD Name : "슬림의 시험용 죽음의 기사", Name AC enUS : "Slim's Test Death Knight" ; Wowhead enUS : "Slim's Test Death Knight"
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7624;
-- AC datas : OLD Name : "잿빛 골짜기 전사", Name AC enUS : "Ashenvale Warrior" ; Wowhead enUS : "Ashenvale Warrior"
UPDATE `creature_template_locale` SET `Name` = '잿빛골짜기 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7663;
-- AC datas : OLD Name : "표범", Name AC enUS : "Leopard" ; Wowhead enUS : "Leopard"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Yellow)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7684;
-- AC datas : OLD Name : "벵갈호랑이", Name AC enUS : "Bengal Tiger" ; Wowhead enUS : "Bengal Tiger"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Red)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7686;
-- AC datas : OLD Name : "점박이밤호랑이", Name AC enUS : "Spotted Nightsaber" ; Wowhead enUS : "Spotted Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (BlackSpotted)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7689;
-- AC datas : OLD Name : "검은색 랩터", Name AC enUS : "Obsidian Raptor" ; Wowhead enUS : "Obsidian Raptor"
UPDATE `creature_template_locale` SET `Name` = '길들인 랩터 (Obsidian)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7703;
-- AC datas : OLD Name : "붉은 점박이 랩터", Name AC enUS : "Mottled Red Raptor" ; Wowhead enUS : "Mottled Red Raptor"
UPDATE `creature_template_locale` SET `Name` = '길들인 랩터 (Crimson)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7704;
-- AC datas : OLD Name : "상아색 랩터", Name AC enUS : "Ivory Raptor" ; Wowhead enUS : "Ivory Raptor"
UPDATE `creature_template_locale` SET `Name` = '길들인 랩터 (Ivory)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7706;
-- AC datas : OLD Name : "비울라", Name AC enUS : "Innkeeper Byula" ; Wowhead enUS : "Innkeeper Byula",  OLD Subname : "전직 여관주인", Subname AC enUS : "Innkeeper" ; Wowhead enUS : "Innkeeper"
UPDATE `creature_template_locale` SET `Name` = '여관주인 비울라', `Title` = '여관주인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7714;
-- AC datas : OLD Name : "그림토템 침략자", Name AC enUS : "Grimtotem Raider" ; Wowhead enUS : "Grimtotem Raider"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 침략자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7725;
-- AC datas : OLD Name : "그림토템 식물학자", Name AC enUS : "Grimtotem Naturalist" ; Wowhead enUS : "Grimtotem Naturalist"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 식물학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7726;
-- AC datas : OLD Name : "그림토템 주술사", Name AC enUS : "Grimtotem Shaman" ; Wowhead enUS : "Grimtotem Shaman"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7727;
-- AC datas : OLD Name : "마른나무껍질 지옥사냥개", Name AC enUS : "Witherbark Felhunter" ; Wowhead enUS : "Witherbark Felhunter"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 지옥사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7767;
-- AC datas : OLD Name : "마른나무껍질 새끼거미", Name AC enUS : "Witherbark Bloodling" ; Wowhead enUS : "Witherbark Bloodling"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 새끼거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7768;
-- AC datas : OLD Name : "그레간 브루스퓨워", Name AC enUS : "Gregan Brewspewer" ; Wowhead enUS : "Gregan Brewspewer"
UPDATE `creature_template_locale` SET `Name` = '그레간 브루스퓨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7775;
-- AC datas : OLD Subname : "마른나무껍질 트롤", Subname AC enUS : "Witherbark Troll" ; Wowhead enUS : "Witherbark Troll"
UPDATE `creature_template_locale` SET `Title` = '마른나무껍질부족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7780;
-- AC datas : OLD Name : "로라무스 탈리페데스", Name AC enUS : "Loramus Thalipedes" ; Wowhead enUS : "Loramus Thalipedes"
UPDATE `creature_template_locale` SET `Name` = '로라무스 탈리뻬데스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7783;
-- AC datas : OLD Name : "성난모래 노예", Name AC enUS : "Sandfury Slave" ; Wowhead enUS : "Sandfury Slave"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7787;
-- AC datas : OLD Name : "성난모래 노역꾼", Name AC enUS : "Sandfury Drudge" ; Wowhead enUS : "Sandfury Drudge"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 노역꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7788;
-- AC datas : OLD Name : "성난모래 정신병자", Name AC enUS : "Sandfury Cretin" ; Wowhead enUS : "Sandfury Cretin"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 정신병자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7789;
-- AC datas : OLD Name : "썩은가지 복병", Name AC enUS : "Vilebranch Ambusher" ; Wowhead enUS : "Vilebranch Ambusher"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7809;
-- AC datas : OLD Name : "어슬렁거리는 거친흉터 설인", Name AC enUS : "Lurking Feral Scar" ; Wowhead enUS : "Lurking Feral Scar"
UPDATE `creature_template_locale` SET `Name` = '어슬렁거리는 원시설인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7848;
-- AC datas : OLD Name : "남쪽바다 해적", Name AC enUS : "Southsea Pirate" ; Wowhead enUS : "Southsea Pirate"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 무법자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7855;
-- AC datas : OLD Name : "남쪽바다 약탈자", Name AC enUS : "Southsea Freebooter" ; Wowhead enUS : "Southsea Freebooter"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7856;
-- AC datas : OLD Name : "남쪽바다 부두일꾼", Name AC enUS : "Southsea Dock Worker" ; Wowhead enUS : "Southsea Dock Worker"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 부두일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7857;
-- AC datas : OLD Name : "남쪽바다 칼잡이", Name AC enUS : "Southsea Swashbuckler" ; Wowhead enUS : "Southsea Swashbuckler"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 칼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7858;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Dragonscale Leatherworking Trainer" ; Wowhead enUS : "Dragonscale Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 용비늘 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7866;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Dragonscale Leatherworking Trainer" ; Wowhead enUS : "Dragonscale Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 용비늘 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7867;
-- AC datas : OLD Name : "사라 태너", Name AC enUS : "Sarah Tanner" ; Wowhead enUS : "Sarah Tanner",  OLD Subname : "전문 가죽세공인", Subname AC enUS : "Elemental Leatherworking Trainer" ; Wowhead enUS : "Elemental Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Name` = '사라 터너', `Title` = '전문 원소 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7868;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Elemental Leatherworking Trainer" ; Wowhead enUS : "Elemental Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 원소 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7869;
-- AC datas : OLD Name : "캐리시아 문헌터", Name AC enUS : "Caryssia Moonhunter" ; Wowhead enUS : "Caryssia Moonhunter",  OLD Subname : "전문 가죽세공인", Subname AC enUS : "Tribal Leatherworking Trainer" ; Wowhead enUS : "Tribal Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Name` = '카리시아 문헌터', `Title` = '전문 전통 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7870;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Tribal Leatherworking Trainer" ; Wowhead enUS : "Tribal Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 전통 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7871;
-- AC datas : OLD Name : "가시덩굴 전투호위병", Name AC enUS : "Razorfen Battleguard" ; Wowhead enUS : "Razorfen Battleguard"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7873;
-- AC datas : OLD Name : "가시덩굴 가시마술사", Name AC enUS : "Razorfen Thornweaver" ; Wowhead enUS : "Razorfen Thornweaver"
UPDATE `creature_template_locale` SET `Name` = '가시덩굴일족 가시마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7874;
-- AC datas : OLD Name : "퀸티스 존스파이어", Name AC enUS : "Quintis Jonespyre" ; Wowhead enUS : "Quintis Jonespyre"
UPDATE `creature_template_locale` SET `Name` = '쿠인티스 존스피레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7879;
-- AC datas : OLD Name : "원한꼬리 전투대장", Name AC enUS : "Spitelash Battlemaster" ; Wowhead enUS : "Spitelash Battlemaster"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 전투대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7885;
-- AC datas : OLD Name : "원한꼬리 요술사", Name AC enUS : "Spitelash Enchantress" ; Wowhead enUS : "Spitelash Enchantress"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 마법부여사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7886;
-- AC datas : OLD Subname : "트로야스의 소환수", Subname AC enUS : "Troyas' Pet" ; Wowhead enUS : "Troyas' Pet"
UPDATE `creature_template_locale` SET `Title` = '트로야스의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7903;
-- AC datas : OLD Subname : "안젤라스의 소환수", Subname AC enUS : "Angelas' Pet" ; Wowhead enUS : "Angelas' Pet"
UPDATE `creature_template_locale` SET `Title` = '안젤라스의 야수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7904;
-- AC datas : OLD Name : "황금골 경비병", Name AC enUS : "Goldshire Guard" ; Wowhead enUS : "Goldshire Guard"
UPDATE `creature_template_locale` SET `Name` = '골드샤이어 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7906;
-- AC datas : OLD Name : "페더문 파수꾼", Name AC enUS : "Feathermoon Sentinel" ; Wowhead enUS : "Feathermoon Sentinel"
UPDATE `creature_template_locale` SET `Name` = '페더문요새 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7939;
-- AC datas : OLD Subname : "노움 전문 기계공학자", Subname AC enUS : "Gnomish Engineering Trainer" ; Wowhead enUS : "Gnomish Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '노움 기술자 조합장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7944;
-- AC datas : OLD Subname : "전문 기수", Subname AC enUS : "Mechanostrider Pilot" ; Wowhead enUS : "Mechanostrider Pilot"
UPDATE `creature_template_locale` SET `Title` = '기계타조 조종사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7954;
-- AC datas : OLD Name : "나라체 야영지 용사", Name AC enUS : "Mulgore Protector" ; Wowhead enUS : "Mulgore Protector"
UPDATE `creature_template_locale` SET `Name` = '멀고어 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7975;
-- AC datas : OLD Name : "정예 죽음경비병", Name AC enUS : "Deathguard Elite" ; Wowhead enUS : "Deathguard Elite"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비대 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7980;
-- AC datas : OLD Name : "수호자 퀴아가", Name AC enUS : "Qiaga the Keeper" ; Wowhead enUS : "Qiaga the Keeper"
UPDATE `creature_template_locale` SET `Name` = '문지기 퀴아가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 7996;
-- AC datas : OLD Name : "잿빛 골짜기 파수꾼", Name AC enUS : "Ashenvale Sentinel" ; Wowhead enUS : "Ashenvale Sentinel"
UPDATE `creature_template_locale` SET `Name` = '잿빛골짜기 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8015;
-- AC datas : OLD Name : "검은무쇠 지뢰", Name AC enUS : "Dark Iron Land Mine" ; Wowhead enUS : "Dark Iron Land Mine"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 지뢰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8035;
-- AC datas : OLD Name : "서부 몰락지대 여단 경비병", Name AC enUS : "Protector of the People" ; Wowhead enUS : "Protector of the People",  OLD Subname : "", Subname AC enUS : "The People's Militia" ; Wowhead enUS : "The People's Militia"
UPDATE `creature_template_locale` SET `Name` = '민병대원', `Title` = '백성의 민병대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8096;
-- AC datas : OLD Subname : "고블린 전문 기계공학자", Subname AC enUS : "Goblin Engineering Trainer" ; Wowhead enUS : "Goblin Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '고블린 기술자 조합장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8126;
-- AC datas : OLD Name : "신드라 톨그라스", Name AC enUS : "Sheendra Tallgrass" ; Wowhead enUS : "Sheendra Tallgrass"
UPDATE `creature_template_locale` SET `Name` = '신드라 톨그래스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8145;
-- AC datas : OLD Name : "모자케 야영지 용사", Name AC enUS : "Camp Mojache Brave" ; Wowhead enUS : "Camp Mojache Brave"
UPDATE `creature_template_locale` SET `Name` = '모자케야영지 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8147;
-- AC datas : OLD Name : "나이젤의 야영지 경비병", Name AC enUS : "Nijel's Point Guard" ; Wowhead enUS : "Nijel's Point Guard"
UPDATE `creature_template_locale` SET `Name` = '나이젤의야영지 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8151;
-- AC datas : OLD Name : "오쿨루스", Name AC enUS : "Occulus" ; Wowhead enUS : "Occulus"
UPDATE `creature_template_locale` SET `Name` = '오크쿨루스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8196;
-- AC datas : OLD Name : "크레그 킬홀", Name AC enUS : "Kregg Keelhaul" ; Wowhead enUS : "Kregg Keelhaul"
UPDATE `creature_template_locale` SET `Name` = '크레그 킬하울', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8203;
-- AC datas : OLD Name : "잿불날개", Name AC enUS : "Greater Firebird" ; Wowhead enUS : "Greater Firebird"
UPDATE `creature_template_locale` SET `Name` = '거대한 불새', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8207;
-- AC datas : OLD Name : "추적자 메마른심장", Name AC enUS : "Witherheart the Stalker" ; Wowhead enUS : "Witherheart the Stalker"
UPDATE `creature_template_locale` SET `Name` = '추적자 매마른심장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8218;
-- AC datas : OLD Name : "진흙광포어", Name AC enUS : "Muck Frenzy" ; Wowhead enUS : "Muck Frenzy"
UPDATE `creature_template_locale` SET `Name` = '진흙프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8236;
-- AC datas : OLD Name : "불완전한 전쟁 골렘", Name AC enUS : "Faulty War Golem" ; Wowhead enUS : "Faulty War Golem"
UPDATE `creature_template_locale` SET `Name` = '불완전한 전투골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8279;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8306;
-- AC datas : OLD Name : "아탈라이 부족 영혼", Name AC enUS : "Atal'ai Deathwalker's Spirit" ; Wowhead enUS : "Atal'ai Deathwalker's Spirit"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8317;
-- AC datas : OLD Name : "아탈라이 노예", Name AC enUS : "Atal'ai Slave" ; Wowhead enUS : "Atal'ai Slave"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8318;
-- AC datas : OLD Name : "아탈라이 해골", Name AC enUS : "Atal'ai Skeleton" ; Wowhead enUS : "Atal'ai Skeleton"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 해골', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8324;
-- AC datas : OLD Name : "학카리 채찍천둥매", Name AC enUS : "Hakkari Sapper" ; Wowhead enUS : "Hakkari Sapper"
UPDATE `creature_template_locale` SET `Name` = '학카르 채찍천둥매', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8336;
-- AC datas : OLD Name : "검은무쇠 대장장이", Name AC enUS : "Dark Iron Steelshifter" ; Wowhead enUS : "Dark Iron Steelshifter"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8337;
-- AC datas : OLD Name : "검은무쇠 명사수", Name AC enUS : "Dark Iron Marksman" ; Wowhead enUS : "Dark Iron Marksman"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 명사수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8338;
-- AC datas : OLD Name : "어둠 전당의 아디", Name AC enUS : "Ahdi of Shadow Hall" ; Wowhead enUS : "Ahdi of Shadow Hall"
UPDATE `creature_template_locale` SET `Name` = '어둠의 전당의 아디', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8377;
-- AC datas : OLD Name : "롤랜드 기어대블러", Name AC enUS : "Roland Geardabbler" ; Wowhead enUS : "Roland Geardabbler"
UPDATE `creature_template_locale` SET `Name` = '롤랜드 기어드애블러', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8394;
-- AC datas : OLD Name : "황혼의 우상숭배자", Name AC enUS : "Twilight Idolater" ; Wowhead enUS : "Twilight Idolater"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 우상숭배자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8419;
-- AC datas : OLD Name : "학카리 문지기", Name AC enUS : "Hakkari Minion" ; Wowhead enUS : "Hakkari Minion"
UPDATE `creature_template_locale` SET `Name` = '학카르 문지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8437;
-- AC datas : OLD Name : "학카리 수호천둥매", Name AC enUS : "Hakkari Bloodkeeper" ; Wowhead enUS : "Hakkari Bloodkeeper"
UPDATE `creature_template_locale` SET `Name` = '학카르 수호천둥매', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8438;
-- AC datas : OLD Name : "칼라란 윈드블레이드", Name AC enUS : "Kalaran Windblade" ; Wowhead enUS : "Velarok Windblade"
UPDATE `creature_template_locale` SET `Name` = '벨라로크 윈드블레이드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8479;
-- AC datas : OLD Name : "책략가 칼라란", Name AC enUS : "Kalaran the Deceiver" ; Wowhead enUS : "Velarok the Deceiver"
UPDATE `creature_template_locale` SET `Name` = '책략가 벨라로크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8480;
-- AC datas : OLD Name : "검은무쇠 경비병", Name AC enUS : "Dark Iron Sentry" ; Wowhead enUS : "Dark Iron Sentry"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8504;
-- AC datas : OLD Name : "잠말란의 사술", Name AC enUS : "Hex of Jammal'an" ; Wowhead enUS : "Hex of Jammal'an"
UPDATE `creature_template_locale` SET `Name` = '잠말란의 마물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8505;
-- AC datas : OLD Name : "아탈라이 토템", Name AC enUS : "Atal'ai Totem" ; Wowhead enUS : "Atal'ai Totem"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8510;
-- AC datas : OLD Name : "강령사", Name AC enUS : "Necrolyte" ; Wowhead enUS : "Necrolyte"
UPDATE `creature_template_locale` SET `Name` = '수습강령술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8552;
-- AC datas : OLD Name : "족장 칼날엄니", Name AC enUS : "Chief Sharptusk Thornmantle" ; Wowhead enUS : "Chief Sharptusk Thornmantle"
UPDATE `creature_template_locale` SET `Name` = '족장 뾰족어금니', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8554;
-- AC datas : OLD Name : "이끼껍질 정찰병", Name AC enUS : "Mossflayer Scout" ; Wowhead enUS : "Mossflayer Scout"
UPDATE `creature_template_locale` SET `Name` = '이끼껍질부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8560;
-- AC datas : OLD Name : "이끼껍질 어둠사냥꾼", Name AC enUS : "Mossflayer Shadowhunter" ; Wowhead enUS : "Mossflayer Shadowhunter"
UPDATE `creature_template_locale` SET `Name` = '이끼껍질부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8561;
-- AC datas : OLD Name : "이끼껍질 식인종", Name AC enUS : "Mossflayer Cannibal" ; Wowhead enUS : "Mossflayer Cannibal"
UPDATE `creature_template_locale` SET `Name` = '이끼껍질부족 식인종', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8562;
-- AC datas : OLD Name : "타락한 수렵꾼", Name AC enUS : "Woodsman" ; Wowhead enUS : "Woodsman"
UPDATE `creature_template_locale` SET `Name` = '수렵꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8563;
-- AC datas : OLD Name : "타락한 순찰자", Name AC enUS : "Ranger" ; Wowhead enUS : "Ranger"
UPDATE `creature_template_locale` SET `Name` = '순찰자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8564;
-- AC datas : OLD Name : "타락한 길잡이", Name AC enUS : "Pathstrider" ; Wowhead enUS : "Pathstrider"
UPDATE `creature_template_locale` SET `Name` = '길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8565;
-- AC datas : OLD Name : "검은무쇠 망꾼", Name AC enUS : "Dark Iron Lookout" ; Wowhead enUS : "Dark Iron Lookout"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 망꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8566;
-- AC datas : OLD Name : "덩치 큰 역병사냥개", Name AC enUS : "Plaguehound Mastiff" ; Wowhead enUS : "Plaguehound Mastiff"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 역병사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8599;
-- AC datas : OLD Name : "수호자 몰타기아", Name AC enUS : "Morta'gya the Keeper" ; Wowhead enUS : "Morta'gya the Keeper"
UPDATE `creature_template_locale` SET `Name` = '문지기 몰타기아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8636;
-- AC datas : OLD Name : "검은무쇠 보초", Name AC enUS : "Dark Iron Watchman" ; Wowhead enUS : "Dark Iron Watchman"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8637;
-- AC datas : OLD Name : "후쿠의 공허방랑자", Name AC enUS : "Hukku's Voidwalker" ; Wowhead enUS : "Hukku's Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '후쿠의 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8656;
-- AC datas : OLD Name : "태양길잡이 살옌", Name AC enUS : "Saern Priderunner" ; Wowhead enUS : "Saern Priderunner"
UPDATE `creature_template_locale` SET `Name` = '살옌 프라이드러너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8664;
-- AC datas : OLD Name : "꼬마 티미", Name AC enUS : "Lil Timmy" ; Wowhead enUS : "Lil Timmy"
UPDATE `creature_template_locale` SET `Name` = '릴 티미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8666;
-- AC datas : OLD Name : "공용 노움 전문 기계공학자", Name AC enUS : "World Gnome Engineering Trainer" ; Wowhead enUS : "World Gnome Engineering Trainer",  OLD Subname : "노움 전문 기계공학자", Subname AC enUS : "Gnomish Engineering Trainer" ; Wowhead enUS : "Gnomish Engineering Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 전문 노움 기술자', `Title` = '전문 노움 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8676;
-- AC datas : OLD Name : "공용 고블린 전문 기계공학자", Name AC enUS : "World Goblin Engineering Trainer" ; Wowhead enUS : "World Goblin Engineering Trainer",  OLD Subname : "고블린 전문 기계공학자", Subname AC enUS : "Goblin Engineering Trainer" ; Wowhead enUS : "Goblin Engineering Trainer"
UPDATE `creature_template_locale` SET `Name` = '공용 고블린 전문 기술자', `Title` = '고블린 전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8677;
-- AC datas : OLD Name : "공포의 군주", Name AC enUS : "Dreadlord" ; Wowhead enUS : "Dreadlord"
UPDATE `creature_template_locale` SET `Name` = '공포의군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8716;
-- AC datas : OLD Name : "정예 지옥수호병", Name AC enUS : "Felguard Elite" ; Wowhead enUS : "Felguard Elite"
UPDATE `creature_template_locale` SET `Name` = '정예 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8717;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8736;
-- AC datas : OLD Name : "바자리오 링크그리스", Name AC enUS : "Vazario Linkgrease" ; Wowhead enUS : "Vazario Linkgrease",  OLD Subname : "고블린 전문 기계공학자", Subname AC enUS : "Goblin Engineering Trainer" ; Wowhead enUS : "Goblin Engineering Trainer"
UPDATE `creature_template_locale` SET `Name` = '바자리오 링크그리즈', `Title` = '고블린 기술자 조합장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8738;
-- AC datas : OLD Name : "성난모래 수행사제", Name AC enUS : "Sandfury Acolyte" ; Wowhead enUS : "Sandfury Acolyte"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 수행사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8876;
-- AC datas : OLD Name : "성난모래 광신도", Name AC enUS : "Sandfury Zealot" ; Wowhead enUS : "Sandfury Zealot"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8877;
-- AC datas : OLD Name : "성난모루 감독관", Name AC enUS : "Anvilrage Overseer" ; Wowhead enUS : "Anvilrage Overseer"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8889;
-- AC datas : OLD Name : "성난모루 교도관", Name AC enUS : "Anvilrage Warden" ; Wowhead enUS : "Anvilrage Warden"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 교도관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8890;
-- AC datas : OLD Name : "성난모루 보초", Name AC enUS : "Anvilrage Guardsman" ; Wowhead enUS : "Anvilrage Guardsman"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8891;
-- AC datas : OLD Name : "성난모루 보병", Name AC enUS : "Anvilrage Footman" ; Wowhead enUS : "Anvilrage Footman"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8892;
-- AC datas : OLD Name : "성난모루 병사", Name AC enUS : "Anvilrage Soldier" ; Wowhead enUS : "Anvilrage Soldier"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8893;
-- AC datas : OLD Name : "성난모루 간호병", Name AC enUS : "Anvilrage Medic" ; Wowhead enUS : "Anvilrage Medic"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 간호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8894;
-- AC datas : OLD Name : "성난모루 장교", Name AC enUS : "Anvilrage Officer" ; Wowhead enUS : "Anvilrage Officer"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8895;
-- AC datas : OLD Name : "어둠괴철로 일꾼", Name AC enUS : "Shadowforge Peasant" ; Wowhead enUS : "Shadowforge Peasant"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8896;
-- AC datas : OLD Name : "파멸괴철로 땜장이", Name AC enUS : "Doomforge Craftsman" ; Wowhead enUS : "Doomforge Craftsman"
UPDATE `creature_template_locale` SET `Name` = '파멸괴철로단 땜장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8897;
-- AC datas : OLD Name : "성난모루 치안대장", Name AC enUS : "Anvilrage Marshal" ; Wowhead enUS : "Anvilrage Marshal"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 치안대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8898;
-- AC datas : OLD Name : "파멸괴철로 용기병", Name AC enUS : "Doomforge Dragoon" ; Wowhead enUS : "Doomforge Dragoon"
UPDATE `creature_template_locale` SET `Name` = '파멸괴철로단 용기병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8899;
-- AC datas : OLD Name : "파멸괴철로 신비대장장이", Name AC enUS : "Doomforge Arcanasmith" ; Wowhead enUS : "Doomforge Arcanasmith"
UPDATE `creature_template_locale` SET `Name` = '파멸괴철로단 신비의대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8900;
-- AC datas : OLD Name : "성난모루 보충병", Name AC enUS : "Anvilrage Reservist" ; Wowhead enUS : "Anvilrage Reservist"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 보충병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8901;
-- AC datas : OLD Name : "어둠괴철로 민간인", Name AC enUS : "Shadowforge Citizen" ; Wowhead enUS : "Shadowforge Citizen"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 민간인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8902;
-- AC datas : OLD Name : "성난모루 대장", Name AC enUS : "Anvilrage Captain" ; Wowhead enUS : "Anvilrage Captain"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8903;
-- AC datas : OLD Name : "어둠괴철로 원로원", Name AC enUS : "Shadowforge Senator" ; Wowhead enUS : "Shadowforge Senator"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 원로원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8904;
-- AC datas : OLD Name : "전쟁인도자 피조물", Name AC enUS : "Warbringer Construct" ; Wowhead enUS : "Warbringer Construct"
UPDATE `creature_template_locale` SET `Name` = '재앙의 피조물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8905;
-- AC datas : OLD Name : "뜨겁게 달궈진 전쟁 골렘", Name AC enUS : "Molten War Golem" ; Wowhead enUS : "Molten War Golem"
UPDATE `creature_template_locale` SET `Name` = '뜨겁게 달궈진 전투골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8908;
-- AC datas : OLD Name : "황혼의 망치단 고문관", Name AC enUS : "Twilight's Hammer Torturer" ; Wowhead enUS : "Twilight's Hammer Torturer"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 고문관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8912;
-- AC datas : OLD Name : "황혼의 밀사", Name AC enUS : "Twilight Emissary" ; Wowhead enUS : "Twilight Emissary"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 밀사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8913;
-- AC datas : OLD Name : "황혼의 경호원", Name AC enUS : "Twilight Bodyguard" ; Wowhead enUS : "Twilight Bodyguard"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 경호원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8914;
-- AC datas : OLD Name : "황혼의 망치단 사절", Name AC enUS : "Twilight's Hammer Ambassador" ; Wowhead enUS : "Twilight's Hammer Ambassador"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8915;
-- AC datas : OLD Name : "덩치 큰 핏빛사냥개", Name AC enUS : "Bloodhound Mastiff" ; Wowhead enUS : "Bloodhound Mastiff"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 핏빛사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8922;
-- AC datas : OLD Name : "니다", Name AC enUS : "Hilary" ; Wowhead enUS : "Hilary"
UPDATE `creature_template_locale` SET `Name` = '힐러리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8962;
-- AC datas : OLD Name : "검은바위 비룡", Name AC enUS : "Blackrock Drake" ; Wowhead enUS : "Blackrock Drake"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 비룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8964;
-- AC datas : OLD Name : "불자루 우두머리", Name AC enUS : "Firegut Captain" ; Wowhead enUS : "Firegut Captain"
UPDATE `creature_template_locale` SET `Name` = '불자루일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8980;
-- AC datas : OLD Name : "하급 공허방랑자", Name AC enUS : "Voidwalker Minion" ; Wowhead enUS : "Voidwalker Minion"
UPDATE `creature_template_locale` SET `Name` = '하급 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 8996;
-- AC datas : OLD Name : "불의 군주 인센디우스", Name AC enUS : "Lord Incendius" ; Wowhead enUS : "Lord Incendius"
UPDATE `creature_template_locale` SET `Name` = '불의군주 인센디우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9017;
-- AC datas : OLD Name : "불의 군주 록코르", Name AC enUS : "Lord Roccor" ; Wowhead enUS : "Lord Roccor"
UPDATE `creature_template_locale` SET `Name` = '불의군주 록코르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9025;
-- AC datas : OLD Name : "고를로프", Name AC enUS : "Gor'tesh" ; Wowhead enUS : "Gor'tesh"
UPDATE `creature_template_locale` SET `Name` = '고르테쉬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9176;
-- AC datas : OLD Name : "오랄리우스", Name AC enUS : "Oralius" ; Wowhead enUS : "Oralius"
UPDATE `creature_template_locale` SET `Name` = '랄리우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9177;
-- AC datas : OLD Name : "이벤트 생성기", Name AC enUS : "World Event Generator" ; Wowhead enUS : "World Event Generator"
UPDATE `creature_template_locale` SET `Name` = '공용 이벤트 생성기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9180;
-- AC datas : OLD Name : "대영주 오모크", Name AC enUS : "Highlord Omokk" ; Wowhead enUS : "Highlord Omokk"
UPDATE `creature_template_locale` SET `Name` = '대군주 오모크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9196;
-- AC datas : OLD Name : "뾰족바위 전투마법사", Name AC enUS : "Spirestone Battle Mage" ; Wowhead enUS : "Spirestone Battle Mage"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 전투마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9197;
-- AC datas : OLD Name : "뾰족바위 비술사", Name AC enUS : "Spirestone Mystic" ; Wowhead enUS : "Spirestone Mystic"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9198;
-- AC datas : OLD Name : "뾰족바위 집행자", Name AC enUS : "Spirestone Enforcer" ; Wowhead enUS : "Spirestone Enforcer"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9199;
-- AC datas : OLD Name : "뾰족바위 약탈꾼", Name AC enUS : "Spirestone Reaver" ; Wowhead enUS : "Spirestone Reaver"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9200;
-- AC datas : OLD Name : "뾰족바위 오우거마법사", Name AC enUS : "Spirestone Ogre Magus" ; Wowhead enUS : "Spirestone Ogre Magus"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 오우거마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9201;
-- AC datas : OLD Name : "뾰족바위 투사", Name AC enUS : "Spirestone Warlord" ; Wowhead enUS : "Spirestone Warlord"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9216;
-- AC datas : OLD Name : "뾰족바위 마법사장", Name AC enUS : "Spirestone Lord Magus" ; Wowhead enUS : "Spirestone Lord Magus"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 마법사장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9217;
-- AC datas : OLD Name : "뾰족바위 전투대장", Name AC enUS : "Spirestone Battle Lord" ; Wowhead enUS : "Spirestone Battle Lord"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 전투대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9218;
-- AC datas : OLD Name : "뾰족바위 학살자", Name AC enUS : "Spirestone Butcher" ; Wowhead enUS : "Spirestone Butcher"
UPDATE `creature_template_locale` SET `Name` = '뾰족바위일족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9219;
-- AC datas : OLD Name : "가시불꽃 비술사", Name AC enUS : "Smolderthorn Mystic" ; Wowhead enUS : "Smolderthorn Mystic"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9239;
-- AC datas : OLD Name : "가시불꽃 어둠의 사제", Name AC enUS : "Smolderthorn Shadow Priest" ; Wowhead enUS : "Smolderthorn Shadow Priest"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 어둠의사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9240;
-- AC datas : OLD Name : "가시불꽃 인간사냥꾼", Name AC enUS : "Smolderthorn Headhunter" ; Wowhead enUS : "Smolderthorn Headhunter"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9241;
-- AC datas : OLD Name : "가시불꽃 어둠사냥꾼", Name AC enUS : "Smolderthorn Shadow Hunter" ; Wowhead enUS : "Smolderthorn Shadow Hunter"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9265;
-- AC datas : OLD Name : "가시불꽃 의술사", Name AC enUS : "Smolderthorn Witch Doctor" ; Wowhead enUS : "Smolderthorn Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9266;
-- AC datas : OLD Name : "가시불꽃 도끼투척병", Name AC enUS : "Smolderthorn Axe Thrower" ; Wowhead enUS : "Smolderthorn Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9267;
-- AC datas : OLD Name : "가시불꽃 광전사", Name AC enUS : "Smolderthorn Berserker" ; Wowhead enUS : "Smolderthorn Berserker"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9268;
-- AC datas : OLD Name : "가시불꽃 예언자", Name AC enUS : "Smolderthorn Seer" ; Wowhead enUS : "Smolderthorn Seer"
UPDATE `creature_template_locale` SET `Name` = '가시불꽃부족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9269;
-- AC datas : OLD Name : "밀리 오스워스", Name AC enUS : "Milly Osworth" ; Wowhead enUS : "Milly Osworth"
UPDATE `creature_template_locale` SET `Name` = '밀리 오스워드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9296;
-- AC datas : OLD Name : "발굴된 화석", Name AC enUS : "Living Storm" ; Wowhead enUS : "Living Storm"
UPDATE `creature_template_locale` SET `Name` = '살아있는 회오리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9397;
-- AC datas : OLD Name : "황혼의 망치단 집행자", Name AC enUS : "Twilight's Hammer Executioner" ; Wowhead enUS : "Twilight's Hammer Executioner"
UPDATE `creature_template_locale` SET `Name` = '황혼의망치단 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9398;
-- AC datas : OLD Name : "플러거 스패즈링", Name AC enUS : "Plugger Spazzring" ; Wowhead enUS : "Plugger Spazzring"
UPDATE `creature_template_locale` SET `Name` = '플러거 스파즈링', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9499;
-- AC datas : OLD Name : "팔랑크스", Name AC enUS : "Phalanx" ; Wowhead enUS : "Phalanx"
UPDATE `creature_template_locale` SET `Name` = '팔란스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9502;
-- AC datas : OLD Name : "검은바위 복병", Name AC enUS : "Blackrock Ambusher" ; Wowhead enUS : "Blackrock Ambusher"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9522;
-- AC datas : OLD Name : "콜카르 폭풍술사", Name AC enUS : "Kolkar Stormseer" ; Wowhead enUS : "Kolkar Stormseer"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 폭풍술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9523;
-- AC datas : OLD Name : "콜카르 침략꾼", Name AC enUS : "Kolkar Invader" ; Wowhead enUS : "Kolkar Invader"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 침략꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9524;
-- AC datas : OLD Name : "높새바람 용사", Name AC enUS : "Freewind Brave" ; Wowhead enUS : "Freewind Brave"
UPDATE `creature_template_locale` SET `Name` = '높새바람 봉우리 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9525;
-- AC datas : OLD Name : "술 취한 손님", Name AC enUS : "Guzzling Patron" ; Wowhead enUS : "Guzzling Patron"
UPDATE `creature_template_locale` SET `Name` = '술취한 손님', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9547;
-- AC datas : OLD Name : "보란드", Name AC enUS : "Borand" ; Wowhead enUS : "Borand"
UPDATE `creature_template_locale` SET `Name` = '보른다', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9549;
-- AC datas : OLD Name : "나디아 버논", Name AC enUS : "Nadia Vernon" ; Wowhead enUS : "Nadia Vernon"
UPDATE `creature_template_locale` SET `Name` = '나디아 베르논', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9553;
-- AC datas : OLD Name : "그리즐로", Name AC enUS : "Grizzlowe" ; Wowhead enUS : "Grizzlowe"
UPDATE `creature_template_locale` SET `Name` = '그리즐로위', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9559;
-- AC datas : OLD Name : "자페타", Name AC enUS : "Zapetta" ; Wowhead enUS : "Zapetta"
UPDATE `creature_template_locale` SET `Name` = '제페타', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9566;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Master Shadoweave Tailor" ; Wowhead enUS : "Master Shadoweave Tailor"
UPDATE `creature_template_locale` SET `Title` = '그림자매듭 재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9584;
-- AC datas : OLD Name : "검은바위 공격대원", Name AC enUS : "Blackrock Raider" ; Wowhead enUS : "Blackrock Raider"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 공격대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9605;
-- AC datas : OLD Name : "침 흘리는 검은불늑대", Name AC enUS : "Slavering Ember Worg" ; Wowhead enUS : "Slavering Ember Worg"
UPDATE `creature_template_locale` SET `Name` = '굶주린 검은불늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9694;
-- AC datas : OLD Name : "[미사용] 그루르크", Name AC enUS : "Grurk" ; Wowhead enUS : "Grurk"
UPDATE `creature_template_locale` SET `Name` = '그루르크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9702;
-- AC datas : OLD Name : "[미사용] 일투르크", Name AC enUS : "Il'thurk" ; Wowhead enUS : "Il'thurk"
UPDATE `creature_template_locale` SET `Name` = '일투르크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9703;
-- AC datas : OLD Name : "[미사용] 루무르크", Name AC enUS : "Lumurk" ; Wowhead enUS : "Lumurk"
UPDATE `creature_template_locale` SET `Name` = '루무르크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9704;
-- AC datas : OLD Name : "환상의 꿈감시자", Name AC enUS : "Illusionary Dreamwatcher" ; Wowhead enUS : "Illusionary Dreamwatcher"
UPDATE `creature_template_locale` SET `Name` = '환상의 꿈의감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9705;
-- AC datas : OLD Name : "방패부대 차원문", Name AC enUS : "Scarshield Portal" ; Wowhead enUS : "Scarshield Portal"
UPDATE `creature_template_locale` SET `Name` = '방패부대 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9707;
-- AC datas : OLD Name : "불의 수호자 엠버시어", Name AC enUS : "Pyroguard Emberseer" ; Wowhead enUS : "Pyroguard Emberseer"
UPDATE `creature_template_locale` SET `Name` = '불의수호자 엠버시어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9816;
-- AC datas : OLD Name : "살리아", Name AC enUS : "Salia" ; Wowhead enUS : "Salia"
UPDATE `creature_template_locale` SET `Name` = '살리라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9860;
-- AC datas : OLD Name : "제데나르 부대원", Name AC enUS : "Jaedenar Legionnaire" ; Wowhead enUS : "Jaedenar Legionnaire"
UPDATE `creature_template_locale` SET `Name` = '자에데나르 부대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9862;
-- AC datas : OLD Name : "어둠괴철로 불꽃지기", Name AC enUS : "Shadowforge Flame Keeper" ; Wowhead enUS : "Shadowforge Flame Keeper"
UPDATE `creature_template_locale` SET `Name` = '어둠괴철로단 불꽃지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9956;
-- AC datas : OLD Subname : "전직 야수 관리인", Subname AC enUS : "Stable Master" ; Wowhead enUS : "Stable Master"
UPDATE `creature_template_locale` SET `Title` = '야수 관리인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9983;
-- AC datas : OLD Name : "리나 하스스토브", Name AC enUS : "Lina Hearthstove" ; Wowhead enUS : "Lina Hearthstove"
UPDATE `creature_template_locale` SET `Name` = '리나 하스토브', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 9989;
-- AC datas : OLD Name : "호숫골 경비병", Name AC enUS : "Lakeshire Guard" ; Wowhead enUS : "Lakeshire Guard"
UPDATE `creature_template_locale` SET `Name` = '레이크샤이어 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10037;
-- AC datas : OLD Name : "어둠의 순찰대 경비병", Name AC enUS : "Night Watch Guard" ; Wowhead enUS : "Night Watch Guard"
UPDATE `creature_template_locale` SET `Name` = '어둠의순찰대 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10038;
-- AC datas : OLD Name : "킬리움 볼더토", Name AC enUS : "Killium Bouldertoe" ; Wowhead enUS : "Killium Bouldertoe"
UPDATE `creature_template_locale` SET `Name` = '킬리움 바울더토', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10061;
-- AC datas : OLD Name : "형광녹색 기계타조", Name AC enUS : "Fluorescent Green Mechanostrider" ; Wowhead enUS : "Fluorescent Green Mechanostrider"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Flourescent Green)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10178;
-- AC datas : OLD Name : "최신형 흰색 기계타조", Name AC enUS : "White Mechanostrider Mod B" ; Wowhead enUS : "White Mechanostrider Mod B"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Black)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10179;
-- AC datas : OLD Name : "불타는 지옥수호병", Name AC enUS : "Burning Felguard" ; Wowhead enUS : "Burning Felguard"
UPDATE `creature_template_locale` SET `Name` = '불타는 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10263;
-- AC datas : OLD Subname : "수습 대장장이", Subname AC enUS : "Apprentice Blacksmith" ; Wowhead enUS : "Apprentice Blacksmith"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10266;
-- AC datas : OLD Name : "사로잡은 악령숲 수액괴물", Name AC enUS : "Captured Felwood Ooze" ; Wowhead enUS : "Captured Felwood Ooze"
UPDATE `creature_template_locale` SET `Name` = '사로잡은 악령의숲 수액괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10290;
-- AC datas : OLD Subname : "", Subname AC enUS : "Dagger Trainer" ; Wowhead enUS : "Dagger Trainer"
UPDATE `creature_template_locale` SET `Title` = '단검류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10292;
-- AC datas : OLD Subname : "", Subname AC enUS : "Fist Weapons Trainer" ; Wowhead enUS : "Fist Weapons Trainer"
UPDATE `creature_template_locale` SET `Title` = '장착 무기류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10294;
-- AC datas : OLD Name : "아크라이드", Name AC enUS : "Vaelan" ; Wowhead enUS : "Vaelan"
UPDATE `creature_template_locale` SET `Name` = '밸란', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10296;
-- AC datas : OLD Subname : "", Subname AC enUS : "Bow Trainer" ; Wowhead enUS : "Bow Trainer"
UPDATE `creature_template_locale` SET `Title` = '궁술 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10297;
-- AC datas : OLD Name : "아크라이드", Name AC enUS : "Scarshield Infiltrator" ; Wowhead enUS : "Scarshield Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '방패부대 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10299;
-- AC datas : OLD Subname : "", Subname AC enUS : "Explorers' League" ; Wowhead enUS : "Explorers' League"
UPDATE `creature_template_locale` SET `Title` = '탐험가 연맹', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10301;
-- AC datas : OLD Name : "고대눈호랑이", Name AC enUS : "Ancient Frostsaber" ; Wowhead enUS : "Ancient Frostsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (White)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10322;
-- AC datas : OLD Name : "원시표범", Name AC enUS : "Primal Leopard" ; Wowhead enUS : "Primal Leopard"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Leopard)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10336;
-- AC datas : OLD Name : "갈색퓨마", Name AC enUS : "Tawny Sabercat" ; Wowhead enUS : "Tawny Sabercat"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Orange)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10337;
-- AC datas : OLD Name : "황금퓨마", Name AC enUS : "Golden Sabercat" ; Wowhead enUS : "Golden Sabercat"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Gold)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10338;
-- AC datas : OLD Subname : "마법 재료 및 독극물 상인", Subname AC enUS : "Reagents & Poison Supplies" ; Wowhead enUS : "Reagents & Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '마법 및 독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10364;
-- AC datas : OLD Name : "[미사용] 검은호위대 전사", Name AC enUS : "Black Guard Warrior" ; Wowhead enUS : "Black Guard Warrior"
UPDATE `creature_template_locale` SET `Name` = '검은호위대 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10395;
-- AC datas : OLD Name : "[미사용] 검은호위대 사형집행인", Name AC enUS : "Black Guard Executioner" ; Wowhead enUS : "Black Guard Executioner"
UPDATE `creature_template_locale` SET `Name` = '검은호위대 사형집행인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10397;
-- AC datas : OLD Name : "되살아난 보초", Name AC enUS : "Crimson Guardsman" ; Wowhead enUS : "Crimson Guardsman"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10418;
-- AC datas : OLD Name : "되살아난 요술사", Name AC enUS : "Crimson Conjuror" ; Wowhead enUS : "Crimson Conjuror"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 요술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10419;
-- AC datas : OLD Name : "되살아난 신입회원", Name AC enUS : "Crimson Initiate" ; Wowhead enUS : "Crimson Initiate"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 신입회원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10420;
-- AC datas : OLD Name : "되살아난 파수병", Name AC enUS : "Crimson Defender" ; Wowhead enUS : "Crimson Defender"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10421;
-- AC datas : OLD Name : "되살아난 사술사", Name AC enUS : "Crimson Sorcerer" ; Wowhead enUS : "Crimson Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 사술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10422;
-- AC datas : OLD Name : "되살아난 사제", Name AC enUS : "Crimson Priest" ; Wowhead enUS : "Crimson Priest"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10423;
-- AC datas : OLD Name : "되살아난 수행원", Name AC enUS : "Crimson Gallant" ; Wowhead enUS : "Crimson Gallant"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 수행원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10424;
-- AC datas : OLD Name : "되살아난 전투마법사", Name AC enUS : "Crimson Battle Mage" ; Wowhead enUS : "Crimson Battle Mage"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 전투마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10425;
-- AC datas : OLD Name : "되살아난 종교재판관", Name AC enUS : "Crimson Inquisitor" ; Wowhead enUS : "Crimson Inquisitor"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 종교재판관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10426;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crossbow Trainer" ; Wowhead enUS : "Crossbow Trainer"
UPDATE `creature_template_locale` SET `Title` = '석궁류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10446;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crossbow Trainer" ; Wowhead enUS : "Crossbow Trainer"
UPDATE `creature_template_locale` SET `Title` = '석궁류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10450;
-- AC datas : OLD Subname : "", Subname AC enUS : "Mace Trainer" ; Wowhead enUS : "Mace Trainer"
UPDATE `creature_template_locale` SET `Title` = '둔기류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10452;
-- AC datas : OLD Subname : "", Subname AC enUS : "Axe Trainer" ; Wowhead enUS : "Axe Trainer"
UPDATE `creature_template_locale` SET `Title` = '도끼류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10453;
-- AC datas : OLD Subname : "", Subname AC enUS : "Crossbow Trainer" ; Wowhead enUS : "Crossbow Trainer"
UPDATE `creature_template_locale` SET `Title` = '석궁류 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10454;
-- AC datas : OLD Name : "스칼로맨스 숙련마술사", Name AC enUS : "Scholomance Adept" ; Wowhead enUS : "Scholomance Adept"
UPDATE `creature_template_locale` SET `Name` = '스칼로맨스 숙련사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10469;
-- AC datas : OLD Name : "스칼로맨스 강령사", Name AC enUS : "Scholomance Necrolyte" ; Wowhead enUS : "Scholomance Necrolyte"
UPDATE `creature_template_locale` SET `Name` = '스칼로맨스 수습강령술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10476;
-- AC datas : OLD Name : "제드 룬워처", Name AC enUS : "Jed Runewatcher" ; Wowhead enUS : "Jed Runewatcher"
UPDATE `creature_template_locale` SET `Name` = '제드 룬와처', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10509;
-- AC datas : OLD Name : "우로크 집행자", Name AC enUS : "Urok Enforcer" ; Wowhead enUS : "Urok Enforcer"
UPDATE `creature_template_locale` SET `Name` = '우로크일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10601;
-- AC datas : OLD Name : "우로크 오우거마법사", Name AC enUS : "Urok Ogre Magus" ; Wowhead enUS : "Urok Ogre Magus"
UPDATE `creature_template_locale` SET `Name` = '우로크일족 오우거마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10602;
-- AC datas : OLD Name : "앵거스", Name AC enUS : "Angus" ; Wowhead enUS : "Angus"
UPDATE `creature_template_locale` SET `Name` = '앙구스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10610;
-- AC datas : OLD Name : "갈라크 전령", Name AC enUS : "Galak Messenger" ; Wowhead enUS : "Galak Messenger"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 전령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10617;
-- AC datas : OLD Name : "임시 주둔지 파수병", Name AC enUS : "Refuge Pointe Defender" ; Wowhead enUS : "Refuge Pointe Defender"
UPDATE `creature_template_locale` SET `Name` = '임시주둔지 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10696;
-- AC datas : OLD Name : "갈라크 암살자", Name AC enUS : "Galak Assassin" ; Wowhead enUS : "Galak Assassin"
UPDATE `creature_template_locale` SET `Name` = '갈라크일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10720;
-- AC datas : OLD Name : "대족장 겨울눈", Name AC enUS : "High Chief Winterfall" ; Wowhead enUS : "High Chief Winterfall"
UPDATE `creature_template_locale` SET `Name` = '대족장 눈사태', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10738;
-- AC datas : OLD Name : "그림토템 무법자", Name AC enUS : "Grimtotem Bandit" ; Wowhead enUS : "Grimtotem Bandit"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 무법자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10758;
-- AC datas : OLD Name : "그림토템 발굽전사", Name AC enUS : "Grimtotem Stomper" ; Wowhead enUS : "Grimtotem Stomper"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 발굽전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10759;
-- AC datas : OLD Name : "그림토템 흙점쟁이", Name AC enUS : "Grimtotem Geomancer" ; Wowhead enUS : "Grimtotem Geomancer"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10760;
-- AC datas : OLD Name : "그림토템 학살자", Name AC enUS : "Grimtotem Reaver" ; Wowhead enUS : "Grimtotem Reaver"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10761;
-- AC datas : OLD Name : "핑클 아인혼", Name AC enUS : "Finkle Einhorn" ; Wowhead enUS : "Pip Quickwit"
UPDATE `creature_template_locale` SET `Name` = '핀클 에인혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10776;
-- AC datas : OLD Name : "교관 갈포드", Name AC enUS : "Archivist Galford" ; Wowhead enUS : "Archivist Galford"
UPDATE `creature_template_locale` SET `Name` = '기록관 갈포드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10811;
-- AC datas : OLD Name : "죽음사냥꾼 호크스피어", Name AC enUS : "Ranger Lord Hawkspear" ; Wowhead enUS : "Ranger Lord Hawkspear"
UPDATE `creature_template_locale` SET `Name` = '순찰대장 호크스피어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10824;
-- AC datas : OLD Name : "죽음예언자 셀렌드레", Name AC enUS : "Deathspeaker Selendre" ; Wowhead enUS : "Deathspeaker Selendre"
UPDATE `creature_template_locale` SET `Name` = '죽음의전령사 셀렌드레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10827;
-- AC datas : OLD Name : "리니아 아벤디스", Name AC enUS : "High General Abbendis" ; Wowhead enUS : "High General Abbendis"
UPDATE `creature_template_locale` SET `Name` = '고위사령관 아벤디스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10828;
-- AC datas : OLD Name : "고위집행관 데링턴", Name AC enUS : "High Executor Derrington" ; Wowhead enUS : "High Executor Derrington"
UPDATE `creature_template_locale` SET `Name` = '고위집행관 델링턴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10837;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10839;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10840;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10857;
-- AC datas : OLD Name : "겨울눈 정찰꾼", Name AC enUS : "Winterfall Runner" ; Wowhead enUS : "Winterfall Runner"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10916;
-- AC datas : OLD Name : "뾰족창 트롤", Name AC enUS : "Shatterspear Troll" ; Wowhead enUS : "Shatterspear Troll"
UPDATE `creature_template_locale` SET `Name` = '뾰족창부족 트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10919;
-- AC datas : OLD Name : "다로우골 배반자", Name AC enUS : "Darrowshire Betrayer" ; Wowhead enUS : "Darrowshire Betrayer"
UPDATE `creature_template_locale` SET `Name` = '다로우샤이어 배반자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10947;
-- AC datas : OLD Name : "다로우골 파수병", Name AC enUS : "Darrowshire Defender" ; Wowhead enUS : "Darrowshire Defender"
UPDATE `creature_template_locale` SET `Name` = '다로우샤이어 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10948;
-- AC datas : OLD Name : "은빛 성기사단 사도", Name AC enUS : "Silver Hand Disciple" ; Wowhead enUS : "Silver Hand Disciple"
UPDATE `creature_template_locale` SET `Name` = '은빛성기사단 신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10949;
-- AC datas : OLD Name : "흰수염 졸개", Name AC enUS : "Whitewhisker Vermin" ; Wowhead enUS : "Whitewhisker Vermin"
UPDATE `creature_template_locale` SET `Name` = '흰수염일족 졸개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10982;
-- AC datas : OLD Name : "겨울도끼 광전사", Name AC enUS : "Winterax Berserker" ; Wowhead enUS : "Winterax Berserker"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10984;
-- AC datas : OLD Name : "자갈발 놀", Name AC enUS : "Wildpaw Gnoll" ; Wowhead enUS : "Wildpaw Gnoll"
UPDATE `creature_template_locale` SET `Name` = '자갈발일족 놀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10991;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10993;
-- AC datas : OLD Name : "윌리 호프브레이커", Name AC enUS : "Cannon Master Willey" ; Wowhead enUS : "Cannon Master Willey"
UPDATE `creature_template_locale` SET `Name` = '포병대장 윌리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10997;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11017;
-- AC datas : OLD Name : "제시르 문보우", Name AC enUS : "Jessir Moonbow" ; Wowhead enUS : "Jessir Moonbow"
UPDATE `creature_template_locale` SET `Name` = '제시 문보우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11019;
-- AC datas : OLD Name : "여명의 설원 눈호랑이", Name AC enUS : "Winterspring Frostsaber" ; Wowhead enUS : "Winterspring Frostsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (Winterspring)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11021;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11025;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '수습 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11026;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '수습 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11028;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '숙련 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11029;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11031;
-- AC datas : OLD Name : "사령관 말로", Name AC enUS : "Malor the Zealous" ; Wowhead enUS : "Malor the Zealous"
UPDATE `creature_template_locale` SET `Name` = '광신자 말로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11032;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11034;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11036;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11037;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11039;
-- AC datas : OLD Name : "되살아난 수도사", Name AC enUS : "Crimson Monk" ; Wowhead enUS : "Crimson Monk"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 수도사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11043;
-- AC datas : OLD Name : "되살아난 소총병", Name AC enUS : "Crimson Rifleman" ; Wowhead enUS : "Crimson Rifleman"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 소총병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11054;
-- AC datas : OLD Name : "프라스 샤비", Name AC enUS : "Fras Siabi" ; Wowhead enUS : "Ezra Grimm"
UPDATE `creature_template_locale` SET `Name` = '에즈라 그림', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11058;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11063;
-- AC datas : OLD Name : "다로우골 영혼", Name AC enUS : "Darrowshire Spirit" ; Wowhead enUS : "Darrowshire Spirit"
UPDATE `creature_template_locale` SET `Name` = '다로우샤이어 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11064;
-- AC datas : OLD Name : "제노바 스톤실드", Name AC enUS : "Jenova Stoneshield" ; Wowhead enUS : "Jenova Stoneshield"
UPDATE `creature_template_locale` SET `Name` = '제노바 소튼실드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11069;
-- AC datas : OLD Name : "은빛 기수", Name AC enUS : "Argent Rider" ; Wowhead enUS : "Argent Rider",  OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Name` = '은빛 여명회 기수', `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11102;
-- AC datas : OLD Name : "되살아난 대장장이", Name AC enUS : "Crimson Hammersmith" ; Wowhead enUS : "Crimson Hammersmith"
UPDATE `creature_template_locale` SET `Name` = '진홍십자군 대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11120;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith Trainer" ; Wowhead enUS : "Weaponsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11146;
-- AC datas : OLD Name : "보라색 기계타조", Name AC enUS : "Purple Mechanostrider" ; Wowhead enUS : "Purple Mechanostrider"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Purple)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11148;
-- AC datas : OLD Name : "적청색 기계타조", Name AC enUS : "Red and Blue Mechanostrider" ; Wowhead enUS : "Red and Blue Mechanostrider"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Red/Blue)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11149;
-- AC datas : OLD Name : "최신형 투명청색 기계타조", Name AC enUS : "Icy Blue Mechanostrider Mod A" ; Wowhead enUS : "Icy Blue Mechanostrider Mod A"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Icy Blue)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11150;
-- AC datas : OLD Name : "갈색 해골마", Name AC enUS : "Brown Skeletal Horse" ; Wowhead enUS : "Brown Skeletal Horse"
UPDATE `creature_template_locale` SET `Name` = '기계타조 (Brown)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11155;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmith" ; Wowhead enUS : "Armorsmith"
UPDATE `creature_template_locale` SET `Title` = '방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11177;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith" ; Wowhead enUS : "Weaponsmith"
UPDATE `creature_template_locale` SET `Title` = '무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11178;
-- AC datas : OLD Name : "은빛 수호병", Name AC enUS : "Argent Defender" ; Wowhead enUS : "Argent Defender",  OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Name` = '은빛 여명회 수호병', `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11194;
-- AC datas : OLD Name : "죽음의 군마", Name AC enUS : "Deathcharger" ; Wowhead enUS : "Deathcharger"
UPDATE `creature_template_locale` SET `Name` = '검은 해골군마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11195;
-- AC datas : OLD Name : "뾰족창 북장이", Name AC enUS : "Shatterspear Drummer" ; Wowhead enUS : "Shatterspear Drummer"
UPDATE `creature_template_locale` SET `Name` = '뾰족창부족 고수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11196;
-- AC datas : OLD Name : "루시앙 사크호프", Name AC enUS : "Lucien Sarkhoff" ; Wowhead enUS : "Lucien Sarkhoff"
UPDATE `creature_template_locale` SET `Name` = '루시엔 사크호프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11217;
-- AC datas : OLD Name : "부서질 듯한 해골", Name AC enUS : "Frail Skeleton" ; Wowhead enUS : "Frail Skeleton"
UPDATE `creature_template_locale` SET `Name` = '부서질것 같은 해골', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11258;
-- AC datas : OLD Name : "북녘골 인부", Name AC enUS : "Northshire Peasant" ; Wowhead enUS : "Northshire Peasant"
UPDATE `creature_template_locale` SET `Name` = '노스샤이어 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11260;
-- AC datas : OLD Name : "의사 테올렌 크라스티노브", Name AC enUS : "Doctor Theolen Krastinov" ; Wowhead enUS : "Doctor Theolen Krastinov"
UPDATE `creature_template_locale` SET `Name` = '학자 테올렌 크라스티노브', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11261;
-- AC datas : OLD Name : "이끼껍질 좀비", Name AC enUS : "Mossflayer Zombie" ; Wowhead enUS : "Mossflayer Zombie"
UPDATE `creature_template_locale` SET `Name` = '이끼껍질부족 좀비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11290;
-- AC datas : OLD Name : "죽지 못하는 이끼껍질 트롤", Name AC enUS : "Unliving Mossflayer" ; Wowhead enUS : "Unliving Mossflayer"
UPDATE `creature_template_locale` SET `Name` = '죽지 못하는 이끼껍질트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11291;
-- AC datas : OLD Name : "이끼껍질 광전사", Name AC enUS : "Mossflayer Berserker" ; Wowhead enUS : "Mossflayer Berserker"
UPDATE `creature_template_locale` SET `Name` = '이끼껍질부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11292;
-- AC datas : OLD Name : "다로우골 유령", Name AC enUS : "Darrowshire Poltergeist" ; Wowhead enUS : "Darrowshire Poltergeist"
UPDATE `creature_template_locale` SET `Name` = '다로우샤이어 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11296;
-- AC datas : OLD Name : "성난불길 주술사", Name AC enUS : "Ragefire Shaman" ; Wowhead enUS : "Ragefire Shaman"
UPDATE `creature_template_locale` SET `Name` = '성난불길일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11319;
-- AC datas : OLD Name : "녹아내린 정령", Name AC enUS : "Molten Elemental" ; Wowhead enUS : "Molten Elemental"
UPDATE `creature_template_locale` SET `Name` = '녹아내리는 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11321;
-- AC datas : OLD Name : "동쪽계곡 인부", Name AC enUS : "Eastvale Peasant" ; Wowhead enUS : "Eastvale Peasant"
UPDATE `creature_template_locale` SET `Name` = '동부벌목지 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11328;
-- AC datas : OLD Name : "학카리 흑마술사", Name AC enUS : "Hakkari Shadowcaster" ; Wowhead enUS : "Hakkari Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11338;
-- AC datas : OLD Name : "학카리 어둠사냥꾼", Name AC enUS : "Hakkari Shadow Hunter" ; Wowhead enUS : "Hakkari Shadow Hunter"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11339;
-- AC datas : OLD Name : "학카리 혈사제", Name AC enUS : "Hakkari Blood Priest" ; Wowhead enUS : "Hakkari Blood Priest"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 혈사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11340;
-- AC datas : OLD Name : "학카리 현자", Name AC enUS : "Hakkari Oracle" ; Wowhead enUS : "Hakkari Oracle"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 현자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11346;
-- AC datas : OLD Name : "구루바시 도끼투척병", Name AC enUS : "Gurubashi Axe Thrower" ; Wowhead enUS : "Gurubashi Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11350;
-- AC datas : OLD Name : "구루바시 인간사냥꾼", Name AC enUS : "Gurubashi Headhunter" ; Wowhead enUS : "Gurubashi Headhunter"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11351;
-- AC datas : OLD Name : "구루바시 광전사", Name AC enUS : "Gurubashi Berserker" ; Wowhead enUS : "Gurubashi Berserker"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11352;
-- AC datas : OLD Name : "구루바시 흡혈전사", Name AC enUS : "Gurubashi Blood Drinker" ; Wowhead enUS : "Gurubashi Blood Drinker"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 혈투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11353;
-- AC datas : OLD Name : "구루바시 전사", Name AC enUS : "Gurubashi Warrior" ; Wowhead enUS : "Gurubashi Warrior"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11355;
-- AC datas : OLD Name : "구루바시 용사", Name AC enUS : "Gurubashi Champion" ; Wowhead enUS : "Gurubashi Champion"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11356;
-- AC datas : OLD Name : "영혼약탈자", Name AC enUS : "Soulflayer" ; Wowhead enUS : "Soulflayer"
UPDATE `creature_template_locale` SET `Name` = '영혼의 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11359;
-- AC datas : OLD Name : "사술사 진도", Name AC enUS : "Jin'do the Hexxer" ; Wowhead enUS : "Jin'do the Hexxer"
UPDATE `creature_template_locale` SET `Name` = '주술사 진도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11380;
-- AC datas : OLD Name : "성난모래 전령", Name AC enUS : "Sandfury Speaker" ; Wowhead enUS : "Sandfury Speaker",  OLD Subname : "성난모래 부족 사절", Subname AC enUS : "Sandfury Troll Ambassador" ; Wowhead enUS : "Sandfury Troll Ambassador"
UPDATE `creature_template_locale` SET `Name` = '성난모래부족 전령', `Title` = '성난모래부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11387;
-- AC datas : OLD Name : "마른나무껍질 전령", Name AC enUS : "Witherbark Speaker" ; Wowhead enUS : "Witherbark Speaker",  OLD Subname : "마른나무껍질 트롤 사절", Subname AC enUS : "Witherbark Troll Ambassador" ; Wowhead enUS : "Witherbark Troll Ambassador"
UPDATE `creature_template_locale` SET `Name` = '마른나무껍질부족 전령', `Title` = '마른나무껍질부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11388;
-- AC datas : OLD Name : "붉은머리 전령", Name AC enUS : "Bloodscalp Speaker" ; Wowhead enUS : "Bloodscalp Speaker",  OLD Subname : "붉은머리 부족 사절", Subname AC enUS : "Bloodscalp Troll Ambassador" ; Wowhead enUS : "Bloodscalp Troll Ambassador"
UPDATE `creature_template_locale` SET `Name` = '붉은머리부족 전령', `Title` = '붉은머리부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11389;
-- AC datas : OLD Name : "백골가루 전령", Name AC enUS : "Skullsplitter Speaker" ; Wowhead enUS : "Skullsplitter Speaker",  OLD Subname : "백골가루 트롤 사절", Subname AC enUS : "Skullsplitter Troll Ambassador" ; Wowhead enUS : "Skullsplitter Troll Ambassador"
UPDATE `creature_template_locale` SET `Name` = '백골가루부족 전령', `Title` = '백골가루부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11390;
-- AC datas : OLD Name : "썩은가지 전령", Name AC enUS : "Vilebranch Speaker" ; Wowhead enUS : "Vilebranch Speaker",  OLD Subname : "썩은가지 트롤 사절", Subname AC enUS : "Vilebranch Troll Ambassador" ; Wowhead enUS : "Vilebranch Troll Ambassador"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 전령', `Title` = '썩은가지부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11391;
-- AC datas : OLD Name : "오드리 베르가라", Name AC enUS : "Audrey Vergara" ; Wowhead enUS : "Audrey Vergara"
UPDATE `creature_template_locale` SET `Name` = '오드레이 베르가라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11392;
-- AC datas : OLD Name : "고르독 집행자", Name AC enUS : "Gordok Enforcer" ; Wowhead enUS : "Gordok Enforcer"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11440;
-- AC datas : OLD Name : "고르독 투사", Name AC enUS : "Gordok Brute" ; Wowhead enUS : "Gordok Brute"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11441;
-- AC datas : OLD Name : "고르독 싸움꾼", Name AC enUS : "Gordok Mauler" ; Wowhead enUS : "Gordok Mauler"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11442;
-- AC datas : OLD Name : "고르독 오우거마법사", Name AC enUS : "Gordok Ogre-Mage" ; Wowhead enUS : "Gordok Ogre-Mage"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 오우거마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11443;
-- AC datas : OLD Name : "고르독 대마법사", Name AC enUS : "Gordok Mage-Lord" ; Wowhead enUS : "Gordok Mage-Lord"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 대마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11444;
-- AC datas : OLD Name : "고르독 전투대장", Name AC enUS : "Gordok Captain" ; Wowhead enUS : "Gordok Captain"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 전투대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11445;
-- AC datas : OLD Name : "고르독 영혼", Name AC enUS : "Gordok Spirit" ; Wowhead enUS : "Gordok Spirit"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11446;
-- AC datas : OLD Name : "고르독 흑마법사", Name AC enUS : "Gordok Warlock" ; Wowhead enUS : "Gordok Warlock"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11448;
-- AC datas : OLD Name : "고르독 약탈자", Name AC enUS : "Gordok Reaver" ; Wowhead enUS : "Gordok Reaver"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11450;
-- AC datas : OLD Name : "명가의 소환사", Name AC enUS : "Highborne Summoner" ; Wowhead enUS : "Highborne Summoner"
UPDATE `creature_template_locale` SET `Name` = '귀족 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11466;
-- AC datas : OLD Name : "해골이 된 명가", Name AC enUS : "Skeletal Highborne" ; Wowhead enUS : "Skeletal Highborne"
UPDATE `creature_template_locale` SET `Name` = '해골이 된 귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11476;
-- AC datas : OLD Name : "썩어가는 명가", Name AC enUS : "Rotting Highborne" ; Wowhead enUS : "Rotting Highborne"
UPDATE `creature_template_locale` SET `Name` = '썩어가는 귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11477;
-- AC datas : OLD Name : "[미사용] 불가사의한 소산물", Name AC enUS : "Arcane Horror" ; Wowhead enUS : "Arcane Horror"
UPDATE `creature_template_locale` SET `Name` = '불가사의한 소산물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11479;
-- AC datas : OLD Name : "일리아나 레이븐오크", Name AC enUS : "Illyanna Ravenoak" ; Wowhead enUS : "Illyanna Ravenoak"
UPDATE `creature_template_locale` SET `Name` = '일샨나 레이븐오크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11488;
-- AC datas : OLD Name : "패배의 스카르", Name AC enUS : "Skarr the Unbreakable" ; Wowhead enUS : "Skarr the Unbreakable"
UPDATE `creature_template_locale` SET `Name` = '무패의 스카르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11498;
-- AC datas : OLD Name : "나무구렁 문지기", Name AC enUS : "Timbermaw Warder" ; Wowhead enUS : "Timbermaw Warder"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 문지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11516;
-- AC datas : OLD Subname : "성난불길 일족 족장", Subname AC enUS : "Ragefire Chieftain" ; Wowhead enUS : "Ragefire Chieftain"
UPDATE `creature_template_locale` SET `Title` = '성난불길일족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11517;
-- AC datas : OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11536;
-- AC datas : OLD Name : "나무구렁 비술사", Name AC enUS : "Timbermaw Mystic" ; Wowhead enUS : "Timbermaw Mystic"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11552;
-- AC datas : OLD Name : "나무구렁 싸움꾼", Name AC enUS : "Timbermaw Woodbender" ; Wowhead enUS : "Timbermaw Woodbender"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11553;
-- AC datas : OLD Name : "마그람 유령", Name AC enUS : "Magrami Spectre" ; Wowhead enUS : "Magrami Spectre"
UPDATE `creature_template_locale` SET `Name` = '마그람일족 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11560;
-- AC datas : OLD Name : "깊은무쇠 주술사", Name AC enUS : "Irondeep Shaman" ; Wowhead enUS : "Irondeep Shaman"
UPDATE `creature_template_locale` SET `Name` = '깊은무쇠일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11600;
-- AC datas : OLD Name : "깊은무쇠 망치잡이", Name AC enUS : "Irondeep Skullthumper" ; Wowhead enUS : "Irondeep Skullthumper"
UPDATE `creature_template_locale` SET `Name` = '깊은무쇠일족 망치잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11602;
-- AC datas : OLD Name : "흰수염 채굴꾼", Name AC enUS : "Whitewhisker Digger" ; Wowhead enUS : "Whitewhisker Digger"
UPDATE `creature_template_locale` SET `Name` = '흰수염일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11603;
-- AC datas : OLD Name : "흰수염 흙점쟁이", Name AC enUS : "Whitewhisker Geomancer" ; Wowhead enUS : "Whitewhisker Geomancer"
UPDATE `creature_template_locale` SET `Name` = '흰수염일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11604;
-- AC datas : OLD Name : "흰수염 감독관", Name AC enUS : "Whitewhisker Overseer" ; Wowhead enUS : "Whitewhisker Overseer"
UPDATE `creature_template_locale` SET `Name` = '흰수염일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11605;
-- AC datas : OLD Name : "흰수염 코볼트", Name AC enUS : "Whitewhisker Tunnel Rat" ; Wowhead enUS : "Whitewhisker Tunnel Rat"
UPDATE `creature_template_locale` SET `Name` = '흰수염일족 코볼트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11606;
-- AC datas : OLD Name : "고고학자 "스패너" 베리아투스", Name AC enUS : "Digger "The Wrench" Veriatus" ; Wowhead enUS : "Digger "The Wrench" Veriatus"
UPDATE `creature_template_locale` SET `Name` = '"스패너" 고고학자 베리아투스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11617;
-- AC datas : OLD Name : "들창엄니", Name AC enUS : "Rattlegore" ; Wowhead enUS : "Rattlegore"
UPDATE `creature_template_locale` SET `Name` = '들창어금니', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11622;
-- AC datas : OLD Name : "전쟁노래 일꾼", Name AC enUS : "Warsong Peon" ; Wowhead enUS : "Warsong Peon"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11656;
-- AC datas : OLD Name : "불꽃꼬리 전사", Name AC enUS : "Flamewaker" ; Wowhead enUS : "Flamewaker"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11661;
-- AC datas : OLD Name : "불꽃꼬리 사제", Name AC enUS : "Flamewaker Priest" ; Wowhead enUS : "Flamewaker Priest"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11662;
-- AC datas : OLD Name : "불꽃꼬리 치유사", Name AC enUS : "Flamewaker Healer" ; Wowhead enUS : "Flamewaker Healer"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 치유사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11663;
-- AC datas : OLD Name : "불꽃꼬리 정예병", Name AC enUS : "Flamewaker Elite" ; Wowhead enUS : "Flamewaker Elite"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11664;
-- AC datas : OLD Name : "불의 군주", Name AC enUS : "Firelord" ; Wowhead enUS : "Firelord"
UPDATE `creature_template_locale` SET `Name` = '불의군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11668;
-- AC datas : OLD Name : "심장부 사냥개", Name AC enUS : "Ancient Core Hound" ; Wowhead enUS : "Ancient Core Hound"
UPDATE `creature_template_locale` SET `Name` = '고대의 심장부 사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11673;
-- AC datas : OLD Name : "서리바람 바람소환사", Name AC enUS : "Snowblind Windcaller" ; Wowhead enUS : "Snowblind Windcaller"
UPDATE `creature_template_locale` SET `Name` = '서리바람일족 바람마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11675;
-- AC datas : OLD Name : "서리바람 복병", Name AC enUS : "Snowblind Ambusher" ; Wowhead enUS : "Snowblind Ambusher"
UPDATE `creature_template_locale` SET `Name` = '서리바람일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11678;
-- AC datas : OLD Name : "겨울도끼 의술사", Name AC enUS : "Winterax Witch Doctor" ; Wowhead enUS : "Winterax Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11679;
-- AC datas : OLD Name : "전쟁노래 벌채꾼", Name AC enUS : "Horde Deforester" ; Wowhead enUS : "Horde Deforester"
UPDATE `creature_template_locale` SET `Name` = '호드 벌채꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11681;
-- AC datas : OLD Name : "전쟁노래 그런트", Name AC enUS : "Warsong Grunt" ; Wowhead enUS : "Warsong Grunt"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11682;
-- AC datas : OLD Name : "전쟁노래 주술사", Name AC enUS : "Warsong Shaman" ; Wowhead enUS : "Warsong Shaman"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11683;
-- AC datas : OLD Name : "고블린 벌채기", Name AC enUS : "Warsong Shredder" ; Wowhead enUS : "Warsong Shredder"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 벌목기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11684;
-- AC datas : OLD Name : "마라우돈 사제", Name AC enUS : "Maraudine Priest" ; Wowhead enUS : "Maraudine Priest"
UPDATE `creature_template_locale` SET `Name` = '마라우돈일족 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11685;
-- AC datas : OLD Name : "갈색 코도", Name AC enUS : "Brown Kodo" ; Wowhead enUS : "Brown Kodo"
UPDATE `creature_template_locale` SET `Name` = '길들인 갈색 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11689;
-- AC datas : OLD Name : "나무옹이 선동자", Name AC enUS : "Gnarlpine Instigator" ; Wowhead enUS : "Gnarlpine Instigator"
UPDATE `creature_template_locale` SET `Name` = '나무옹이일족 선동자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11690;
-- AC datas : OLD Name : "검은나무 추적자", Name AC enUS : "Blackwood Tracker" ; Wowhead enUS : "Blackwood Tracker"
UPDATE `creature_template_locale` SET `Name` = '검은나무일족 추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11713;
-- AC datas : OLD Name : "사르 브라운아이", Name AC enUS : "Sar Browneye" ; Wowhead enUS : "Sar Browneye"
UPDATE `creature_template_locale` SET `Name` = '사르 바라운아이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11718;
-- AC datas : OLD Name : "하이브레갈 땅무지", Name AC enUS : "Hive'Regal Burrower" ; Wowhead enUS : "Hive'Regal Burrower"
UPDATE `creature_template_locale` SET `Name` = '땅꾼 하이브레갈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11731;
-- AC datas : OLD Name : "퀸", Name AC enUS : "Quinn" ; Wowhead enUS : "Quinn"
UPDATE `creature_template_locale` SET `Name` = '쿠인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11756;
-- AC datas : OLD Name : "호박눈 갈퀴바실리스크", Name AC enUS : "Ambereye Reaver" ; Wowhead enUS : "Ambereye Reaver"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발톱 호박눈 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11786;
-- AC datas : OLD Name : "셀레브리안 드리아드", Name AC enUS : "Celebrian Dryad" ; Wowhead enUS : "Celebrian Dryad"
UPDATE `creature_template_locale` SET `Name` = '셀레브라스의 드리아드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11793;
-- AC datas : OLD Subname : "썬더 블러프 비행 조련사", Subname AC enUS : "Thunder Bluff Flight Master" ; Wowhead enUS : "Thunder Bluff Flight Master"
UPDATE `creature_template_locale` SET `Title` = '썬더 블러프 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11798;
-- AC datas : OLD Subname : "다르나서스 비행 조련사", Subname AC enUS : "Darnassus Flight Master" ; Wowhead enUS : "Darnassus Flight Master"
UPDATE `creature_template_locale` SET `Title` = '다르나서스 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11800;
-- AC datas : OLD Name : "달숲 집행자", Name AC enUS : "Moonglade Warden" ; Wowhead enUS : "Moonglade Warden"
UPDATE `creature_template_locale` SET `Name` = '달의숲 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11822;
-- AC datas : OLD Name : "학카리 사제", Name AC enUS : "Hakkari Priest" ; Wowhead enUS : "Hakkari Priest"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11830;
-- AC datas : OLD Name : "학카리 의술사", Name AC enUS : "Hakkari Witch Doctor" ; Wowhead enUS : "Hakkari Witch Doctor"
UPDATE `creature_template_locale` SET `Name` = '학카르부족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11831;
-- AC datas : OLD Name : "자갈발 주술사", Name AC enUS : "Wildpaw Shaman" ; Wowhead enUS : "Wildpaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '자갈발일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11837;
-- AC datas : OLD Name : "자갈발 비술사", Name AC enUS : "Wildpaw Mystic" ; Wowhead enUS : "Wildpaw Mystic"
UPDATE `creature_template_locale` SET `Name` = '자갈발일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11838;
-- AC datas : OLD Name : "자갈발 투사", Name AC enUS : "Wildpaw Brute" ; Wowhead enUS : "Wildpaw Brute"
UPDATE `creature_template_locale` SET `Name` = '자갈발일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11839;
-- AC datas : OLD Name : "자갈발 우두머리", Name AC enUS : "Wildpaw Alpha" ; Wowhead enUS : "Wildpaw Alpha"
UPDATE `creature_template_locale` SET `Name` = '자갈발일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11840;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11865;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11866;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11867;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11868;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11869;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11870;
-- AC datas : OLD Name : "머큐시오 필스고저", Name AC enUS : "Mercutio Filthgorger" ; Wowhead enUS : "Mercutio Filthgorger"
UPDATE `creature_template_locale` SET `Name` = '머큐시오 플리스고저', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11886;
-- AC datas : OLD Name : "그림토템 약탈자", Name AC enUS : "Grimtotem Ruffian" ; Wowhead enUS : "Grimtotem Ruffian"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11910;
-- AC datas : OLD Name : "그림토템 용병", Name AC enUS : "Grimtotem Mercenary" ; Wowhead enUS : "Grimtotem Mercenary"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 용병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11911;
-- AC datas : OLD Name : "그림토템 투사", Name AC enUS : "Grimtotem Brute" ; Wowhead enUS : "Grimtotem Brute"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11912;
-- AC datas : OLD Name : "그림토템 마술사", Name AC enUS : "Grimtotem Sorcerer" ; Wowhead enUS : "Grimtotem Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11913;
-- AC datas : OLD Name : "구릉바위 바위지기", Name AC enUS : "Gogger Rock Keeper" ; Wowhead enUS : "Gogger Rock Keeper"
UPDATE `creature_template_locale` SET `Name` = '고우저일족 바위지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11915;
-- AC datas : OLD Name : "구릉바위 흙점쟁이", Name AC enUS : "Gogger Geomancer" ; Wowhead enUS : "Gogger Geomancer"
UPDATE `creature_template_locale` SET `Name` = '고우저일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11917;
-- AC datas : OLD Name : "구릉바위 채굴꾼", Name AC enUS : "Gogger Stonepounder" ; Wowhead enUS : "Gogger Stonepounder"
UPDATE `creature_template_locale` SET `Name` = '고우저일족 채굴꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11918;
-- AC datas : OLD Subname : "용아귀 부족 족장", Subname AC enUS : "Chieftain of the Dragonmaw Clan" ; Wowhead enUS : "Chieftain of the Dragonmaw Clan"
UPDATE `creature_template_locale` SET `Title` = '용아귀부족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 11980;
-- AC datas : OLD Name : "달숲 전문 연금술사", Name AC enUS : "Moonglade Alchemy Trainer" ; Wowhead enUS : "Moonglade Alchemy Trainer"
UPDATE `creature_template_locale` SET `Name` = '달의숲 전문 연금술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12020;
-- AC datas : OLD Name : "그렐라 스톤피스트", Name AC enUS : "Aerie Peak General Goods" ; Wowhead enUS : "Aerie Peak General Goods"
UPDATE `creature_template_locale` SET `Name` = '맹금의봉우리 일용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12036;
-- AC datas : OLD Name : "브란닉 아이언벨리", Name AC enUS : "Aerie Peak Mail Armor Vendor" ; Wowhead enUS : "Aerie Peak Mail Armor Vendor"
UPDATE `creature_template_locale` SET `Name` = '맹금의봉우리 갑옷제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12040;
-- AC datas : OLD Name : "설퍼론 선구자", Name AC enUS : "Sulfuron Harbinger" ; Wowhead enUS : "Sulfuron Harbinger"
UPDATE `creature_template_locale` SET `Name` = '설퍼론 사자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12098;
-- AC datas : OLD Name : "불꽃꼬리 수호병", Name AC enUS : "Flamewaker Protector" ; Wowhead enUS : "Flamewaker Protector"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12119;
-- AC datas : OLD Name : "매머드 상어", Name AC enUS : "Mammoth Shark" ; Wowhead enUS : "Mammoth Shark"
UPDATE `creature_template_locale` SET `Name` = '맘모스 상어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12125;
-- AC datas : OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12126;
-- AC datas : OLD Subname : "티리스팔 숲행 비행선 기장", Subname AC enUS : "Tirisfal Glades Zeppelin Master" ; Wowhead enUS : "Tirisfal Glades Zeppelin Master"
UPDATE `creature_template_locale` SET `Title` = '언더시티행 비행선 기장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12137;
-- AC datas : OLD Name : "불꽃꼬리 수호자", Name AC enUS : "Flamewaker Guardian" ; Wowhead enUS : "Flamewaker Guardian"
UPDATE `creature_template_locale` SET `Name` = '불꽃꼬리일족 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12142;
-- AC datas : OLD Name : "청색 코도", Name AC enUS : "Teal Kodo" ; Wowhead enUS : "Teal Kodo"
UPDATE `creature_template_locale` SET `Name` = '길들인 청색 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12148;
-- AC datas : OLD Name : "회색 코도", Name AC enUS : "Gray Kodo" ; Wowhead enUS : "Gray Kodo"
UPDATE `creature_template_locale` SET `Name` = '길들인 회색 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12149;
-- AC datas : OLD Name : "녹색 코도", Name AC enUS : "Green Kodo" ; Wowhead enUS : "Green Kodo"
UPDATE `creature_template_locale` SET `Name` = '길들인 녹색 코도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12151;
-- AC datas : OLD Name : "겨울도끼 도끼투척병", Name AC enUS : "Winterax Axe Thrower" ; Wowhead enUS : "Winterax Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12156;
-- AC datas : OLD Name : "겨울도끼 어둠사냥꾼", Name AC enUS : "Winterax Shadow Hunter" ; Wowhead enUS : "Winterax Shadow Hunter"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 어둠사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12157;
-- AC datas : OLD Name : "겨울도끼 사냥꾼", Name AC enUS : "Winterax Hunter" ; Wowhead enUS : "Winterax Hunter"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12158;
-- AC datas : OLD Name : "그늘 협곡 파수꾼", Name AC enUS : "Shadowglen Sentinel" ; Wowhead enUS : "Shadowglen Sentinel"
UPDATE `creature_template_locale` SET `Name` = '그늘협곡 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12160;
-- AC datas : OLD Name : "마틴 린지", Name AC enUS : "Martin Lindsey" ; Wowhead enUS : "Martin Lindsey"
UPDATE `creature_template_locale` SET `Name` = '마틴 린드시', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12198;
-- AC datas : OLD Name : "원한꼬리 약탈자", Name AC enUS : "Spitelash Raider" ; Wowhead enUS : "Spitelash Raider"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12204;
-- AC datas : OLD Name : "원한꼬리 마녀", Name AC enUS : "Spitelash Witch" ; Wowhead enUS : "Spitelash Witch"
UPDATE `creature_template_locale` SET `Name` = '원한의꼬리일족 마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12205;
-- AC datas : OLD Name : "테살라 히드라", Name AC enUS : "Thessala Hydra" ; Wowhead enUS : "Thessala Hydra"
UPDATE `creature_template_locale` SET `Name` = '텟살라 히드라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12207;
-- AC datas : OLD Name : "침투요원 하메야", Name AC enUS : "Infiltrator Hameya" ; Wowhead enUS : "Infiltrator Hameya"
UPDATE `creature_template_locale` SET `Name` = '첩보원 하메야', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12248;
-- AC datas : OLD Name : "오염된 이끼껍질 트롤", Name AC enUS : "Infected Mossflayer" ; Wowhead enUS : "Infected Mossflayer"
UPDATE `creature_template_locale` SET `Name` = '오염된 이끼껍질트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12261;
-- AC datas : OLD Name : "폭풍비늘 독술사", Name AC enUS : "Stormscale Toxicologist" ; Wowhead enUS : "Stormscale Toxicologist"
UPDATE `creature_template_locale` SET `Name` = '폭풍비늘일족 독술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12321;
-- AC datas : OLD Name : "붉은십자군 돌격병", Name AC enUS : "Scarlet Trooper" ; Wowhead enUS : "Scarlet Trooper"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 기병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12352;
-- AC datas : OLD Name : "길들인 밤호랑이", Name AC enUS : "Riding Nightsaber" ; Wowhead enUS : "Riding Nightsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 흑호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12361;
-- AC datas : OLD Name : "길들인 눈호랑이", Name AC enUS : "Riding Frostsaber" ; Wowhead enUS : "Riding Frostsaber"
UPDATE `creature_template_locale` SET `Name` = '길들인 빙호', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12362;
-- AC datas : OLD Name : "냠냠이", Name AC enUS : "Nibbles" ; Wowhead enUS : "Nibbles"
UPDATE `creature_template_locale` SET `Name` = '갈갈이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12383;
-- AC datas : OLD Name : "파멸의 수호병 사령관", Name AC enUS : "Doomguard Commander" ; Wowhead enUS : "Doomguard Commander"
UPDATE `creature_template_locale` SET `Name` = '파멸의수호대 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12396;
-- AC datas : OLD Name : "고르독 하이에나", Name AC enUS : "Gordok Hyena" ; Wowhead enUS : "Gordok Hyena"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12418;
-- AC datas : OLD Name : "경비병 로버츠", Name AC enUS : "Guard Roberts" ; Wowhead enUS : "Guard Roberts"
UPDATE `creature_template_locale` SET `Name` = '경비병 로버트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12423;
-- AC datas : OLD Name : "죽음경비병 켈", Name AC enUS : "Deathguard Kel" ; Wowhead enUS : "Deathguard Kel"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 켈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12428;
-- AC datas : OLD Name : "그림자거미 크레시스", Name AC enUS : "Krethis Shadowspinner" ; Wowhead enUS : "Krethis Shadowspinner"
UPDATE `creature_template_locale` SET `Name` = '크레시스 섀도스피너', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12433;
-- AC datas : OLD Name : "혈폭풍 갈퀴발톱", Name AC enUS : "Bloodfury Ripper" ; Wowhead enUS : "Bloodfury Ripper"
UPDATE `creature_template_locale` SET `Name` = '혈폭풍일족 갈퀴발톱', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12579;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12736;
-- AC datas : OLD Name : "정예근위병 비긴스", Name AC enUS : "Master Sergeant Biggins" ; Wowhead enUS : "Master Sergeant Biggins"
UPDATE `creature_template_locale` SET `Name` = '하사관 비긴스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12781;
-- AC datas : OLD Name : "경비병 콰인", Name AC enUS : "Guard Quine" ; Wowhead enUS : "Guard Quine"
UPDATE `creature_template_locale` SET `Name` = '경비병 쿠인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12786;
-- AC datas : OLD Subname : "보급품 병참장교", Subname AC enUS : "Accessories Quartermaster" ; Wowhead enUS : "Accessories Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '비전투장비 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12799;
-- AC datas : OLD Subname : "보급품 병참장교", Subname AC enUS : "Accessories Quartermaster" ; Wowhead enUS : "Accessories Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '비전투장비 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12805;
-- AC datas : OLD Name : "잿빛 골짜기 정찰꾼", Name AC enUS : "Ashenvale Outrunner" ; Wowhead enUS : "Ashenvale Outrunner"
UPDATE `creature_template_locale` SET `Name` = '잿빛골짜기 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12856;
-- AC datas : OLD Name : "전쟁노래 정찰병", Name AC enUS : "Warsong Scout" ; Wowhead enUS : "Warsong Scout"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12862;
-- AC datas : OLD Name : "전쟁노래 길잡이", Name AC enUS : "Warsong Runner" ; Wowhead enUS : "Warsong Runner"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12863;
-- AC datas : OLD Name : "전쟁노래 척후병", Name AC enUS : "Warsong Outrider" ; Wowhead enUS : "Warsong Outrider"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12864;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Trauma Surgeon" ; Wowhead enUS : "Trauma Surgeon"
UPDATE `creature_template_locale` SET `Title` = '군의관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12939;
-- AC datas : OLD Name : "콜카르 잠복꾼", Name AC enUS : "Kolkar Waylayer" ; Wowhead enUS : "Kolkar Waylayer"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 잠복꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12976;
-- AC datas : OLD Name : "콜카르 매복병", Name AC enUS : "Kolkar Ambusher" ; Wowhead enUS : "Kolkar Ambusher"
UPDATE `creature_template_locale` SET `Name` = '콜카르일족 매복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12977;
-- AC datas : OLD Name : "고르독 사냥개", Name AC enUS : "Gordok Mastiff" ; Wowhead enUS : "Gordok Mastiff"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 고르독일족 하이에나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13036;
-- AC datas : OLD Name : "빅시 워블봉크", Name AC enUS : "Bixi Wobblebonk" ; Wowhead enUS : "Bixi Wobblebonk",  OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Name` = '빅시 와블봉크', `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13084;
-- AC datas : OLD Name : "부관 루이스", Name AC enUS : "Lieutenant Lewis" ; Wowhead enUS : "Lieutenant Lewis"
UPDATE `creature_template_locale` SET `Name` = '부관 류이스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13147;
-- AC datas : OLD Name : "죽음추적자", Name AC enUS : "Deathstalker Agent" ; Wowhead enUS : "Deathstalker Agent"
UPDATE `creature_template_locale` SET `Name` = '죽음의 추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13155;
-- AC datas : OLD Name : "부관 샌더스", Name AC enUS : "Lieutenant Sanders" ; Wowhead enUS : "Lieutenant Sanders"
UPDATE `creature_template_locale` SET `Name` = '부관 샌더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13158;
-- AC datas : OLD Name : "전투와이번", Name AC enUS : "War Rider" ; Wowhead enUS : "War Rider"
UPDATE `creature_template_locale` SET `Name` = '전투 와이번', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13178;
-- AC datas : OLD Name : "조렉 아이언사이드", Name AC enUS : "Jekyll Flandring" ; Wowhead enUS : "Jekyll Flandring"
UPDATE `creature_template_locale` SET `Name` = '제킬 플랜드링', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13219;
-- AC datas : OLD Name : "라이슨의 창공의 눈", Name AC enUS : "Ryson's Eye in the Sky" ; Wowhead enUS : "Ryson's Eye in the Sky"
UPDATE `creature_template_locale` SET `Name` = '하늘의 라이슨 눈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13221;
-- AC datas : OLD Name : "서리늑대 주술사", Name AC enUS : "Frostwolf Shaman" ; Wowhead enUS : "Frostwolf Shaman"
UPDATE `creature_template_locale` SET `Name` = '서리늑대부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13284;
-- AC datas : OLD Name : "작은 개구리", Name AC enUS : "Frog" ; Wowhead enUS : "Frog"
UPDATE `creature_template_locale` SET `Name` = '개구리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13321;
-- AC datas : OLD Name : "상급 방어병", Name AC enUS : "Seasoned Defender" ; Wowhead enUS : "Seasoned Defender"
UPDATE `creature_template_locale` SET `Name` = '상급 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13326;
-- AC datas : OLD Name : "정예 방어병", Name AC enUS : "Veteran Defender" ; Wowhead enUS : "Veteran Defender"
UPDATE `creature_template_locale` SET `Name` = '정예 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13331;
-- AC datas : OLD Name : "최정예 방어병", Name AC enUS : "Champion Defender" ; Wowhead enUS : "Champion Defender"
UPDATE `creature_template_locale` SET `Name` = '최정예 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13422;
-- AC datas : OLD Name : "서리늑대 늑대기병", Name AC enUS : "Frostwolf Wolf Rider" ; Wowhead enUS : "Frostwolf Wolf Rider"
UPDATE `creature_template_locale` SET `Name` = '서리늑대부족 늑대기병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13440;
-- AC datas : OLD Name : "젠발아이", Name AC enUS : "Balai Lok'Wein" ; Wowhead enUS : "Balai Lok'Wein",  OLD Subname : "상급 드루이드", Subname AC enUS : "Potions, Scrolls & Reagents" ; Wowhead enUS : "Potions, Scrolls & Reagents"
UPDATE `creature_template_locale` SET `Name` = '발라이 로크웨인', `Title` = '물약 및 마법용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13476;
-- AC datas : OLD Name : "서리늑대 폭파 전문가", Name AC enUS : "Frostwolf Explosives Expert" ; Wowhead enUS : "Frostwolf Explosives Expert"
UPDATE `creature_template_locale` SET `Name` = '서리늑대 폭파전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13597;
-- AC datas : OLD Name : "스톰파이크 폭파 전문가", Name AC enUS : "Stormpike Explosives Expert" ; Wowhead enUS : "Stormpike Explosives Expert"
UPDATE `creature_template_locale` SET `Name` = '스톰파이크 폭파전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13598;
-- AC datas : OLD Name : "서리늑대 야수 관리인", Name AC enUS : "Frostwolf Stable Master" ; Wowhead enUS : "Frostwolf Stable Master"
UPDATE `creature_template_locale` SET `Name` = '서리늑대부족 야수관리인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13616;
-- AC datas : OLD Name : "스톰파이크 야수 관리인", Name AC enUS : "Stormpike Stable Master" ; Wowhead enUS : "Stormpike Stable Master"
UPDATE `creature_template_locale` SET `Name` = '스톰파이크 야수관리인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13617;
-- AC datas : OLD Name : "불타는 칼날단 악몽마", Name AC enUS : "Burning Blade Nightmare" ; Wowhead enUS : "Burning Blade Nightmare"
UPDATE `creature_template_locale` SET `Name` = '불타는 칼날단 나이트메어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13836;
-- AC datas : OLD Name : "겨울도끼 비술사", Name AC enUS : "Winterax Mystic" ; Wowhead enUS : "Winterax Mystic"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13956;
-- AC datas : OLD Name : "겨울도끼 전사", Name AC enUS : "Winterax Warrior" ; Wowhead enUS : "Winterax Warrior"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13957;
-- AC datas : OLD Name : "겨울도끼 현자", Name AC enUS : "Winterax Seer" ; Wowhead enUS : "Winterax Seer"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 현자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 13958;
-- AC datas : OLD Name : "부패한 트롤", Name AC enUS : "Withered Troll" ; Wowhead enUS : "Withered Troll"
UPDATE `creature_template_locale` SET `Name` = '썩어버린 트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14017;
-- AC datas : OLD Subname : "겨울도끼 부족 영웅", Subname AC enUS : "Winterax Hero" ; Wowhead enUS : "Winterax Hero"
UPDATE `creature_template_locale` SET `Title` = '겨울도끼부족 영웅', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14018;
-- AC datas : OLD Name : "겨울도끼 보초병", Name AC enUS : "Winterax Sentry" ; Wowhead enUS : "Winterax Sentry"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 보초병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14021;
-- AC datas : OLD Name : "분노한 지옥수호병", Name AC enUS : "Enraged Felguard" ; Wowhead enUS : "Enraged Felguard"
UPDATE `creature_template_locale` SET `Name` = '분노한 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14101;
-- AC datas : OLD Name : "심술쟁이 벤지", Name AC enUS : "Cranky Benj" ; Wowhead enUS : "Cranky Benj"
UPDATE `creature_template_locale` SET `Name` = '심술쟁이 밴즈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14223;
-- AC datas : OLD Name : "히죽이", Name AC enUS : "Giggler" ; Wowhead enUS : "Giggler"
UPDATE `creature_template_locale` SET `Name` = '갈갈이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14228;
-- AC datas : OLD Name : "저주받은 뱀갈퀴 나가", Name AC enUS : "Accursed Slitherblade" ; Wowhead enUS : "Accursed Slitherblade"
UPDATE `creature_template_locale` SET `Name` = '저주받은 뱀갈퀴일족 나가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14229;
-- AC datas : OLD Name : "겨울도끼 추적자", Name AC enUS : "Winterax Tracker" ; Wowhead enUS : "Winterax Tracker"
UPDATE `creature_template_locale` SET `Name` = '겨울도끼부족 추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14274;
-- AC datas : OLD Name : "고르독 매복병", Name AC enUS : "Gordok Bushwacker" ; Wowhead enUS : "Gordok Bushwacker"
UPDATE `creature_template_locale` SET `Name` = '고르독일족 매복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14351;
-- AC datas : OLD Name : "군주 랜드레사르", Name AC enUS : "Duke Landressar" ; Wowhead enUS : "Duke Landressar"
UPDATE `creature_template_locale` SET `Name` = '군주 랜드렛사르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14352;
-- AC datas : OLD Name : "톱지느러미 광포어", Name AC enUS : "Sawfin Frenzy" ; Wowhead enUS : "Sawfin Frenzy"
UPDATE `creature_template_locale` SET `Name` = '톱지느러미 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14356;
-- AC datas : OLD Name : "겨울눈 복병", Name AC enUS : "Winterfall Ambusher" ; Wowhead enUS : "Winterfall Ambusher"
UPDATE `creature_template_locale` SET `Name` = '눈사태일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14372;
-- AC datas : OLD Name : "하급 파멸의 수호병", Name AC enUS : "Doomguard Minion" ; Wowhead enUS : "Doomguard Minion"
UPDATE `creature_template_locale` SET `Name` = '하급 파멸의수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14385;
-- AC datas : OLD Name : "상사 매팅리", Name AC enUS : "Major Mattingly" ; Wowhead enUS : "Major Mattingly"
UPDATE `creature_template_locale` SET `Name` = '상사 매팅글리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14394;
-- AC datas : OLD Name : "비전 격류", Name AC enUS : "Arcane Torrent" ; Wowhead enUS : "Arcane Torrent"
UPDATE `creature_template_locale` SET `Name` = '비전의 격류', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14399;
-- AC datas : OLD Name : "장교 잭슨", Name AC enUS : "Officer Jaxon" ; Wowhead enUS : "Officer Jaxon"
UPDATE `creature_template_locale` SET `Name` = '하사관 잭슨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14423;
-- AC datas : OLD Name : "장교 폼로이", Name AC enUS : "Officer Pomeroy" ; Wowhead enUS : "Officer Pomeroy"
UPDATE `creature_template_locale` SET `Name` = '하사관 폼로이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14438;
-- AC datas : OLD Name : "장교 브래디", Name AC enUS : "Officer Brady" ; Wowhead enUS : "Officer Brady"
UPDATE `creature_template_locale` SET `Name` = '하사관 브래디', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14439;
-- AC datas : OLD Name : "군주 웜막", Name AC enUS : "Lord Captain Wyrmak" ; Wowhead enUS : "Lord Captain Wyrmak"
UPDATE `creature_template_locale` SET `Name` = '대군주 웜막', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14445;
-- AC datas : OLD Name : "사로잡힌 파멸의 수호병 사령관", Name AC enUS : "Enslaved Doomguard Commander" ; Wowhead enUS : "Enslaved Doomguard Commander"
UPDATE `creature_template_locale` SET `Name` = '사로잡힌 파멸의수호대 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14452;
-- AC datas : OLD Name : "에리스 헤이븐파이어", Name AC enUS : "Eris Havenfire" ; Wowhead enUS : "Eris Havenfire"
UPDATE `creature_template_locale` SET `Name` = '에리스 헤븐파이어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14494;
-- AC datas : OLD Name : "졸려 보이는 검은무쇠 인부", Name AC enUS : "Sleepy Dark Iron Worker" ; Wowhead enUS : "Sleepy Dark Iron Worker"
UPDATE `creature_template_locale` SET `Name` = '졸려 보이는 검은무쇠단 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14635;
-- AC datas : OLD Name : "조르빈 팬대즐", Name AC enUS : "Zorbin Fandazzle" ; Wowhead enUS : "Zorbin Fandazzle"
UPDATE `creature_template_locale` SET `Name` = '조브린 팬대즐', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14637;
-- AC datas : OLD Name : "남작 티투스 리븐데어", Name AC enUS : "Baron Titus Rivendare" ; Wowhead enUS : "Baron Titus Rivendare"
UPDATE `creature_template_locale` SET `Name` = '남작 디도 리븐데어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14683;
-- AC datas : OLD Name : "야전사령관 아프라샤비", Name AC enUS : "Field Marshal Afrasiabi" ; Wowhead enUS : "Field Marshal Stonebridge"
UPDATE `creature_template_locale` SET `Name` = '야전사령관 스톤브릿지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14721;
-- AC datas : OLD Name : "깨진엄니 보초", Name AC enUS : "Revantusk Watcher" ; Wowhead enUS : "Revantusk Watcher"
UPDATE `creature_template_locale` SET `Name` = '레반터스크 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14730;
-- AC datas : OLD Name : "깨진엄니 북장이", Name AC enUS : "Revantusk Drummer" ; Wowhead enUS : "Revantusk Drummer"
UPDATE `creature_template_locale` SET `Name` = '레반터스크 북장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14734;
-- AC datas : OLD Name : "주술사 톤터스크", Name AC enUS : "Primal Torntusk" ; Wowhead enUS : "Primal Torntusk"
UPDATE `creature_template_locale` SET `Name` = '주술사 쏜터스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14736;
-- AC datas : OLD Subname : "전문 낚시꾼 및 낚시용품 상인", Subname AC enUS : "Fishing Trainer & Supplies" ; Wowhead enUS : "Fishing Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '낚시용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14740;
-- AC datas : OLD Name : "썩은가지 약탈자", Name AC enUS : "Vilebranch Kidnapper" ; Wowhead enUS : "Vilebranch Kidnapper"
UPDATE `creature_template_locale` SET `Name` = '썩은가지부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14748;
-- AC datas : OLD Name : "구루바시 박쥐 기수", Name AC enUS : "Gurubashi Bat Rider" ; Wowhead enUS : "Gurubashi Bat Rider"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 박쥐기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14750;
-- AC datas : OLD Name : "서리늑대 전투 깃발", Name AC enUS : "Frostwolf Battle Standard" ; Wowhead enUS : "Frostwolf Battle Standard"
UPDATE `creature_template_locale` SET `Name` = '서리늑대 전투깃발', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14751;
-- AC datas : OLD Name : "스톰파이크 전투 깃발", Name AC enUS : "Stormpike Battle Standard" ; Wowhead enUS : "Stormpike Battle Standard"
UPDATE `creature_template_locale` SET `Name` = '스톰파이크 전투깃발', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14752;
-- AC datas : OLD Name : "장로 톤터스크", Name AC enUS : "Elder Torntusk" ; Wowhead enUS : "Elder Torntusk"
UPDATE `creature_template_locale` SET `Name` = '장로 쏜터스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14757;
-- AC datas : OLD Name : "돌난로 작전사령관", Name AC enUS : "Stonehearth Marshal" ; Wowhead enUS : "Stonehearth Marshal"
UPDATE `creature_template_locale` SET `Name` = '돌심장 작전사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14765;
-- AC datas : OLD Name : "돌난로 전투대장", Name AC enUS : "Stonehearth Warmaster" ; Wowhead enUS : "Stonehearth Warmaster"
UPDATE `creature_template_locale` SET `Name` = '돌심장 전투대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14775;
-- AC datas : OLD Subname : "기념품 및 장난감 상품", Subname AC enUS : "Darkmoon Faire Ticket Redemption" ; Wowhead enUS : "Darkmoon Faire Ticket Redemption"
UPDATE `creature_template_locale` SET `Title` = '다크문 유랑단 상품 교환원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14828;
-- AC datas : OLD Subname : "음료 상인", Subname AC enUS : "Darkmoon Faire Drink Vendor" ; Wowhead enUS : "Darkmoon Faire Drink Vendor"
UPDATE `creature_template_locale` SET `Title` = '다크문 유랑단 음료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14844;
-- AC datas : OLD Subname : "식료품 상인", Subname AC enUS : "Darkmoon Faire Food Vendor" ; Wowhead enUS : "Darkmoon Faire Food Vendor"
UPDATE `creature_template_locale` SET `Title` = '다크문 유랑단 음식 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14845;
-- AC datas : OLD Subname : "애완동물 및 탈것 상인", Subname AC enUS : "Darkmoon Faire Exotic Goods" ; Wowhead enUS : "Darkmoon Faire Exotic Goods"
UPDATE `creature_template_locale` SET `Title` = '다크문 유랑단 특산품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14846;
-- AC datas : OLD Name : "학자 타데우스 팔레오", Name AC enUS : "Professor Thaddeus Paleo" ; Wowhead enUS : "Professor Thaddeus Paleo",  OLD Subname : "다크문 카드", Subname AC enUS : "Darkmoon Faire Cards & Exotic Goods" ; Wowhead enUS : "Darkmoon Faire Cards & Exotic Goods"
UPDATE `creature_template_locale` SET `Name` = '학자 타데우스 페일로', `Title` = '다크문 유랑단 카드 및 특산품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14847;
-- AC datas : OLD Name : "다크문 일꾼", Name AC enUS : "Darkmoon Faire Carnie" ; Wowhead enUS : "Darkmoon Faire Carnie"
UPDATE `creature_template_locale` SET `Name` = '다크문 유랑단 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14849;
-- AC datas : OLD Name : "꼬마 코카트리스", Name AC enUS : "Pygmy Cockatrice" ; Wowhead enUS : "Pygmy Cockatrice"
UPDATE `creature_template_locale` SET `Name` = '피그미 코카트리스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14869;
-- AC datas : OLD Name : "잔달라 머리사냥꾼", Name AC enUS : "Zandalar Headshrinker" ; Wowhead enUS : "Zandalar Headshrinker"
UPDATE `creature_template_locale` SET `Name` = '잔달라부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14876;
-- AC datas : OLD Name : "아탈라이 무희", Name AC enUS : "Atal'ai Mistress" ; Wowhead enUS : "Atal'ai Mistress"
UPDATE `creature_template_locale` SET `Name` = '아탈라이부족 무희', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14882;
-- AC datas : OLD Name : "잔달라 집행자", Name AC enUS : "Zandalar Enforcer" ; Wowhead enUS : "Zandalar Enforcer"
UPDATE `creature_template_locale` SET `Name` = '잔달라부족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14911;
-- AC datas : OLD Name : "사로잡힌 학카리 광신도", Name AC enUS : "Captured Hakkari Zealot" ; Wowhead enUS : "Captured Hakkari Zealot"
UPDATE `creature_template_locale` SET `Name` = '사로잡힌 학카르부족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14912;
-- AC datas : OLD Subname : "잔달라 부족 보급 및 수리", Subname AC enUS : "Zandalar Supplies & Repair" ; Wowhead enUS : "Zandalar Supplies & Repair"
UPDATE `creature_template_locale` SET `Title` = '잔달라부족 보급 및 수리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14921;
-- AC datas : OLD Name : "파멸단 특사", Name AC enUS : "Defilers Emissary" ; Wowhead enUS : "Defilers Emissary"
UPDATE `creature_template_locale` SET `Name` = '파멸단 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14990;
-- AC datas : OLD Name : "정글 두꺼비", Name AC enUS : "Jungle Toad" ; Wowhead enUS : "Jungle Toad"
UPDATE `creature_template_locale` SET `Name` = '정글두꺼비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15010;
-- AC datas : OLD Name : "죽음추적자 몰티스", Name AC enUS : "Deathstalker Mortis" ; Wowhead enUS : "Deathstalker Mortis"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 몰티스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15022;
-- AC datas : OLD Name : "잠들지 않는 잔자", Name AC enUS : "Zanza the Restless" ; Wowhead enUS : "Zanza the Restless"
UPDATE `creature_template_locale` SET `Name` = '수호신 잔자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15042;
-- AC datas : OLD Name : "잔달라 사절", Name AC enUS : "Zandalarian Emissary" ; Wowhead enUS : "Zandalarian Emissary"
UPDATE `creature_template_locale` SET `Name` = '잔달라부족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15076;
-- AC datas : OLD Name : "전쟁노래 특사", Name AC enUS : "Warsong Emissary" ; Wowhead enUS : "Warsong Emissary"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15105;
-- AC datas : OLD Name : "서리늑대 특사", Name AC enUS : "Frostwolf Emissary" ; Wowhead enUS : "Frostwolf Emissary"
UPDATE `creature_template_locale` SET `Name` = '서리늑대 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15106;
-- AC datas : OLD Name : "구루바시 포로", Name AC enUS : "Gurubashi Prisoner" ; Wowhead enUS : "Gurubashi Prisoner"
UPDATE `creature_template_locale` SET `Name` = '구루바시부족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15110;
-- AC datas : OLD Name : "광기 어린 종복", Name AC enUS : "Mad Servant" ; Wowhead enUS : "Mad Servant"
UPDATE `creature_template_locale` SET `Name` = '광기어린 종복', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15111;
-- AC datas : OLD Name : "해골 마술군주", Name AC enUS : "Skeletal Magelord" ; Wowhead enUS : "Skeletal Magelord"
UPDATE `creature_template_locale` SET `Name` = '해골 마술사왕', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15121;
-- AC datas : OLD Name : "망치 주둔지 정예병", Name AC enUS : "Hammerfall Elite" ; Wowhead enUS : "Hammerfall Elite"
UPDATE `creature_template_locale` SET `Name` = '해머폴 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15136;
-- AC datas : OLD Name : "광기 어린 공허방랑자", Name AC enUS : "Mad Voidwalker" ; Wowhead enUS : "Mad Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '광기어린 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15146;
-- AC datas : OLD Name : "여군주 실바나스 윈드러너", Name AC enUS : "The Banshee Queen" ; Wowhead enUS : "The Banshee Queen"
UPDATE `creature_template_locale` SET `Name` = '밴시 여왕', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15193;
-- AC datas : OLD Subname : "크툰의 대여사제", Subname AC enUS : "High Priestess of C'Thun" ; Wowhead enUS : "High Priestess of C'Thun"
UPDATE `creature_template_locale` SET `Title` = '쑨의 대여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15215;
-- AC datas : OLD Subname : "다크문 축제 포수", Subname AC enUS : "Darkmoon Faire Cannoneer" ; Wowhead enUS : "Darkmoon Faire Cannoneer"
UPDATE `creature_template_locale` SET `Title` = '다크문 유랑단 포수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15303;
-- AC datas : OLD Name : "호드 전쟁인도자", Name AC enUS : "Horde Warbringer" ; Wowhead enUS : "Horde Warbringer"
UPDATE `creature_template_locale` SET `Name` = '호드 돌격대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15350;
-- AC datas : OLD Name : "카트리나 쉬머스타", Name AC enUS : "Katrina Shimmerstar" ; Wowhead enUS : "Katrina Shimmerstar"
UPDATE `creature_template_locale` SET `Name` = '카트리나 쉼머스타', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15353;
-- AC datas : OLD Name : "판드랄 스태그헬름", Name AC enUS : "Fandral Staghelm" ; Wowhead enUS : "Fandral Staghelm"
UPDATE `creature_template_locale` SET `Name` = '판드랄 스테그헬름', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15382;
-- AC datas : OLD Name : "하사관 스톤브라우", Name AC enUS : "Sergeant Stonebrow" ; Wowhead enUS : "Sergeant Stonebrow"
UPDATE `creature_template_locale` SET `Name` = '하사관 스톤브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15383;
-- AC datas : OLD Name : "남녘해안 구린내 폭탄", Name AC enUS : "Southshore Stink Bomb Counter" ; Wowhead enUS : "Southshore Stink Bomb Counter"
UPDATE `creature_template_locale` SET `Name` = '사우스쇼어 구린내 폭탄', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15415;
-- AC datas : OLD Subname : "룬무늬 붕대 수집원", Subname AC enUS : "Runecloth Bandage Collector" ; Wowhead enUS : "Runecloth Bandage Collector"
UPDATE `creature_template_locale` SET `Title` = '룬매듭 붕대 수집원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15453;
-- AC datas : OLD Name : "약초채집가 프라우드페더", Name AC enUS : "Herbalist Proudfeather" ; Wowhead enUS : "Herbalist Proudfeather"
UPDATE `creature_template_locale` SET `Name` = '약초채집사 프라우드페더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15477;
-- AC datas : OLD Name : "불꽃 회오리 토템", Name AC enUS : "Fire Nova Totem VII" ; Wowhead enUS : "Fire Nova Totem VII"
UPDATE `creature_template_locale` SET `Name` = '불꽃 회오리 토템 VII', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15483;
-- AC datas : OLD Name : "밤의 안식처 수호병", Name AC enUS : "Nighthaven Defender" ; Wowhead enUS : "Nighthaven Defender"
UPDATE `creature_template_locale` SET `Name` = '나이트헤이븐 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15495;
-- AC datas : OLD Name : "운하 광포어", Name AC enUS : "Canal Frenzy" ; Wowhead enUS : "Canal Frenzy"
UPDATE `creature_template_locale` SET `Name` = '운하 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15505;
-- AC datas : OLD Subname : "룬무늬 붕대 수집원", Subname AC enUS : "Runecloth Bandage Collector" ; Wowhead enUS : "Runecloth Bandage Collector"
UPDATE `creature_template_locale` SET `Title` = '룬매듭 붕대 수집원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15532;
-- AC datas : OLD Name : "장로 스톰브라우", Name AC enUS : "Elder Stormbrow" ; Wowhead enUS : "Elder Stormbrow"
UPDATE `creature_template_locale` SET `Name` = '장로 스톰브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15565;
-- AC datas : OLD Name : "장로 에즈라 윗후프", Name AC enUS : "Elder Ezra Wheathoof" ; Wowhead enUS : "Elder Ezra Wheathoof"
UPDATE `creature_template_locale` SET `Name` = '장로 프라우드혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15580;
-- AC datas : OLD Name : "크툰의 눈", Name AC enUS : "Eye of C'Thun" ; Wowhead enUS : "Eye of C'Thun"
UPDATE `creature_template_locale` SET `Name` = '쑨의 눈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15589;
-- AC datas : OLD Name : "장로 메도런", Name AC enUS : "Elder Meadowrun" ; Wowhead enUS : "Elder Meadowrun"
UPDATE `creature_template_locale` SET `Name` = '장로 미도우런', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15602;
-- AC datas : OLD Name : "세나리온 정찰병 잘리아", Name AC enUS : "Cenarion Scout Jalia" ; Wowhead enUS : "Cenarion Scout Jalia"
UPDATE `creature_template_locale` SET `Name` = '세나리온 정찰병 잘리나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15611;
-- AC datas : OLD Name : "성난비늘 멀록", Name AC enUS : "Grimscale Murloc" ; Wowhead enUS : "Grimscale Murloc"
UPDATE `creature_template_locale` SET `Name` = '성난비늘멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15668;
-- AC datas : OLD Name : "성난비늘 수련사", Name AC enUS : "Grimscale Oracle" ; Wowhead enUS : "Grimscale Oracle"
UPDATE `creature_template_locale` SET `Name` = '성난비늘멀록 수련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15669;
-- AC datas : OLD Name : "성난비늘 채집꾼", Name AC enUS : "Grimscale Forager" ; Wowhead enUS : "Grimscale Forager"
UPDATE `creature_template_locale` SET `Name` = '성난비늘멀록 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15670;
-- AC datas : OLD Name : "남쪽바다 납치범", Name AC enUS : "Southsea Kidnapper" ; Wowhead enUS : "Southsea Kidnapper"
UPDATE `creature_template_locale` SET `Name` = '남쪽바다해적단 납치범', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15685;
-- AC datas : OLD Name : "정예근위병 매클루어", Name AC enUS : "Master Sergeant Maclure" ; Wowhead enUS : "Master Sergeant Maclure"
UPDATE `creature_template_locale` SET `Name` = '정예근위병 맥클루어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15708;
-- AC datas : OLD Name : "나무구렁 선조", Name AC enUS : "Timbermaw Ancestor" ; Wowhead enUS : "Timbermaw Ancestor"
UPDATE `creature_template_locale` SET `Name` = '나무구렁일족 선조', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15720;
-- AC datas : OLD Name : "술 취한 투사", Name AC enUS : "Drunken Bruiser" ; Wowhead enUS : "Drunken Bruiser"
UPDATE `creature_template_locale` SET `Name` = '술취한 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15724;
-- AC datas : OLD Name : "크툰", Name AC enUS : "C'Thun" ; Wowhead enUS : "C'Thun"
UPDATE `creature_template_locale` SET `Name` = '쑨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15727;
-- AC datas : OLD Name : "거대한 아누비사스 전쟁인도자", Name AC enUS : "Colossal Anubisath Warbringer" ; Wowhead enUS : "Colossal Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '거대한 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15743;
-- AC datas : OLD Name : "아누비사스 전쟁인도자", Name AC enUS : "Lesser Anubisath Warbringer" ; Wowhead enUS : "Lesser Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15748;
-- AC datas : OLD Name : "상급 아누비사스 전쟁인도자", Name AC enUS : "Anubisath Warbringer" ; Wowhead enUS : "Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '상급 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15751;
-- AC datas : OLD Name : "최상급 아누비사스 전쟁인도자", Name AC enUS : "Greater Anubisath Warbringer" ; Wowhead enUS : "Greater Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '최상급 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15754;
-- AC datas : OLD Name : "정예 아누비사스 전쟁인도자", Name AC enUS : "Supreme Anubisath Warbringer" ; Wowhead enUS : "Supreme Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '정예 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15758;
-- AC datas : OLD Name : "하급 아누비사스 전쟁인도자", Name AC enUS : "Minor Anubisath Warbringer" ; Wowhead enUS : "Minor Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '하급 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15807;
-- AC datas : OLD Name : "최하급 아누비사스 전쟁인도자", Name AC enUS : "Eroded Anubisath Warbringer" ; Wowhead enUS : "Eroded Anubisath Warbringer"
UPDATE `creature_template_locale` SET `Name` = '최하급 아누비사스 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15810;
-- AC datas : OLD Name : "오그리마 정예 보병대원", Name AC enUS : "Orgrimmar Elite Infantryman" ; Wowhead enUS : "Orgrimmar Elite Infantryman"
UPDATE `creature_template_locale` SET `Name` = '오그리마 정예보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15853;
-- AC datas : OLD Name : "스톰윈드 보병대원", Name AC enUS : "Stormwind Infantryman" ; Wowhead enUS : "Stormwind Infantryman"
UPDATE `creature_template_locale` SET `Name` = '스톰윈드 보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15858;
-- AC datas : OLD Name : "아이언포지 보병대원", Name AC enUS : "Ironforge Infantryman" ; Wowhead enUS : "Ironforge Infantryman"
UPDATE `creature_template_locale` SET `Name` = '아이언포지 보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15861;
-- AC datas : OLD Name : "검은창 주술사", Name AC enUS : "Darkspear Shaman" ; Wowhead enUS : "Darkspear Shaman"
UPDATE `creature_template_locale` SET `Name` = '검은창부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15863;
-- AC datas : OLD Name : "크툰의 차원문", Name AC enUS : "C'Thun Portal" ; Wowhead enUS : "C'Thun Portal"
UPDATE `creature_template_locale` SET `Name` = '쑨의 차원문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15896;
-- AC datas : OLD Name : "맹독 진흙", Name AC enUS : "Toxic Slime" ; Wowhead enUS : "Toxic Slime"
UPDATE `creature_template_locale` SET `Name` = '독성 수액괴물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15925;
-- AC datas : OLD Name : "독구름", Name AC enUS : "Poison Cloud" ; Wowhead enUS : "Poison Cloud"
UPDATE `creature_template_locale` SET `Name` = '독 구름', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15933;
-- AC datas : OLD Subname : "성난비늘 족장", Subname AC enUS : "Grimscale Chieftain" ; Wowhead enUS : "Grimscale Chieftain"
UPDATE `creature_template_locale` SET `Title` = '성난비늘멀록 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15937;
-- AC datas : OLD Name : "성난비늘 점쟁이", Name AC enUS : "Grimscale Seer" ; Wowhead enUS : "Grimscale Seer"
UPDATE `creature_template_locale` SET `Name` = '성난비늘멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15950;
-- AC datas : OLD Name : "다르나서스 정찰병", Name AC enUS : "Darnassian Scout" ; Wowhead enUS : "Darnassian Scout"
UPDATE `creature_template_locale` SET `Name` = '나이트 엘프 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15968;
-- AC datas : OLD Name : "죽음경비병 토르", Name AC enUS : "Deathguard Tor" ; Wowhead enUS : "Deathguard Tor"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 토르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16003;
-- AC datas : OLD Name : "미사용", Name AC enUS : "[UNUSED] Bog Beast B [PH]" ; Wowhead enUS : "[UNUSED] Bog Beast B [PH]"
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16035;
-- AC datas : OLD Name : "거키", Name AC enUS : "Gurky" ; Wowhead enUS : "Gurky"
UPDATE `creature_template_locale` SET `Name` = '구르키', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16069;
-- AC datas : OLD Name : "유령 그리핀", Name AC enUS : "Spectral Gryphon" ; Wowhead enUS : "Spectral Gryphon"
UPDATE `creature_template_locale` SET `Name` = '그리핀 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16081;
-- AC datas : OLD Name : "십자군 사령관 코팩스", Name AC enUS : "Korfax, Champion of the Light" ; Wowhead enUS : "Korfax, Champion of the Light"
UPDATE `creature_template_locale` SET `Name` = '빛의 용사 코팩스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16112;
-- AC datas : OLD Name : "십자군 사령관 엘리고르 돈브링어", Name AC enUS : "Commander Eligor Dawnbringer" ; Wowhead enUS : "Commander Eligor Dawnbringer"
UPDATE `creature_template_locale` SET `Name` = '사령관 엘리고르 돈브링어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16115;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16134;
-- AC datas : OLD Name : "레인", Name AC enUS : "Rayne" ; Wowhead enUS : "Rayne"
UPDATE `creature_template_locale` SET `Name` = '레이네', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16135;
-- AC datas : OLD Subname : "용매 조련사", Subname AC enUS : "Dragonhawk Master" ; Wowhead enUS : "Dragonhawk Master"
UPDATE `creature_template_locale` SET `Title` = '박쥐 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16189;
-- AC datas : OLD Subname : "용매 조련사", Subname AC enUS : "Dragonhawk Master" ; Wowhead enUS : "Dragonhawk Master"
UPDATE `creature_template_locale` SET `Title` = '박쥐 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16192;
-- AC datas : OLD Name : "죽음추적자 라시엘", Name AC enUS : "Deathstalker Rathiel" ; Wowhead enUS : "Deathstalker Rathiel"
UPDATE `creature_template_locale` SET `Name` = '죽음의 추적자 라시엘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16200;
-- AC datas : OLD Subname : "비행 조련사", Subname AC enUS : "Flight Master" ; Wowhead enUS : "Flight Master"
UPDATE `creature_template_locale` SET `Title` = '그리핀/와이번 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16227;
-- AC datas : OLD Name : "죽음추적자 말텐디스", Name AC enUS : "Deathstalker Maltendis" ; Wowhead enUS : "Deathstalker Maltendis"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 말텐디스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16251;
-- AC datas : OLD Name : "셰리", Name AC enUS : "Sheri" ; Wowhead enUS : "Sheri"
UPDATE `creature_template_locale` SET `Name` = '쉬리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16259;
-- AC datas : OLD Subname : "독극물 상인", Subname AC enUS : "Poison Supplies" ; Wowhead enUS : "Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16268;
-- AC datas : OLD Subname : "", Subname AC enUS : "Rogue Trainer" ; Wowhead enUS : "Rogue Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 도적', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16279;
-- AC datas : OLD Name : "짐노새 주인 스톤브루저", Name AC enUS : "Packmaster Stonebruiser" ; Wowhead enUS : "Packmaster Stonebruiser"
UPDATE `creature_template_locale` SET `Name` = '짐말주인 스톤브루저', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16283;
-- AC datas : OLD Name : "해골 기습돌격병", Name AC enUS : "Skeletal Shocktrooper" ; Wowhead enUS : "Skeletal Shocktrooper"
UPDATE `creature_template_locale` SET `Name` = '해골 돌격병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16299;
-- AC datas : OLD Name : "다르나서스 드루이드", Name AC enUS : "Darnassian Druid" ; Wowhead enUS : "Darnassian Druid"
UPDATE `creature_template_locale` SET `Name` = '나이트 엘프 드루이드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16331;
-- AC datas : OLD Name : "다르나서스 여사냥꾼", Name AC enUS : "Darnassian Huntress" ; Wowhead enUS : "Darnassian Huntress"
UPDATE `creature_template_locale` SET `Name` = '나이트 엘프 여사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16332;
-- AC datas : OLD Name : "파수대 침투요원", Name AC enUS : "Sentinel Infiltrator" ; Wowhead enUS : "Sentinel Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '파수대 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16333;
-- AC datas : OLD Name : "검은발 청소부", Name AC enUS : "Blackpaw Scavenger" ; Wowhead enUS : "Blackpaw Scavenger"
UPDATE `creature_template_locale` SET `Name` = '검은발일족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16335;
-- AC datas : OLD Name : "검은발 주술사", Name AC enUS : "Blackpaw Shaman" ; Wowhead enUS : "Blackpaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '검은발일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16337;
-- AC datas : OLD Name : "그림자소나무 학살자", Name AC enUS : "Shadowpine Ripper" ; Wowhead enUS : "Shadowpine Ripper"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16340;
-- AC datas : OLD Name : "그림자소나무 점쟁이", Name AC enUS : "Shadowpine Witch" ; Wowhead enUS : "Shadowpine Witch"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16341;
-- AC datas : OLD Name : "그림자소나무 예언자", Name AC enUS : "Shadowpine Oracle" ; Wowhead enUS : "Shadowpine Oracle"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16343;
-- AC datas : OLD Name : "그림자소나무 인간사냥꾼", Name AC enUS : "Shadowpine Headhunter" ; Wowhead enUS : "Shadowpine Headhunter"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 인간사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16344;
-- AC datas : OLD Name : "그림자소나무 살쾡이군주", Name AC enUS : "Shadowpine Catlord" ; Wowhead enUS : "Shadowpine Catlord"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 살쾡이군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16345;
-- AC datas : OLD Name : "그림자소나무 사술사", Name AC enUS : "Shadowpine Hexxer" ; Wowhead enUS : "Shadowpine Hexxer"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 사술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16346;
-- AC datas : OLD Subname : "전문 약초채집사/약초채집용품 상인", Subname AC enUS : "Herbalism Trainer & Supplies" ; Wowhead enUS : "Herbalism Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '전문 약초채집사/연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16367;
-- AC datas : OLD Name : "은빛 보초병", Name AC enUS : "Argent Sentry" ; Wowhead enUS : "Argent Sentry",  OLD Subname : "은빛십자군", Subname AC enUS : "The Argent Dawn" ; Wowhead enUS : "The Argent Dawn"
UPDATE `creature_template_locale` SET `Name` = '은빛 여명회 보초병', `Title` = '은빛 여명회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16378;
-- AC datas : OLD Name : "해골 마녀", Name AC enUS : "Bone Witch" ; Wowhead enUS : "Bone Witch"
UPDATE `creature_template_locale` SET `Name` = '스컬지 해골마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16380;
-- AC datas : OLD Name : "미라가 된 성난비늘 멀록", Name AC enUS : "Zombified Grimscale" ; Wowhead enUS : "Zombified Grimscale"
UPDATE `creature_template_locale` SET `Name` = '미라가 된 성난비늘멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16402;
-- AC datas : OLD Name : "말라 비틀어진 성난비늘 멀록", Name AC enUS : "Withered Grimscale" ; Wowhead enUS : "Withered Grimscale"
UPDATE `creature_template_locale` SET `Name` = '말라 비틀어진 성난비늘멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16403;
-- AC datas : OLD Name : "노란아가미 광포어", Name AC enUS : "Yellowgill Frenzy" ; Wowhead enUS : "Yellowgill Frenzy"
UPDATE `creature_template_locale` SET `Name` = '노란아가미 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16404;
-- AC datas : OLD Name : "흰꼬리 광포어", Name AC enUS : "Whitetail Frenzy" ; Wowhead enUS : "Whitetail Frenzy"
UPDATE `creature_template_locale` SET `Name` = '흰꼬리 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16405;
-- AC datas : OLD Name : "She number one", Name AC enUS : "She number one" ; Wowhead enUS : "She number one",  OLD Subname : "CocaCola Ambassador", Subname AC enUS : "CocaCola Ambassador" ; Wowhead enUS : "CocaCola Ambassador"
UPDATE `creature_template_locale` SET `Name` = NULL, `Title` = '코카콜라 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16450;
-- AC datas : OLD Name : "She number two", Name AC enUS : "She number two" ; Wowhead enUS : "She number two",  OLD Subname : "CocaCola Ambassador", Subname AC enUS : "CocaCola Ambassador" ; Wowhead enUS : "CocaCola Ambassador"
UPDATE `creature_template_locale` SET `Name` = NULL, `Title` = '코카콜라 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16454;
-- AC datas : OLD Name : "She number three", Name AC enUS : "She number three" ; Wowhead enUS : "She number three",  OLD Subname : "CocaCola Ambassador", Subname AC enUS : "CocaCola Ambassador" ; Wowhead enUS : "CocaCola Ambassador"
UPDATE `creature_template_locale` SET `Name` = NULL, `Title` = '코카콜라 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16455;
-- AC datas : OLD Name : "밤의 무희", Name AC enUS : "Concubine" ; Wowhead enUS : "Zealous Paramour"
UPDATE `creature_template_locale` SET `Name` = '열망 어린 연인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16461;
-- AC datas : OLD Name : "그림자소나무 흑마술사", Name AC enUS : "Shadowpine Shadowcaster" ; Wowhead enUS : "Shadowpine Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '그림자소나무부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16469;
-- AC datas : OLD Name : "무시무시한 귀신", Name AC enUS : "Ghastly Haunt" ; Wowhead enUS : "Ghastly Haunt"
UPDATE `creature_template_locale` SET `Name` = '무시무시한 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16481;
-- AC datas : OLD Name : "은빛십자군 군마", Name AC enUS : "Argent Charger" ; Wowhead enUS : "Argent Charger"
UPDATE `creature_template_locale` SET `Name` = '은빛 여명회 군마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16510;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Master Herbalism Trainer" ; Wowhead enUS : "Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16527;
-- AC datas : OLD Name : "버섯 괴물", Name AC enUS : "Fungal Beast" ; Wowhead enUS : "Fungal Beast"
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16565;
-- AC datas : OLD Name : "광기 어린 물의 정령", Name AC enUS : "Crazed Water Spirit" ; Wowhead enUS : "Crazed Water Spirit"
UPDATE `creature_template_locale` SET `Name` = '광기어린 물의 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16570;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16583;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16588;
-- AC datas : OLD Name : "부상당한 스랄마 그런트", Name AC enUS : "Injured Thrallmar Grunt" ; Wowhead enUS : "Injured Thrallmar Grunt"
UPDATE `creature_template_locale` SET `Name` = '부상당한 스랄마 보병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16590;
-- AC datas : OLD Name : "어둠달 수행사제", Name AC enUS : "Shadowmoon Acolyte" ; Wowhead enUS : "Shadowmoon Acolyte"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 수행사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16594;
-- AC datas : OLD Name : "플로이드 핑쿠스", Name AC enUS : "Floyd Pinkus" ; Wowhead enUS : "Floyd Pinkus"
UPDATE `creature_template_locale` SET `Name` = '플로이드 핀쿠스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16602;
-- AC datas : OLD Name : "브리의 시험용 캐릭터", Name AC enUS : "Bri's Test Character" ; Wowhead enUS : "Bri's Test Character"
UPDATE `creature_template_locale` SET `Name` = '브리아나 슈나이더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16605;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16610;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16621;
-- AC datas : OLD Name : "경매인 이실란", Name AC enUS : "Ithillan" ; Wowhead enUS : "Ithillan",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '이실란', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16627;
-- AC datas : OLD Name : "경매인 카이도리", Name AC enUS : "Caidori" ; Wowhead enUS : "Caidori",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '카이도리', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16628;
-- AC datas : OLD Name : "경매인 탄드론", Name AC enUS : "Tandron" ; Wowhead enUS : "Tandron",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '탄드론', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16629;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '약초채집 용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16630;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16667;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '수습 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16668;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16676;
-- AC datas : OLD Subname : "암거래상", Subname AC enUS : "Shady Dealer" ; Wowhead enUS : "Shady Dealer"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16682;
-- AC datas : OLD Name : "경매인 에오크", Name AC enUS : "Eoch" ; Wowhead enUS : "Eoch",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '에오크', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16707;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16719;
-- AC datas : OLD Subname : "", Subname AC enUS : "" ; Wowhead enUS : ""
UPDATE `creature_template_locale` SET `Title` = '악마 훈련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16720;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16726;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '약초채집 용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16737;
-- AC datas : OLD Subname : "수습 기계공학자", Subname AC enUS : "Apprentice Engineer" ; Wowhead enUS : "Apprentice Engineer"
UPDATE `creature_template_locale` SET `Title` = '수습 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16743;
-- AC datas : OLD Subname : "독극물 상인", Subname AC enUS : "Poison Supplies" ; Wowhead enUS : "Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16754;
-- AC datas : OLD Subname : "휘장 상인", Subname AC enUS : "Tabard Vendor" ; Wowhead enUS : "Tabard Vendor"
UPDATE `creature_template_locale` SET `Title` = '길드 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16766;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16773;
-- AC datas : OLD Name : "전쟁인도자 오므로그", Name AC enUS : "Warbringer O'mrogg" ; Wowhead enUS : "Warbringer O'mrogg"
UPDATE `creature_template_locale` SET `Name` = '돌격대장 오므로그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16809;
-- AC datas : OLD Subname : "흑마법사", Subname AC enUS : "The Warlock" ; Wowhead enUS : "The Warlock"
UPDATE `creature_template_locale` SET `Title` = '흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16814;
-- AC datas : OLD Subname : "로서의 후예들", Subname AC enUS : "Sons of Lothar" ; Wowhead enUS : "Sons of Lothar"
UPDATE `creature_template_locale` SET `Title` = '로서의 후예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16819;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16823;
-- AC datas : OLD Name : "정예근위병 로린 탈메로크", Name AC enUS : "Master Sergeant Lorin Thalmerok" ; Wowhead enUS : "Master Sergeant Lorin Thalmerok"
UPDATE `creature_template_locale` SET `Name` = '하사관 로린 탈메로크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16824;
-- AC datas : OLD Name : "수도자 오베다이", Name AC enUS : "Anchorite Obadei" ; Wowhead enUS : "Anchorite Obadei"
UPDATE `creature_template_locale` SET `Name` = '수도사 오베다이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16834;
-- AC datas : OLD Name : "탈출한 넝마두건 일족", Name AC enUS : "Escaped Dreghood" ; Wowhead enUS : "Escaped Dreghood"
UPDATE `creature_template_locale` SET `Name` = '탈출한 넝마두건일족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16836;
-- AC datas : OLD Name : "광기 어린 지옥멧돼지", Name AC enUS : "Deranged Helboar" ; Wowhead enUS : "Deranged Helboar"
UPDATE `creature_template_locale` SET `Name` = '광기어린 지옥멧돼지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16863;
-- AC datas : OLD Name : "윈섬", Name AC enUS : "Laughing Skull Slayer" ; Wowhead enUS : "Laughing Skull Slayer"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16868;
-- AC datas : OLD Name : "지싱", Name AC enUS : "Laughing Skull Neophyte" ; Wowhead enUS : "Laughing Skull Neophyte"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 수련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16869;
-- AC datas : OLD Name : "피눈물 그런트", Name AC enUS : "Bleeding Hollow Grunt" ; Wowhead enUS : "Bleeding Hollow Grunt"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16871;
-- AC datas : OLD Name : "피눈물 흑마법사", Name AC enUS : "Bleeding Hollow Warlock" ; Wowhead enUS : "Bleeding Hollow Warlock"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16872;
-- AC datas : OLD Name : "피눈물 암흑주술사", Name AC enUS : "Bleeding Hollow Dark Shaman" ; Wowhead enUS : "Bleeding Hollow Dark Shaman"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 암흑주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16873;
-- AC datas : OLD Name : "피눈물 흑마술사", Name AC enUS : "Bleeding Hollow Shadowcaster" ; Wowhead enUS : "Bleeding Hollow Shadowcaster"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16874;
-- AC datas : OLD Name : "명예의 요새 훈련용 허수아비", Name AC enUS : "Honor Hold Target Dummy Middle" ; Wowhead enUS : "Honor Hold Target Dummy Middle"
UPDATE `creature_template_locale` SET `Name` = '명예의 요새 수련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16897;
-- AC datas : OLD Name : "명예의 요새 훈련용 허수아비", Name AC enUS : "Honor Hold Target Dummy Right" ; Wowhead enUS : "Honor Hold Target Dummy Right"
UPDATE `creature_template_locale` SET `Name` = '명예의 요새 수련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16898;
-- AC datas : OLD Name : "명예의 요새 훈련용 허수아비", Name AC enUS : "Honor Hold Target Dummy Left" ; Wowhead enUS : "Honor Hold Target Dummy Left"
UPDATE `creature_template_locale` SET `Name` = '명예의 요새 수련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16899;
-- AC datas : OLD Name : "피눈물 일꾼", Name AC enUS : "Bleeding Hollow Peon" ; Wowhead enUS : "Bleeding Hollow Peon"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16907;
-- AC datas : OLD Name : "넝마두건 창잡이", Name AC enUS : "Dreghood Spearman" ; Wowhead enUS : "Dreghood Spearman"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 창잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16935;
-- AC datas : OLD Name : "넝마두건 방랑자", Name AC enUS : "Dreghood Wanderer" ; Wowhead enUS : "Dreghood Wanderer"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 방랑자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16936;
-- AC datas : OLD Name : "넝마두건 흙점쟁이", Name AC enUS : "Dreghood Geomancer" ; Wowhead enUS : "Dreghood Geomancer"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16937;
-- AC datas : OLD Name : "넝마두건 투사", Name AC enUS : "Dreghood Brute" ; Wowhead enUS : "Dreghood Brute"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16938;
-- AC datas : OLD Name : "변화하는 공허소환사", Name AC enUS : "Phasing Voidcaller" ; Wowhead enUS : "Phasing Voidcaller"
UPDATE `creature_template_locale` SET `Name` = '변화하는 공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16941;
-- AC datas : OLD Name : "간아그 기계박사", Name AC enUS : "Gan'arg Mekgineer" ; Wowhead enUS : "Gan'arg Mekgineer"
UPDATE `creature_template_locale` SET `Name` = '간아그 기계공학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16949;
-- AC datas : OLD Name : "하알에쉬 매눈박이", Name AC enUS : "Haal'eshi Hawkeye" ; Wowhead enUS : "Haal'eshi Hawkeye"
UPDATE `creature_template_locale` SET `Name` = '하알레쉬 매눈박이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16965;
-- AC datas : OLD Name : "떠도는 공허방랑자", Name AC enUS : "Rogue Voidwalker" ; Wowhead enUS : "Rogue Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '떠도는 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16974;
-- AC datas : OLD Name : "구속이 풀린 공허방랑자", Name AC enUS : "Uncontrolled Voidwalker" ; Wowhead enUS : "Uncontrolled Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '구속이 풀린 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16975;
-- AC datas : OLD Name : "드레나이 수도자", Name AC enUS : "Draenei Anchorite" ; Wowhead enUS : "Draenei Anchorite"
UPDATE `creature_template_locale` SET `Name` = '드레나이 수도사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16994;
-- AC datas : OLD Name : "비글스워스 씨", Name AC enUS : "Mr. Bigglesworth" ; Wowhead enUS : "Mr. Bigglesworth"
UPDATE `creature_template_locale` SET `Name` = '비글스워스씨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 16998;
-- AC datas : OLD Subname : "", Subname AC enUS : "Weapon Master" ; Wowhead enUS : "Weapon Master"
UPDATE `creature_template_locale` SET `Title` = '무기 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17005;
-- AC datas : OLD Name : "붕괴하는 공허방랑자", Name AC enUS : "Collapsing Voidwalker" ; Wowhead enUS : "Collapsing Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '붕괴하는 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17014;
-- AC datas : OLD Name : "용아귀 부족 병사", Name AC enUS : "Dragonmaw Clan Soldier" ; Wowhead enUS : "Dragonmaw Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17016;
-- AC datas : OLD Name : "검은바위 병사", Name AC enUS : "Blackrock Clan Soldier" ; Wowhead enUS : "Blackrock Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '검은바위부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17017;
-- AC datas : OLD Name : "천둥군주 부족 병사", Name AC enUS : "Thunderlord Clan Soldier" ; Wowhead enUS : "Thunderlord Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '천둥군주부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17018;
-- AC datas : OLD Name : "서리늑대 병사", Name AC enUS : "Frostwolf Clan Soldier" ; Wowhead enUS : "Frostwolf Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '서리늑대부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17019;
-- AC datas : OLD Name : "피눈물 부족 병사", Name AC enUS : "Bleeding Hollow Clan Soldier" ; Wowhead enUS : "Bleeding Hollow Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17020;
-- AC datas : OLD Name : "전쟁노래 병사", Name AC enUS : "Warsong Clan Soldier" ; Wowhead enUS : "Warsong Clan Soldier"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17021;
-- AC datas : OLD Subname : "전문 낚시꾼 및 낚시용품 상인", Subname AC enUS : "Fishing Trainer & Supplies" ; Wowhead enUS : "Fishing Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '낚시용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17101;
-- AC datas : OLD Name : "수도자 델란", Name AC enUS : "Anchorite Delan" ; Wowhead enUS : "Anchorite Delan"
UPDATE `creature_template_locale` SET `Name` = '수도사 델란', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17104;
-- AC datas : OLD Subname : "", Subname AC enUS : "Mage Trainer" ; Wowhead enUS : "Mage Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17105;
-- AC datas : OLD Name : "너울소나무 아루구", Name AC enUS : "Arugoo of the Stillpine" ; Wowhead enUS : "Arugoo of the Stillpine"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 아루구', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17114;
-- AC datas : OLD Name : "수도자 아분", Name AC enUS : "Anchorite Avuun" ; Wowhead enUS : "Anchorite Avuun"
UPDATE `creature_template_locale` SET `Name` = '수도사 아분', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17127;
-- AC datas : OLD Name : "돌주먹 장사", Name AC enUS : "Boulderfist Crusher" ; Wowhead enUS : "Boulderfist Crusher"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 장사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17134;
-- AC datas : OLD Name : "돌주먹 비술사", Name AC enUS : "Boulderfist Mystic" ; Wowhead enUS : "Boulderfist Mystic"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17135;
-- AC datas : OLD Name : "돌주먹 전사", Name AC enUS : "Boulderfist Warrior" ; Wowhead enUS : "Boulderfist Warrior"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17136;
-- AC datas : OLD Name : "돌주먹 마법사", Name AC enUS : "Boulderfist Mage" ; Wowhead enUS : "Boulderfist Mage"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17137;
-- AC datas : OLD Name : "전쟁망치 약탈자", Name AC enUS : "Warmaul Reaver" ; Wowhead enUS : "Warmaul Reaver"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17138;
-- AC datas : OLD Name : "바람갈대 청소부", Name AC enUS : "Windyreed Scavenger" ; Wowhead enUS : "Windyreed Scavenger"
UPDATE `creature_template_locale` SET `Name` = '바람갈대일족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17139;
-- AC datas : OLD Name : "바람갈대 난민", Name AC enUS : "Windyreed Wretch" ; Wowhead enUS : "Windyreed Wretch"
UPDATE `creature_template_locale` SET `Name` = '바람갈대일족 난민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17141;
-- AC datas : OLD Name : "지옥수호병", Name AC enUS : "Felguard Legionnaire" ; Wowhead enUS : "Felguard Legionnaire"
UPDATE `creature_template_locale` SET `Name` = '지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17152;
-- AC datas : OLD Name : "뾰족가지 바람소환사", Name AC enUS : "Bristlelimb Windcaller" ; Wowhead enUS : "Bristlelimb Windcaller"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 바람소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17184;
-- AC datas : OLD Name : "뾰족가지 펄볼그", Name AC enUS : "Bristlelimb Ursa" ; Wowhead enUS : "Bristlelimb Ursa"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17185;
-- AC datas : OLD Name : "진흙지느러미 멀록", Name AC enUS : "Siltfin Murloc" ; Wowhead enUS : "Siltfin Murloc"
UPDATE `creature_template_locale` SET `Name` = '진흙지느러미멀록', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17190;
-- AC datas : OLD Name : "진흙지느러미 수련사", Name AC enUS : "Siltfin Oracle" ; Wowhead enUS : "Siltfin Oracle"
UPDATE `creature_template_locale` SET `Name` = '진흙지느러미멀록 수련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17191;
-- AC datas : OLD Name : "진흙지느러미 사냥꾼", Name AC enUS : "Siltfin Hunter" ; Wowhead enUS : "Siltfin Hunter"
UPDATE `creature_template_locale` SET `Name` = '진흙지느러미멀록 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17192;
-- AC datas : OLD Name : "성난비늘 나가", Name AC enUS : "Wrathscale Naga" ; Wowhead enUS : "Wrathscale Naga"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 나가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17193;
-- AC datas : OLD Name : "성난비늘 미르미돈", Name AC enUS : "Wrathscale Myrmidon" ; Wowhead enUS : "Wrathscale Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17194;
-- AC datas : OLD Name : "성난비늘 세이렌", Name AC enUS : "Wrathscale Siren" ; Wowhead enUS : "Wrathscale Siren"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17195;
-- AC datas : OLD Name : "수도자 파티마", Name AC enUS : "Anchorite Fateema" ; Wowhead enUS : "Anchorite Fateema"
UPDATE `creature_template_locale` SET `Name` = '수도사 파티마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17214;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Engineering Trainer" ; Wowhead enUS : "Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17222;
-- AC datas : OLD Subname : "은빛 성기사단", Subname AC enUS : "Knights of the Silver Hand" ; Wowhead enUS : "Knights of the Silver Hand"
UPDATE `creature_template_locale` SET `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17233;
-- AC datas : OLD Name : "수도자 트루엔", Name AC enUS : "Anchorite Truuen" ; Wowhead enUS : "Anchorite Truuen"
UPDATE `creature_template_locale` SET `Name` = '수도사 트루엔', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17238;
-- AC datas : OLD Subname : "전문 대장장이 및 대장용품 상인", Subname AC enUS : "Blacksmithing Trainer & Supplies" ; Wowhead enUS : "Blacksmithing Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '수습 대장장이 및 대장용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17245;
-- AC datas : OLD Subname : "전문 요리사 및 요리 용품 상인", Subname AC enUS : "Cooking Trainer & Supplies" ; Wowhead enUS : "Cooking Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '요리사 및 요리 용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17246;
-- AC datas : OLD Name : "피눈물 암흑술사", Name AC enUS : "Bleeding Hollow Darkcaster" ; Wowhead enUS : "Bleeding Hollow Darkcaster"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 암흑술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17269;
-- AC datas : OLD Name : "피눈물 궁사", Name AC enUS : "Bleeding Hollow Archer" ; Wowhead enUS : "Bleeding Hollow Archer"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 궁사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17270;
-- AC datas : OLD Name : "대장 앨리나", Name AC enUS : "Captain Alina" ; Wowhead enUS : "Captain Alina"
UPDATE `creature_template_locale` SET `Name` = '대장 알리나', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17290;
-- AC datas : OLD Name : "나알", Name AC enUS : "Gnarl" ; Wowhead enUS : "Gnarl"
UPDATE `creature_template_locale` SET `Name` = '그날', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17310;
-- AC datas : OLD Name : "슬림의 죽어라때려보라지", Name AC enUS : "Slim's Unkillable Test Dummy" ; Wowhead enUS : "Slim's Unkillable Test Dummy"
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17313;
-- AC datas : OLD Name : "뾰족가지 길잡이", Name AC enUS : "Bristlelimb Pathfinder" ; Wowhead enUS : "Bristlelimb Pathfinder"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17319;
-- AC datas : OLD Name : "뾰족가지 주술사", Name AC enUS : "Bristlelimb Shaman" ; Wowhead enUS : "Bristlelimb Shaman"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17320;
-- AC datas : OLD Name : "뾰족가지 전사", Name AC enUS : "Bristlelimb Warrior" ; Wowhead enUS : "Bristlelimb Warrior"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17321;
-- AC datas : OLD Name : "검은진흙 채집꾼", Name AC enUS : "Blacksilt Forager" ; Wowhead enUS : "Blacksilt Forager"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17325;
-- AC datas : OLD Name : "검은진흙 정찰꾼", Name AC enUS : "Blacksilt Scout" ; Wowhead enUS : "Blacksilt Scout"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17326;
-- AC datas : OLD Name : "검은진흙 파도술사", Name AC enUS : "Blacksilt Tidecaller" ; Wowhead enUS : "Blacksilt Tidecaller"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 파도술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17327;
-- AC datas : OLD Name : "검은진흙 바다약탈자", Name AC enUS : "Blacksilt Shorestriker" ; Wowhead enUS : "Blacksilt Shorestriker"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 바다약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17328;
-- AC datas : OLD Name : "검은진흙 전사", Name AC enUS : "Blacksilt Warrior" ; Wowhead enUS : "Blacksilt Warrior"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17329;
-- AC datas : OLD Name : "검은진흙 점쟁이", Name AC enUS : "Blacksilt Seer" ; Wowhead enUS : "Blacksilt Seer"
UPDATE `creature_template_locale` SET `Name` = '검은진흙멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17330;
-- AC datas : OLD Name : "성난비늘 바다추적자", Name AC enUS : "Wrathscale Shorestalker" ; Wowhead enUS : "Wrathscale Shorestalker"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 바다추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17331;
-- AC datas : OLD Name : "성난비늘 침략자", Name AC enUS : "Wrathscale Raider" ; Wowhead enUS : "Wrathscale Raider"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 침략자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17332;
-- AC datas : OLD Name : "성난비늘 비명술사", Name AC enUS : "Wrathscale Screamer" ; Wowhead enUS : "Wrathscale Screamer"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 비명술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17333;
-- AC datas : OLD Name : "성난비늘 약탈자", Name AC enUS : "Wrathscale Marauder" ; Wowhead enUS : "Wrathscale Marauder"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17334;
-- AC datas : OLD Name : "성난비늘 수호병", Name AC enUS : "Wrathscale Serpent Guard" ; Wowhead enUS : "Wrathscale Serpent Guard"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17335;
-- AC datas : OLD Name : "성난비늘 여마법사", Name AC enUS : "Wrathscale Sorceress" ; Wowhead enUS : "Wrathscale Sorceress"
UPDATE `creature_template_locale` SET `Name` = '성난비늘일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17336;
-- AC datas : OLD Name : "너울소나무 언어의 토템 06", Name AC enUS : "Stillpine Langauge Totem 06" ; Wowhead enUS : "Stillpine Langauge Totem 06"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 언어의 토템 06', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17365;
-- AC datas : OLD Name : "너울소나무 언어의 토템 07", Name AC enUS : "Stillpine Langauge Totem 07" ; Wowhead enUS : "Stillpine Langauge Totem 07"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 언어의 토템 07', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17366;
-- AC datas : OLD Name : "웃는 해골 집행자", Name AC enUS : "Laughing Skull Enforcer" ; Wowhead enUS : "Laughing Skull Enforcer"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17370;
-- AC datas : OLD Name : "어둠달 흑마법사", Name AC enUS : "Shadowmoon Warlock" ; Wowhead enUS : "Shadowmoon Warlock"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17371;
-- AC datas : OLD Name : "너울소나무 포로", Name AC enUS : "Stillpine Captive" ; Wowhead enUS : "Stillpine Captive"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17375;
-- AC datas : OLD Name : "너울소나무 선조 아키다", Name AC enUS : "Stillpine Ancestor Akida" ; Wowhead enUS : "Stillpine Ancestor Akida"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 아키다', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17379;
-- AC datas : OLD Name : "어둠달 공허소환사", Name AC enUS : "Shadowmoon Voidcaller" ; Wowhead enUS : "Shadowmoon Voidcaller"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17389;
-- AC datas : OLD Name : "너울소나무 선조 쿠우", Name AC enUS : "Stillpine Ancestor Coo" ; Wowhead enUS : "Stillpine Ancestor Coo"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 쿠우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17391;
-- AC datas : OLD Name : "너울소나무 선조 티크티", Name AC enUS : "Stillpine Ancestor Tikti" ; Wowhead enUS : "Stillpine Ancestor Tikti"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 티크티', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17392;
-- AC datas : OLD Name : "너울소나무 선조 요르", Name AC enUS : "Stillpine Ancestor Yor" ; Wowhead enUS : "Stillpine Ancestor Yor"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 요르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17393;
-- AC datas : OLD Name : "어둠달 소환사", Name AC enUS : "Shadowmoon Summoner" ; Wowhead enUS : "Shadowmoon Summoner"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17395;
-- AC datas : OLD Name : "어둠달 마술사", Name AC enUS : "Shadowmoon Sorcerer" ; Wowhead enUS : "Shadowmoon Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17396;
-- AC datas : OLD Name : "어둠달 숙련병", Name AC enUS : "Shadowmoon Adept" ; Wowhead enUS : "Shadowmoon Adept"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 숙련병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17397;
-- AC datas : OLD Name : "파멸의 지옥수호병", Name AC enUS : "Felguard Annihilator" ; Wowhead enUS : "Felguard Annihilator"
UPDATE `creature_template_locale` SET `Name` = '파멸의 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17400;
-- AC datas : OLD Name : "수도자 알렌다르", Name AC enUS : "Anchorite Alendar" ; Wowhead enUS : "Anchorite Alendar"
UPDATE `creature_template_locale` SET `Name` = '수도사 알렌다르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17403;
-- AC datas : OLD Name : "수습생 볼리안", Name AC enUS : "Apprentice Boulian" ; Wowhead enUS : "Apprentice Boulian"
UPDATE `creature_template_locale` SET `Name` = '수습생 바울리안', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17409;
-- AC datas : OLD Name : "너울소나무 선조 바르크", Name AC enUS : "Stillpine Ancestor Vark" ; Wowhead enUS : "Stillpine Ancestor Vark"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 바르크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17410;
-- AC datas : OLD Name : "어둠달 기술병", Name AC enUS : "Shadowmoon Technician" ; Wowhead enUS : "Shadowmoon Technician"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 기술병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17414;
-- AC datas : OLD Name : "웃는 해골 복병", Name AC enUS : "Laughing Skull Ambusher" ; Wowhead enUS : "Laughing Skull Ambusher"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17418;
-- AC datas : OLD Name : "너울소나무 선조 쿠우", Name AC enUS : "Stillpine Ancestor Coo Transform" ; Wowhead enUS : "Stillpine Ancestor Coo Transform"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 선조 쿠우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17422;
-- AC datas : OLD Name : "수도자 패테우스", Name AC enUS : "Anchorite Paetheus" ; Wowhead enUS : "Anchorite Paetheus"
UPDATE `creature_template_locale` SET `Name` = '수도사 패테우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17424;
-- AC datas : OLD Name : "너울소나무 파수꾼", Name AC enUS : "Stillpine Defender" ; Wowhead enUS : "Stillpine Defender"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17432;
-- AC datas : OLD Name : "너울소나무 파수꾼 시체", Name AC enUS : "Stillpine Defender Corpse" ; Wowhead enUS : "Stillpine Defender Corpse"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 파수꾼 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17437;
-- AC datas : OLD Name : "너울소나무 사냥꾼", Name AC enUS : "Stillpine Hunter" ; Wowhead enUS : "Stillpine Hunter"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17439;
-- AC datas : OLD Name : "하급 어둠의 균열", Name AC enUS : "Lesser Shadow Fissure" ; Wowhead enUS : "Lesser Shadow Fissure"
UPDATE `creature_template_locale` SET `Name` = '작은 어둠의 균열', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17471;
-- AC datas : OLD Name : "피눈물 점술사", Name AC enUS : "Bleeding Hollow Scryer" ; Wowhead enUS : "Bleeding Hollow Scryer"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 점술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17478;
-- AC datas : OLD Name : "로건 다니엘", Name AC enUS : "Logan Daniel" ; Wowhead enUS : "Logan Daniel"
UPDATE `creature_template_locale` SET `Name` = '로간 다니엘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17489;
-- AC datas : OLD Name : "너울소나무 에르그", Name AC enUS : "Ergh of the Stillpine" ; Wowhead enUS : "Ergh of the Stillpine"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 에르그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17490;
-- AC datas : OLD Name : "웃는 해골 도적", Name AC enUS : "Laughing Skull Rogue" ; Wowhead enUS : "Laughing Skull Rogue"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 도적', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17491;
-- AC datas : OLD Name : "너울소나무 약탈꾼", Name AC enUS : "Stillpine Raider" ; Wowhead enUS : "Stillpine Raider"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17495;
-- AC datas : OLD Name : "지옥불 훈련용 허수아비", Name AC enUS : "Hellfire Training Dummy" ; Wowhead enUS : "Hellfire Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '수련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17578;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition Vendor" ; Wowhead enUS : "Ammunition Vendor"
UPDATE `creature_template_locale` SET `Title` = '화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17598;
-- AC datas : OLD Name : "짐꾼 엘레크", Name AC enUS : "Pack Elekk" ; Wowhead enUS : "Pack Elekk"
UPDATE `creature_template_locale` SET `Name` = '짐 나르는 엘레크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17601;
-- AC datas : OLD Name : "웃는 해골 감시자", Name AC enUS : "Laughing Skull Warden" ; Wowhead enUS : "Laughing Skull Warden"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17624;
-- AC datas : OLD Name : "웃는 해골 병사", Name AC enUS : "Laughing Skull Legionnaire" ; Wowhead enUS : "Laughing Skull Legionnaire"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17626;
-- AC datas : OLD Name : "경매인 제나스", Name AC enUS : "Jenath" ; Wowhead enUS : "Jenath",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '제나스', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17627;
-- AC datas : OLD Name : "경매인 빈나", Name AC enUS : "Vynna" ; Wowhead enUS : "Vynna",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '빈나', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17628;
-- AC datas : OLD Name : "경매인 페인나", Name AC enUS : "Feynna" ; Wowhead enUS : "Feynna",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '페인나', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17629;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17634;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17637;
-- AC datas : OLD Name : "진흙지느러미 복병", Name AC enUS : "Siltfin Ambusher" ; Wowhead enUS : "Siltfin Ambusher"
UPDATE `creature_template_locale` SET `Name` = '진흙지느러미멀록 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17638;
-- AC datas : OLD Name : "뾰족가지 복병", Name AC enUS : "Bristlelimb Ambusher" ; Wowhead enUS : "Bristlelimb Ambusher"
UPDATE `creature_template_locale` SET `Name` = '뾰족가지일족 복병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17640;
-- AC datas : OLD Name : "어둠달 역술사", Name AC enUS : "Shadowmoon Channeler" ; Wowhead enUS : "Shadowmoon Channeler"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 역술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17653;
-- AC datas : OLD Name : "표시 달린 검은진흙 정찰꾼", Name AC enUS : "Tagged Blacksilt Scout" ; Wowhead enUS : "Tagged Blacksilt Scout"
UPDATE `creature_template_locale` SET `Name` = '표시 달린 검은진흙멀록 정찰꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17654;
-- AC datas : OLD Name : "맥아리의 제세라", Name AC enUS : "Jessera of Mac'Aree" ; Wowhead enUS : "Maatparm"
UPDATE `creature_template_locale` SET `Name` = '마아트팜', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17663;
-- AC datas : OLD Name : "저승바람 주민", Name AC enUS : "Deadwind Villager" ; Wowhead enUS : "Deadwind Villager"
UPDATE `creature_template_locale` SET `Name` = '죽음의고개 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17672;
-- AC datas : OLD Name : "고린뿔작살광포어", Name AC enUS : "Stinkhorn Striker" ; Wowhead enUS : "Stinkhorn Striker"
UPDATE `creature_template_locale` SET `Name` = '고린뿔 작살프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17673;
-- AC datas : OLD Name : "불꽃 화살", Name AC enUS : "Flame Arrow" ; Wowhead enUS : "Flame Arrow"
UPDATE `creature_template_locale` SET `Name` = '불화살', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17687;
-- AC datas : OLD Name : "어둠달 암흑술사", Name AC enUS : "Shadowmoon Darkcaster" ; Wowhead enUS : "Shadowmoon Darkcaster"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 암흑술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17694;
-- AC datas : OLD Name : "역병숲 호드 점령 퀘스트", Name AC enUS : "Plaguewood Horde Capture Quest Doodad" ; Wowhead enUS : "Plaguewood Horde Capture Quest Doodad"
UPDATE `creature_template_locale` SET `Name` = '역병의 숲 호드 점령 퀘스트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17699;
-- AC datas : OLD Name : "성난갈퀴 미르미돈", Name AC enUS : "Wrathfin Myrmidon" ; Wowhead enUS : "Wrathfin Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '성난갈퀴일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17726;
-- AC datas : OLD Name : "성난갈퀴 보초", Name AC enUS : "Wrathfin Sentry" ; Wowhead enUS : "Wrathfin Sentry"
UPDATE `creature_template_locale` SET `Name` = '성난갈퀴일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17727;
-- AC datas : OLD Name : "수렁피 전사", Name AC enUS : "Murkblood Tribesman" ; Wowhead enUS : "Murkblood Tribesman"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17728;
-- AC datas : OLD Name : "수렁피 창잡이", Name AC enUS : "Murkblood Spearman" ; Wowhead enUS : "Murkblood Spearman"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 창잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17729;
-- AC datas : OLD Name : "수렁피 치유사", Name AC enUS : "Murkblood Healer" ; Wowhead enUS : "Murkblood Healer"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 치유사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17730;
-- AC datas : OLD Name : "성난갈퀴 전사", Name AC enUS : "Wrathfin Warrior" ; Wowhead enUS : "Wrathfin Warrior"
UPDATE `creature_template_locale` SET `Name` = '성난갈퀴일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17735;
-- AC datas : OLD Name : "수렁피 점쟁이", Name AC enUS : "Murkblood Oracle" ; Wowhead enUS : "Murkblood Oracle"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17771;
-- AC datas : OLD Name : "제이나 프라우드무어", Name AC enUS : "Lady Jaina Proudmoore" ; Wowhead enUS : "Lady Jaina Proudmoore"
UPDATE `creature_template_locale` SET `Name` = '여군주 제이나 프라우드무어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17772;
-- AC datas : OLD Name : "넝마두건 노예", Name AC enUS : "Dreghood Slave" ; Wowhead enUS : "Dreghood Slave"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17799;
-- AC datas : OLD Name : "[미사용] 광포한 늑대인간", Name AC enUS : "Crazed Worgen" ; Wowhead enUS : "Crazed Worgen"
UPDATE `creature_template_locale` SET `Name` = '광포한 늑대인간', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17823;
-- AC datas : OLD Name : "수렁피 현장감독", Name AC enUS : "Murkblood Foreman" ; Wowhead enUS : "Murkblood Foreman"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 현장감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17872;
-- AC datas : OLD Name : "수렁피 심복", Name AC enUS : "Murkblood Henchman" ; Wowhead enUS : "Murkblood Henchman",  OLD Subname : "수렁피 현장감독의 아첨꾼", Subname AC enUS : "Murkblood Foreman's Flunky" ; Wowhead enUS : "Murkblood Foreman's Flunky"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 심복', `Title` = '수렁피일족 현장감독의 아첨꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17873;
-- AC datas : OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17910;
-- AC datas : OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17911;
-- AC datas : OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17912;
-- AC datas : OLD Name : "제압자 앨마르", Name AC enUS : "Aelmar the Vanquisher" ; Wowhead enUS : "Aelmar the Vanquisher",  OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Name` = '복수자 앨마르', `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17913;
-- AC datas : OLD Name : "성직자 히에로니무스", Name AC enUS : "Vicar Hieronymus" ; Wowhead enUS : "Vicar Hieronymus",  OLD Subname : "은빛 성기사단", Subname AC enUS : "Order of the Silver Hand" ; Wowhead enUS : "Order of the Silver Hand"
UPDATE `creature_template_locale` SET `Name` = '성직자 에어로니무스', `Title` = '은빛 기사단', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17914;
-- AC datas : OLD Name : "갈퀴송곳니 요술사", Name AC enUS : "Coilfang Enchantress" ; Wowhead enUS : "Coilfang Enchantress"
UPDATE `creature_template_locale` SET `Name` = '갈퀴송곳니 마법부여사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17961;
-- AC datas : OLD Name : "거친황야 노예", Name AC enUS : "Wastewalker Slave" ; Wowhead enUS : "Wastewalker Slave"
UPDATE `creature_template_locale` SET `Name` = '거친황야일족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17963;
-- AC datas : OLD Name : "거친황야 일꾼", Name AC enUS : "Wastewalker Worker" ; Wowhead enUS : "Wastewalker Worker"
UPDATE `creature_template_locale` SET `Name` = '거친황야일족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17964;
-- AC datas : OLD Name : "지하쇠똥구리", Name AC enUS : "Crypt Scarab" ; Wowhead enUS : "Crypt Scarab"
UPDATE `creature_template_locale` SET `Name` = '납골당 스카라베', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17967;
-- AC datas : OLD Name : "수도자 아후른", Name AC enUS : "Anchorite Ahuurn" ; Wowhead enUS : "Anchorite Ahuurn"
UPDATE `creature_template_locale` SET `Name` = '수도사 아후른', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18003;
-- AC datas : OLD Name : "전쟁망치 흑마법사", Name AC enUS : "Warmaul Warlock" ; Wowhead enUS : "Warmaul Warlock"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18037;
-- AC datas : OLD Name : "그늘늪 감독관", Name AC enUS : "Umbrafen Slavebinder" ; Wowhead enUS : "Umbrafen Slavebinder"
UPDATE `creature_template_locale` SET `Name` = '그늘늪일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18042;
-- AC datas : OLD Name : "전쟁망치 주술사", Name AC enUS : "Warmaul Shaman" ; Wowhead enUS : "Warmaul Shaman"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18064;
-- AC datas : OLD Name : "전쟁망치 투사", Name AC enUS : "Warmaul Brute" ; Wowhead enUS : "Warmaul Brute"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18065;
-- AC datas : OLD Subname : "전쟁망치 일족의 영웅", Subname AC enUS : "Hero of the Warmaul" ; Wowhead enUS : "Hero of the Warmaul"
UPDATE `creature_template_locale` SET `Title` = '전쟁망치일족의 영웅', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18069;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18071;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18072;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18073;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18074;
-- AC datas : OLD Name : "그늘늪 예언자", Name AC enUS : "Umbrafen Oracle" ; Wowhead enUS : "Umbrafen Oracle"
UPDATE `creature_template_locale` SET `Name` = '그늘늪일족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18077;
-- AC datas : OLD Name : "그늘늪 점쟁이", Name AC enUS : "Umbrafen Seer" ; Wowhead enUS : "Umbrafen Seer"
UPDATE `creature_template_locale` SET `Name` = '그늘늪일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18079;
-- AC datas : OLD Name : "암흑갈기 감독관", Name AC enUS : "Darkcrest Taskmaster" ; Wowhead enUS : "Darkcrest Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '암흑갈기일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18086;
-- AC datas : OLD Name : "암흑갈기 세이렌", Name AC enUS : "Darkcrest Siren" ; Wowhead enUS : "Darkcrest Siren"
UPDATE `creature_template_locale` SET `Name` = '암흑갈기일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18087;
-- AC datas : OLD Name : "피비늘 요술사", Name AC enUS : "Bloodscale Enchantress" ; Wowhead enUS : "Bloodscale Enchantress"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 마법부여사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18088;
-- AC datas : OLD Name : "피비늘 노예감독", Name AC enUS : "Bloodscale Slavedriver" ; Wowhead enUS : "Bloodscale Slavedriver"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 노예감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18089;
-- AC datas : OLD Name : "타렌 제분소 경비병", Name AC enUS : "Tarren Mill Guardsman" ; Wowhead enUS : "Tarren Mill Guardsman"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18092;
-- AC datas : OLD Name : "타렌 제분소 민병대원", Name AC enUS : "Tarren Mill Protector" ; Wowhead enUS : "Tarren Mill Protector"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 민병대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18093;
-- AC datas : OLD Name : "타렌 제분소 보초", Name AC enUS : "Tarren Mill Lookout" ; Wowhead enUS : "Tarren Mill Lookout"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18094;
-- AC datas : OLD Name : "파멸불꽃 영혼", Name AC enUS : "Doomfire Spirit" ; Wowhead enUS : "Doomfire Spirit"
UPDATE `creature_template_locale` SET `Name` = 'Doomfire Targeting', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18104;
-- AC datas : OLD Name : "야생늪 사냥꾼", Name AC enUS : "Feralfen Hunter" ; Wowhead enUS : "Feralfen Hunter"
UPDATE `creature_template_locale` SET `Name` = '야생늪일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18113;
-- AC datas : OLD Name : "야생늪 비술사", Name AC enUS : "Feralfen Mystic" ; Wowhead enUS : "Feralfen Mystic"
UPDATE `creature_template_locale` SET `Name` = '야생늪일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18114;
-- AC datas : OLD Name : "비수늪 땅꾼", Name AC enUS : "Daggerfen Muckdweller" ; Wowhead enUS : "Daggerfen Muckdweller"
UPDATE `creature_template_locale` SET `Name` = '비수늪일족 땅꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18115;
-- AC datas : OLD Name : "비수늪 암살자", Name AC enUS : "Daggerfen Assassin" ; Wowhead enUS : "Daggerfen Assassin"
UPDATE `creature_template_locale` SET `Name` = '비수늪일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18116;
-- AC datas : OLD Name : "앙고로쉬 주술사", Name AC enUS : "Ango'rosh Shaman" ; Wowhead enUS : "Ango'rosh Shaman"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18118;
-- AC datas : OLD Name : "앙고로쉬 투사", Name AC enUS : "Ango'rosh Brute" ; Wowhead enUS : "Ango'rosh Brute"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18119;
-- AC datas : OLD Name : "앙고로쉬 싸움꾼", Name AC enUS : "Ango'rosh Mauler" ; Wowhead enUS : "Ango'rosh Mauler"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18120;
-- AC datas : OLD Name : "앙고로쉬 영혼착취자", Name AC enUS : "Ango'rosh Souleater" ; Wowhead enUS : "Ango'rosh Souleater"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 영혼착취자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18121;
-- AC datas : OLD Name : "넝마두건 노역꾼", Name AC enUS : "Dreghood Drudge" ; Wowhead enUS : "Dreghood Drudge"
UPDATE `creature_template_locale` SET `Name` = '넝마두건일족 노역꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18122;
-- AC datas : OLD Subname : "로서의 후예들", Subname AC enUS : "Sons of Lothar" ; Wowhead enUS : "Sons of Lothar"
UPDATE `creature_template_locale` SET `Title` = '로서의 후예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18166;
-- AC datas : OLD Name : "야생늪 토템", Name AC enUS : "Feralfen Totem" ; Wowhead enUS : "Feralfen Totem"
UPDATE `creature_template_locale` SET `Name` = '야생늪일족 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18186;
-- AC datas : OLD Name : "수렁피 파괴자", Name AC enUS : "Murkblood Putrifier" ; Wowhead enUS : "Murkblood Putrifier"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18202;
-- AC datas : OLD Name : "수렁피 약탈자", Name AC enUS : "Murkblood Raider" ; Wowhead enUS : "Murkblood Raider"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18203;
-- AC datas : OLD Name : "수렁피 일족 오르토르", Name AC enUS : "Ortor of Murkblood" ; Wowhead enUS : "Ortor of Murkblood"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족의 오르토르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18204;
-- AC datas : OLD Name : "거친황야 포로", Name AC enUS : "Wastewalker Captive" ; Wowhead enUS : "Wastewalker Captive"
UPDATE `creature_template_locale` SET `Name` = '거친황야일족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18206;
-- AC datas : OLD Name : "수렁피 청소부", Name AC enUS : "Murkblood Scavenger" ; Wowhead enUS : "Murkblood Scavenger"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18207;
-- AC datas : OLD Name : "수렁피 투사", Name AC enUS : "Murkblood Brute" ; Wowhead enUS : "Murkblood Brute"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18211;
-- AC datas : OLD Name : "흙지느러미 광포어", Name AC enUS : "Mudfin Frenzy" ; Wowhead enUS : "Mudfin Frenzy"
UPDATE `creature_template_locale` SET `Name` = '흙지느러미 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18212;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18233;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18234;
-- AC datas : OLD Name : "작은 비전 피조물", Name AC enUS : "Tiny Arcane Construct" ; Wowhead enUS : "Tiny Arcane Construct"
UPDATE `creature_template_locale` SET `Name` = '작은 비전 창조물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18237;
-- AC datas : OLD Name : "수렁피 침략자", Name AC enUS : "Murkblood Invader" ; Wowhead enUS : "Murkblood Invader"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 침략자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18238;
-- AC datas : OLD Name : "돌주먹 약탈자", Name AC enUS : "Boulderfist Invader" ; Wowhead enUS : "Boulderfist Invader"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18260;
-- AC datas : OLD Name : "피눈물 피난민", Name AC enUS : "Bleeding Hollow Refugee" ; Wowhead enUS : "Bleeding Hollow Refugee"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 피난민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18292;
-- AC datas : OLD Name : "피눈물 고아", Name AC enUS : "Bleeding Hollow Orphan" ; Wowhead enUS : "Bleeding Hollow Orphan"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 고아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18299;
-- AC datas : OLD Name : "무역연합 징집관", Name AC enUS : "Consortium Recruiter" ; Wowhead enUS : "Consortium Recruiter"
UPDATE `creature_template_locale` SET `Name` = '무역연합 징집병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18335;
-- AC datas : OLD Name : "경매인 파닌", Name AC enUS : "Fanin" ; Wowhead enUS : "Fanin",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '파닌', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18348;
-- AC datas : OLD Name : "경매인 이레사", Name AC enUS : "Iressa" ; Wowhead enUS : "Iressa",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '이레사', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18349;
-- AC datas : OLD Name : "돌주먹 사냥꾼", Name AC enUS : "Boulderfist Hunter" ; Wowhead enUS : "Boulderfist Hunter"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18352;
-- AC datas : OLD Name : "공허소환사", Name AC enUS : "Voidcaller" ; Wowhead enUS : "Voidcaller"
UPDATE `creature_template_locale` SET `Name` = '공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18368;
-- AC datas : OLD Name : "돌주먹 파괴자", Name AC enUS : "Boulderfist Saboteur" ; Wowhead enUS : "Boulderfist Saboteur"
UPDATE `creature_template_locale` SET `Name` = '돌주먹일족 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18396;
-- AC datas : OLD Name : "수렁피 쌍둥이", Name AC enUS : "Murkblood Twin" ; Wowhead enUS : "Murkblood Twin"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 쌍둥이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18399;
-- AC datas : OLD Name : "전쟁망치 용사", Name AC enUS : "Warmaul Champion" ; Wowhead enUS : "Warmaul Champion"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18402;
-- AC datas : OLD Name : "회오리바람", Name AC enUS : "Cyclone (The Crone)" ; Wowhead enUS : "Cyclone (The Crone)"
UPDATE `creature_template_locale` SET `Name` = '소용돌이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18412;
-- AC datas : OLD Name : "전쟁망치 주방장 버펄로", Name AC enUS : "Warmaul Chef Bufferlo" ; Wowhead enUS : "Warmaul Chef Bufferlo"
UPDATE `creature_template_locale` SET `Name` = '전쟁망치일족 주방장 버펄로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18440;
-- AC datas : OLD Name : "길 잃은 망령", Name AC enUS : "Lost Spirit" ; Wowhead enUS : "Lost Spirit"
UPDATE `creature_template_locale` SET `Name` = '길잃은 망령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18460;
-- AC datas : OLD Name : "안개비늘 폭식바실리스크", Name AC enUS : "Dampscale Devourer" ; Wowhead enUS : "Dampscale Devourer"
UPDATE `creature_template_locale` SET `Name` = '걸신들린 안개비늘 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18463;
-- AC datas : OLD Name : "나이트 엘프 고대 수호정령", Name AC enUS : "Night Elf Ancient Protector" ; Wowhead enUS : "Night Elf Ancient Protector"
UPDATE `creature_template_locale` SET `Name` = '나이트 엘프 고대 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18487;
-- AC datas : OLD Name : "아키나이 수도사", Name AC enUS : "Auchenai Monk" ; Wowhead enUS : "Auchenai Monk"
UPDATE `creature_template_locale` SET `Name` = '아키나이 수도승', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18497;
-- AC datas : OLD Name : "분노하는 영혼", Name AC enUS : "Raging Soul" ; Wowhead enUS : "Raging Soul"
UPDATE `creature_template_locale` SET `Name` = '분노한 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18506;
-- AC datas : OLD Name : "빛의 감시자 아드옌", Name AC enUS : "Adyen the Lightwarden" ; Wowhead enUS : "Adyen the Lightwarden"
UPDATE `creature_template_locale` SET `Name` = '빛의 수호자 아드옌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18537;
-- AC datas : OLD Name : "알라르의 재", Name AC enUS : "Ashes of Al'ar" ; Wowhead enUS : "Ashes of Al'ar"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 불사조 미리보기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18545;
-- AC datas : OLD Name : "수렁피 야생 엘레크", Name AC enUS : "Wild Elekk Murkblood Mount" ; Wowhead enUS : "Wild Elekk Murkblood Mount"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 야생 엘레크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18546;
-- AC datas : OLD Name : "타렌 제분소 인부", Name AC enUS : "Tarren Mill Peasant" ; Wowhead enUS : "Tarren Mill Peasant"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18644;
-- AC datas : OLD Name : "타렌 제분소 인부", Name AC enUS : "Tarren Mill Peasant (With Sack)" ; Wowhead enUS : "Tarren Mill Peasant (With Sack)"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18645;
-- AC datas : OLD Name : "타렌 제분소 마부", Name AC enUS : "Tarren Mill Horsehand" ; Wowhead enUS : "Tarren Mill Horsehand"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 마부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18646;
-- AC datas : OLD Name : "타렌 제분소 말", Name AC enUS : "Tarren Mill Horse" ; Wowhead enUS : "Tarren Mill Horse"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 말', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18650;
-- AC datas : OLD Name : "타렌 제분소 낚시꾼", Name AC enUS : "Tarren Mill Fisherman" ; Wowhead enUS : "Tarren Mill Fisherman"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 낚시꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18657;
-- AC datas : OLD Name : "공포수호병", Name AC enUS : "Terrorguard" ; Wowhead enUS : "Terrorguard"
UPDATE `creature_template_locale` SET `Name` = '공포의 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18661;
-- AC datas : OLD Name : "어둠의 소용돌이", Name AC enUS : "Dark Vortex" ; Wowhead enUS : "Dark Vortex"
UPDATE `creature_template_locale` SET `Name` = '암흑의 소용돌이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18701;
-- AC datas : OLD Name : "분노하는 영혼", Name AC enUS : "Flying Raging Soul" ; Wowhead enUS : "Flying Raging Soul"
UPDATE `creature_template_locale` SET `Name` = '분노한 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18726;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Master Mining Trainer" ; Wowhead enUS : "Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18747;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Master Herbalism Trainer" ; Wowhead enUS : "Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18748;
-- AC datas : OLD Name : "달리나", Name AC enUS : "Dalinna" ; Wowhead enUS : "Dalinna",  OLD Subname : "전문 재봉사", Subname AC enUS : "Master Tailoring Trainer" ; Wowhead enUS : "Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Name` = '달린나', `Title` = '재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18749;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18751;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18752;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18753;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18754;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Master Skinning Trainer" ; Wowhead enUS : "Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18755;
-- AC datas : OLD Name : "경매인 다리즈", Name AC enUS : "Darise" ; Wowhead enUS : "Darise",  OLD Subname : "", Subname AC enUS : "Auctioneer" ; Wowhead enUS : "Auctioneer"
UPDATE `creature_template_locale` SET `Name` = '다리즈', `Title` = '경매인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18761;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18771;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Master Tailoring Trainer" ; Wowhead enUS : "Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18772;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18773;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18774;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18775;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Master Herbalism Trainer" ; Wowhead enUS : "Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18776;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Master Skinning Trainer" ; Wowhead enUS : "Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18777;
-- AC datas : OLD Name : "분노하는 영혼", Name AC enUS : "Cosmetic Raging Soul" ; Wowhead enUS : "Cosmetic Raging Soul"
UPDATE `creature_template_locale` SET `Name` = '분노한 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18778;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Master Mining Trainer" ; Wowhead enUS : "Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18779;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18802;
-- AC datas : OLD Name : "너울소나무 대사 프라사부", Name AC enUS : "Stillpine Ambassador Frasaboo" ; Wowhead enUS : "Stillpine Ambassador Olorg",  OLD Subname : "너울소나무 일족 사절", Subname AC enUS : "Envoy of the Stillpine" ; Wowhead enUS : "Envoy of the Stillpine"
UPDATE `creature_template_locale` SET `Name` = '너울소나무일족 대사 올로그', `Title` = '너울소나무일족 사절', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18803;
-- AC datas : OLD Name : "공허군주", Name AC enUS : "Voidlord" ; Wowhead enUS : "Voidlord"
UPDATE `creature_template_locale` SET `Name` = '공허의 군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18871;
-- AC datas : OLD Name : "지옥수호병 투사", Name AC enUS : "Felguard Brute" ; Wowhead enUS : "Felguard Brute"
UPDATE `creature_template_locale` SET `Name` = '지옥군단병 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18894;
-- AC datas : OLD Subname : "전문 낚시꾼", Subname AC enUS : "Master Fishing Trainer" ; Wowhead enUS : "Master Fishing Trainer"
UPDATE `creature_template_locale` SET `Title` = '낚시의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18911;
-- AC datas : OLD Name : "해골이빨 청소부", Name AC enUS : "Bonechewer Scavenger" ; Wowhead enUS : "Bonechewer Scavenger"
UPDATE `creature_template_locale` SET `Name` = '해골이빨부족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18952;
-- AC datas : OLD Name : "검은창 도끼투척병", Name AC enUS : "Darkspear Axe Thrower" ; Wowhead enUS : "Darkspear Axe Thrower"
UPDATE `creature_template_locale` SET `Name` = '검은창부족 도끼투척병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18970;
-- AC datas : OLD Name : "격노수호병", Name AC enUS : "Wrathguard" ; Wowhead enUS : "Wrathguard"
UPDATE `creature_template_locale` SET `Name` = '격노의 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18975;
-- AC datas : OLD Name : "파괴의 지옥수호병", Name AC enUS : "Felguard Destroyer" ; Wowhead enUS : "Felguard Destroyer"
UPDATE `creature_template_locale` SET `Name` = '파괴의 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18977;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Chef" ; Wowhead enUS : "Chef"
UPDATE `creature_template_locale` SET `Title` = '음식 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18987;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Chef" ; Wowhead enUS : "Chef"
UPDATE `creature_template_locale` SET `Title` = '음식 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18988;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Medic" ; Wowhead enUS : "Medic"
UPDATE `creature_template_locale` SET `Title` = '의무병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18990;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Medic" ; Wowhead enUS : "Medic"
UPDATE `creature_template_locale` SET `Title` = '의무병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18991;
-- AC datas : OLD Subname : "전문 요리사 및 요리 용품 상인", Subname AC enUS : "Cooking Supplies" ; Wowhead enUS : "Cooking Supplies"
UPDATE `creature_template_locale` SET `Title` = '요리 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18993;
-- AC datas : OLD Name : "무한의 제압자", Name AC enUS : "Infinite Vanquisher" ; Wowhead enUS : "Infinite Vanquisher"
UPDATE `creature_template_locale` SET `Name` = '무한의 정복자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18995;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19052;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19063;
-- AC datas : OLD Name : "수도자 수행원", Name AC enUS : "Anchorite Attendant" ; Wowhead enUS : "Anchorite Attendant"
UPDATE `creature_template_locale` SET `Name` = '수도사 수행원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19138;
-- AC datas : OLD Name : "알도르 수도자", Name AC enUS : "Aldor Anchorite" ; Wowhead enUS : "Aldor Anchorite"
UPDATE `creature_template_locale` SET `Name` = '알도르 수도사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19142;
-- AC datas : OLD Subname : "", Subname AC enUS : "Horse Pet Trainer" ; Wowhead enUS : "Horse Pet Trainer"
UPDATE `creature_template_locale` SET `Title` = '말 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19145;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Master Skinning Trainer" ; Wowhead enUS : "Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19180;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19185;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19187;
-- AC datas : OLD Name : "대수도자 알모넨", Name AC enUS : "Grand Anchorite Almonen" ; Wowhead enUS : "Grand Anchorite Almonen"
UPDATE `creature_template_locale` SET `Name` = '대수도사 알모넨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19216;
-- AC datas : OLD Name : "마그마 분출 토템", Name AC enUS : "Magma Flow Totem" ; Wowhead enUS : "Magma Flow Totem"
UPDATE `creature_template_locale` SET `Name` = '용암 분출 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19222;
-- AC datas : OLD Name : "나는 공허방랑자", Name AC enUS : "Flying Voidwalker" ; Wowhead enUS : "Flying Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '나는 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19233;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19252;
-- AC datas : OLD Name : "지옥불정령 전쟁인도자", Name AC enUS : "Infernal Warbringer" ; Wowhead enUS : "Infernal Warbringer"
UPDATE `creature_template_locale` SET `Name` = '지옥불정령 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19261;
-- AC datas : OLD Name : "웃는 해골 광전사", Name AC enUS : "Laughing Skull Berserker" ; Wowhead enUS : "Laughing Skull Berserker"
UPDATE `creature_template_locale` SET `Name` = '웃는 해골부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19267;
-- AC datas : OLD Name : "피눈물 장로", Name AC enUS : "Bleeding Hollow Vizier" ; Wowhead enUS : "Bleeding Hollow Vizier"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 장로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19268;
-- AC datas : OLD Name : "들이닥친 공허방랑자", Name AC enUS : "Invading Voidwalker" ; Wowhead enUS : "Invading Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '들이닥친 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19287;
-- AC datas : OLD Name : "방랑자", Name AC enUS : "Vagabond" ; Wowhead enUS : "Vagabond"
UPDATE `creature_template_locale` SET `Name` = '무숙자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19289;
-- AC datas : OLD Name : "전쟁인도자 아릭스아말", Name AC enUS : "Warbringer Arix'Amal" ; Wowhead enUS : "Warbringer Arix'Amal"
UPDATE `creature_template_locale` SET `Name` = '전쟁의 인도자 아릭스아말', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19298;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19341;
-- AC datas : OLD Subname : "총기류 상인", Subname AC enUS : "Guns & Ammunition" ; Wowhead enUS : "Guns & Ammunition"
UPDATE `creature_template_locale` SET `Title` = '총기류 및 탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19351;
-- AC datas : OLD Name : "어둠달 일꾼", Name AC enUS : "Shadowmoon Peon" ; Wowhead enUS : "Shadowmoon Peon"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19355;
-- AC datas : OLD Name : "코르크론 수호병", Name AC enUS : "Kor'kron Defender" ; Wowhead enUS : "Kor'kron Defender"
UPDATE `creature_template_locale` SET `Name` = '코르크론 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19362;
-- AC datas : OLD Name : "하사관 달톤", Name AC enUS : "Sergeant Dalton" ; Wowhead enUS : "Sergeant Dalton"
UPDATE `creature_template_locale` SET `Name` = '하사관 돌턴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19363;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cook" ; Wowhead enUS : "Cook"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19369;
-- AC datas : OLD Name : "수도자 닌두멘", Name AC enUS : "Anchorite Nindumen" ; Wowhead enUS : "Anchorite Nindumen"
UPDATE `creature_template_locale` SET `Name` = '수도사 닌두멘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19378;
-- AC datas : OLD Subname : "쿠르드란 와일드해머의 그리핀", Subname AC enUS : "Gryphon of Kurdran Wildhammer" ; Wowhead enUS : "Gryphon of Kurdran Wildhammer"
UPDATE `creature_template_locale` SET `Title` = '쿠르트란 와일드해머의 그리핀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19379;
-- AC datas : OLD Name : "지옥수호병 부관", Name AC enUS : "Felguard Lieutenant" ; Wowhead enUS : "Felguard Lieutenant"
UPDATE `creature_template_locale` SET `Name` = '지옥군단 부관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19391;
-- AC datas : OLD Name : "피눈물 강령사", Name AC enUS : "Bleeding Hollow Necrolyte" ; Wowhead enUS : "Bleeding Hollow Necrolyte"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 강령사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19422;
-- AC datas : OLD Name : "피눈물 검은늑대", Name AC enUS : "Bleeding Hollow Worg" ; Wowhead enUS : "Bleeding Hollow Worg"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19423;
-- AC datas : OLD Name : "피눈물 심문관", Name AC enUS : "Bleeding Hollow Tormentor" ; Wowhead enUS : "Bleeding Hollow Tormentor"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 심문관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19424;
-- AC datas : OLD Name : "공허소환사", Name AC enUS : "Voidwalker Summoner" ; Wowhead enUS : "Voidwalker Summoner"
UPDATE `creature_template_locale` SET `Name` = '공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19427;
-- AC datas : OLD Name : "어둠의 사제 말로드", Name AC enUS : "Dark Cleric Malod" ; Wowhead enUS : "Dark Cleric Malod"
UPDATE `creature_template_locale` SET `Name` = '암흑 성직자 말로드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19435;
-- AC datas : OLD Name : "피눈물 해골", Name AC enUS : "Bleeding Hollow Skeleton" ; Wowhead enUS : "Bleeding Hollow Skeleton"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 해골', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19460;
-- AC datas : OLD Name : "피눈물 영혼", Name AC enUS : "Bleeding Hollow Soul" ; Wowhead enUS : "Bleeding Hollow Soul"
UPDATE `creature_template_locale` SET `Name` = '피투성이굴부족 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19464;
-- AC datas : OLD Name : "수도자 카르자", Name AC enUS : "Anchorite Karja" ; Wowhead enUS : "Anchorite Karja"
UPDATE `creature_template_locale` SET `Name` = '수도사 카르자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19467;
-- AC datas : OLD Subname : "투척용 무기 상인", Subname AC enUS : "Throwing Weapons & Ammunition" ; Wowhead enUS : "Throwing Weapons & Ammunition"
UPDATE `creature_template_locale` SET `Title` = '투척용 무기 및 탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19473;
-- AC datas : OLD Name : "도망 중인 넝마두건 전사", Name AC enUS : "Fleeing Dreghood Warrior" ; Wowhead enUS : "Fleeing Dreghood Warrior"
UPDATE `creature_template_locale` SET `Name` = '도망 중인 넝마두건일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19477;
-- AC datas : OLD Subname : "야수 관리인", Subname AC enUS : "Horse Riding Trainer" ; Wowhead enUS : "Horse Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '비행 탈것 전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19491;
-- AC datas : OLD Subname : "야수 관리인", Subname AC enUS : "Horse Riding Trainer" ; Wowhead enUS : "Horse Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '비행 탈것 전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19492;
-- AC datas : OLD Name : "태양추적대 약초채집가", Name AC enUS : "Sunseeker Herbalist" ; Wowhead enUS : "Sunseeker Herbalist"
UPDATE `creature_template_locale` SET `Name` = '태양추적대 약초채집사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19508;
-- AC datas : OLD Name : "동요하는 공허소환사", Name AC enUS : "Vacillating Voidcaller" ; Wowhead enUS : "Vacillating Voidcaller"
UPDATE `creature_template_locale` SET `Name` = '동요하는 공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19527;
-- AC datas : OLD Name : "폭풍 첨탑 연합경비병", Name AC enUS : "Stormspire Nexus-Guard" ; Wowhead enUS : "Stormspire Nexus-Guard"
UPDATE `creature_template_locale` SET `Name` = '폭풍첨탑 연합경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19529;
-- AC datas : OLD Subname : "보석 및 보석세공용품 상인", Subname AC enUS : "Gems & Jewelcrafting Supplies" ; Wowhead enUS : "Gems & Jewelcrafting Supplies"
UPDATE `creature_template_locale` SET `Title` = '보석 및 보석세공 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19538;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19539;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19540;
-- AC datas : OLD Name : "야전사령관 마푼", Name AC enUS : "Field Commander Mahfuun" ; Wowhead enUS : "Field Commander Mahfuun"
UPDATE `creature_template_locale` SET `Name` = '야전사령관 마수드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19542;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19576;
-- AC datas : OLD Name : "방사능에 노출된 관리자", Name AC enUS : "Irradiated Manager" ; Wowhead enUS : "Irradiated Manager"
UPDATE `creature_template_locale` SET `Name` = '방사능에 노출된 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19612;
-- AC datas : OLD Name : "길들인 피눈물 검은늑대", Name AC enUS : "Bleeding Hollow Riding Worg" ; Wowhead enUS : "Bleeding Hollow Riding Worg"
UPDATE `creature_template_locale` SET `Name` = '길들인 피투성이굴부족 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19640;
-- AC datas : OLD Name : "거대한 정예 엘레크", Name AC enUS : "Great Elite Elekk" ; Wowhead enUS : "Great Elite Elekk"
UPDATE `creature_template_locale` SET `Name` = '거대한 엘레크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19659;
-- AC datas : OLD Name : "클라리사", Name AC enUS : "Clarissa" ; Wowhead enUS : "Clarissa"
UPDATE `creature_template_locale` SET `Name` = '클래리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19693;
-- AC datas : OLD Name : "농부 (나무) 1.50", Name AC enUS : "Peasant (Wood) 1.50" ; Wowhead enUS : "Peasant (Wood) 1.50"
UPDATE `creature_template_locale` SET `Name` = '인부 (나무) 1.51', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19695;
-- AC datas : OLD Name : "무쇠돌기 큰눈트레샬리스크", Name AC enUS : "Ironspine Gazer" ; Wowhead enUS : "Ironspine Gazer"
UPDATE `creature_template_locale` SET `Name` = '큰눈 무쇠돌기 트레샬리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19730;
-- AC datas : OLD Name : "앙고로쉬 흑마법사", Name AC enUS : "Ango'rosh Warlock" ; Wowhead enUS : "Ango'rosh Warlock"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19732;
-- AC datas : OLD Name : "비수늪 하수인", Name AC enUS : "Daggerfen Servant" ; Wowhead enUS : "Daggerfen Servant"
UPDATE `creature_template_locale` SET `Name` = '비수늪일족 하수인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19733;
-- AC datas : OLD Name : "어둠달 유령", Name AC enUS : "Shadowmoon Specter" ; Wowhead enUS : "Shadowmoon Specter"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19749;
-- AC datas : OLD Name : "복수심에 불타는 어둠달 망령", Name AC enUS : "Vengeful Shadowmoon Wraith" ; Wowhead enUS : "Vengeful Shadowmoon Wraith"
UPDATE `creature_template_locale` SET `Name` = '복수심에 불타는 어둠달부족 망령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19751;
-- AC datas : OLD Name : "덩치 큰 차원날개용", Name AC enUS : "Greater Snap Dragon" ; Wowhead enUS : "Greater Snap Dragon"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 차원날개용', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19771;
-- AC datas : OLD Name : "별의 섬광", Name AC enUS : "Astral Flare" ; Wowhead enUS : "Astral Flare"
UPDATE `creature_template_locale` SET `Name` = '별의 광채', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19781;
-- AC datas : OLD Name : "별의 섬광", Name AC enUS : "Astral Flare" ; Wowhead enUS : "Astral Flare"
UPDATE `creature_template_locale` SET `Name` = '별의 광채', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19782;
-- AC datas : OLD Name : "별의 섬광", Name AC enUS : "Astral Flare" ; Wowhead enUS : "Astral Flare"
UPDATE `creature_template_locale` SET `Name` = '별의 광채', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19783;
-- AC datas : OLD Name : "회색심장 길잡이", Name AC enUS : "Greyheart Wayfinder" ; Wowhead enUS : "Greyheart Wayfinder"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 길잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19807;
-- AC datas : OLD Name : "회색심장 오크학살자", Name AC enUS : "Greyheart Orc-Slayer" ; Wowhead enUS : "Greyheart Orc-Slayer"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 오크학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19808;
-- AC datas : OLD Name : "회색심장 주술사", Name AC enUS : "Greyheart Shaman" ; Wowhead enUS : "Greyheart Shaman"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19809;
-- AC datas : OLD Name : "회색심장 황천의 현자", Name AC enUS : "Greyheart Nether-sage" ; Wowhead enUS : "Greyheart Nether-sage"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 황천의 현자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19810;
-- AC datas : OLD Name : "회색심장 지휘관", Name AC enUS : "Greyheart Battle-Master" ; Wowhead enUS : "Greyheart Battle-Master"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 지휘관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19811;
-- AC datas : OLD Name : "암흑갈기 노예사냥꾼", Name AC enUS : "Darkcrest Slaver" ; Wowhead enUS : "Darkcrest Slaver"
UPDATE `creature_template_locale` SET `Name` = '암흑갈기일족 노예사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19946;
-- AC datas : OLD Name : "암흑갈기 여마술사", Name AC enUS : "Darkcrest Sorceress" ; Wowhead enUS : "Darkcrest Sorceress"
UPDATE `creature_template_locale` SET `Name` = '암흑갈기일족 여마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19947;
-- AC datas : OLD Name : "피망치 척후병", Name AC enUS : "Bloodmaul Skirmisher" ; Wowhead enUS : "Bloodmaul Skirmisher"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19948;
-- AC datas : OLD Name : "피망치 흙점쟁이", Name AC enUS : "Bloodmaul Geomancer" ; Wowhead enUS : "Bloodmaul Geomancer"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19952;
-- AC datas : OLD Name : "피망치 망꾼", Name AC enUS : "Bloodmaul Lookout" ; Wowhead enUS : "Bloodmaul Lookout"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 망꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19956;
-- AC datas : OLD Name : "피망치 양조사", Name AC enUS : "Bloodmaul Brewmaster" ; Wowhead enUS : "Bloodmaul Brewmaster"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 양조사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19957;
-- AC datas : OLD Name : "백색 덩굴손", Name AC enUS : "White Seedling" ; Wowhead enUS : "White Seedling"
UPDATE `creature_template_locale` SET `Name` = '흰색 덩굴손', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19958;
-- AC datas : OLD Name : "청색 덩굴손", Name AC enUS : "Blue Seedling" ; Wowhead enUS : "Blue Seedling"
UPDATE `creature_template_locale` SET `Name` = '푸른 덩굴손', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19962;
-- AC datas : OLD Name : "적색 덩굴손", Name AC enUS : "Red Seedling" ; Wowhead enUS : "Red Seedling"
UPDATE `creature_template_locale` SET `Name` = '붉은 덩굴손', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19964;
-- AC datas : OLD Name : "피망치 투사", Name AC enUS : "Bloodmaul Brute" ; Wowhead enUS : "Bloodmaul Brute"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19991;
-- AC datas : OLD Name : "피망치 주술사", Name AC enUS : "Bloodmaul Shaman" ; Wowhead enUS : "Bloodmaul Shaman"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19992;
-- AC datas : OLD Name : "피망치 싸움꾼", Name AC enUS : "Bloodmaul Mauler" ; Wowhead enUS : "Bloodmaul Mauler"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 싸움꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19993;
-- AC datas : OLD Name : "피망치 흑마법사", Name AC enUS : "Bloodmaul Warlock" ; Wowhead enUS : "Bloodmaul Warlock"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 흑마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19994;
-- AC datas : OLD Name : "칼날첨탑 투사", Name AC enUS : "Bladespire Brute" ; Wowhead enUS : "Bladespire Brute"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19995;
-- AC datas : OLD Name : "칼날첨탑 전투마법사", Name AC enUS : "Bladespire Battlemage" ; Wowhead enUS : "Bladespire Battlemage"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 전투마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19996;
-- AC datas : OLD Name : "칼날첨탑 집행자", Name AC enUS : "Bladespire Enforcer" ; Wowhead enUS : "Bladespire Enforcer"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19997;
-- AC datas : OLD Name : "칼날첨탑 주술사", Name AC enUS : "Bladespire Shaman" ; Wowhead enUS : "Bladespire Shaman"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19998;
-- AC datas : OLD Name : "칸레타드", Name AC enUS : "Alexander!" ; Wowhead enUS : "Alexander!"
UPDATE `creature_template_locale` SET `Name` = '칸레사드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20000;
-- AC datas : OLD Name : "타렌 제분소 인부", Name AC enUS : "Tarren Mill Peasant Specimen" ; Wowhead enUS : "Tarren Mill Peasant Specimen"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 인부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20055;
-- AC datas : OLD Name : "광포한 피망치 늑대", Name AC enUS : "Bloodmaul Dire Wolf" ; Wowhead enUS : "Bloodmaul Dire Wolf"
UPDATE `creature_template_locale` SET `Name` = '광포한 피망치일족 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20058;
-- AC datas : OLD Name : "암흑갈기 파수꾼", Name AC enUS : "Darkcrest Sentry" ; Wowhead enUS : "Darkcrest Sentry"
UPDATE `creature_template_locale` SET `Name` = '암흑갈기일족 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20079;
-- AC datas : OLD Name : "피비늘 감독관", Name AC enUS : "Bloodscale Overseer" ; Wowhead enUS : "Bloodscale Overseer"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20088;
-- AC datas : OLD Name : "피비늘 파도술사", Name AC enUS : "Bloodscale Wavecaller" ; Wowhead enUS : "Bloodscale Wavecaller"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 파도술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20089;
-- AC datas : OLD Name : "피비늘 파수꾼", Name AC enUS : "Bloodscale Sentry" ; Wowhead enUS : "Bloodscale Sentry"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20090;
-- AC datas : OLD Name : "피비늘 미르미돈", Name AC enUS : "Bloodscale Myrmidon" ; Wowhead enUS : "Bloodscale Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20091;
-- AC datas : OLD Name : "그늘늪 의술사", Name AC enUS : "Umbrafen Witchdoctor" ; Wowhead enUS : "Umbrafen Witchdoctor"
UPDATE `creature_template_locale` SET `Name` = '그늘늪일족 의술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20115;
-- AC datas : OLD Name : "피비늘 바다 마녀", Name AC enUS : "Bloodscale Sea Witch" ; Wowhead enUS : "Bloodscale Sea Witch"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 바다마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20122;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmith Trainer" ; Wowhead enUS : "Weaponsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20124;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmith Trainer" ; Wowhead enUS : "Armorsmith Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20125;
-- AC datas : OLD Name : "불안정한 공허방랑자", Name AC enUS : "Unstable Voidwalker" ; Wowhead enUS : "Unstable Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '불안정한 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20145;
-- AC datas : OLD Name : "도망 중인 넝마두건 흙점쟁이", Name AC enUS : "Fleeing Dreghood Geomancer" ; Wowhead enUS : "Fleeing Dreghood Geomancer"
UPDATE `creature_template_locale` SET `Name` = '도망 중인 넝마두건일족 흙점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20157;
-- AC datas : OLD Name : "수습생 비셸", Name AC enUS : "Apprentice Vishael" ; Wowhead enUS : "Apprentice Vishael"
UPDATE `creature_template_locale` SET `Name` = '수습생 비쉘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20233;
-- AC datas : OLD Name : "키티군", Name AC enUS : "Mr. Kitty" ; Wowhead enUS : "Mr. Kitty"
UPDATE `creature_template_locale` SET `Name` = '미스터 키티', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20245;
-- AC datas : OLD Name : "야생늪 드루이드", Name AC enUS : "Feralfen Druid" ; Wowhead enUS : "Feralfen Druid"
UPDATE `creature_template_locale` SET `Name` = '야생늪일족 드루이드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20270;
-- AC datas : OLD Subname : "옛날 투기장 방어구 상인", Subname AC enUS : "Brutal Arena Vendor" ; Wowhead enUS : "Brutal Arena Vendor"
UPDATE `creature_template_locale` SET `Title` = '냉혹한 투기장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20278;
-- AC datas : OLD Name : "노바 테라", Name AC enUS : "Nova Terra" ; Wowhead enUS : "Nova Terra"
UPDATE `creature_template_locale` SET `Name` = '회오리치는 대지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20297;
-- AC datas : OLD Name : "피망치 전투늑대", Name AC enUS : "Bloodmaul Battle Worg" ; Wowhead enUS : "Bloodmaul Battle Worg"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 전투늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20330;
-- AC datas : OLD Name : "칼날첨탑 요리사", Name AC enUS : "Bladespire Cook" ; Wowhead enUS : "Bladespire Cook"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20334;
-- AC datas : OLD Name : "선장 샌더스", Name AC enUS : "Captain Sanders" ; Wowhead enUS : "Captain Sanders"
UPDATE `creature_template_locale` SET `Name` = '선장 샌더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20351;
-- AC datas : OLD Name : "대런 말뷰", Name AC enUS : "Darren Malvew OH" ; Wowhead enUS : "Darren Malvew OH"
UPDATE `creature_template_locale` SET `Name` = '다렌 말뷰', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20366;
-- AC datas : OLD Name : "언덕마루 소작농", Name AC enUS : "Hillsbrad Peasant" ; Wowhead enUS : "Hillsbrad Peasant"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 소작농', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20424;
-- AC datas : OLD Name : "언덕마루 주민", Name AC enUS : "Hillsbrad Citizen" ; Wowhead enUS : "Hillsbrad Citizen"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20426;
-- AC datas : OLD Name : "언덕마루 주민", Name AC enUS : "Hillsbrad Citizen" ; Wowhead enUS : "Hillsbrad Citizen"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20428;
-- AC datas : OLD Name : "언덕마루 주민", Name AC enUS : "Hillsbrad Citizen" ; Wowhead enUS : "Hillsbrad Citizen"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20429;
-- AC datas : OLD Name : "언덕마루 주민", Name AC enUS : "Hillsbrad Citizen" ; Wowhead enUS : "Hillsbrad Citizen"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20430;
-- AC datas : OLD Name : "언덕마루 농부", Name AC enUS : "Hillsbrad Farmer" ; Wowhead enUS : "Hillsbrad Farmer"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 농부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20433;
-- AC datas : OLD Name : "앙고로쉬 보초", Name AC enUS : "Ango'rosh Sentry" ; Wowhead enUS : "Ango'rosh Sentry"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20443;
-- AC datas : OLD Name : "앙고로쉬 어둠마법사", Name AC enUS : "Ango'rosh Shadowmage" ; Wowhead enUS : "Ango'rosh Shadowmage"
UPDATE `creature_template_locale` SET `Name` = '앙고로쉬일족 어둠마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20444;
-- AC datas : OLD Name : "영혼분리자 말드루크", Name AC enUS : "Mal'druk the Soulrender" ; Wowhead enUS : "Mal'druk the Soulrender"
UPDATE `creature_template_locale` SET `Name` = '영혼의 분리자 말드루크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20445;
-- AC datas : OLD Name : "지하수렁 광포어", Name AC enUS : "Underbog Frenzy" ; Wowhead enUS : "Underbog Frenzy"
UPDATE `creature_template_locale` SET `Name` = '지하수렁 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20465;
-- AC datas : OLD Name : "사나운 불길", Name AC enUS : "Raging Flames" ; Wowhead enUS : "Raging Flames"
UPDATE `creature_template_locale` SET `Name` = '타오르는 불길', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20481;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20500;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20511;
-- AC datas : OLD Name : "초강력 폭탄로봇", Name AC enUS : "Boom Bot Xtreme" ; Wowhead enUS : "Boom Bot Xtreme"
UPDATE `creature_template_locale` SET `Name` = '초강력 폭탄 로봇', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20519;
-- AC datas : OLD Name : "바위가죽바실리스크", Name AC enUS : "Craghide Basilisk" ; Wowhead enUS : "Craghide Basilisk"
UPDATE `creature_template_locale` SET `Name` = '바위가죽 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20607;
-- AC datas : OLD Name : "아라가의 새끼", Name AC enUS : "Darkmaw Cub" ; Wowhead enUS : "Darkmaw Cub"
UPDATE `creature_template_locale` SET `Name` = '암흑아귀 스라소니 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20615;
-- AC datas : OLD Name : "포자바람 광포어", Name AC enUS : "Sporewind Frenzy" ; Wowhead enUS : "Sporewind Frenzy"
UPDATE `creature_template_locale` SET `Name` = '포자바람 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20667;
-- AC datas : OLD Name : "렉토르", Name AC enUS : "Outland Raptor, Black" ; Wowhead enUS : "Outland Raptor, Black"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 랩터, Black', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20716;
-- AC datas : OLD Name : "칼날첨탑 주방장", Name AC enUS : "Bladespire Chef" ; Wowhead enUS : "Bladespire Chef"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 주방장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20756;
-- AC datas : OLD Name : "칼날첨탑 장사", Name AC enUS : "Bladespire Crusher" ; Wowhead enUS : "Bladespire Crusher"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 장사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20765;
-- AC datas : OLD Name : "칼날첨탑 비술사", Name AC enUS : "Bladespire Mystic" ; Wowhead enUS : "Bladespire Mystic"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 비술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20766;
-- AC datas : OLD Name : "피비늘 정령", Name AC enUS : "Bloodscale Elemental" ; Wowhead enUS : "Bloodscale Elemental"
UPDATE `creature_template_locale` SET `Name` = '피비늘일족 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20792;
-- AC datas : OLD Name : "제련장인 모루그", Name AC enUS : "Forgemaster Morug" ; Wowhead enUS : "Forgemaster Morug"
UPDATE `creature_template_locale` SET `Name` = '괴철로감독관 모루그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20800;
-- AC datas : OLD Name : "영혼 포식자", Name AC enUS : "Soul Devourer" ; Wowhead enUS : "Soul Devourer"
UPDATE `creature_template_locale` SET `Name` = '영혼의 포식자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20866;
-- AC datas : OLD Name : "속박 풀린 제레케스", Name AC enUS : "Zereketh the Unbound" ; Wowhead enUS : "Zereketh the Unbound"
UPDATE `creature_template_locale` SET `Name` = '속박이 풀린 제레케스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20870;
-- AC datas : OLD Name : "속박 풀린 파멸자", Name AC enUS : "Unbound Devastator" ; Wowhead enUS : "Unbound Devastator"
UPDATE `creature_template_locale` SET `Name` = '해방된 파멸자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20881;
-- AC datas : OLD Name : "아키리스 번개술사", Name AC enUS : "Akkiris Lightning-Waker" ; Wowhead enUS : "Akkiris Lightning-Waker"
UPDATE `creature_template_locale` SET `Name` = '설퍼론 번개술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20908;
-- AC datas : OLD Subname : "암거래상", Subname AC enUS : "Shady Dealer" ; Wowhead enUS : "Shady Dealer"
UPDATE `creature_template_locale` SET `Title` = '독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20986;
-- AC datas : OLD Name : "어둠달 주민", Name AC enUS : "Shadowmoon Villager" ; Wowhead enUS : "Shadowmoon Villager"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 20995;
-- AC datas : OLD Name : "죽어라때려보라지 73 공격대 약화 효과 (방어도 높음)", Name AC enUS : "QA Test Dummy 73 Raid Debuff (High Armor)" ; Wowhead enUS : "QA Test Dummy 73 Raid Debuff (High Armor)"
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21003;
-- AC datas : OLD Name : "대지치유사 토르록", Name AC enUS : "Earthmender Torlok" ; Wowhead enUS : "Earthmender Torlok",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '대지의 치유사 토르록', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21024;
-- AC datas : OLD Name : "대지치유사 고르보토", Name AC enUS : "Earthmender Gorboto" ; Wowhead enUS : "Earthmender Gorboto",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '대지의 치유사 고르보토', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21026;
-- AC datas : OLD Name : "대지치유사 윌다", Name AC enUS : "Earthmender Wilda" ; Wowhead enUS : "Earthmender Wilda",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '대지의 치유사 윌다', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21027;
-- AC datas : OLD Name : "격노의 점술사의 돌진 표적", Name AC enUS : "Wrath-Scryer's Charge Target" ; Wowhead enUS : "Wrath-Scryer's Charge Target"
UPDATE `creature_template_locale` SET `Name` = '격노의 점술사의 돌진 목표', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21030;
-- AC datas : OLD Name : "볼더모크 투사", Name AC enUS : "Boulder'mok Brute" ; Wowhead enUS : "Boulder'mok Brute"
UPDATE `creature_template_locale` SET `Name` = '바울더모크일족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21046;
-- AC datas : OLD Name : "볼더모크 주술사", Name AC enUS : "Boulder'mok Shaman" ; Wowhead enUS : "Boulder'mok Shaman"
UPDATE `creature_template_locale` SET `Name` = '바울더모크일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21047;
-- AC datas : OLD Name : "볼더모크 족장", Name AC enUS : "Boulder'mok Chieftain" ; Wowhead enUS : "Boulder'mok Chieftain"
UPDATE `creature_template_locale` SET `Name` = '바울더모크일족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21048;
-- AC datas : OLD Name : "푸른색 용매 새끼", Name AC enUS : "Blue Dragonhawk Hatchling" ; Wowhead enUS : "Blue Dragonhawk Hatchling"
UPDATE `creature_template_locale` SET `Name` = '푸른 용매 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21056;
-- AC datas : OLD Name : "붉은색 용매 새끼", Name AC enUS : "Red Dragonhawk Hatchling" ; Wowhead enUS : "Red Dragonhawk Hatchling"
UPDATE `creature_template_locale` SET `Name` = '붉은 용매 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21064;
-- AC datas : OLD Name : "아웃랜드 격노수호병 Black", Name AC enUS : "Outland Wrathguard Black" ; Wowhead enUS : "Outland Wrathguard Black"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 격노의 수호병 Black', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21067;
-- AC datas : OLD Name : "아웃랜드 격노수호병 Green", Name AC enUS : "Outland Wrathguard Green" ; Wowhead enUS : "Outland Wrathguard Green"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 격노의 수호병 Green', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21068;
-- AC datas : OLD Name : "아웃랜드 격노수호병 Red", Name AC enUS : "Outland Wrathguard Red" ; Wowhead enUS : "Outland Wrathguard Red"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 격노의 수호병 Red', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21069;
-- AC datas : OLD Name : "아웃랜드 격노수호병 Pink", Name AC enUS : "Outland Wrathguard Pink" ; Wowhead enUS : "Outland Wrathguard Pink"
UPDATE `creature_template_locale` SET `Name` = '아웃랜드 격노의 수호병 Pink', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21070;
-- AC datas : OLD Name : "정령의 토템", Name AC enUS : "Totem of Spirits" ; Wowhead enUS : "Totem of Spirits"
UPDATE `creature_template_locale` SET `Name` = '정기의 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21071;
-- AC datas : OLD Name : "잠든 지옥불정령", Name AC enUS : "Dormant Infernal" ; Wowhead enUS : "Dormant Infernal"
UPDATE `creature_template_locale` SET `Name` = '잠들어 있는 지옥불정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21080;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21087;
-- AC datas : OLD Name : "속박 풀린 공허의 지대", Name AC enUS : "Unbound Void Zone" ; Wowhead enUS : "Unbound Void Zone"
UPDATE `creature_template_locale` SET `Name` = '속박이 풀린 공허의 지대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21101;
-- AC datas : OLD Name : "무한의 제압자", Name AC enUS : "Infinite Vanquisher" ; Wowhead enUS : "Infinite Vanquisher"
UPDATE `creature_template_locale` SET `Name` = '무한의 정복자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21139;
-- AC datas : OLD Name : "군단 시험용 대포 지옥수호병", Name AC enUS : "Legion Prototype Cannon 2 & 3 Felguard" ; Wowhead enUS : "Legion Prototype Cannon 2 & 3 Felguard"
UPDATE `creature_template_locale` SET `Name` = '군단 시험용 대포 지옥군단병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21146;
-- AC datas : OLD Subname : "일리다리 악마사냥꾼", Subname AC enUS : "Illidari Demon Hunter" ; Wowhead enUS : "Illidari Demon Hunter"
UPDATE `creature_template_locale` SET `Title` = '일리다리 악마 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21177;
-- AC datas : OLD Name : "새끼 칼날발톱", Name AC enUS : "Ravenous Hatchling" ; Wowhead enUS : "Ravenous Hatchling"
UPDATE `creature_template_locale` SET `Name` = '게걸스러운 갈퀴발톱 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21204;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21209;
-- AC datas : OLD Name : "심해군주 카라드레스", Name AC enUS : "Fathom-Lord Karathress" ; Wowhead enUS : "Fathom-Lord Karathress"
UPDATE `creature_template_locale` SET `Name` = '심연의 군주 카라드레스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21214;
-- AC datas : OLD Name : "겅둥파도 점쟁이", Name AC enUS : "Tidewalker Depth-Seer" ; Wowhead enUS : "Tidewalker Depth-Seer"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21224;
-- AC datas : OLD Name : "겅둥파도 전사", Name AC enUS : "Tidewalker Warrior" ; Wowhead enUS : "Tidewalker Warrior"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21225;
-- AC datas : OLD Name : "겅둥파도 주술사", Name AC enUS : "Tidewalker Shaman" ; Wowhead enUS : "Tidewalker Shaman"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21226;
-- AC datas : OLD Name : "겅둥파도 작살사수", Name AC enUS : "Tidewalker Harpooner" ; Wowhead enUS : "Tidewalker Harpooner"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 작살사수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21227;
-- AC datas : OLD Name : "겅둥파도 냉기술사", Name AC enUS : "Tidewalker Hydromancer" ; Wowhead enUS : "Tidewalker Hydromancer"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 냉기술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21228;
-- AC datas : OLD Name : "회색심장 파도술사", Name AC enUS : "Greyheart Tidecaller" ; Wowhead enUS : "Greyheart Tidecaller"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 파도술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21229;
-- AC datas : OLD Name : "회색심장 황천의 마법사", Name AC enUS : "Greyheart Nether-Mage" ; Wowhead enUS : "Greyheart Nether-Mage"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 황천의 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21230;
-- AC datas : OLD Name : "회색심장 방패수호병", Name AC enUS : "Greyheart Shield-Bearer" ; Wowhead enUS : "Greyheart Shield-Bearer"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 방패수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21231;
-- AC datas : OLD Name : "회색심장 암살자", Name AC enUS : "Greyheart Skulker" ; Wowhead enUS : "Greyheart Skulker"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21232;
-- AC datas : OLD Name : "피망치 노역꾼", Name AC enUS : "Bloodmaul Drudger" ; Wowhead enUS : "Bloodmaul Drudger"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 노역꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21238;
-- AC datas : OLD Name : "게걸스러운 새끼 칼날발톱", Name AC enUS : "Ravenous Ravager Hatchling" ; Wowhead enUS : "Ravenous Ravager Hatchling"
UPDATE `creature_template_locale` SET `Name` = '게걸스러운 갈퀴발톱 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21239;
-- AC datas : OLD Name : "회색심장 기술병", Name AC enUS : "Greyheart Technician" ; Wowhead enUS : "Greyheart Technician"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 기술병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21263;
-- AC datas : OLD Name : "새끼 칼날발톱", Name AC enUS : "Ravager Hatchling" ; Wowhead enUS : "Ravager Hatchling"
UPDATE `creature_template_locale` SET `Name` = '갈퀴발톱 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21266;
-- AC datas : OLD Name : "참상의 도끼", Name AC enUS : "Devastation" ; Wowhead enUS : "Devastation"
UPDATE `creature_template_locale` SET `Name` = '황폐의 도끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21269;
-- AC datas : OLD Name : "전쟁인도자 라주운", Name AC enUS : "Warbringer Razuun" ; Wowhead enUS : "Warbringer Razuun"
UPDATE `creature_template_locale` SET `Name` = '전쟁의 인도자 라주운', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21287;
-- AC datas : OLD Name : "피망치 집행자", Name AC enUS : "Bloodmaul Goon" ; Wowhead enUS : "Bloodmaul Goon"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21294;
-- AC datas : OLD Name : "칼날첨탑 용사", Name AC enUS : "Bladespire Champion" ; Wowhead enUS : "Bladespire Champion"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21296;
-- AC datas : OLD Name : "쿠르드란 와일드해머", Name AC enUS : "Kurdran Wildhammer" ; Wowhead enUS : "Kurdran Wildhammer"
UPDATE `creature_template_locale` SET `Name` = '쿠르트란 와일드해머', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21330;
-- AC datas : OLD Name : "덩치 큰 비단날개나방 애벌레", Name AC enUS : "Plump Silkwing Larva" ; Wowhead enUS : "Plump Silkwing Larva"
UPDATE `creature_template_locale` SET `Name` = '덩치큰 비단날개나방 애벌레', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21375;
-- AC datas : OLD Name : "수도자 케일라", Name AC enUS : "Anchorite Ceyla" ; Wowhead enUS : "Anchorite Ceyla"
UPDATE `creature_template_locale` SET `Name` = '수도사 케일라', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21402;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21483;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21488;
-- AC datas : OLD Name : "전쟁인도자 라주운의 환영", Name AC enUS : "Image of Warbringer Razuun" ; Wowhead enUS : "Image of Warbringer Razuun"
UPDATE `creature_template_locale` SET `Name` = '전쟁의 인도자 라주운의 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21502;
-- AC datas : OLD Name : "갈퀴송곳니 광포어", Name AC enUS : "Coilfang Frenzy" ; Wowhead enUS : "Coilfang Frenzy"
UPDATE `creature_template_locale` SET `Name` = '갈퀴송곳니 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21508;
-- AC datas : OLD Name : "숲타조", Name AC enUS : "Afrazi Forest Strider" ; Wowhead enUS : "Forest Strider"
UPDATE `creature_template_locale` SET `Name` = '아프라지 숲타조', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21635;
-- AC datas : OLD Name : "명가의 애가", Name AC enUS : "Lament of the Highborne Spell Bunny" ; Wowhead enUS : "Lament of the Highborne Spell Bunny"
UPDATE `creature_template_locale` SET `Name` = '귀족의 애가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21641;
-- AC datas : OLD Name : "갈퀴송곳니 광포어 시체", Name AC enUS : "Coilfang Frenzy Corpse" ; Wowhead enUS : "Coilfang Frenzy Corpse"
UPDATE `creature_template_locale` SET `Name` = '갈퀴송곳니 프렌지 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21689;
-- AC datas : OLD Name : "잿빛혓바닥 결사단원", Name AC enUS : "Ashtongue Deathsworn" ; Wowhead enUS : "Ashtongue Deathsworn"
UPDATE `creature_template_locale` SET `Name` = '잿빛혓바닥 맹신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21701;
-- AC datas : OLD Name : "용아귀 사냥꾼", Name AC enUS : "Dragonmaw Wrangler" ; Wowhead enUS : "Dragonmaw Wrangler"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21717;
-- AC datas : OLD Name : "용아귀 정복자", Name AC enUS : "Dragonmaw Subjugator" ; Wowhead enUS : "Dragonmaw Subjugator"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 정복자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21718;
-- AC datas : OLD Name : "용아귀 비룡기수", Name AC enUS : "Dragonmaw Drake-Rider" ; Wowhead enUS : "Dragonmaw Drake-Rider"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 비룡기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21719;
-- AC datas : OLD Name : "용아귀 주술사", Name AC enUS : "Dragonmaw Shaman" ; Wowhead enUS : "Dragonmaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21720;
-- AC datas : OLD Name : "어둠달 척후병", Name AC enUS : "Shadowmoon Scout" ; Wowhead enUS : "Shadowmoon Scout"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 척후병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21749;
-- AC datas : OLD Name : "어둠달 광신도", Name AC enUS : "Shadowmoon Zealot" ; Wowhead enUS : "Shadowmoon Zealot"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 광신도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21788;
-- AC datas : OLD Name : "어둠달 선구자", Name AC enUS : "Shadowmoon Harbinger" ; Wowhead enUS : "Shadowmoon Harbinger"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 선구자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21795;
-- AC datas : OLD Name : "고대 어둠달 영혼", Name AC enUS : "Ancient Shadowmoon Spirit" ; Wowhead enUS : "Ancient Shadowmoon Spirit"
UPDATE `creature_template_locale` SET `Name` = '고대 어둠달부족 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21797;
-- AC datas : OLD Name : "회색심장 역술사", Name AC enUS : "Greyheart Spellbinder" ; Wowhead enUS : "Greyheart Spellbinder"
UPDATE `creature_template_locale` SET `Name` = '회색심장일족 역술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21806;
-- AC datas : OLD Name : "무쇠돌기 강철이빨트레샬리스크", Name AC enUS : "Ironspine Chomper" ; Wowhead enUS : "Ironspine Chomper"
UPDATE `creature_template_locale` SET `Name` = '강철이빨 무쇠돌기 트레샬리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21816;
-- AC datas : OLD Name : "대규모 시포리움 폭약", Name AC enUS : "Massive Seaforium Charge" ; Wowhead enUS : "Massive Seaforium Charge"
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21848;
-- AC datas : OLD Name : "무쇠돌기 돌트레샬리스크", Name AC enUS : "Ironspine Petrifier" ; Wowhead enUS : "Ironspine Petrifier"
UPDATE `creature_template_locale` SET `Name` = '돌비늘 무쇠돌기 트레샬리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21854;
-- AC datas : OLD Name : "주문에 구속된 공포수호병", Name AC enUS : "Spellbound Terrorguard" ; Wowhead enUS : "Spellbound Terrorguard"
UPDATE `creature_template_locale` SET `Name` = '주문에 구속된 공포의 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21908;
-- AC datas : OLD Name : "겅둥파도 잠복꾼", Name AC enUS : "Tidewalker Lurker" ; Wowhead enUS : "Tidewalker Lurker"
UPDATE `creature_template_locale` SET `Name` = '겅둥파도멀록 잠복꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21920;
-- AC datas : OLD Name : "대지치유사 소푸루스", Name AC enUS : "Earthmender Sophurus" ; Wowhead enUS : "Earthmender Sophurus",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '대지의 치유사 소푸루스', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21937;
-- AC datas : OLD Name : "대지치유사 스플린트후프", Name AC enUS : "Earthmender Splinthoof" ; Wowhead enUS : "Earthmender Splinthoof",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '대지의 치유사 스플린트후프', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21938;
-- AC datas : OLD Name : "절도 있는 칼날첨탑 파수병", Name AC enUS : "Bladespire Sober Defender" ; Wowhead enUS : "Bladespire Sober Defender"
UPDATE `creature_template_locale` SET `Name` = '절도 있는 칼날첨탑일족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 21975;
-- AC datas : OLD Name : "캐스크", Name AC enUS : "Cask" ; Wowhead enUS : "Cask"
UPDATE `creature_template_locale` SET `Name` = '카스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22010;
-- AC datas : OLD Name : "그리핀 기수 키에란", Name AC enUS : "Gryphonrider Kieran" ; Wowhead enUS : "Gryphonrider Kieran"
UPDATE `creature_template_locale` SET `Name` = '그리핀기수 키에란', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22042;
-- AC datas : OLD Name : "어둠달 영혼강탈자", Name AC enUS : "Shadowmoon Soulstealer" ; Wowhead enUS : "Shadowmoon Soulstealer"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 영혼강탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22061;
-- AC datas : OLD Name : "어둠혈맹 용기병", Name AC enUS : "Shadowsworn Drakonid" ; Wowhead enUS : "Shadowsworn Drakonid"
UPDATE `creature_template_locale` SET `Name` = '어둠의혈맹 용기병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22072;
-- AC datas : OLD Name : "어둠달 흑마술사", Name AC enUS : "Shadowmoon Darkweaver" ; Wowhead enUS : "Shadowmoon Darkweaver"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 흑마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22081;
-- AC datas : OLD Name : "어둠달 학살자", Name AC enUS : "Shadowmoon Slayer" ; Wowhead enUS : "Shadowmoon Slayer"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22082;
-- AC datas : OLD Name : "어둠달 정예병", Name AC enUS : "Shadowmoon Chosen" ; Wowhead enUS : "Shadowmoon Chosen"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22084;
-- AC datas : OLD Name : "어둠달 수행원", Name AC enUS : "Shadowmoon Retainer" ; Wowhead enUS : "Shadowmoon Retainer"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 수행원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22102;
-- AC datas : OLD Name : "골두니 철퇴잡이", Name AC enUS : "Gordunni Back-Breaker" ; Wowhead enUS : "Gordunni Back-Breaker"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 철퇴잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22143;
-- AC datas : OLD Name : "골두니 원소술사", Name AC enUS : "Gordunni Elementalist" ; Wowhead enUS : "Gordunni Elementalist"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 원소술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22144;
-- AC datas : OLD Name : "골두니 사형집행인", Name AC enUS : "Gordunni Head-Splitter" ; Wowhead enUS : "Gordunni Head-Splitter"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 사형집행인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22148;
-- AC datas : OLD Name : "피망치 감독관", Name AC enUS : "Bloodmaul Taskmaster" ; Wowhead enUS : "Bloodmaul Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22160;
-- AC datas : OLD Name : "용아귀 오크", Name AC enUS : "Dragonmaw Orc" ; Wowhead enUS : "Dragonmaw Orc"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 오크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22197;
-- AC datas : OLD Subname : "달빛매듭 재봉술 전문가", Subname AC enUS : "Mooncloth Specialist" ; Wowhead enUS : "Mooncloth Specialist"
UPDATE `creature_template_locale` SET `Title` = '달빛매듭 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22208;
-- AC datas : OLD Subname : "그림자매듭 재봉술 전문가", Subname AC enUS : "Shadoweave Specialist" ; Wowhead enUS : "Shadoweave Specialist"
UPDATE `creature_template_locale` SET `Title` = '그림자매듭 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22212;
-- AC datas : OLD Subname : "마법불꽃 재봉술 전문가", Subname AC enUS : "Spellfire Specialist" ; Wowhead enUS : "Spellfire Specialist"
UPDATE `creature_template_locale` SET `Title` = '마법불꽃 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22213;
-- AC datas : OLD Name : "바시르 약탈자", Name AC enUS : "Bash'ir Raider" ; Wowhead enUS : "Bash'ir Raider"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22241;
-- AC datas : OLD Name : "바시르 마법도둑", Name AC enUS : "Bash'ir Spell-Thief" ; Wowhead enUS : "Bash'ir Spell-Thief"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 마법도둑', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22242;
-- AC datas : OLD Name : "바시르 비전술사", Name AC enUS : "Bash'ir Arcanist" ; Wowhead enUS : "Bash'ir Arcanist"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 비전술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22243;
-- AC datas : OLD Name : "속박 풀린 에테리얼", Name AC enUS : "Unbound Ethereal" ; Wowhead enUS : "Unbound Ethereal"
UPDATE `creature_template_locale` SET `Name` = '속박이 풀린 에테리얼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22244;
-- AC datas : OLD Name : "용아귀 궁수", Name AC enUS : "Dragonmaw Archer" ; Wowhead enUS : "Dragonmaw Archer"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 궁수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22251;
-- AC datas : OLD Name : "용아귀 일꾼", Name AC enUS : "Dragonmaw Peon" ; Wowhead enUS : "Dragonmaw Peon"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22252;
-- AC datas : OLD Name : "용아귀 지배자", Name AC enUS : "Dragonmaw Ascendant" ; Wowhead enUS : "Dragonmaw Ascendant"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 지배자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22253;
-- AC datas : OLD Name : "무쇠발톱바실리스크", Name AC enUS : "Ironclaw Basilisk" ; Wowhead enUS : "Ironclaw Basilisk"
UPDATE `creature_template_locale` SET `Name` = '무쇠발톱 바실리스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22256;
-- AC datas : OLD Name : "칼날첨탑 수호병", Name AC enUS : "Bladespire Guardian" ; Wowhead enUS : "Bladespire Guardian"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22261;
-- AC datas : OLD Name : "칼날첨탑 장로", Name AC enUS : "Bladespire Elder" ; Wowhead enUS : "Bladespire Elder"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 장로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22262;
-- AC datas : OLD Name : "칼날첨탑 술고래", Name AC enUS : "Bladespire Keg King" ; Wowhead enUS : "Bladespire Keg King"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 술고래', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22263;
-- AC datas : OLD Name : "용아귀 하늘파괴자", Name AC enUS : "Dragonmaw Skybreaker" ; Wowhead enUS : "Dragonmaw Skybreaker"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 하늘파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22274;
-- AC datas : OLD Name : "에레다르 폭풍인도자", Name AC enUS : "Eredar Stormbringer" ; Wowhead enUS : "Eredar Stormbringer"
UPDATE `creature_template_locale` SET `Name` = '에레다르 폭풍의 인도자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22283;
-- AC datas : OLD Name : "어둠불꽃 지옥불정령", Name AC enUS : "Darkflame Infernal" ; Wowhead enUS : "Darkflame Infernal"
UPDATE `creature_template_locale` SET `Name` = '검은불길 지옥불정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22289;
-- AC datas : OLD Subname : "용아귀 부족 족장", Subname AC enUS : "Chieftain of the Dragonmaw Clan" ; Wowhead enUS : "Chieftain of the Dragonmaw Clan"
UPDATE `creature_template_locale` SET `Title` = '용아귀부족 족장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22330;
-- AC datas : OLD Name : "용아귀 정예병", Name AC enUS : "Dragonmaw Elite" ; Wowhead enUS : "Dragonmaw Elite"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22331;
-- AC datas : OLD Name : "피망치 예언자", Name AC enUS : "Bloodmaul Soothsayer" ; Wowhead enUS : "Bloodmaul Soothsayer"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 예언자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22384;
-- AC datas : OLD Name : "사나운 황천의 망령", Name AC enUS : "Furious Nether-wraith" ; Wowhead enUS : "Furious Nether-wraith"
UPDATE `creature_template_locale` SET `Name` = '격노한 황천의 망령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22408;
-- AC datas : OLD Name : "수도자 바라다", Name AC enUS : "Anchorite Barada" ; Wowhead enUS : "Anchorite Barada"
UPDATE `creature_template_locale` SET `Name` = '수도사 바라다', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22431;
-- AC datas : OLD Name : "수도자의 유물", Name AC enUS : "Anchorite Relic Bunny" ; Wowhead enUS : "Anchorite Relic Bunny"
UPDATE `creature_template_locale` SET `Name` = '수도사의 유물', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22444;
-- AC datas : OLD Name : "수도자 엔샴", Name AC enUS : "Anchorite Ensham" ; Wowhead enUS : "Anchorite Ensham"
UPDATE `creature_template_locale` SET `Name` = '수도사 엔샴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22477;
-- AC datas : OLD Name : "비틀린 우주 투사", Name AC enUS : "Cosmowrench Bruiser" ; Wowhead enUS : "Cosmowrench Bruiser"
UPDATE `creature_template_locale` SET `Name` = '코스모렌치 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22494;
-- AC datas : OLD Name : "잃어버린 자의 성물함", Name AC enUS : "Reliquary of the Lost" ; Wowhead enUS : "Reliquary of the Lost"
UPDATE `creature_template_locale` SET `Name` = '잃어버린 자의 성골함', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22856;
-- AC datas : OLD Name : "수도자 칼렌", Name AC enUS : "Anchorite Caalen" ; Wowhead enUS : "Anchorite Caalen"
UPDATE `creature_template_locale` SET `Name` = '수도사 칼렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22862;
-- AC datas : OLD Name : "어둠달 약탈자", Name AC enUS : "Shadowmoon Reaver" ; Wowhead enUS : "Shadowmoon Reaver"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22879;
-- AC datas : OLD Name : "어둠달 용사", Name AC enUS : "Shadowmoon Champion" ; Wowhead enUS : "Shadowmoon Champion"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22880;
-- AC datas : OLD Name : "어둠달 죽음의 창조자", Name AC enUS : "Shadowmoon Deathshaper" ; Wowhead enUS : "Shadowmoon Deathshaper"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 죽음의 창조자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22882;
-- AC datas : OLD Name : "독구름 (호드)", Name AC enUS : "Poison Cloud Bunny (Horde)" ; Wowhead enUS : "Poison Cloud Bunny (Horde)"
UPDATE `creature_template_locale` SET `Name` = '독 구름 (호드)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22926;
-- AC datas : OLD Name : "사원의 무희", Name AC enUS : "Temple Concubine" ; Wowhead enUS : "Temple Acolyte"
UPDATE `creature_template_locale` SET `Name` = '사원 수행사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22939;
-- AC datas : OLD Name : "어둠달 혈법사", Name AC enUS : "Shadowmoon Blood Mage" ; Wowhead enUS : "Shadowmoon Blood Mage"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 혈법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22945;
-- AC datas : OLD Name : "매력적인 무희", Name AC enUS : "Charming Courtesan" ; Wowhead enUS : "Charming Patron"
UPDATE `creature_template_locale` SET `Name` = '매력적인 손님', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22955;
-- AC datas : OLD Name : "고통의 자매", Name AC enUS : "Sister of Pain" ; Wowhead enUS : "Priestess of Torment"
UPDATE `creature_template_locale` SET `Name` = '고통의 여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22956;
-- AC datas : OLD Name : "광기의 여사제", Name AC enUS : "Priestess of Dementia" ; Wowhead enUS : "Mistress of Dementia"
UPDATE `creature_template_locale` SET `Name` = '광기의 여군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22957;
-- AC datas : OLD Name : "주문에 구속된 수행원", Name AC enUS : "Spellbound Attendant" ; Wowhead enUS : "Ardent Host"
UPDATE `creature_template_locale` SET `Name` = '열정적인 관리자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22959;
-- AC datas : OLD Name : "용아귀 용술사", Name AC enUS : "Dragonmaw Wyrmcaller" ; Wowhead enUS : "Dragonmaw Wyrmcaller"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 용술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22960;
-- AC datas : OLD Name : "환희의 여사제", Name AC enUS : "Priestess of Delight" ; Wowhead enUS : "Mistress of Woe"
UPDATE `creature_template_locale` SET `Name` = '비통의 여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22962;
-- AC datas : OLD Name : "쾌락의 자매", Name AC enUS : "Sister of Pleasure" ; Wowhead enUS : "Priestess of Delight"
UPDATE `creature_template_locale` SET `Name` = '환희의 여사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22964;
-- AC datas : OLD Name : "지배당한 하인", Name AC enUS : "Enslaved Servant" ; Wowhead enUS : "Devoted Steward"
UPDATE `creature_template_locale` SET `Name` = '헌신적인 하인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22965;
-- AC datas : OLD Name : "어둠달 사냥개조련사", Name AC enUS : "Shadowmoon Houndmaster" ; Wowhead enUS : "Shadowmoon Houndmaster"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 사냥개조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23018;
-- AC datas : OLD Name : "용아귀 하늘추적자", Name AC enUS : "Dragonmaw Sky Stalker" ; Wowhead enUS : "Dragonmaw Sky Stalker"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 하늘추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23030;
-- AC datas : OLD Name : "어둠달 병사", Name AC enUS : "Shadowmoon Soldier" ; Wowhead enUS : "Shadowmoon Soldier"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 병사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23047;
-- AC datas : OLD Name : "어둠달 훈련교관", Name AC enUS : "Shadowmoon Weapon Master" ; Wowhead enUS : "Shadowmoon Weapon Master"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 훈련교관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23049;
-- AC datas : OLD Name : "피망치 백성", Name AC enUS : "Bloodmaul Supplicant" ; Wowhead enUS : "Bloodmaul Supplicant"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 백성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23052;
-- AC datas : OLD Name : "칼날첨탑 백성", Name AC enUS : "Bladespire Supplicant" ; Wowhead enUS : "Bladespire Supplicant"
UPDATE `creature_template_locale` SET `Name` = '칼날첨탑일족 백성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23053;
-- AC datas : OLD Name : "지옥수호병 파괴자", Name AC enUS : "Felguard Degrader" ; Wowhead enUS : "Felguard Degrader"
UPDATE `creature_template_locale` SET `Name` = '지옥군단 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23055;
-- AC datas : OLD Name : "어둠달 전투늑대", Name AC enUS : "Shadowmoon Riding Hound" ; Wowhead enUS : "Shadowmoon Riding Hound"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 전투늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23083;
-- AC datas : OLD Name : "파멸의 수호병 응징자", Name AC enUS : "Doomguard Punisher" ; Wowhead enUS : "Doomguard Punisher"
UPDATE `creature_template_locale` SET `Name` = '파멸의 수호대 응징자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23113;
-- AC datas : OLD Name : "대군주 모르고르", Name AC enUS : "Overlord Mor'ghor" ; Wowhead enUS : "Overlord Mor'ghor"
UPDATE `creature_template_locale` SET `Name` = '대군주 모르호르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23139;
-- AC datas : OLD Name : "용아귀 집행자", Name AC enUS : "Dragonmaw Enforcer" ; Wowhead enUS : "Dragonmaw Enforcer"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23146;
-- AC datas : OLD Name : "어둠달 그런트", Name AC enUS : "Shadowmoon Grunt" ; Wowhead enUS : "Shadowmoon Grunt"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23147;
-- AC datas : OLD Name : "바시르 감독관", Name AC enUS : "Bash'ir Surveyor" ; Wowhead enUS : "Bash'ir Surveyor"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23153;
-- AC datas : OLD Name : "광기 어린 오르카오스", Name AC enUS : "Or'kaos the Insane" ; Wowhead enUS : "Or'kaos the Insane"
UPDATE `creature_template_locale` SET `Name` = '광기어린 오르카오스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23168;
-- AC datas : OLD Name : "타렌 제분소 경비병", Name AC enUS : "Tarren Mill Guardsman" ; Wowhead enUS : "Tarren Mill Guardsman"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23175;
-- AC datas : OLD Name : "타렌 제분소 경비병", Name AC enUS : "Tarren Mill Guardsman" ; Wowhead enUS : "Tarren Mill Guardsman"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23176;
-- AC datas : OLD Name : "타렌 제분소 보초", Name AC enUS : "Tarren Mill Lookout" ; Wowhead enUS : "Tarren Mill Lookout"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23177;
-- AC datas : OLD Name : "타렌 제분소 보초", Name AC enUS : "Tarren Mill Lookout" ; Wowhead enUS : "Tarren Mill Lookout"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 보초', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23178;
-- AC datas : OLD Name : "타렌 제분소 민병대원", Name AC enUS : "Tarren Mill Protector" ; Wowhead enUS : "Tarren Mill Protector"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 민병대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23179;
-- AC datas : OLD Name : "타렌 제분소 민병대원", Name AC enUS : "Tarren Mill Protector" ; Wowhead enUS : "Tarren Mill Protector"
UPDATE `creature_template_locale` SET `Name` = '타렌 밀농장 민병대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23180;
-- AC datas : OLD Name : "용아귀 수송병", Name AC enUS : "Dragonmaw Transporter" ; Wowhead enUS : "Dragonmaw Transporter"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 수송병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23188;
-- AC datas : OLD Name : "용아귀 일꾼 처치", Name AC enUS : "Dragonmaw Peon Kill Credit" ; Wowhead enUS : "Dragonmaw Peon Kill Credit"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 일꾼 처치', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23209;
-- AC datas : OLD Name : "용아귀 일꾼", Name AC enUS : "Dragonmaw Peon Mutton" ; Wowhead enUS : "Dragonmaw Peon Mutton"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23213;
-- AC datas : OLD Name : "피망치 요원", Name AC enUS : "Bloodmaul Agent" ; Wowhead enUS : "Bloodmaul Agent"
UPDATE `creature_template_locale` SET `Name` = '피망치일족 요원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23218;
-- AC datas : OLD Name : "쉬바라 암살자", Name AC enUS : "Shivan Assassin" ; Wowhead enUS : "Shivan Assassin"
UPDATE `creature_template_locale` SET `Name` = '쉬반 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23220;
-- AC datas : OLD Name : "침 흘리는 노예", Name AC enUS : "Slavering Slave" ; Wowhead enUS : "Slavering Slave"
UPDATE `creature_template_locale` SET `Name` = '굶주린 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23246;
-- AC datas : OLD Name : "바시르 부대장", Name AC enUS : "Bash'ir Subprimal" ; Wowhead enUS : "Bash'ir Subprimal"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 부대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23247;
-- AC datas : OLD Name : "바시르 살덩이마귀", Name AC enUS : "Bash'ir Flesh Fiend" ; Wowhead enUS : "Bash'ir Flesh Fiend"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 살덩이마귀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23249;
-- AC datas : OLD Name : "지옥수호병 환영", Name AC enUS : "Felguard Smoke Image" ; Wowhead enUS : "Felguard Smoke Image"
UPDATE `creature_template_locale` SET `Name` = '지옥군단병 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23252;
-- AC datas : OLD Name : "탐욕스러운 아르보아르", Name AC enUS : "Arvoar the Rapacious" ; Wowhead enUS : "Arvoar the Rapacious"
UPDATE `creature_template_locale` SET `Name` = '탐욕스런 아르보아르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23267;
-- AC datas : OLD Name : "수렁피 광부", Name AC enUS : "Murkblood Miner" ; Wowhead enUS : "Murkblood Miner"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 광부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23287;
-- AC datas : OLD Name : "아카마 이벤트 추적기", Name AC enUS : "Akama Event Stalker" ; Wowhead enUS : "Akama Event Stalker"
UPDATE `creature_template_locale` SET `Name` = '투명 추적기(아카마)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23288;
-- AC datas : OLD Name : "정신나간 수렁피 현장감독", Name AC enUS : "Crazed Murkblood Foreman" ; Wowhead enUS : "Crazed Murkblood Foreman"
UPDATE `creature_template_locale` SET `Name` = '정신나간 수렁피일족 현장감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23305;
-- AC datas : OLD Name : "용아귀 일꾼 작업 지점", Name AC enUS : "Dragonmaw Peon Work Node" ; Wowhead enUS : "Dragonmaw Peon Work Node"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 일꾼 작업 지점', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23308;
-- AC datas : OLD Name : "수렁피 감독관", Name AC enUS : "Murkblood Overseer" ; Wowhead enUS : "Murkblood Overseer"
UPDATE `creature_template_locale` SET `Name` = '수렁피일족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23309;
-- AC datas : OLD Name : "반항적인 용아귀 일꾼", Name AC enUS : "Disobedient Dragonmaw Peon" ; Wowhead enUS : "Disobedient Dragonmaw Peon"
UPDATE `creature_template_locale` SET `Name` = '반항적인 용아귀부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23311;
-- AC datas : OLD Name : "잿빛혓바닥 도적", Name AC enUS : "Ashtongue Rogue" ; Wowhead enUS : "Ashtongue Rogue"
UPDATE `creature_template_locale` SET `Name` = '잿빛혓바닥 어둠전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23318;
-- AC datas : OLD Name : "용아귀 비행 교관", Name AC enUS : "Dragonmaw Flight Instructor" ; Wowhead enUS : "Dragonmaw Flight Instructor"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 비행 교관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23321;
-- AC datas : OLD Name : "정신나간 수렁피 광부", Name AC enUS : "Crazed Murkblood Miner" ; Wowhead enUS : "Crazed Murkblood Miner"
UPDATE `creature_template_locale` SET `Name` = '정신나간 수렁피일족 광부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23324;
-- AC datas : OLD Name : "용아귀 비행 교관 대상", Name AC enUS : "Dragonmaw Flight Instructor Target" ; Wowhead enUS : "Dragonmaw Flight Instructor Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 비행 교관 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23325;
-- AC datas : OLD Name : "용아귀 하늘약탈자", Name AC enUS : "Dragonmaw Wind Reaver" ; Wowhead enUS : "Dragonmaw Wind Reaver"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 하늘약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23330;
-- AC datas : OLD Name : "바시르 계산원", Name AC enUS : "Bash'ir Reckoner" ; Wowhead enUS : "Bash'ir Reckoner"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 계산원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23332;
-- AC datas : OLD Name : "용아귀 나방 (탈것)", Name AC enUS : "Dragonmaw Moth Mount" ; Wowhead enUS : "Dragonmaw Moth Mount"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 나방 (탈것)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23341;
-- AC datas : OLD Name : "용아귀 경주: 노장의 대상", Name AC enUS : "Dragonmaw Race: Oldie's Target" ; Wowhead enUS : "Dragonmaw Race: Oldie's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 노장의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23356;
-- AC datas : OLD Name : "용아귀 경주: 트로프의 대상", Name AC enUS : "Dragonmaw Race: Trope's Target" ; Wowhead enUS : "Dragonmaw Race: Trope's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 트로프의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23357;
-- AC datas : OLD Name : "용아귀 경주: 코를록의 대상", Name AC enUS : "Dragonmaw Race: Corlok's Target" ; Wowhead enUS : "Dragonmaw Race: Corlok's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 코를록의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23358;
-- AC datas : OLD Name : "용아귀 경주: 이크만의 대상", Name AC enUS : "Dragonmaw Race: Ichman's Target" ; Wowhead enUS : "Dragonmaw Race: Ichman's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 이크만의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23359;
-- AC datas : OLD Name : "용아귀 경주: 멀베릭의 대상", Name AC enUS : "Dragonmaw Race: Mulverick's Target" ; Wowhead enUS : "Dragonmaw Race: Mulverick's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 멀베릭의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23360;
-- AC datas : OLD Name : "용아귀 경주: 스카이쉐터의 대상", Name AC enUS : "Dragonmaw Race: Skyshatter's Target" ; Wowhead enUS : "Dragonmaw Race: Skyshatter's Target"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 경주: 스카이쉐터의 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23361;
-- AC datas : OLD Name : "바시르 감사관", Name AC enUS : "Bash'ir Controller" ; Wowhead enUS : "Bash'ir Controller"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 감사관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23368;
-- AC datas : OLD Name : "소용돌이 칼날", Name AC enUS : "Whirling Blade" ; Wowhead enUS : "Whirling Blade"
UPDATE `creature_template_locale` SET `Name` = '소용돌이치는 칼날', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23369;
-- AC datas : OLD Name : "용아귀 관제사", Name AC enUS : "Dragonmaw Tower Controller" ; Wowhead enUS : "Dragonmaw Tower Controller"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 관제사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23370;
-- AC datas : OLD Name : "어둠달 전사자", Name AC enUS : "Shadowmoon Fallen" ; Wowhead enUS : "Shadowmoon Fallen"
UPDATE `creature_template_locale` SET `Name` = '어둠달부족 전사자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23371;
-- AC datas : OLD Name : "용아귀 현장감독", Name AC enUS : "Dragonmaw Foreman" ; Wowhead enUS : "Dragonmaw Foreman"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 현장감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23376;
-- AC datas : OLD Name : "바시르 영지 우두머리", Name AC enUS : "Bash'ir Landing Boss Bunny" ; Wowhead enUS : "Bash'ir Landing Boss Bunny"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 영지 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23395;
-- AC datas : OLD Subname : "오리지널 얼라이언스 사슬 및 판금 방어구", Subname AC enUS : "Brutal Arena Vendor" ; Wowhead enUS : "Brutal Arena Vendor"
UPDATE `creature_template_locale` SET `Title` = '2시즌 투기장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23396;
-- AC datas : OLD Subname : "", Subname AC enUS : "" ; Wowhead enUS : "PTR Consumables"
UPDATE `creature_template_locale` SET `Title` = '공개 테스트 서버 소비용품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23405;
-- AC datas : OLD Name : "까마귀 군주", Name AC enUS : "Raven Lord" ; Wowhead enUS : "Raven Lord"
UPDATE `creature_template_locale` SET `Name` = '날쌘 까마귀 탈것', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23408;
-- AC datas : OLD Name : "바시르 심문관", Name AC enUS : "Bash'ir Inquisitor" ; Wowhead enUS : "Bash'ir Inquisitor"
UPDATE `creature_template_locale` SET `Name` = '바쉬르 심문관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23414;
-- AC datas : OLD Name : "성물함 전투 트리거", Name AC enUS : "Reliquary Combat Trigger" ; Wowhead enUS : "Reliquary Combat Trigger"
UPDATE `creature_template_locale` SET `Name` = '성골함 전투 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23417;
-- AC datas : OLD Name : "에테리얼 기지 제어기, 정예", Name AC enUS : "Ethereal Ring Control Bunny, Elite" ; Wowhead enUS : "Ethereal Ring Control Bunny, Elite"
UPDATE `creature_template_locale` SET `Name` = '에테리얼 기지 제어기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23425;
-- AC datas : OLD Name : "비전 폭발물", Name AC enUS : "Arcane Charge" ; Wowhead enUS : "Arcane Charge"
UPDATE `creature_template_locale` SET `Name` = '비전 충전', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23429;
-- AC datas : OLD Name : "용아귀 하늘파괴자", Name AC enUS : "Dragonmaw Skybreaker" ; Wowhead enUS : "Dragonmaw Skybreaker"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 하늘파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23440;
-- AC datas : OLD Name : "용아귀 하늘파괴자", Name AC enUS : "Dragonmaw Skybreaker" ; Wowhead enUS : "Dragonmaw Skybreaker"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 하늘파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23441;
-- AC datas : OLD Name : "용아귀 부족 공격대 (점술가 길드)", Name AC enUS : "Dragonmaw Raid Credit Marker (Scryers)" ; Wowhead enUS : "Dragonmaw Raid Credit Marker (Scryers)"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 공격대 (점술가 길드)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23443;
-- AC datas : OLD Name : "부관 트리스티아", Name AC enUS : "Lieutenant Tristia" ; Wowhead enUS : "Lieutenant Tristia"
UPDATE `creature_template_locale` SET `Name` = '부관 트리시아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23446;
-- AC datas : OLD Name : "골두니 대리인", Name AC enUS : "Gordunni Proxy" ; Wowhead enUS : "Gordunni Proxy"
UPDATE `creature_template_locale` SET `Name` = '골두니일족 대리인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23450;
-- AC datas : OLD Name : "용아귀 부족 공격대 (알도르 사제회)", Name AC enUS : "Dragonmaw Raid Credit Marker (Aldor)" ; Wowhead enUS : "Dragonmaw Raid Credit Marker (Aldor)"
UPDATE `creature_template_locale` SET `Name` = '용아귀부족 공격대 (알도르 사제회)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23454;
-- AC datas : OLD Name : "성물함 LoS 어그로 트리거", Name AC enUS : "Reliquary LoS Agro Trigger" ; Wowhead enUS : "Reliquary LoS Agro Trigger"
UPDATE `creature_template_locale` SET `Name` = '성골함', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23502;
-- AC datas : OLD Name : "잿빛혓바닥 영혼결속자", Name AC enUS : "Ashtongue Spiritbinder" ; Wowhead enUS : "Ashtongue Spiritbinder"
UPDATE `creature_template_locale` SET `Name` = '잿빛혓바닥 정기술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23524;
-- AC datas : OLD Name : "용약탈 침략자", Name AC enUS : "Dragonflayer Raider" ; Wowhead enUS : "Dragonflayer Raider"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 침략자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23557;
-- AC datas : OLD Name : "버드", Name AC enUS : "Budd Nedreck" ; Wowhead enUS : "Budd Nedreck"
UPDATE `creature_template_locale` SET `Name` = '버드 네드렉', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23559;
-- AC datas : OLD Name : "역병 걸린 용약탈 전투사", Name AC enUS : "Plagued Dragonflayer Tribesman" ; Wowhead enUS : "Plagued Dragonflayer Tribesman"
UPDATE `creature_template_locale` SET `Name` = '역병 걸린 용약탈부족 전투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23564;
-- AC datas : OLD Subname : "돌망치 일족 생존자", Subname AC enUS : "Stonemaul Survivor" ; Wowhead enUS : "Stonemaul Survivor"
UPDATE `creature_template_locale` SET `Title` = '돌망치일족 생존자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23579;
-- AC datas : OLD Name : "아마니쉬 전쟁인도자", Name AC enUS : "Amani'shi Warbringer" ; Wowhead enUS : "Amani'shi Warbringer"
UPDATE `creature_template_locale` SET `Name` = '아마니쉬 전투병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23580;
-- AC datas : OLD Name : "아마니쉬 정찰병", Name AC enUS : "Amani'shi Scout" ; Wowhead enUS : "Amani'shi Scout"
UPDATE `creature_template_locale` SET `Name` = '아마니 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23586;
-- AC datas : OLD Name : "아마니쉬 지원병", Name AC enUS : "Amani'shi Reinforcement" ; Wowhead enUS : "Amani'shi Reinforcement"
UPDATE `creature_template_locale` SET `Name` = '아마니 지원병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23587;
-- AC datas : OLD Name : "그림토템 투사", Name AC enUS : "Grimtotem Breaker" ; Wowhead enUS : "Grimtotem Breaker"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23592;
-- AC datas : OLD Name : "그림토템 영혼변형술사", Name AC enUS : "Grimtotem Spirit-Shifter" ; Wowhead enUS : "Grimtotem Spirit-Shifter"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 영혼변형술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23593;
-- AC datas : OLD Name : "그림토템 파괴자", Name AC enUS : "Grimtotem Destroyer" ; Wowhead enUS : "Grimtotem Destroyer"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23594;
-- AC datas : OLD Name : "그림토템 대지의 결속자", Name AC enUS : "Grimtotem Earthbinder" ; Wowhead enUS : "Grimtotem Earthbinder"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 대지의 결속자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23595;
-- AC datas : OLD Subname : "포도주 상인", Subname AC enUS : "Wine Vendor" ; Wowhead enUS : "Wine Vendor"
UPDATE `creature_template_locale` SET `Title` = '와인 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23606;
-- AC datas : OLD Name : "긴엄니 낚시꾼", Name AC enUS : "Longtusk Fisherman" ; Wowhead enUS : "Longtusk Fisherman"
UPDATE `creature_template_locale` SET `Name` = '긴엄니부족 낚시꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23638;
-- AC datas : OLD Name : "용약탈 전투사", Name AC enUS : "Dragonflayer Tribesman" ; Wowhead enUS : "Dragonflayer Tribesman"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 전투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23651;
-- AC datas : OLD Name : "용약탈 브리쿨", Name AC enUS : "Dragonflayer Vrykul" ; Wowhead enUS : "Dragonflayer Vrykul"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 브리쿨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23652;
-- AC datas : OLD Name : "용약탈 전사", Name AC enUS : "Dragonflayer Warrior" ; Wowhead enUS : "Dragonflayer Warrior"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23654;
-- AC datas : OLD Name : "용약탈 룬점쟁이", Name AC enUS : "Dragonflayer Rune-Seer" ; Wowhead enUS : "Dragonflayer Rune-Seer"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 룬점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23656;
-- AC datas : OLD Name : "용약탈 죽음의 마술사", Name AC enUS : "Dragonflayer Death Weaver" ; Wowhead enUS : "Dragonflayer Death Weaver"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 죽음의 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23658;
-- AC datas : OLD Name : "용약탈 무사", Name AC enUS : "Dragonflayer Thane" ; Wowhead enUS : "Dragonflayer Thane"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 무사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23660;
-- AC datas : OLD Name : "무쇠룬 일꾼", Name AC enUS : "Iron Rune Worker" ; Wowhead enUS : "Iron Rune Worker"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23672;
-- AC datas : OLD Name : "무쇠룬 강철경비병", Name AC enUS : "Iron Rune Steelguard" ; Wowhead enUS : "Iron Rune Steelguard"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 강철경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23673;
-- AC datas : OLD Name : "무쇠룬 룬술사", Name AC enUS : "Iron Rune Runemaster" ; Wowhead enUS : "Iron Rune Runemaster"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 룬술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23675;
-- AC datas : OLD Name : "콩깍지 고글 노움 남성", Name AC enUS : "Beer Goggles Gnome Male" ; Wowhead enUS : "Beer Goggles Gnome Male"
UPDATE `creature_template_locale` SET `Name` = '흐릿흐릿 고글 노움 남성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23697;
-- AC datas : OLD Name : "술 취한 가을 축제 구경꾼", Name AC enUS : "Drunken Brewfest Reveler" ; Wowhead enUS : "Drunken Brewfest Reveler"
UPDATE `creature_template_locale` SET `Name` = '술취한 가을 축제 구경꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23698;
-- AC datas : OLD Name : "가을 축제 검은무쇠 이벤트 생성", Name AC enUS : "[DND] Brewfest Dark Iron Event Generator" ; Wowhead enUS : "[DND] Brewfest Dark Iron Event Generator"
UPDATE `creature_template_locale` SET `Name` = '가을 축제 검은무쇠단 이벤트 생성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23703;
-- AC datas : OLD Name : "검은무쇠 주정뱅이", Name AC enUS : "Dark Iron Guzzler" ; Wowhead enUS : "Dark Iron Guzzler"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 주정뱅이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23709;
-- AC datas : OLD Name : "그림토템 장로", Name AC enUS : "Grimtotem Elder" ; Wowhead enUS : "Grimtotem Elder"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 장로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23714;
-- AC datas : OLD Name : "사술사의 시체", Name AC enUS : "Hexxer Corpse" ; Wowhead enUS : "Hexxer Corpse"
UPDATE `creature_template_locale` SET `Name` = '주술사의 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23716;
-- AC datas : OLD Name : "수도자 야즈미나", Name AC enUS : "Anchorite Yazmina" ; Wowhead enUS : "Anchorite Yazmina",  OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Name` = '수도사 야즈미나', `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23734;
-- AC datas : OLD Name : "복수의 상륙지 죽음경비병", Name AC enUS : "Vengeance Landing Deathguard" ; Wowhead enUS : "Vengeance Landing Deathguard"
UPDATE `creature_template_locale` SET `Name` = '복수의 상륙지 죽음의경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23779;
-- AC datas : OLD Name : "돌망치 영혼", Name AC enUS : "Stonemaul Spirit" ; Wowhead enUS : "Stonemaul Spirit"
UPDATE `creature_template_locale` SET `Name` = '돌망치일족 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23786;
-- AC datas : OLD Name : "매니 씨", Name AC enUS : "Mister Manny" ; Wowhead enUS : "Mister Manny"
UPDATE `creature_template_locale` SET `Name` = '매니씨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23787;
-- AC datas : OLD Name : "검은무쇠 불한당", Name AC enUS : "Dark Iron Antagonist" ; Wowhead enUS : "Dark Iron Antagonist"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 불한당', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23795;
-- AC datas : OLD Name : "무쇠룬 결속사", Name AC enUS : "Iron Rune Binder" ; Wowhead enUS : "Iron Rune Binder"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 결속사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23796;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23862;
-- AC datas : OLD Name : "용약탈 조련사", Name AC enUS : "Dragonflayer Handler" ; Wowhead enUS : "Dragonflayer Handler"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23871;
-- AC datas : OLD Name : "가을 축제 검은무쇠 생성", Name AC enUS : "[DND] Brewfest Dark Iron Spawn Bunny" ; Wowhead enUS : "[DND] Brewfest Dark Iron Spawn Bunny"
UPDATE `creature_template_locale` SET `Name` = '가을 축제 검은무쇠단 생성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23894;
-- AC datas : OLD Name : ""더러운" 마이클 크로", Name AC enUS : ""Dirty" Michael Crowe" ; Wowhead enUS : ""Dirty" Michael Crowe",  OLD Subname : "전문 낚시꾼 및 낚시용품 상인", Subname AC enUS : "Fish Merchant" ; Wowhead enUS : "Fish Merchant"
UPDATE `creature_template_locale` SET `Name` = '"더러운" 마이클 크로위', `Title` = '생선 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23896;
-- AC datas : OLD Name : "시험용 나방", Name AC enUS : "[DNT]TEST Pet Moth" ; Wowhead enUS : "[DNT]TEST Pet Moth"
UPDATE `creature_template_locale` SET `Name` = '테스트 나방', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23936;
-- AC datas : OLD Name : "용약탈 전략가", Name AC enUS : "Dragonflayer Strategist" ; Wowhead enUS : "Dragonflayer Strategist"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 전략가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23956;
-- AC datas : OLD Name : "용약탈 룬마술사", Name AC enUS : "Dragonflayer Runecaster" ; Wowhead enUS : "Dragonflayer Runecaster"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 룬마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23960;
-- AC datas : OLD Name : "용약탈 무쇠투구병", Name AC enUS : "Dragonflayer Ironhelm" ; Wowhead enUS : "Dragonflayer Ironhelm"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 무쇠투구병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23961;
-- AC datas : OLD Name : "광기 어린 탐험가", Name AC enUS : "Deranged Explorer" ; Wowhead enUS : "Deranged Explorer"
UPDATE `creature_template_locale` SET `Name` = '광기어린 탐험가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23967;
-- AC datas : OLD Name : "용약탈 사냥개", Name AC enUS : "Dragonflayer Hunting Hound" ; Wowhead enUS : "Dragonflayer Hunting Hound"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23994;
-- AC datas : OLD Name : "유령 호랑이", Name AC enUS : "Spectral Tiger" ; Wowhead enUS : "Spectral Tiger"
UPDATE `creature_template_locale` SET `Name` = '길들인 호랑이 (유령)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24003;
-- AC datas : OLD Name : "날쌘 유령 호랑이", Name AC enUS : "Swift Spectral Tiger" ; Wowhead enUS : "Swift Spectral Tiger"
UPDATE `creature_template_locale` SET `Name` = '날쌘 호랑이 (유령)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24004;
-- AC datas : OLD Name : "공성 일꾼", Name AC enUS : "Mill Worker" ; Wowhead enUS : "Mill Worker"
UPDATE `creature_template_locale` SET `Name` = '제재소 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24005;
-- AC datas : OLD Name : "무쇠룬 돌소환사", Name AC enUS : "Iron Rune Stonecaller" ; Wowhead enUS : "Iron Rune Stonecaller"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 돌소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24030;
-- AC datas : OLD Name : "용약탈 침입자", Name AC enUS : "Dragonflayer Invader" ; Wowhead enUS : "Dragonflayer Invader"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 침입자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24051;
-- AC datas : OLD Name : "용약탈 검은늑대", Name AC enUS : "Dragonflayer Worg" ; Wowhead enUS : "Dragonflayer Worg"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24063;
-- AC datas : OLD Name : "용약탈 해골분쇄자", Name AC enUS : "Dragonflayer Bonecrusher" ; Wowhead enUS : "Dragonflayer Bonecrusher"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 해골분쇄자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24069;
-- AC datas : OLD Name : "용약탈 심장분쇄자", Name AC enUS : "Dragonflayer Heartsplitter" ; Wowhead enUS : "Dragonflayer Heartsplitter"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 심장분쇄자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24071;
-- AC datas : OLD Name : "용약탈 금속세공사", Name AC enUS : "Dragonflayer Metalworker" ; Wowhead enUS : "Dragonflayer Metalworker"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 금속세공사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24078;
-- AC datas : OLD Name : "용약탈 괴철로 감독", Name AC enUS : "Dragonflayer Forge Master" ; Wowhead enUS : "Dragonflayer Forge Master"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 괴철로 감독', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24079;
-- AC datas : OLD Name : "용약탈 무기제작자", Name AC enUS : "Dragonflayer Weaponsmith" ; Wowhead enUS : "Dragonflayer Weaponsmith"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24080;
-- AC datas : OLD Name : "용약탈 감독관", Name AC enUS : "Dragonflayer Overseer" ; Wowhead enUS : "Dragonflayer Overseer"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24085;
-- AC datas : OLD Name : "용약탈 점쟁이 시체", Name AC enUS : "Dragonflayer Oracle Corpse" ; Wowhead enUS : "Dragonflayer Oracle Corpse"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 점쟁이 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24112;
-- AC datas : OLD Name : "용약탈 검은늑대 시체", Name AC enUS : "Dragonflayer Worg Corpse" ; Wowhead enUS : "Dragonflayer Worg Corpse"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 검은늑대 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24113;
-- AC datas : OLD Name : "용약탈 무사 시체", Name AC enUS : "Dragonflayer Thane Corpse" ; Wowhead enUS : "Dragonflayer Thane Corpse"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 무사 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24114;
-- AC datas : OLD Name : "고대 그림토템 영혼의 인도자", Name AC enUS : "Ancient Grimtotem Spirit Guide" ; Wowhead enUS : "Ancient Grimtotem Spirit Guide"
UPDATE `creature_template_locale` SET `Name` = '고대 그림토템부족 영혼의 인도자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24133;
-- AC datas : OLD Name : "용약탈 점쟁이 대상", Name AC enUS : "Dragonflayer Oracle Target" ; Wowhead enUS : "Dragonflayer Oracle Target"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 점쟁이 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24158;
-- AC datas : OLD Name : "용약탈 부대장", Name AC enUS : "Dragonflayer Lieutenant" ; Wowhead enUS : "Dragonflayer Lieutenant"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 부대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24169;
-- AC datas : OLD Name : "역병 걸린 용약탈 룬마술사", Name AC enUS : "Plagued Dragonflayer Rune-Caster" ; Wowhead enUS : "Plagued Dragonflayer Rune-Caster"
UPDATE `creature_template_locale` SET `Name` = '역병 걸린 용약탈부족 룬마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24198;
-- AC datas : OLD Name : "역병 걸린 용약탈 조련사", Name AC enUS : "Plagued Dragonflayer Handler" ; Wowhead enUS : "Plagued Dragonflayer Handler"
UPDATE `creature_template_locale` SET `Name` = '역병 걸린 용약탈부족 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24199;
-- AC datas : OLD Name : "무쇠룬 수호자", Name AC enUS : "Iron Rune Guardian" ; Wowhead enUS : "Iron Rune Guardian"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24212;
-- AC datas : OLD Name : "용약탈 광전사", Name AC enUS : "Dragonflayer Berserker" ; Wowhead enUS : "Dragonflayer Berserker"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24216;
-- AC datas : OLD Name : "용약탈 광전사 대상", Name AC enUS : "Dragonflayer Berserker Target" ; Wowhead enUS : "Dragonflayer Berserker Target"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 광전사 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24221;
-- AC datas : OLD Name : "독수리 위협 수준 트리거", Name AC enUS : "Eagle Trash Aggro Trigger" ; Wowhead enUS : "Eagle Trash Aggro Trigger"
UPDATE `creature_template_locale` SET `Name` = '독수리 위협수준 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24223;
-- AC datas : OLD Name : "용약탈 포로", Name AC enUS : "Dragonflayer Prisoner" ; Wowhead enUS : "Dragonflayer Prisoner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24226;
-- AC datas : OLD Name : "사술 군주 말라크라스", Name AC enUS : "Hex Lord Malacrass" ; Wowhead enUS : "Hex Lord Malacrass"
UPDATE `creature_template_locale` SET `Name` = '주술 군주 말라크라스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24239;
-- AC datas : OLD Name : "용약탈 영혼파괴자", Name AC enUS : "Dragonflayer Soulreaver" ; Wowhead enUS : "Dragonflayer Soulreaver"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 영혼파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24249;
-- AC datas : OLD Name : "용약탈 식인전사", Name AC enUS : "Dragonflayer Fleshripper" ; Wowhead enUS : "Dragonflayer Fleshripper"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 식인전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24250;
-- AC datas : OLD Name : "용약탈 포로", Name AC enUS : "Dragonflayer Prisoner" ; Wowhead enUS : "Dragonflayer Prisoner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24253;
-- AC datas : OLD Name : "용약탈 포로", Name AC enUS : "Dragonflayer Prisoner" ; Wowhead enUS : "Dragonflayer Prisoner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24254;
-- AC datas : OLD Name : "용약탈 포로", Name AC enUS : "Dragonflayer Prisoner" ; Wowhead enUS : "Dragonflayer Prisoner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24255;
-- AC datas : OLD Name : "용약탈 브리쿨 포로", Name AC enUS : "Dragonflayer Vrykul Prisoner" ; Wowhead enUS : "Dragonflayer Vrykul Prisoner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 브리쿨 포로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24284;
-- AC datas : OLD Name : "무쇠룬 파수꾼", Name AC enUS : "Iron Rune Sentinel" ; Wowhead enUS : "Iron Rune Sentinel"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 파수꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24316;
-- AC datas : OLD Name : "원정대 죽음경비병", Name AC enUS : "Expedition Deathguard" ; Wowhead enUS : "Expedition Deathguard"
UPDATE `creature_template_locale` SET `Name` = '원정대 죽음의경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24317;
-- AC datas : OLD Name : "비정상 종료 시험용 NPC", Name AC enUS : "Crash Test Creature" ; Wowhead enUS : "Crash Test Creature"
UPDATE `creature_template_locale` SET `Name` = '비정상 종료 테스트 NPC', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24324;
-- AC datas : OLD Name : "제이슨 굿허치", Name AC enUS : "Bartender Jason Goodhutch" ; Wowhead enUS : "Bartender Jason Goodhutch",  OLD Subname : "바텐더", Subname AC enUS : "Drinks" ; Wowhead enUS : "Drinks"
UPDATE `creature_template_locale` SET `Name` = '바텐더 제이슨 굿허치', `Title` = '음료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24333;
-- AC datas : OLD Name : "룬새김 구슬", Name AC enUS : "Runed Orb" ; Wowhead enUS : "Runed Orb"
UPDATE `creature_template_locale` SET `Name` = '룬문자 구슬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24335;
-- AC datas : OLD Name : "티모시 홀랜드", Name AC enUS : "Timothy Holland" ; Wowhead enUS : "Timothy Holland"
UPDATE `creature_template_locale` SET `Name` = '티모스 홀랜드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24342;
-- AC datas : OLD Name : "연금술사 아나스타샤", Name AC enUS : "Apothecary Anastasia" ; Wowhead enUS : "Apothecary Anastasia"
UPDATE `creature_template_locale` SET `Name` = '연금술사 아나스타시아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24359;
-- AC datas : OLD Name : "사술 군주 말라크라스", Name AC enUS : "Hex Lord Malacrass" ; Wowhead enUS : "Hex Lord Malacrass"
UPDATE `creature_template_locale` SET `Name` = '주술 군주 말라크라스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24363;
-- AC datas : OLD Name : "해리슨의 시체", Name AC enUS : "Willie's Corpse" ; Wowhead enUS : "Willie's Corpse"
UPDATE `creature_template_locale` SET `Name` = '윌리의 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24365;
-- AC datas : OLD Name : "하급 공허방랑자", Name AC enUS : "Minor Voidwalker" ; Wowhead enUS : "Minor Voidwalker"
UPDATE `creature_template_locale` SET `Name` = '하급 보이드워커', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24476;
-- AC datas : OLD Name : "세나리온 전투 히포그리프", Name AC enUS : "Cenarion War Hippogryph" ; Wowhead enUS : "Cenarion War Hippogryph"
UPDATE `creature_template_locale` SET `Name` = '녹색 장갑 히포그리프', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24488;
-- AC datas : OLD Name : "죽음경비병 플로렌스", Name AC enUS : "Deathguard Florence" ; Wowhead enUS : "Deathguard Florence"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 플로렌스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24491;
-- AC datas : OLD Name : "콩깍지 고글 오크 여성", Name AC enUS : "Beer Goggles Orc Female" ; Wowhead enUS : "Beer Goggles Orc Female"
UPDATE `creature_template_locale` SET `Name` = '흐릿흐릿 고글 오크 여성', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24496;
-- AC datas : OLD Name : "도리스 볼란티우스", Name AC enUS : "Doris Volanthius" ; Wowhead enUS : "Doris Volanthius"
UPDATE `creature_template_locale` SET `Name` = '도리스 볼란시우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24520;
-- AC datas : OLD Name : "용약탈 수호병", Name AC enUS : "Dragonflayer Defender" ; Wowhead enUS : "Dragonflayer Defender"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24533;
-- AC datas : OLD Name : "검은무쇠 전령", Name AC enUS : "Dark Iron Herald" ; Wowhead enUS : "Dark Iron Herald"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 전령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24536;
-- AC datas : OLD Name : "용약탈 군사 시설 I", Name AC enUS : "Dragonflayer Installation I" ; Wowhead enUS : "Dragonflayer Installation I"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 군사 시설 I', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24538;
-- AC datas : OLD Name : "채찍파도 미르미돈", Name AC enUS : "Riplash Myrmidon" ; Wowhead enUS : "Riplash Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '채찍파도일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24576;
-- AC datas : OLD Name : "북쪽바다 결투사", Name AC enUS : "Northsea Duelist" ; Wowhead enUS : "Northsea Duelist"
UPDATE `creature_template_locale` SET `Name` = '북쪽바다해적단 결투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24628;
-- AC datas : OLD Name : "술 취한 드워프 구경꾼", Name AC enUS : "Drunk Dwarf Reveler" ; Wowhead enUS : "Drunk Dwarf Reveler"
UPDATE `creature_template_locale` SET `Name` = '술취한 드워프 구경꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24631;
-- AC datas : OLD Name : "술 취한 고블린 구경꾼", Name AC enUS : "Drunk Goblin Reveler" ; Wowhead enUS : "Drunk Goblin Reveler"
UPDATE `creature_template_locale` SET `Name` = '술취한 고블린 구경꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24632;
-- AC datas : OLD Name : "용약탈 작살병", Name AC enUS : "Dragonflayer Harpooner" ; Wowhead enUS : "Dragonflayer Harpooner"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 작살병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24635;
-- AC datas : OLD Name : "용약탈 군사 시설 II", Name AC enUS : "Dragonflayer Installation II" ; Wowhead enUS : "Dragonflayer Installation II"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 군사 시설 II', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24646;
-- AC datas : OLD Name : "용약탈 군사 시설 III", Name AC enUS : "Dragonflayer Installation III" ; Wowhead enUS : "Dragonflayer Installation III"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 군사 시설 III', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24647;
-- AC datas : OLD Name : "채찍파도 여마법사", Name AC enUS : "Riplash Sorceress" ; Wowhead enUS : "Riplash Sorceress"
UPDATE `creature_template_locale` SET `Name` = '채찍파도일족 여마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24662;
-- AC datas : OLD Name : "불기둥 트리거", Name AC enUS : "Flame Strike Trigger (Kael - 5Man)" ; Wowhead enUS : "Flame Strike Trigger (Kael - 5Man)"
UPDATE `creature_template_locale` SET `Name` = '화염 강타 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24666;
-- AC datas : OLD Name : "잠든 브리쿨", Name AC enUS : "Dormant Vrykul" ; Wowhead enUS : "Dormant Vrykul"
UPDATE `creature_template_locale` SET `Name` = '잠들어 있는 브리쿨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24669;
-- AC datas : OLD Name : "부관 트리스티아", Name AC enUS : "Lieutenant Tristia" ; Wowhead enUS : "Lieutenant Tristia"
UPDATE `creature_template_locale` SET `Name` = '부관 트리시아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24670;
-- AC datas : OLD Name : "광기 어린 북쪽바다 노예사냥꾼", Name AC enUS : "Crazed Northsea Slaver" ; Wowhead enUS : "Crazed Northsea Slaver"
UPDATE `creature_template_locale` SET `Name` = '광기어린 북쪽바다해적단 노예사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24676;
-- AC datas : OLD Name : "고급 훈련용 허수아비", Name AC enUS : "Advanced Training Dummy" ; Wowhead enUS : "Advanced Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '고급 수련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24792;
-- AC datas : OLD Name : "성난모루 작업반장", Name AC enUS : "Anvilrage Taskmaster" ; Wowhead enUS : "Anvilrage Taskmaster"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 작업반장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24818;
-- AC datas : OLD Name : "성난모루 집행자", Name AC enUS : "Anvilrage Enforcer" ; Wowhead enUS : "Anvilrage Enforcer"
UPDATE `creature_template_locale` SET `Name` = '성난모루단 집행자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24819;
-- AC datas : OLD Name : "바위동굴 강탈자", Name AC enUS : "Stonevault Pillager" ; Wowhead enUS : "Stonevault Pillager"
UPDATE `creature_template_locale` SET `Name` = '바위동굴일족 강탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24830;
-- AC datas : OLD Name : "용약탈 일꾼", Name AC enUS : "Dragonflayer Worker" ; Wowhead enUS : "Dragonflayer Worker"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24864;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24868;
-- AC datas : OLD Name : "광기 어린 압둘", Name AC enUS : "Abdul the Insane" ; Wowhead enUS : "Abdul the Insane"
UPDATE `creature_template_locale` SET `Name` = '광기어린 압둘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24900;
-- AC datas : OLD Name : "서슬가시 바위갈퀴", Name AC enUS : "Razorthorn Flayer" ; Wowhead enUS : "Razorthorn Flayer"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기 바위갈퀴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24920;
-- AC datas : OLD Name : "서슬가시 칼날발톱", Name AC enUS : "Razorthorn Ravager" ; Wowhead enUS : "Razorthorn Ravager"
UPDATE `creature_template_locale` SET `Name` = '서슬갈기 칼날발톱', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24922;
-- AC datas : OLD Name : "우두머리 차원문: 보라색", Name AC enUS : "Boss Portal: Purple (3.00)" ; Wowhead enUS : "Boss Portal: Purple (3.00)"
UPDATE `creature_template_locale` SET `Name` = '우두머리 문: 보라색', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24925;
-- AC datas : OLD Name : "떠 있는 공포수호병", Name AC enUS : "Suspended Terrorguard" ; Wowhead enUS : "Suspended Terrorguard"
UPDATE `creature_template_locale` SET `Name` = '떠 있는 공포의 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24933;
-- AC datas : OLD Subname : "플라스카타우르의 배우자", Subname AC enUS : "Mate of the Flaskataur" ; Wowhead enUS : "PTR Enchants"
UPDATE `creature_template_locale` SET `Title` = 'PTR 마법부여', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24982;
-- AC datas : OLD Name : "파수꾼 브라이트그라스", Name AC enUS : "Sentinel Brightgrass" ; Wowhead enUS : "Sentinel Brightgrass"
UPDATE `creature_template_locale` SET `Name` = '파수꾼 브라이트그래스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25013;
-- AC datas : OLD Name : "어둠가시 미르미돈", Name AC enUS : "Darkspine Myrmidon" ; Wowhead enUS : "Darkspine Myrmidon"
UPDATE `creature_template_locale` SET `Name` = '어둠가시일족 미르미돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25060;
-- AC datas : OLD Name : "어둠가시 세이렌", Name AC enUS : "Darkspine Siren" ; Wowhead enUS : "Darkspine Siren"
UPDATE `creature_template_locale` SET `Name` = '어둠가시일족 세이렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25073;
-- AC datas : OLD Name : "죽음경비병 파울리스", Name AC enUS : "Deathguard Fowles" ; Wowhead enUS : "Deathguard Fowles"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 파울리스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25079;
-- AC datas : OLD Name : "죽음경비병 러슨", Name AC enUS : "Deathguard Lawson" ; Wowhead enUS : "Deathguard Lawson"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 러슨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25083;
-- AC datas : OLD Name : "초록아가미 노예", Name AC enUS : "Greengill Slave" ; Wowhead enUS : "Greengill Slave"
UPDATE `creature_template_locale` SET `Name` = '초록아가미일족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25084;
-- AC datas : OLD Name : "해방된 초록아가미 노예", Name AC enUS : "Freed Greengill Slave" ; Wowhead enUS : "Freed Greengill Slave"
UPDATE `creature_template_locale` SET `Name` = '해방된 초록아가미일족 노예', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25085;
-- AC datas : OLD Name : "해방된 초록아가미 처치 크레딧", Name AC enUS : "Freed Greengill Slave Kill Credit" ; Wowhead enUS : "Freed Greengill Slave Kill Credit"
UPDATE `creature_template_locale` SET `Name` = '해방된 초록아가미일족 처치 크레딧', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25086;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25099;
-- AC datas : OLD Name : "수도자 아유리", Name AC enUS : "Anchorite Ayuri" ; Wowhead enUS : "Anchorite Ayuri"
UPDATE `creature_template_locale` SET `Name` = '수도사 아유리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25112;
-- AC datas : OLD Name : "태양샘 - 퀘스트 - 차원문", Name AC enUS : "Sunwell - Quest Bunny - Portal" ; Wowhead enUS : "Sunwell - Quest Bunny - Portal"
UPDATE `creature_template_locale` SET `Name` = '태양샘 - 퀘스트 - 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25156;
-- AC datas : OLD Name : "수도자 케어소스", Name AC enUS : "Anchorite Kairthos" ; Wowhead enUS : "Anchorite Kairthos"
UPDATE `creature_template_locale` SET `Name` = '수도사 케어소스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25163;
-- AC datas : OLD Name : "엑튼 브라스텀블러", Name AC enUS : "Ecton Brasstumbler" ; Wowhead enUS : "Ecton Brasstumbler"
UPDATE `creature_template_locale` SET `Name` = '엑튼 브래스텀블러', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25178;
-- AC datas : OLD Name : "프릭시 브라스텀블러", Name AC enUS : "Frixee Brasstumbler" ; Wowhead enUS : "Frixee Brasstumbler"
UPDATE `creature_template_locale` SET `Name` = '프릭시 브래스텀블러', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25179;
-- AC datas : OLD Name : "날쌘 검은색 전투산양", Name AC enUS : "Fast Black War Ram" ; Wowhead enUS : "Fast Black War Ram"
UPDATE `creature_template_locale` SET `Name` = '날쌘 검은색 전투 산양', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25180;
-- AC datas : OLD Name : "날쌘 검은색 전투늑대", Name AC enUS : "Fast Black War Wolf" ; Wowhead enUS : "Fast Black War Wolf"
UPDATE `creature_template_locale` SET `Name` = '날쌘 검은색 전투 늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25181;
-- AC datas : OLD Name : "스칼록의 전투마", Name AC enUS : "Skarloc's Warhorse" ; Wowhead enUS : "Skarloc's Warhorse"
UPDATE `creature_template_locale` SET `Name` = '스칼록의 군마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25190;
-- AC datas : OLD Subname : "", Subname AC enUS : "Specialty Ammunition Vendor" ; Wowhead enUS : "Specialty Ammunition Vendor"
UPDATE `creature_template_locale` SET `Title` = '특수 화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25195;
-- AC datas : OLD Subname : "", Subname AC enUS : "Specialty Ammunition Vendor" ; Wowhead enUS : "Specialty Ammunition Vendor"
UPDATE `creature_template_locale` SET `Title` = '특수 화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25196;
-- AC datas : OLD Name : "멀록왕 아옳아옳", Name AC enUS : "King Mrgl-Mrgl" ; Wowhead enUS : "King Mrgl-Mrgl"
UPDATE `creature_template_locale` SET `Name` = '멀록왕 므르글므르글', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25197;
-- AC datas : OLD Name : "겨울지느러미 채집꾼", Name AC enUS : "Winterfin Gatherer" ; Wowhead enUS : "Winterfin Gatherer"
UPDATE `creature_template_locale` SET `Name` = '겨울지느러미일족 채집꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25198;
-- AC datas : OLD Name : "겨울지느러미 작살사수", Name AC enUS : "Winterfin Shorestriker" ; Wowhead enUS : "Winterfin Shorestriker"
UPDATE `creature_template_locale` SET `Name` = '겨울지느러미일족 작살사수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25215;
-- AC datas : OLD Name : "겨울지느러미 점쟁이", Name AC enUS : "Winterfin Oracle" ; Wowhead enUS : "Winterfin Oracle"
UPDATE `creature_template_locale` SET `Name` = '겨울지느러미일족 점쟁이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25216;
-- AC datas : OLD Name : "겨울지느러미 전사", Name AC enUS : "Winterfin Warrior" ; Wowhead enUS : "Winterfin Warrior"
UPDATE `creature_template_locale` SET `Name` = '겨울지느러미일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25217;
-- AC datas : OLD Name : "전쟁노래 전투호위병", Name AC enUS : "Warsong Battleguard" ; Wowhead enUS : "Warsong Battleguard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25242;
-- AC datas : OLD Name : "전쟁노래 근위병", Name AC enUS : "Warsong Honor Guard" ; Wowhead enUS : "Warsong Honor Guard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 근위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25243;
-- AC datas : OLD Name : "전쟁노래 명사수", Name AC enUS : "Warsong Marksman" ; Wowhead enUS : "Warsong Marksman"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 명사수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25244;
-- AC datas : OLD Name : "보병 미치", Name AC enUS : "Footman Mitch" ; Wowhead enUS : "Footman Mitch"
UPDATE `creature_template_locale` SET `Name` = '보병 밋치', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25260;
-- AC datas : OLD Name : "전쟁노래 일꾼", Name AC enUS : "Warsong Peon" ; Wowhead enUS : "Warsong Peon"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25270;
-- AC datas : OLD Name : "전쟁노래 징집관", Name AC enUS : "Warsong Recruitment Officer" ; Wowhead enUS : "Warsong Recruitment Officer"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 징집관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25273;
-- AC datas : OLD Name : "전쟁노래 대장장이", Name AC enUS : "Warsong Blacksmith" ; Wowhead enUS : "Warsong Blacksmith"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25275;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineer" ; Wowhead enUS : "Grand Master Engineer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25277;
-- AC datas : OLD Name : "전쟁노래 와이번 기수", Name AC enUS : "Warsong Wind Rider" ; Wowhead enUS : "Warsong Wind Rider"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 와이번 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25286;
-- AC datas : OLD Name : "녹주석 마술사", Name AC enUS : "Beryl Sorcerer" ; Wowhead enUS : "Beryl Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '녹주석 거점 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25316;
-- AC datas : OLD Name : "대지 고리회 인도자", Name AC enUS : "Earthen Ring Guide" ; Wowhead enUS : "Earthen Ring Guide"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 인도자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25324;
-- AC datas : OLD Name : "대지 고리회 인도자 늑대 형상", Name AC enUS : "Earthen Ring Guide Wolf Form" ; Wowhead enUS : "Earthen Ring Guide Wolf Form"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 인도자 늑대 형상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25325;
-- AC datas : OLD Name : "시체분쇄자 고지", Name AC enUS : "Gorge the Corpsegrinder" ; Wowhead enUS : "Annihilator Grek'lor"
UPDATE `creature_template_locale` SET `Name` = '파멸자 그렉로르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25329;
-- AC datas : OLD Name : "끔찍한 전쟁노래 누더기골렘", Name AC enUS : "Stitched Warsong Horror" ; Wowhead enUS : "Stitched Warsong Horror"
UPDATE `creature_template_locale` SET `Name` = '끔찍한 전쟁노래부족 누더기골렘', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25332;
-- AC datas : OLD Name : "전쟁노래 짐마차 경비병", Name AC enUS : "Warsong Caravan Guard" ; Wowhead enUS : "Warsong Caravan Guard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 짐마차 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25338;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25344;
-- AC datas : OLD Name : "대지 고리회 호드 변장", Name AC enUS : "Earthen Ring Horde Disguise" ; Wowhead enUS : "Earthen Ring Horde Disguise",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 호드 변장', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25345;
-- AC datas : OLD Name : "녹주석 보물 사냥꾼", Name AC enUS : "Beryl Treasure Hunter" ; Wowhead enUS : "Beryl Treasure Hunter"
UPDATE `creature_template_locale` SET `Name` = '녹주석 거점 보물 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25353;
-- AC datas : OLD Name : "녹주석 사냥개", Name AC enUS : "Beryl Hound" ; Wowhead enUS : "Beryl Hound"
UPDATE `creature_template_locale` SET `Name` = '녹주석 거점 사냥개', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25355;
-- AC datas : OLD Name : "대지 고리회 얼라이언스 변장", Name AC enUS : "Earthen Ring Alliance Disguise" ; Wowhead enUS : "Earthen Ring Alliance Disguise",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 얼라이언스 변장', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25360;
-- AC datas : OLD Name : "전쟁노래 돼지", Name AC enUS : "Warsong Swine" ; Wowhead enUS : "Warsong Swine"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 요새 돼지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25362;
-- AC datas : OLD Name : "어둠비수 영혼술사", Name AC enUS : "Shadowsword Soulbinder" ; Wowhead enUS : "Shadowsword Soulbinder"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 영혼술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25373;
-- AC datas : OLD Name : "부서질 듯한 해골", Name AC enUS : "Brittle Skeleton" ; Wowhead enUS : "Brittle Skeleton"
UPDATE `creature_template_locale` SET `Name` = '빛바랜 해골', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25377;
-- AC datas : OLD Name : "전쟁노래 전사", Name AC enUS : "Warsong Hold Warrior" ; Wowhead enUS : "Warsong Hold Warrior"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25414;
-- AC datas : OLD Name : "전쟁노래 마법사", Name AC enUS : "Warsong Hold Mage" ; Wowhead enUS : "Warsong Hold Mage"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25420;
-- AC datas : OLD Name : "전쟁노래 주술사", Name AC enUS : "Warsong Hold Shaman" ; Wowhead enUS : "Warsong Hold Shaman"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25421;
-- AC datas : OLD Name : "전쟁노래 정찰병", Name AC enUS : "Warsong Scout" ; Wowhead enUS : "Warsong Scout"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25439;
-- AC datas : OLD Name : "전쟁노래 경비대장", Name AC enUS : "Warsong Captain" ; Wowhead enUS : "Warsong Captain"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 경비대장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25446;
-- AC datas : OLD Name : "녹주석 수색병", Name AC enUS : "Beryl Reclaimer" ; Wowhead enUS : "Beryl Reclaimer"
UPDATE `creature_template_locale` SET `Name` = '녹주석 거점 수색병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25449;
-- AC datas : OLD Name : "사로잡힌 녹주석 마술사", Name AC enUS : "Captured Beryl Sorcerer" ; Wowhead enUS : "Captured Beryl Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '사로잡힌 녹주석 거점 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25474;
-- AC datas : OLD Name : "구속된 녹주석 마술사", Name AC enUS : "Imprisoned Beryl Sorcerer" ; Wowhead enUS : "Imprisoned Beryl Sorcerer"
UPDATE `creature_template_locale` SET `Name` = '구속된 녹주석 거점 마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25478;
-- AC datas : OLD Name : "어둠비수 마나마귀", Name AC enUS : "Shadowsword Manafiend" ; Wowhead enUS : "Shadowsword Manafiend"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 마나마귀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25483;
-- AC datas : OLD Name : "어둠비수 암살자", Name AC enUS : "Shadowsword Assassin" ; Wowhead enUS : "Shadowsword Assassin"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 암살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25484;
-- AC datas : OLD Name : "어둠비수 죽음의 인도자", Name AC enUS : "Shadowsword Deathbringer" ; Wowhead enUS : "Shadowsword Deathbringer"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 죽음의 인도자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25485;
-- AC datas : OLD Name : "어둠비수 제압자", Name AC enUS : "Shadowsword Vanquisher" ; Wowhead enUS : "Shadowsword Vanquisher"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 제압자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25486;
-- AC datas : OLD Name : "어둠비수 생명술사", Name AC enUS : "Shadowsword Lifeshaper" ; Wowhead enUS : "Shadowsword Lifeshaper"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 생명술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25506;
-- AC datas : OLD Name : "어둠비수 수호병", Name AC enUS : "Shadowsword Guardian" ; Wowhead enUS : "Shadowsword Guardian"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 수호병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25508;
-- AC datas : OLD Name : "녹주석 마법사 사냥꾼", Name AC enUS : "Beryl Mage Hunter" ; Wowhead enUS : "Beryl Mage Hunter"
UPDATE `creature_template_locale` SET `Name` = '녹주석 거점 마법사 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25585;
-- AC datas : OLD Name : "전쟁노래 돌연변이", Name AC enUS : "Warsong Aberration" ; Wowhead enUS : "Warsong Aberration"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 돌연변이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25611;
-- AC datas : OLD Name : "아득골 민병대원", Name AC enUS : "Farshire Militia" ; Wowhead enUS : "Farshire Militia"
UPDATE `creature_template_locale` SET `Name` = '파샤이어 민병대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25617;
-- AC datas : OLD Name : "전쟁노래 돌연변이", Name AC enUS : "Warsong Aberration" ; Wowhead enUS : "Warsong Aberration"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 돌연변이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25625;
-- AC datas : OLD Name : "수도자 엘바돈", Name AC enUS : "Anchorite Elbadon" ; Wowhead enUS : "Anchorite Elbadon"
UPDATE `creature_template_locale` SET `Name` = '수도사 엘바돈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25639;
-- AC datas : OLD Name : "전쟁노래 곡물창고 크레딧", Name AC enUS : "Warsong Grainery Credit" ; Wowhead enUS : "Warsong Grainery Credit"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 곡물창고 크레딧', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25669;
-- AC datas : OLD Name : "전쟁노래 도살장 크레딧", Name AC enUS : "Warsong Slaughterhouse Credit" ; Wowhead enUS : "Warsong Slaughterhouse Credit"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 도살장 크레딧', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25672;
-- AC datas : OLD Name : "이글거리는 불덩이", Name AC enUS : "Scorchling" ; Wowhead enUS : "Scorchling"
UPDATE `creature_template_locale` SET `Name` = '불덩이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25706;
-- AC datas : OLD Name : "전쟁인도자 고어드락", Name AC enUS : "Warbringer Goredrak" ; Wowhead enUS : "Warbringer Goredrak"
UPDATE `creature_template_locale` SET `Name` = '전쟁의 인도자 고어드락', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25712;
-- AC datas : OLD Name : "고대 그림토템 늑대 정령", Name AC enUS : "Ancient Grimtotem Spirit Wolf" ; Wowhead enUS : "Ancient Grimtotem Spirit Wolf"
UPDATE `creature_template_locale` SET `Name` = '고대 그림토템부족 늑대 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25731;
-- AC datas : OLD Name : "징키 윙넛", Name AC enUS : "Jinky Wingnut" ; Wowhead enUS : "Jinky Wingnut"
UPDATE `creature_template_locale` SET `Name` = '진키 윙넛', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25747;
-- AC datas : OLD Name : "대지 고리회 불꽃소환사", Name AC enUS : "Earthen Ring Flamecaller" ; Wowhead enUS : "Earthen Ring Flamecaller"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 불꽃소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25754;
-- AC datas : OLD Name : "어둠비수 광전사", Name AC enUS : "Shadowsword Berserker" ; Wowhead enUS : "Shadowsword Berserker"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25798;
-- AC datas : OLD Name : "어둠비수 분노의 마법사", Name AC enUS : "Shadowsword Fury Mage" ; Wowhead enUS : "Shadowsword Fury Mage"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 분노의 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25799;
-- AC datas : OLD Name : "광기 어린 밀렵꾼", Name AC enUS : "Loot Crazed Poacher" ; Wowhead enUS : "Loot Crazed Poacher"
UPDATE `creature_template_locale` SET `Name` = '광기어린 밀렵꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25806;
-- AC datas : OLD Name : "개조한 경비로봇 57-K", Name AC enUS : "Reprogrammed Sentry-bot 57-K" ; Wowhead enUS : "Reprogrammed Sentry-bot 57-K"
UPDATE `creature_template_locale` SET `Name` = '개조한 보초로봇 57-K', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25823;
-- AC datas : OLD Name : "광기 어린 잠수부", Name AC enUS : "Loot Crazed Diver" ; Wowhead enUS : "Loot Crazed Diver"
UPDATE `creature_template_locale` SET `Name` = '광기어린 잠수부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25836;
-- AC datas : OLD Name : "어둠비수 사령관", Name AC enUS : "Shadowsword Commander" ; Wowhead enUS : "Shadowsword Commander"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25837;
-- AC datas : OLD Name : "지옥수호병 학살자", Name AC enUS : "Felguard Slayer" ; Wowhead enUS : "Felguard Slayer"
UPDATE `creature_template_locale` SET `Name` = '지옥군단병 학살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25864;
-- AC datas : OLD Name : "어둠해안 불꽃감시자", Name AC enUS : "Darkshore Flame Warden" ; Wowhead enUS : "Darkshore Flame Warden"
UPDATE `creature_template_locale` SET `Name` = '어둠의 해안 불꽃감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25893;
-- AC datas : OLD Name : "언덕마루 불꽃감시자", Name AC enUS : "Hillsbrad Flame Warden" ; Wowhead enUS : "Hillsbrad Flame Warden"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 불꽃감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25901;
-- AC datas : OLD Name : "가시덤불 곶 불꽃감시자", Name AC enUS : "Stranglethorn Vale Flame Warden" ; Wowhead enUS : "Stranglethorn Vale Flame Warden"
UPDATE `creature_template_locale` SET `Name` = '가시덤불 골짜기 불꽃감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25915;
-- AC datas : OLD Name : "가시덤불 곶 불꽃지기", Name AC enUS : "Stranglethorn Vale Flame Keeper" ; Wowhead enUS : "Stranglethorn Vale Flame Keeper"
UPDATE `creature_template_locale` SET `Name` = '가시덤불 골짜기 불꽃지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25920;
-- AC datas : OLD Name : "언덕마루 불꽃지기", Name AC enUS : "Hillsbrad Flame Keeper" ; Wowhead enUS : "Hillsbrad Flame Keeper"
UPDATE `creature_template_locale` SET `Name` = '힐스브래드 불꽃지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25935;
-- AC datas : OLD Name : "북부 불모의 땅 불꽃지기", Name AC enUS : "The Barrens Flame Keeper" ; Wowhead enUS : "The Barrens Flame Keeper"
UPDATE `creature_template_locale` SET `Name` = '불모의 땅 불꽃지기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25943;
-- AC datas : OLD Name : "어둠비수 태양샘 수호자", Name AC enUS : "Shadowsword Guardian Sunwell" ; Wowhead enUS : "Shadowsword Guardian Sunwell"
UPDATE `creature_template_locale` SET `Name` = '어둠비수단 태양샘 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25954;
-- AC datas : OLD Name : "대지 고리회 토템", Name AC enUS : "Earthen Ring Totem" ; Wowhead enUS : "Earthen Ring Totem"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 토템', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25961;
-- AC datas : OLD Name : "광기 어린 사냥꾼", Name AC enUS : "Loot Crazed Hunter" ; Wowhead enUS : "Loot Crazed Hunter"
UPDATE `creature_template_locale` SET `Name` = '광기어린 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 25979;
-- AC datas : OLD Name : "길들일 수 있는 맹금", Name AC enUS : "Tamable Bird of Prey" ; Wowhead enUS : "Tamable Bird of Prey"
UPDATE `creature_template_locale` SET `Name` = '길들일 수 있는 올빼미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26028;
-- AC datas : OLD Name : "전쟁노래 검은늑대", Name AC enUS : "Warsong Worg" ; Wowhead enUS : "Warsong Worg"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 요새 검은늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26047;
-- AC datas : OLD Name : "제럴드 그린", Name AC enUS : "Gerald Green" ; Wowhead enUS : "Gerald Green"
UPDATE `creature_template_locale` SET `Name` = '제랄드 그린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26083;
-- AC datas : OLD Name : "웬디 대런", Name AC enUS : "Wendy Darren" ; Wowhead enUS : "Wendy Darren"
UPDATE `creature_template_locale` SET `Name` = '웬디 다렌', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26085;
-- AC datas : OLD Name : "그림토템 늑대 정령", Name AC enUS : "Grimtotem Spirit Wolf" ; Wowhead enUS : "Grimtotem Spirit Wolf"
UPDATE `creature_template_locale` SET `Name` = '그림토템부족 늑대 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26111;
-- AC datas : OLD Name : "아득골 곡식", Name AC enUS : "Farshire Grain Credit" ; Wowhead enUS : "Farshire Grain Credit"
UPDATE `creature_template_locale` SET `Name` = '파샤이어 곡식', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26161;
-- AC datas : OLD Name : "X-51 초강력 황천로켓", Name AC enUS : "X-51 Nether-Rocket X-TREME" ; Wowhead enUS : "X-51 Nether-Rocket X-TREME"
UPDATE `creature_template_locale` SET `Name` = '붉은색 로켓 탈것', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26164;
-- AC datas : OLD Name : "살해된 이교도", Name AC enUS : "Slain Cultist" ; Wowhead enUS : "Slain Cultist"
UPDATE `creature_template_locale` SET `Name` = '살해당한 이교도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26172;
-- AC datas : OLD Name : "X-51 황천로켓", Name AC enUS : "X-51 Nether-Rocket" ; Wowhead enUS : "X-51 Nether-Rocket"
UPDATE `creature_template_locale` SET `Name` = '푸른색 로켓 탈것', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26192;
-- AC datas : OLD Name : "눈사태 숲 약탈꾼", Name AC enUS : "Snowfall Glade Reaver" ; Wowhead enUS : "Snowfall Glade Reaver"
UPDATE `creature_template_locale` SET `Name` = '눈사태숲일족 약탈꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26197;
-- AC datas : OLD Name : "눈사태 숲 울바르", Name AC enUS : "Snowfall Glade Wolvar" ; Wowhead enUS : "Snowfall Glade Wolvar"
UPDATE `creature_template_locale` SET `Name` = '눈사태숲일족 울바르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26198;
-- AC datas : OLD Name : "눈사태 숲 우두머리", Name AC enUS : "Snowfall Glade Den Mother" ; Wowhead enUS : "Snowfall Glade Den Mother"
UPDATE `creature_template_locale` SET `Name` = '눈사태숲일족 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26199;
-- AC datas : OLD Name : "눈사태 숲 새끼 울바르", Name AC enUS : "Snowfall Glade Pup" ; Wowhead enUS : "Snowfall Glade Pup"
UPDATE `creature_template_locale` SET `Name` = '눈사태숲일족 새끼 울바르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26200;
-- AC datas : OLD Name : "눈사태 숲 주술사", Name AC enUS : "Snowfall Glade Shaman" ; Wowhead enUS : "Snowfall Glade Shaman"
UPDATE `creature_template_locale` SET `Name` = '눈사태숲일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26201;
-- AC datas : OLD Name : "대지 고리회 장로", Name AC enUS : "Earthen Ring Elder" ; Wowhead enUS : "Earthen Ring Elder",  OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Name` = '속세의 고리회 장로', `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26221;
-- AC datas : OLD Name : "병사 펄브라우", Name AC enUS : "Private Furlbrow" ; Wowhead enUS : "Private Furlbrow"
UPDATE `creature_template_locale` SET `Name` = '병사 펄브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26235;
-- AC datas : OLD Name : "샤트라스 차원문", Name AC enUS : "Shattrath Portal Dummy" ; Wowhead enUS : "Shattrath Portal Dummy"
UPDATE `creature_template_locale` SET `Name` = '샤트라스 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26251;
-- AC datas : OLD Name : "샤트라스 차원문", Name AC enUS : "Shattrath Portal" ; Wowhead enUS : "Shattrath Portal"
UPDATE `creature_template_locale` SET `Name` = '샤트라스 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26255;
-- AC datas : OLD Name : "무쇠룬 룬세공사", Name AC enUS : "Iron Rune-Shaper" ; Wowhead enUS : "Iron Rune-Shaper"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 룬세공사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26270;
-- AC datas : OLD Name : "판금 방어구 상인", Name AC enUS : "Mail & Plate Armor Vendor" ; Wowhead enUS : "Mail & Plate Armor Vendor"
UPDATE `creature_template_locale` SET `Name` = '가죽 방어구 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26305;
-- AC datas : OLD Name : "가죽 방어구 상인", Name AC enUS : "Cloth Glyph Vendor" ; Wowhead enUS : "Cloth Glyph Vendor"
UPDATE `creature_template_locale` SET `Name` = '사슬 방어구 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26306;
-- AC datas : OLD Name : "사슬 방어구 상인", Name AC enUS : "Leather & Mail Glyph Vendor" ; Wowhead enUS : "Leather & Mail Glyph Vendor"
UPDATE `creature_template_locale` SET `Name` = '판금 방어구 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26308;
-- AC datas : OLD Name : "싸움꾼 조크 토크렌치", Name AC enUS : "Big Zokk Torquewrench" ; Wowhead enUS : "Big Zokk Torquewrench"
UPDATE `creature_template_locale` SET `Name` = '싸움꾼 조크 토르크렌치', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26352;
-- AC datas : OLD Name : "붉은이빨 사냥꾼", Name AC enUS : "Redfang Hunter" ; Wowhead enUS : "Redfang Hunter"
UPDATE `creature_template_locale` SET `Name` = '붉은송곳니일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26356;
-- AC datas : OLD Name : "서리발톱 전사", Name AC enUS : "Frostpaw Warrior" ; Wowhead enUS : "Frostpaw Warrior"
UPDATE `creature_template_locale` SET `Name` = '서리발톱일족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26357;
-- AC datas : OLD Name : "부관 트리스티아", Name AC enUS : "Lieutenant Tristia" ; Wowhead enUS : "Lieutenant Tristia"
UPDATE `creature_template_locale` SET `Name` = '부관 트리시아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26395;
-- AC datas : OLD Name : "도리스 볼란티우스", Name AC enUS : "Doris Volanthius" ; Wowhead enUS : "Doris Volanthius"
UPDATE `creature_template_locale` SET `Name` = '도리스 볼란시우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26398;
-- AC datas : OLD Name : "무쇠룬 룬대장장이", Name AC enUS : "Iron Rune-Smith" ; Wowhead enUS : "Iron Rune-Smith"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 룬대장장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26408;
-- AC datas : OLD Name : "광기 어린 인두르 주민", Name AC enUS : "Deranged Indu'le Villager" ; Wowhead enUS : "Deranged Indu'le Villager"
UPDATE `creature_template_locale` SET `Name` = '광기어린 인두르 주민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26411;
-- AC datas : OLD Name : "서리발톱 주술사", Name AC enUS : "Frostpaw Shaman" ; Wowhead enUS : "Frostpaw Shaman"
UPDATE `creature_template_locale` SET `Name` = '서리발톱일족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26428;
-- AC datas : OLD Name : "서리발톱 덫사냥꾼", Name AC enUS : "Frostpaw Trapper" ; Wowhead enUS : "Frostpaw Trapper"
UPDATE `creature_template_locale` SET `Name` = '서리발톱일족 덫사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26434;
-- AC datas : OLD Name : "붉은이빨 장로", Name AC enUS : "Redfang Elder" ; Wowhead enUS : "Redfang Elder"
UPDATE `creature_template_locale` SET `Name` = '붉은송곳니일족 장로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26436;
-- AC datas : OLD Name : "검은 전투 엘레크", Name AC enUS : "Black War Elekk" ; Wowhead enUS : "Black War Elekk"
UPDATE `creature_template_locale` SET `Name` = '검은색 전투 엘레크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26439;
-- AC datas : OLD Name : "밀사 스카이헤이븐", Name AC enUS : "Emissary Skyhaven" ; Wowhead enUS : "Emissary Skyhaven"
UPDATE `creature_template_locale` SET `Name` = '밀사 스카이하벤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26440;
-- AC datas : OLD Name : "달쉼터 정원 명가", Name AC enUS : "Moonrest Highborne" ; Wowhead enUS : "Moonrest Highborne"
UPDATE `creature_template_locale` SET `Name` = '달쉼터 정원 귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26455;
-- AC datas : OLD Name : "바퀴벌레", Name AC enUS : "Cockroach" ; Wowhead enUS : "Cockroach"
UPDATE `creature_template_locale` SET `Name` = '바퀴', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26525;
-- AC datas : OLD Name : "바실 크로", Name AC enUS : "Basil Crowe" ; Wowhead enUS : "Basil Crowe"
UPDATE `creature_template_locale` SET `Name` = '바실 크로우위', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26547;
-- AC datas : OLD Name : "용약탈 죽음의수색꾼", Name AC enUS : "Dragonflayer Deathseeker" ; Wowhead enUS : "Dragonflayer Deathseeker"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 죽음의수색꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26550;
-- AC datas : OLD Name : "용약탈 광신자", Name AC enUS : "Dragonflayer Fanatic" ; Wowhead enUS : "Dragonflayer Fanatic"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 광신자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26553;
-- AC datas : OLD Name : "용약탈 현자", Name AC enUS : "Dragonflayer Seer" ; Wowhead enUS : "Dragonflayer Seer"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 현자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26554;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26564;
-- AC datas : OLD Subname : "약초채집용품 및 독극물 상인", Subname AC enUS : "Herbalism & Poison Supplies" ; Wowhead enUS : "Herbalism & Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 및 독극물 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26568;
-- AC datas : OLD Name : "눈신 토끼", Name AC enUS : "Snowshoe Hare" ; Wowhead enUS : "Snowshoe Hare"
UPDATE `creature_template_locale` SET `Name` = '눈덧신 토끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26614;
-- AC datas : OLD Name : "피즈크랭크 공수부대원", Name AC enUS : "Fizzcrank Paratrooper" ; Wowhead enUS : "Fizzcrank Paratrooper"
UPDATE `creature_template_locale` SET `Name` = '피즈크랭크 낙하산병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26619;
-- AC datas : OLD Name : "용약탈 구경꾼", Name AC enUS : "Dragonflayer Spectator" ; Wowhead enUS : "Dragonflayer Spectator"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 구경꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26667;
-- AC datas : OLD Name : "전쟁노래 전투 깃발", Name AC enUS : "Warsong Battle Standard" ; Wowhead enUS : "Warsong Battle Standard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투 깃발', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26678;
-- AC datas : OLD Name : "거대한 요르문가르", Name AC enUS : "Massive Jormungar" ; Wowhead enUS : "Massive Jormungar"
UPDATE `creature_template_locale` SET `Name` = '거대 요르문가르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26685;
-- AC datas : OLD Name : "사나운 털북숭이 코뿔소", Name AC enUS : "Ferocious Rhino" ; Wowhead enUS : "Ferocious Rhino"
UPDATE `creature_template_locale` SET `Name` = '사나운 털복숭이 코뿔소', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26686;
-- AC datas : OLD Name : "광기 어린 마나 정령", Name AC enUS : "Crazed Mana-Surge" ; Wowhead enUS : "Crazed Mana-Surge"
UPDATE `creature_template_locale` SET `Name` = '광기어린 마나 정령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26737;
-- AC datas : OLD Name : "광기 어린 마나 망령", Name AC enUS : "Crazed Mana-Wraith" ; Wowhead enUS : "Crazed Mana-Wraith"
UPDATE `creature_template_locale` SET `Name` = '광기어린 마나 망령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26746;
-- AC datas : OLD Name : "광기 어린 마나지룡", Name AC enUS : "Crazed Mana-Wyrm" ; Wowhead enUS : "Crazed Mana-Wyrm"
UPDATE `creature_template_locale` SET `Name` = '광기어린 마나지룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26761;
-- AC datas : OLD Subname : "검은무쇠 양조장 여조수", Subname AC enUS : "Dark Iron Brewmaiden" ; Wowhead enUS : "Dark Iron Brewmaiden"
UPDATE `creature_template_locale` SET `Title` = '검은무쇠단 양조장 여조수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26764;
-- AC datas : OLD Name : "무쇠룬 복수자", Name AC enUS : "Iron Rune Avenger" ; Wowhead enUS : "Iron Rune Avenger"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 복수자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26786;
-- AC datas : OLD Name : "무쇠룬 룬주문술사", Name AC enUS : "Iron Rune-Weaver" ; Wowhead enUS : "Iron Rune-Weaver"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 룬주문술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26820;
-- AC datas : OLD Subname : "검은무쇠 양조장 여조수", Subname AC enUS : "Dark Iron Brewmaiden" ; Wowhead enUS : "Dark Iron Brewmaiden"
UPDATE `creature_template_locale` SET `Title` = '검은무쇠단 양조장 여조수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26822;
-- AC datas : OLD Name : "검은창 용사냥꾼", Name AC enUS : "Darkspear Dragon Hunter" ; Wowhead enUS : "Darkspear Dragon Hunter"
UPDATE `creature_template_locale` SET `Name` = '검은창부족 용사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26870;
-- AC datas : OLD Name : "레가르 브레이크브라우", Name AC enUS : "Raegar Breakbrow" ; Wowhead enUS : "Raegar Breakbrow"
UPDATE `creature_template_locale` SET `Name` = '레가르 브레이크브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26883;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26901;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26903;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26904;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26905;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26906;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineering Trainer" ; Wowhead enUS : "Grand Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26907;
-- AC datas : OLD Subname : "전문 낚시꾼", Subname AC enUS : "Grand Master Fishing Trainer" ; Wowhead enUS : "Grand Master Fishing Trainer"
UPDATE `creature_template_locale` SET `Title` = '낚시의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26909;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Grand Master Herbalism Trainer" ; Wowhead enUS : "Grand Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26910;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworking Trainer" ; Wowhead enUS : "Grand Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26911;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Grand Master Mining Trainer" ; Wowhead enUS : "Grand Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26912;
-- AC datas : OLD Name : "프레더릭 버러스", Name AC enUS : "Frederic Burrhus" ; Wowhead enUS : "Frederic Burrhus",  OLD Subname : "전문 무두장이", Subname AC enUS : "Grand Master Skinning Trainer" ; Wowhead enUS : "Grand Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Name` = '프레데릭 버러스', `Title` = '무두질의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26913;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26914;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26915;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26916;
-- AC datas : OLD Name : "젠드리 베놈터스크", Name AC enUS : "Zend'li Venomtusk" ; Wowhead enUS : "Zend'li Venomtusk"
UPDATE `creature_template_locale` SET `Name` = '젠드리 베놈투스크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26945;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26951;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26952;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26953;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26954;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineering Trainer" ; Wowhead enUS : "Grand Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26955;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26956;
-- AC datas : OLD Subname : "전문 낚시꾼", Subname AC enUS : "Grand Master Fishing Trainer" ; Wowhead enUS : "Grand Master Fishing Trainer"
UPDATE `creature_template_locale` SET `Title` = '낚시의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26957;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Grand Master Herbalism Trainer" ; Wowhead enUS : "Grand Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26958;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26959;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26960;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworking Trainer" ; Wowhead enUS : "Grand Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26961;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Grand Master Mining Trainer" ; Wowhead enUS : "Grand Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26962;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Grand Master Skinning Trainer" ; Wowhead enUS : "Grand Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26963;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26964;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26969;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26972;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Grand Master Herbalism Trainer" ; Wowhead enUS : "Grand Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26974;
-- AC datas : OLD Name : "아서 헨슬로", Name AC enUS : "Arthur Henslowe" ; Wowhead enUS : "Arthur Henslowe",  OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Name` = '아서 헨슬로위', `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26975;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Grand Master Mining Trainer" ; Wowhead enUS : "Grand Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26976;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26977;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26980;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26981;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26982;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Grand Master Skinning Trainer" ; Wowhead enUS : "Grand Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26986;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26987;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26988;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26989;
-- AC datas : OLD Name : "알렉시스 말로", Name AC enUS : "Alexis Marlowe" ; Wowhead enUS : "Alexis Marlowe",  OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Name` = '알렉시스 말로위', `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26990;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineering Trainer" ; Wowhead enUS : "Grand Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26991;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26992;
-- AC datas : OLD Subname : "전문 낚시꾼", Subname AC enUS : "Grand Master Fishing Trainer" ; Wowhead enUS : "Grand Master Fishing Trainer"
UPDATE `creature_template_locale` SET `Title` = '낚시의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26993;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Grand Master Herbalism Trainer" ; Wowhead enUS : "Grand Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26994;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26995;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworker" ; Wowhead enUS : "Grand Master Leatherworker"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26996;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26997;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworking Trainer" ; Wowhead enUS : "Grand Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26998;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Grand Master Mining Trainer" ; Wowhead enUS : "Grand Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 26999;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Grand Master Skinning Trainer" ; Wowhead enUS : "Grand Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27000;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27001;
-- AC datas : OLD Name : "핏빛달 늑대인간", Name AC enUS : "Bloodmoon Worgen" ; Wowhead enUS : "Bloodmoon Worgen"
UPDATE `creature_template_locale` SET `Name` = '핏빛달일족 늑대인간', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27020;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27023;
-- AC datas : OLD Name : "핏빛달 이교도", Name AC enUS : "Bloodmoon Cultist" ; Wowhead enUS : "Bloodmoon Cultist"
UPDATE `creature_template_locale` SET `Name` = '핏빛달일족 이교도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27024;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27029;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27034;
-- AC datas : OLD Name : "원한의 초소 죽음경비병", Name AC enUS : "Venomspite Deathguard" ; Wowhead enUS : "Venomspite Deathguard"
UPDATE `creature_template_locale` SET `Name` = '원한의 초소 죽음의경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27035;
-- AC datas : OLD Subname : "약초채집용품 및 독극물 상인", Subname AC enUS : "Herbalism & Poison Supplies" ; Wowhead enUS : "Herbalism & Poison Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 및 독극물 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27053;
-- AC datas : OLD Name : "부상당한 전쟁노래 전사", Name AC enUS : "Injured Warsong Warrior" ; Wowhead enUS : "Injured Warsong Warrior"
UPDATE `creature_template_locale` SET `Name` = '부상당한 전쟁노래부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27106;
-- AC datas : OLD Name : "부상당한 전쟁노래 마법사", Name AC enUS : "Injured Warsong Mage" ; Wowhead enUS : "Injured Warsong Mage"
UPDATE `creature_template_locale` SET `Name` = '부상당한 전쟁노래부족 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27107;
-- AC datas : OLD Name : "부상당한 전쟁노래 주술사", Name AC enUS : "Injured Warsong Shaman" ; Wowhead enUS : "Injured Warsong Shaman"
UPDATE `creature_template_locale` SET `Name` = '부상당한 전쟁노래부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27108;
-- AC datas : OLD Name : "부상당한 전쟁노래 기술자", Name AC enUS : "Injured Warsong Engineer" ; Wowhead enUS : "Injured Warsong Engineer"
UPDATE `creature_template_locale` SET `Name` = '부상당한 전쟁노래부족 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27110;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27141;
-- AC datas : OLD Name : "약해진 달쉼터 정원 명가", Name AC enUS : "Drained Moonrest Highborne" ; Wowhead enUS : "Drained Moonrest Highborne"
UPDATE `creature_template_locale` SET `Name` = '약해진 달쉼터 정원 귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27165;
-- AC datas : OLD Name : "흑맥주요정", Name AC enUS : "The Black Brewmaiden" ; Wowhead enUS : "The Black Brewmaiden"
UPDATE `creature_template_locale` SET `Name` = '검은 양조장 여조수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27169;
-- AC datas : OLD Name : "무쇠룬 감독관", Name AC enUS : "Iron Rune Overseer" ; Wowhead enUS : "Iron Rune Overseer"
UPDATE `creature_template_locale` SET `Name` = '무쇠룬부족 감독관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27177;
-- AC datas : OLD Name : "고문관 리크래프트", Name AC enUS : "Torturer LeCraft" ; Wowhead enUS : "Torturer Alphonse"
UPDATE `creature_template_locale` SET `Name` = '고문관 알폰스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27209;
-- AC datas : OLD Name : "용약탈 불꽃술사", Name AC enUS : "Dragonflayer Flamebinder" ; Wowhead enUS : "Dragonflayer Flamebinder"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 불꽃술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27259;
-- AC datas : OLD Name : "용약탈 정예병", Name AC enUS : "Dragonflayer Huscarl" ; Wowhead enUS : "Dragonflayer Huscarl"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27260;
-- AC datas : OLD Name : "수습생 버논", Name AC enUS : "Initiate Vernon" ; Wowhead enUS : "Initiate Vernon"
UPDATE `creature_template_locale` SET `Name` = '수습생 베르논', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27300;
-- AC datas : OLD Name : "죽음경비병 몰더", Name AC enUS : "Deathguard Molder" ; Wowhead enUS : "Deathguard Molder"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 몰더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27320;
-- AC datas : OLD Name : "첩보단장 레피네", Name AC enUS : "Spy Mistress Repine" ; Wowhead enUS : "Spy Mistress Repine"
UPDATE `creature_template_locale` SET `Name` = '비밀요원 레피네', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27337;
-- AC datas : OLD Name : "아델라인 챔버스", Name AC enUS : "Bat Handler Adeline" ; Wowhead enUS : "Bat Handler Adeline"
UPDATE `creature_template_locale` SET `Name` = '박쥐 조련사 아델라인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27344;
-- AC datas : OLD Name : "죽음경비병 슈나이더", Name AC enUS : "Deathguard Schneider" ; Wowhead enUS : "Deathguard Schneider"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 슈나이더', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27376;
-- AC datas : OLD Name : "상급 서기관 바리가", Name AC enUS : "Senior Scrivener Barriga" ; Wowhead enUS : "Senior Scrivener Kinnedius"
UPDATE `creature_template_locale` SET `Name` = '상급 서기관 키네디우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27378;
-- AC datas : OLD Name : "골둔", Name AC enUS : "Gordun" ; Wowhead enUS : "Gordun"
UPDATE `creature_template_locale` SET `Name` = '고르둔', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27414;
-- AC datas : OLD Name : "전쟁노래 요새 일꾼", Name AC enUS : "Warsong Hold Peon" ; Wowhead enUS : "Warsong Hold Peon"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27432;
-- AC datas : OLD Name : "전쟁노래 정예병", Name AC enUS : "Warsong Elite" ; Wowhead enUS : "Warsong Elite"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27557;
-- AC datas : OLD Name : "전쟁노래 일꾼", Name AC enUS : "Warsong Peon" ; Wowhead enUS : "Warsong Peon"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27558;
-- AC datas : OLD Name : "검은창 작살병", Name AC enUS : "Darkspear Spear Thrower" ; Wowhead enUS : "Darkspear Spear Thrower"
UPDATE `creature_template_locale` SET `Name` = '검은창부족 작살병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27560;
-- AC datas : OLD Name : "구르토", Name AC enUS : "Gurtor" ; Wowhead enUS : "Gurtor"
UPDATE `creature_template_locale` SET `Name` = '거트로', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27565;
-- AC datas : OLD Name : "군주 아프라사스트라즈", Name AC enUS : "Lord Afrasastrasz" ; Wowhead enUS : "Lord Devrestrasz"
UPDATE `creature_template_locale` SET `Name` = '군주 데브레스트라즈', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27575;
-- AC datas : OLD Name : "시장 고드프리", Name AC enUS : "Mayor Godfrey" ; Wowhead enUS : "Mayor Godfrey"
UPDATE `creature_template_locale` SET `Name` = '시장 고드프레이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27577;
-- AC datas : OLD Name : "전쟁노래 주술사", Name AC enUS : "Warsong Shaman" ; Wowhead enUS : "Warsong Shaman"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27678;
-- AC datas : OLD Name : "로리엘 트루블레이드", Name AC enUS : "Lauriel Trueblade" ; Wowhead enUS : "Lauriel Trueblade"
UPDATE `creature_template_locale` SET `Name` = '라우리엘 트루블레이드', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27803;
-- AC datas : OLD Name : "골룩 록피스트", Name AC enUS : "Golluck Rockfist" ; Wowhead enUS : "Golluck Rockfist"
UPDATE `creature_template_locale` SET `Name` = '골루크 록피스트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27804;
-- AC datas : OLD Name : "펜릭 발로", Name AC enUS : "Fenrick Barlowe" ; Wowhead enUS : "Fenrick Barlowe"
UPDATE `creature_template_locale` SET `Name` = '펜릭 발로위', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27842;
-- AC datas : OLD Name : "검은그물 희생자", Name AC enUS : "Darkweb Victim" ; Wowhead enUS : "Darkweb Victim"
UPDATE `creature_template_locale` SET `Name` = '어둠그물 희생자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27909;
-- AC datas : OLD Name : "암흑룬 전사", Name AC enUS : "Dark Rune Warrior" ; Wowhead enUS : "Dark Rune Warrior"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27960;
-- AC datas : OLD Name : "암흑룬 노동자", Name AC enUS : "Dark Rune Worker" ; Wowhead enUS : "Dark Rune Worker"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 노동자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27961;
-- AC datas : OLD Name : "암흑룬 정령술사", Name AC enUS : "Dark Rune Elementalist" ; Wowhead enUS : "Dark Rune Elementalist"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 정령술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27962;
-- AC datas : OLD Name : "암흑룬 사술사", Name AC enUS : "Dark Rune Theurgist" ; Wowhead enUS : "Dark Rune Theurgist"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 사술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27963;
-- AC datas : OLD Name : "암흑룬 학자", Name AC enUS : "Dark Rune Scholar" ; Wowhead enUS : "Dark Rune Scholar"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 학자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27964;
-- AC datas : OLD Name : "암흑룬 구체자", Name AC enUS : "Dark Rune Shaper" ; Wowhead enUS : "Dark Rune Shaper"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 구체자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27965;
-- AC datas : OLD Name : "암흑룬 감시자", Name AC enUS : "Dark Rune Controller" ; Wowhead enUS : "Dark Rune Controller"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 감시자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27966;
-- AC datas : OLD Name : "암흑룬 파수병", Name AC enUS : "Dark Rune Protector" ; Wowhead enUS : "Dark Rune Protector"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 파수병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27983;
-- AC datas : OLD Name : "암흑룬 폭풍소환사", Name AC enUS : "Dark Rune Stormcaller" ; Wowhead enUS : "Dark Rune Stormcaller"
UPDATE `creature_template_locale` SET `Name` = '암흑룬부족 폭풍소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27984;
-- AC datas : OLD Name : "공포퓨마", Name AC enUS : "Dreadsaber" ; Wowhead enUS : "Dreadsaber"
UPDATE `creature_template_locale` SET `Name` = '공포의 호랑이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28001;
-- AC datas : OLD Name : "퍼서 볼리안", Name AC enUS : "Purser Boulian" ; Wowhead enUS : "Purser Boulian"
UPDATE `creature_template_locale` SET `Name` = '퍼서 바울리안', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28038;
-- AC datas : OLD Subname : "남쪽 바다 무법자", Subname AC enUS : "Scourge of the South Seas" ; Wowhead enUS : "Scourge of the South Seas"
UPDATE `creature_template_locale` SET `Title` = '남쪽바다 무법자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28048;
-- AC datas : OLD Name : "사술사 우분고", Name AC enUS : "Hexxer Ubungo" ; Wowhead enUS : "Hexxer Ubungo"
UPDATE `creature_template_locale` SET `Name` = '주술사 우분고', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28062;
-- AC datas : OLD Name : "검은무쇠 양조장이", Name AC enUS : "Dark Iron Brewer" ; Wowhead enUS : "Dark Iron Brewer"
UPDATE `creature_template_locale` SET `Name` = '검은무쇠단 양조장이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28067;
-- AC datas : OLD Name : "광란심장 광전사", Name AC enUS : "Frenzyheart Berserker" ; Wowhead enUS : "Frenzyheart Berserker"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28076;
-- AC datas : OLD Name : "광란심장 추적자", Name AC enUS : "Frenzyheart Tracker" ; Wowhead enUS : "Frenzyheart Tracker"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28077;
-- AC datas : OLD Name : "광란심장 약탈자", Name AC enUS : "Frenzyheart Ravager" ; Wowhead enUS : "Frenzyheart Ravager"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28078;
-- AC datas : OLD Name : "광란심장 사냥꾼", Name AC enUS : "Frenzyheart Hunter" ; Wowhead enUS : "Frenzyheart Hunter"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28079;
-- AC datas : OLD Name : "광란심장 창잡이", Name AC enUS : "Frenzyheart Spearbearer" ; Wowhead enUS : "Frenzyheart Spearbearer"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 창잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28080;
-- AC datas : OLD Name : "광란심장 청소부", Name AC enUS : "Frenzyheart Scavenger" ; Wowhead enUS : "Frenzyheart Scavenger"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 청소부', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28081;
-- AC datas : OLD Name : "광란심장 새끼", Name AC enUS : "Frenzyheart Pup" ; Wowhead enUS : "Frenzyheart Pup"
UPDATE `creature_template_locale` SET `Name` = '광란의심장일족 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28139;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28176;
-- AC datas : OLD Name : "레인", Name AC enUS : "Rayne" ; Wowhead enUS : "Rayne"
UPDATE `creature_template_locale` SET `Name` = '레이네', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28177;
-- AC datas : OLD Name : "연금술사 핑클스타인", Name AC enUS : "Alchemist Finklestein" ; Wowhead enUS : "Alchemist Finklestein"
UPDATE `creature_template_locale` SET `Name` = '연금술사 핀클스타인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28205;
-- AC datas : OLD Name : "핑클스타인의 가마솥", Name AC enUS : "Finklestein's Cauldron Bunny" ; Wowhead enUS : "Finklestein's Cauldron Bunny"
UPDATE `creature_template_locale` SET `Name` = '핀클스타인의 가마솥', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28240;
-- AC datas : OLD Name : "몬테규 크롤", Name AC enUS : "Montegue Krole" ; Wowhead enUS : "Montegue Krole"
UPDATE `creature_template_locale` SET `Name` = '몬테그 크롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28262;
-- AC datas : OLD Name : "광란심장 언덕", Name AC enUS : "Frenzyheart Hill Bunny" ; Wowhead enUS : "Frenzyheart Hill Bunny"
UPDATE `creature_template_locale` SET `Name` = '광란의심장 언덕', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28299;
-- AC datas : OLD Name : "포세이큰 역병살포자", Name AC enUS : "(Wrathgate Monster) Forsaken Blightspreader (Gas Mask)" ; Wowhead enUS : "(Wrathgate Monster) Forsaken Blightspreader (Gas Mask)"
UPDATE `creature_template_locale` SET `Name` = '포세이큰 파멸의 역병 살포자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28348;
-- AC datas : OLD Name : "이교도 침투요원", Name AC enUS : "Cultist Infiltrator" ; Wowhead enUS : "Cultist Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '이교도 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28373;
-- AC datas : OLD Name : "하르코안 정복자", Name AC enUS : "Har'koan Subduer" ; Wowhead enUS : "Har'koan Subduer"
UPDATE `creature_template_locale` SET `Name` = '하르코아 정복자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28403;
-- AC datas : OLD Name : "용약탈 심령술사", Name AC enUS : "Dragonflayer Spiritualist" ; Wowhead enUS : "Dragonflayer Spiritualist"
UPDATE `creature_template_locale` SET `Name` = '용약탈부족 심령술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28410;
-- AC datas : OLD Name : "붉은십자군 성전사", Name AC enUS : "Scarlet Crusader" ; Wowhead enUS : "Scarlet Crusader"
UPDATE `creature_template_locale` SET `Name` = '십자군 성전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28529;
-- AC datas : OLD Name : "고문관 리크래프트", Name AC enUS : "Torturer LeCraft" ; Wowhead enUS : "Torturer Alphonse"
UPDATE `creature_template_locale` SET `Name` = '고문관 알폰스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28554;
-- AC datas : OLD Name : "물기둥", Name AC enUS : "Water Spout" ; Wowhead enUS : "Water Spout"
UPDATE `creature_template_locale` SET `Name` = '물 분출', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28567;
-- AC datas : OLD Name : "안식골 시민", Name AC enUS : "Citizen of Havenshire" ; Wowhead enUS : "Citizen of Havenshire"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 시민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28576;
-- AC datas : OLD Name : "안식골 시민", Name AC enUS : "Citizen of Havenshire" ; Wowhead enUS : "Citizen of Havenshire"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 시민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28577;
-- AC datas : OLD Name : "속박 풀린 화염폭풍", Name AC enUS : "Unbound Firestorm" ; Wowhead enUS : "Unbound Firestorm"
UPDATE `creature_template_locale` SET `Name` = '속박이 풀린 화염폭풍', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28584;
-- AC datas : OLD Name : "안식골 황토마", Name AC enUS : "Havenshire Stallion" ; Wowhead enUS : "Havenshire Stallion"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 황토마', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28605;
-- AC datas : OLD Name : "안식골 암말", Name AC enUS : "Havenshire Mare" ; Wowhead enUS : "Havenshire Mare"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 암말', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28606;
-- AC datas : OLD Name : "안식골 망아지", Name AC enUS : "Havenshire Colt" ; Wowhead enUS : "Havenshire Colt"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 망아지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28607;
-- AC datas : OLD Name : "붉은십자군 그리핀 기수", Name AC enUS : "Scarlet Gryphon Rider" ; Wowhead enUS : "Scarlet Gryphon Rider"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 그리핀기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28616;
-- AC datas : OLD Name : "안식골 시민", Name AC enUS : "Citizen of Havenshire" ; Wowhead enUS : "Citizen of Havenshire"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 시민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28660;
-- AC datas : OLD Name : "안식골 시민", Name AC enUS : "Citizen of Havenshire" ; Wowhead enUS : "Citizen of Havenshire"
UPDATE `creature_template_locale` SET `Name` = '헤이븐샤이어 시민', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28662;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28693;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28694;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Grand Master Skinning Trainer" ; Wowhead enUS : "Grand Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28696;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineering Trainer" ; Wowhead enUS : "Grand Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28697;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Grand Master Mining Trainer" ; Wowhead enUS : "Grand Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28698;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28699;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworking Trainer" ; Wowhead enUS : "Grand Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28700;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28701;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28702;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28703;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Grand Master Herbalism Trainer" ; Wowhead enUS : "Grand Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28704;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28705;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28706;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28727;
-- AC datas : OLD Subname : "전문 낚시꾼 및 낚시용품 상인", Subname AC enUS : "Grand Master Fishing Trainer & Supplies" ; Wowhead enUS : "Grand Master Fishing Trainer & Supplies"
UPDATE `creature_template_locale` SET `Title` = '낚시의 거장 및 낚시용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28742;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Cold Weather Flying Trainer" ; Wowhead enUS : "Cold Weather Flying Trainer"
UPDATE `creature_template_locale` SET `Title` = '극지 비행 훈련교관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28746;
-- AC datas : OLD Name : "절름발이 하르거스", Name AC enUS : "Hargus the Gimp" ; Wowhead enUS : "Hargus the Geist"
UPDATE `creature_template_locale` SET `Name` = '유령 하르거스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28760;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28800;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28813;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28828;
-- AC datas : OLD Subname : "약초채집용품 상인", Subname AC enUS : "Herbalism Supplies" ; Wowhead enUS : "Herbalism Supplies"
UPDATE `creature_template_locale` SET `Title` = '연금술용품 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28868;
-- AC datas : OLD Name : "납골당 수호자", Name AC enUS : "Crypt Guardian" ; Wowhead enUS : "Crypt Guardian"
UPDATE `creature_template_locale` SET `Name` = '지하 수호자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28937;
-- AC datas : OLD Name : "붉은십자군 성전사", Name AC enUS : "Scarlet Crusader" ; Wowhead enUS : "Scarlet Crusader"
UPDATE `creature_template_locale` SET `Name` = '십자군 성전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28940;
-- AC datas : OLD Name : "붉은십자군 군주 제세리아 맥크리", Name AC enUS : "Scarlet Lord Jesseriah McCree" ; Wowhead enUS : "Scarlet Lord Borugh"
UPDATE `creature_template_locale` SET `Name` = '붉은십자군 군주 보루', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28964;
-- AC datas : OLD Name : "발레리 랭롬", Name AC enUS : "Valerie Langrom" ; Wowhead enUS : "Valerie Langrom"
UPDATE `creature_template_locale` SET `Name` = '발레리 랭그롬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28992;
-- AC datas : OLD Subname : "활 상인", Subname AC enUS : "Fletcher" ; Wowhead enUS : "Fletcher"
UPDATE `creature_template_locale` SET `Title` = '화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29014;
-- AC datas : OLD Subname : "마법 재료 및 독극물 상인", Subname AC enUS : "Reagents & Poisons" ; Wowhead enUS : "Reagents & Poisons"
UPDATE `creature_template_locale` SET `Title` = '마법 및 독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29015;
-- AC datas : OLD Name : "항구일꾼", Name AC enUS : "Dockhand" ; Wowhead enUS : "Dockhand"
UPDATE `creature_template_locale` SET `Name` = '부두 일꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29019;
-- AC datas : OLD Subname : "마법 재료 및 독극물 상인", Subname AC enUS : "Reagents & Poisons" ; Wowhead enUS : "Reagents & Poisons"
UPDATE `creature_template_locale` SET `Title` = '마법 및 독극물 재료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29037;
-- AC datas : OLD Name : "핏빛달 하수인", Name AC enUS : "Bloodmoon Servant" ; Wowhead enUS : "Bloodmoon Servant"
UPDATE `creature_template_locale` SET `Name` = '핏빛달일족 하수인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29082;
-- AC datas : OLD Name : "이언 드레이크", Name AC enUS : "Ian Drake" ; Wowhead enUS : "Ian Drake"
UPDATE `creature_template_locale` SET `Name` = '이안 드레이크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29093;
-- AC datas : OLD Name : "펠라 브라스브러시", Name AC enUS : "Pella Brassbrush" ; Wowhead enUS : "Pella Brassbrush"
UPDATE `creature_template_locale` SET `Name` = '펠라 브라스브러쉬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29141;
-- AC datas : OLD Name : "레인", Name AC enUS : "Rayne" ; Wowhead enUS : "Rayne"
UPDATE `creature_template_locale` SET `Name` = '레이네', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29181;
-- AC datas : OLD Name : "제4장 허수아비", Name AC enUS : "[Chapter IV] Chapter IV Dummy" ; Wowhead enUS : "[Chapter IV] Chapter IV Dummy"
UPDATE `creature_template_locale` SET `Name` = '제 4장 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29192;
-- AC datas : OLD Subname : "마법 재료 상인", Subname AC enUS : "Corpse Dust Vendor" ; Wowhead enUS : "Corpse Dust Vendor"
UPDATE `creature_template_locale` SET `Title` = '시체 가루 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29203;
-- AC datas : OLD Name : "어둠의 영역으로 통하는 차원문", Name AC enUS : "Portal to the Shadow Realm" ; Wowhead enUS : "Portal to the Shadow Realm"
UPDATE `creature_template_locale` SET `Name` = '어둠의 영역으로 통하는 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29218;
-- AC datas : OLD Name : "비글스워스 씨의 환영", Name AC enUS : "Image of Mr. Bigglesworth" ; Wowhead enUS : "Image of Mr. Bigglesworth"
UPDATE `creature_template_locale` SET `Name` = '비글스워스씨의 환영', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29223;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29233;
-- AC datas : OLD Name : "마력의 구슬", Name AC enUS : "Ethereal Sphere" ; Wowhead enUS : "Ethereal Sphere"
UPDATE `creature_template_locale` SET `Name` = '실체 없는 구슬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29271;
-- AC datas : OLD Name : "다니엘 크레이머", Name AC enUS : "Daniel Kramer" ; Wowhead enUS : "Daniel Kramer"
UPDATE `creature_template_locale` SET `Name` = '다니엘 크래머', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29293;
-- AC datas : OLD Name : "로버트 리처드슨", Name AC enUS : "Robert Richardson" ; Wowhead enUS : "Robert Richardson"
UPDATE `creature_template_locale` SET `Name` = '로버트 리차드슨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29300;
-- AC datas : OLD Name : "죽음경비병 헤밀", Name AC enUS : "Deathguard Hemil" ; Wowhead enUS : "Deathguard Hemil"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 헤밀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29302;
-- AC datas : OLD Name : "군드락 박쥐 기수", Name AC enUS : "Gundrak Bat Rider" ; Wowhead enUS : "Gundrak Bat Rider"
UPDATE `creature_template_locale` SET `Name` = '군드락 박쥐기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29332;
-- AC datas : OLD Name : "설맹의 숭배자", Name AC enUS : "Snowblind Devotee" ; Wowhead enUS : "Snowblind Devotee"
UPDATE `creature_template_locale` SET `Name` = '설맹의 신자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29407;
-- AC datas : OLD Name : "성난발톱 광전사", Name AC enUS : "Rageclaw Berserker" ; Wowhead enUS : "Rageclaw Berserker"
UPDATE `creature_template_locale` SET `Name` = '성난발톱일족 광전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29437;
-- AC datas : OLD Name : "성난발톱 원시술사", Name AC enUS : "Rageclaw Primalist" ; Wowhead enUS : "Rageclaw Primalist"
UPDATE `creature_template_locale` SET `Name` = '성난발톱일족 원시술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29438;
-- AC datas : OLD Name : "성난발톱 사냥꾼", Name AC enUS : "Rageclaw Hunter" ; Wowhead enUS : "Rageclaw Hunter"
UPDATE `creature_template_locale` SET `Name` = '성난발톱일족 사냥꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29439;
-- AC datas : OLD Subname : "", Subname AC enUS : "Specialty Ammunition" ; Wowhead enUS : "Specialty Ammunition"
UPDATE `creature_template_locale` SET `Title` = '특수 화살 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29493;
-- AC datas : OLD Subname : "도끼 및 장창 상인", Subname AC enUS : "Axe & Polearm Merchant" ; Wowhead enUS : "Axe & Polearm Merchant"
UPDATE `creature_template_locale` SET `Title` = '도끼 및 장창류 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29496;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Weaponsmithing Trainer" ; Wowhead enUS : "Weaponsmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 무기제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29505;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Armorsmithing Trainer" ; Wowhead enUS : "Armorsmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 방어구 제작자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29506;
-- AC datas : OLD Name : "만프레드 스톨러", Name AC enUS : "Manfred Staller" ; Wowhead enUS : "Manfred Staller",  OLD Subname : "전문 가죽세공인", Subname AC enUS : "Elemental Leatherworking Trainer" ; Wowhead enUS : "Elemental Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Name` = '맨프레드 스톨러', `Title` = '전문 원소 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29507;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Dragonscale Leatherworking Trainer" ; Wowhead enUS : "Dragonscale Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 용비늘 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29508;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Tribal Leatherworking Trainer" ; Wowhead enUS : "Tribal Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 전통 가죽세공인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29509;
-- AC datas : OLD Subname : "고블린 전문 기계공학자", Subname AC enUS : "Goblin Engineering Trainer" ; Wowhead enUS : "Goblin Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 고블린 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29513;
-- AC datas : OLD Subname : "노움 전문 기계공학자", Subname AC enUS : "Gnome Engineering Trainer" ; Wowhead enUS : "Gnome Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 노움 기술자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29514;
-- AC datas : OLD Subname : "서릿결 부족의 우두머리", Subname AC enUS : "King of the Frostborn" ; Wowhead enUS : "King of the Frostborn"
UPDATE `creature_template_locale` SET `Title` = '서릿결부족의 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29593;
-- AC datas : OLD Name : "공포의 군주 말가니스", Name AC enUS : "Dreadlord Mal'Ganis" ; Wowhead enUS : "Dreadlord Mal'Ganis"
UPDATE `creature_template_locale` SET `Name` = '공포의군주 말가니스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29620;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29631;
-- AC datas : OLD Name : "사로잡힌 성난발톱 일족", Name AC enUS : "Captured Rageclaw" ; Wowhead enUS : "Captured Rageclaw"
UPDATE `creature_template_locale` SET `Name` = '사로잡힌 성난발톱일족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29686;
-- AC datas : OLD Name : "서릿결 도끼잡이", Name AC enUS : "Frostborn Axemaster" ; Wowhead enUS : "Frostborn Axemaster"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 도끼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29729;
-- AC datas : OLD Name : "서릿결 폭풍기수", Name AC enUS : "Frostborn Stormrider" ; Wowhead enUS : "Frostborn Stormrider"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 폭풍기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29730;
-- AC datas : OLD Name : "서릿결 얼음술사", Name AC enUS : "Frostborn Iceshaper" ; Wowhead enUS : "Frostborn Iceshaper"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 얼음술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29731;
-- AC datas : OLD Name : "피욜린 프로스트브라우", Name AC enUS : "Fjorlin Frostbrow" ; Wowhead enUS : "Fjorlin Frostbrow"
UPDATE `creature_template_locale` SET `Name` = '피욜린 프로스트브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29732;
-- AC datas : OLD Name : "서리깃 비명하피", Name AC enUS : "Frostfeather Screecher" ; Wowhead enUS : "Frostfeather Screecher"
UPDATE `creature_template_locale` SET `Name` = '서리깃일족 비명소리 하피', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29792;
-- AC datas : OLD Name : "서리깃 마녀", Name AC enUS : "Frostfeather Witch" ; Wowhead enUS : "Frostfeather Witch"
UPDATE `creature_template_locale` SET `Name` = '서리깃일족 마녀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29793;
-- AC datas : OLD Name : "돌조각장이 볼더크랙", Name AC enUS : "Bouldercrag the Rockshaper" ; Wowhead enUS : "Bouldercrag the Rockshaper"
UPDATE `creature_template_locale` SET `Name` = '돌조각장이 바울더크랙', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29801;
-- AC datas : OLD Name : "서릿결 정찰병", Name AC enUS : "Frostborn Scout" ; Wowhead enUS : "Frostborn Scout"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29811;
-- AC datas : OLD Name : "드라카리 광포어", Name AC enUS : "Drakkari Frenzy" ; Wowhead enUS : "Drakkari Frenzy"
UPDATE `creature_template_locale` SET `Name` = '드라카리 프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29834;
-- AC datas : OLD Name : "성난발톱 일족 새끼", Name AC enUS : "Rageclaw Pup" ; Wowhead enUS : "Rageclaw Pup"
UPDATE `creature_template_locale` SET `Name` = '성난발톱일족 새끼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29848;
-- AC datas : OLD Name : "유쾌한 슬러크 브라스놉", Name AC enUS : "Smilin' Slirk Brassknob" ; Wowhead enUS : "Smilin' Slirk Brassknob"
UPDATE `creature_template_locale` SET `Name` = '유쾌한 슬러크 브래스놉', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29904;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29924;
-- AC datas : OLD Name : "전쟁노래 그런트", Name AC enUS : "Warsong Hold Grunt" ; Wowhead enUS : "Warsong Hold Grunt"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 그런트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29942;
-- AC datas : OLD Name : "브렉 록브라우", Name AC enUS : "Breck Rockbrow" ; Wowhead enUS : "Breck Rockbrow"
UPDATE `creature_template_locale` SET `Name` = '브렉 록브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 29950;
-- AC datas : OLD Subname : "겨울도끼 부족의 용사", Subname AC enUS : "Champion of the Winterax" ; Wowhead enUS : "Champion of the Winterax"
UPDATE `creature_template_locale` SET `Title` = '겨울도끼부족의 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30023;
-- AC datas : OLD Name : "돌풍의 왕자 아즈바린", Name AC enUS : "Az'Barin, Prince of the Gust" ; Wowhead enUS : "Az'Barin, Prince of the Gust"
UPDATE `creature_template_locale` SET `Name` = '강풍의 왕자 아즈바린', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30026;
-- AC datas : OLD Name : "서릿결 도끼잡이", Name AC enUS : "Frostborn Axemaster" ; Wowhead enUS : "Frostborn Axemaster"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 도끼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30065;
-- AC datas : OLD Name : "잠 못 드는 서릿결 전사", Name AC enUS : "Restless Frostborn Warrior" ; Wowhead enUS : "Restless Frostborn Warrior"
UPDATE `creature_template_locale` SET `Name` = '잠 못 드는 서릿결부족 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30135;
-- AC datas : OLD Name : "서릿결 떠 있는 영혼", Name AC enUS : "Frostborn Floating Spirit" ; Wowhead enUS : "Frostborn Floating Spirit"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 떠 있는 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30143;
-- AC datas : OLD Name : "잠 못 드는 서릿결 유령", Name AC enUS : "Restless Frostborn Ghost" ; Wowhead enUS : "Restless Frostborn Ghost"
UPDATE `creature_template_locale` SET `Name` = '잠 못 드는 서릿결부족 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30144;
-- AC datas : OLD Name : "서릿결 떠 있는 영혼", Name AC enUS : "Frostborn Floating Spirit" ; Wowhead enUS : "Frostborn Floating Spirit"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 떠 있는 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30145;
-- AC datas : OLD Name : "서릿결 폭풍기수", Name AC enUS : "Frostborn Stormrider" ; Wowhead enUS : "Frostborn Stormrider"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 폭풍기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30166;
-- AC datas : OLD Subname : "서릿결 부족의 우두머리", Subname AC enUS : "King of the Frostborn" ; Wowhead enUS : "King of the Frostborn"
UPDATE `creature_template_locale` SET `Title` = '서릿결부족의 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30182;
-- AC datas : OLD Name : "폭풍으로 벼려낸 침투요원", Name AC enUS : "Stormforged Infiltrator" ; Wowhead enUS : "Stormforged Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '폭풍으로 벼려낸 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30222;
-- AC datas : OLD Name : "바일블로", Name AC enUS : "Bileblow" ; Wowhead enUS : "Bileblow"
UPDATE `creature_template_locale` SET `Name` = '바일블로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30306;
-- AC datas : OLD Name : "마력의 쇄도", Name AC enUS : "Surge of Power" ; Wowhead enUS : "Surge of Power"
UPDATE `creature_template_locale` SET `Name` = '쇄도하는 마력', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30334;
-- AC datas : OLD Name : "요르무타르", Name AC enUS : "Jormuttar" ; Wowhead enUS : "Jorcuttar"
UPDATE `creature_template_locale` SET `Name` = '요르쿠타르', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30340;
-- AC datas : OLD Name : "서릿결 도끼잡이", Name AC enUS : "Frostborn Axemaster" ; Wowhead enUS : "Frostborn Axemaster"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 도끼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30356;
-- AC datas : OLD Name : "서릿결 도끼잡이", Name AC enUS : "Frostborn Axemaster Trigger Bunny" ; Wowhead enUS : "Frostborn Axemaster Trigger Bunny"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 도끼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30361;
-- AC datas : OLD Subname : "서릿결 부족의 우두머리", Subname AC enUS : "King of the Frostborn" ; Wowhead enUS : "King of the Frostborn"
UPDATE `creature_template_locale` SET `Title` = '서릿결부족의 우두머리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30408;
-- AC datas : OLD Name : "잊혀진 자", Name AC enUS : "Forgotten One" ; Wowhead enUS : "Forgotten One"
UPDATE `creature_template_locale` SET `Name` = '잊힌 자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30414;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30437;
-- AC datas : OLD Name : "서리 검은늑대", Name AC enUS : "Frostworg" ; Wowhead enUS : "Frostworg"
UPDATE `creature_template_locale` SET `Name` = '서리늑대', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30455;
-- AC datas : OLD Name : "서릿결 도끼잡이", Name AC enUS : "Frostborn Axemaster" ; Wowhead enUS : "Frostborn Axemaster"
UPDATE `creature_template_locale` SET `Name` = '서릿결부족 도끼잡이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30505;
-- AC datas : OLD Name : "폭풍마루 독수리", Name AC enUS : "Stormcrest Eagle" ; Wowhead enUS : "Stormcrest Eagle"
UPDATE `creature_template_locale` SET `Name` = '폭풍갈기 독수리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30506;
-- AC datas : OLD Name : "프라스 샤비", Name AC enUS : "Fras Siabi" ; Wowhead enUS : "Ezra Grimm"
UPDATE `creature_template_locale` SET `Name` = '에즈라 그림', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30552;
-- AC datas : OLD Subname : "", Subname AC enUS : "Ammunition" ; Wowhead enUS : "Ammunition"
UPDATE `creature_template_locale` SET `Title` = '탄약 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30572;
-- AC datas : OLD Name : "가시 돋친 구울", Name AC enUS : "Spiked Ghoul" ; Wowhead enUS : "Spiked Ghoul"
UPDATE `creature_template_locale` SET `Name` = '파묻힌 구울', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30597;
-- AC datas : OLD Subname : "", Subname AC enUS : "Arena Organizer" ; Wowhead enUS : "Arena Organizer"
UPDATE `creature_template_locale` SET `Title` = '투기장 조직위원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30611;
-- AC datas : OLD Name : "하늘빛 주문파괴자", Name AC enUS : "Azure Spellbreaker" ; Wowhead enUS : "Azure Spellbreaker"
UPDATE `creature_template_locale` SET `Name` = '하늘빛 주문 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30662;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30706;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30709;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30710;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30711;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30713;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30715;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30716;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Inscription Trainer" ; Wowhead enUS : "Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '상급 주문각인사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30717;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Master Inscription Trainer" ; Wowhead enUS : "Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30721;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Master Inscription Trainer" ; Wowhead enUS : "Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30722;
-- AC datas : OLD Name : "전쟁노래 용사", Name AC enUS : "Warsong Champion" ; Wowhead enUS : "Warsong Champion"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 용사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30739;
-- AC datas : OLD Subname : "옛날 투기장 방어구 상인", Subname AC enUS : "Water Vendor" ; Wowhead enUS : "Water Vendor"
UPDATE `creature_template_locale` SET `Title` = '음료 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30885;
-- AC datas : OLD Name : "암영 투사", Name AC enUS : "Umbral Brute" ; Wowhead enUS : "Umbral Brute"
UPDATE `creature_template_locale` SET `Name` = '움브랄 투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30922;
-- AC datas : OLD Name : "하늘빛 주문파괴자", Name AC enUS : "Azure Spellbreaker" ; Wowhead enUS : "Azure Spellbreaker"
UPDATE `creature_template_locale` SET `Name` = '하늘빛 주문 파괴자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31009;
-- AC datas : OLD Name : "되살아난 성전사", Name AC enUS : "Reanimated Crusader" ; Wowhead enUS : "Reanimated Crusader"
UPDATE `creature_template_locale` SET `Name` = '되살아난 십자군', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31043;
-- AC datas : OLD Subname : "요술사", Subname AC enUS : "Enchantress" ; Wowhead enUS : "Enchantress"
UPDATE `creature_template_locale` SET `Title` = '마법부여사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31051;
-- AC datas : OLD Name : "수도자 테사", Name AC enUS : "Anchorite Tessa" ; Wowhead enUS : "Anchorite Tessa"
UPDATE `creature_template_locale` SET `Name` = '수도사 테사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31054;
-- AC datas : OLD Subname : "비행 조련사", Subname AC enUS : "Flight Master" ; Wowhead enUS : "Flight Master"
UPDATE `creature_template_locale` SET `Title` = '비행조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31078;
-- AC datas : OLD Subname : "사술 전문가", Subname AC enUS : "Master Hexxer" ; Wowhead enUS : "Master Hexxer"
UPDATE `creature_template_locale` SET `Title` = '주술 전문가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31101;
-- AC datas : OLD Name : "훈련용 허수아비", Name AC enUS : "Grandmaster's Training Dummy" ; Wowhead enUS : "Grandmaster's Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '거장의 훈련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31144;
-- AC datas : OLD Name : "공격대원의 훈련용 허수아비", Name AC enUS : "Heroic Training Dummy" ; Wowhead enUS : "Heroic Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '영웅의 훈련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31146;
-- AC datas : OLD Subname : "극지 비행 교관", Subname AC enUS : "Cold Weather Flying Trainer" ; Wowhead enUS : "Cold Weather Flying Trainer"
UPDATE `creature_template_locale` SET `Title` = '극지 비행 훈련교관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31238;
-- AC datas : OLD Name : "장군 홀크 스트롱브라우", Name AC enUS : "Warlord Hork Strongbrow" ; Wowhead enUS : "Warlord Hork Strongbrow"
UPDATE `creature_template_locale` SET `Name` = '장군 홀크 스트롱브로우', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31240;
-- AC datas : OLD Name : "전쟁노래 대포", Name AC enUS : "Warsong Cannon" ; Wowhead enUS : "Warsong Cannon"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 대포', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31243;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Cold Weather Flying Trainer" ; Wowhead enUS : "Cold Weather Flying Trainer"
UPDATE `creature_template_locale` SET `Title` = '극지 비행 훈련교관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31247;
-- AC datas : OLD Name : "이미르하임 정예 부대원", Name AC enUS : "Ymirheim Chosen Warrior" ; Wowhead enUS : "Ymirheim Chosen Warrior"
UPDATE `creature_template_locale` SET `Name` = '이미야르 정예 부대원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31258;
-- AC datas : OLD Name : "코르크론 전투와이번", Name AC enUS : "Kor'kron Battle Wyvern" ; Wowhead enUS : "Kor'kron Battle Wyvern"
UPDATE `creature_template_locale` SET `Name` = '코르크론 전투 와이번', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31269;
-- AC datas : OLD Name : "전쟁노래 정예병", Name AC enUS : "(Wrathgate Horde) Warsong Elite" ; Wowhead enUS : "(Wrathgate Horde) Warsong Elite"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 정예병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31285;
-- AC datas : OLD Name : "검은창 트롤", Name AC enUS : "(Wrathgate Horde) Darkspear" ; Wowhead enUS : "(Wrathgate Horde) Darkspear"
UPDATE `creature_template_locale` SET `Name` = '검은창부족 트롤', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31295;
-- AC datas : OLD Name : "전쟁노래 약탈자", Name AC enUS : "Warsong Raider" ; Wowhead enUS : "Warsong Raider"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31435;
-- AC datas : OLD Name : "교활한 공포의 군주", Name AC enUS : "Perfidious Dreadlord" ; Wowhead enUS : "Perfidious Dreadlord"
UPDATE `creature_template_locale` SET `Name` = '교활한 공포의군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31531;
-- AC datas : OLD Name : "전쟁노래 전투호위병", Name AC enUS : "Warsong Battleguard" ; Wowhead enUS : "Warsong Battleguard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31563;
-- AC datas : OLD Name : "전쟁노래 전투호위병", Name AC enUS : "Warsong Battleguard" ; Wowhead enUS : "Warsong Battleguard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31564;
-- AC datas : OLD Subname : "명예 병참 장교의 상징", Subname AC enUS : "Emblem of Valor Quartermaster" ; Wowhead enUS : "Emblem of Valor Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '용맹의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31579;
-- AC datas : OLD Subname : "영웅주의 병참 장교의 상징", Subname AC enUS : "Emblem of Heroism Quartermaster" ; Wowhead enUS : "Emblem of Heroism Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '무용의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31580;
-- AC datas : OLD Name : "마법학자 브라샤엘", Name AC enUS : "Magister Brasael" ; Wowhead enUS : "Magister Brasael",  OLD Subname : "명예 병참 장교의 상징", Subname AC enUS : "Emblem of Valor Quartermaster" ; Wowhead enUS : "Emblem of Valor Quartermaster"
UPDATE `creature_template_locale` SET `Name` = '마법학자 브라샐', `Title` = '용맹의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31581;
-- AC datas : OLD Subname : "영웅주의 병참 장교의 상징", Subname AC enUS : "Emblem of Heroism Quartermaster" ; Wowhead enUS : "Emblem of Heroism Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '무용의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31582;
-- AC datas : OLD Name : "스톰윈드로 통하는 차원문", Name AC enUS : "Portal to Stormwind" ; Wowhead enUS : "Portal to Stormwind"
UPDATE `creature_template_locale` SET `Name` = '스톰윈드로 통하는 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31640;
-- AC datas : OLD Name : "소용돌이", Name AC enUS : "Whirlwind" ; Wowhead enUS : "Whirlwind"
UPDATE `creature_template_locale` SET `Name` = '회오리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31688;
-- AC datas : OLD Name : "황혼의 비룡", Name AC enUS : "Twilight Drake Mount" ; Wowhead enUS : "Twilight Drake Mount"
UPDATE `creature_template_locale` SET `Name` = '길들인 황혼의 비룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31698;
-- AC datas : OLD Name : "죽음경비병 젤므니", Name AC enUS : "Deathguard Barth" ; Wowhead enUS : "Deathguard Barth"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 젤므니', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31708;
-- AC datas : OLD Name : "죽음경비병 주애크", Name AC enUS : "Deathguard Hicks" ; Wowhead enUS : "Deathguard Hicks"
UPDATE `creature_template_locale` SET `Name` = '죽음의경비병 주애크', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31715;
-- AC datas : OLD Name : "광포어", Name AC enUS : "Cosmetic Frenzy" ; Wowhead enUS : "Cosmetic Frenzy"
UPDATE `creature_template_locale` SET `Name` = '프렌지', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31719;
-- AC datas : OLD Name : "창공의 선장 루미디아", Name AC enUS : "Sky-Captain LaFontaine" ; Wowhead enUS : "Sky-Captain LaFontaine"
UPDATE `creature_template_locale` SET `Name` = '창공의 선장 라폰테인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31725;
-- AC datas : OLD Name : "전쟁노래 전투호위병", Name AC enUS : "Warsong Battleguard" ; Wowhead enUS : "Warsong Battleguard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31739;
-- AC datas : OLD Name : "선원 준벅", Name AC enUS : "Sailor Berg" ; Wowhead enUS : "Sailor Berg"
UPDATE `creature_template_locale` SET `Name` = '선원 버그', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31760;
-- AC datas : OLD Name : "선장 웨이들", Name AC enUS : "Captain John Brookman" ; Wowhead enUS : "Captain John Brookman"
UPDATE `creature_template_locale` SET `Name` = '선장 존 브루크만', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31763;
-- AC datas : OLD Name : "길들인 검은 비룡", Name AC enUS : "Black Drake Mount" ; Wowhead enUS : "Black Drake Mount"
UPDATE `creature_template_locale` SET `Name` = '길들인 검은색 비룡', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31778;
-- AC datas : OLD Name : "선장 니아옹", Name AC enUS : "Captain Constance" ; Wowhead enUS : "Captain Constance"
UPDATE `creature_template_locale` SET `Name` = '선장 콘스턴스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31788;
-- AC datas : OLD Name : "항해사 케이제일", Name AC enUS : "Navigator Meyer" ; Wowhead enUS : "Navigator Meyer"
UPDATE `creature_template_locale` SET `Name` = '항해사 메이어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31790;
-- AC datas : OLD Name : "코르크론 침투요원", Name AC enUS : "Kor'kron Infiltrator" ; Wowhead enUS : "Kor'kron Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '코르크론 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31882;
-- AC datas : OLD Subname : "광란심장 보급원", Subname AC enUS : "Frenzyheart Quartermaster" ; Wowhead enUS : "Frenzyheart Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '광란의심장일족 보급원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31911;
-- AC datas : OLD Name : "오그림의 망치호 정찰병", Name AC enUS : "Orgrim's Hammer Scout" ; Wowhead enUS : "Orgrim's Hammer Scout"
UPDATE `creature_template_locale` SET `Name` = '오그림의 망치 정찰병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32201;
-- AC datas : OLD Name : "하늘파괴자 침투요원", Name AC enUS : "Skybreaker Infiltrator" ; Wowhead enUS : "Skybreaker Infiltrator"
UPDATE `creature_template_locale` SET `Name` = '하늘파괴자 첩보원', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32222;
-- AC datas : OLD Name : "공허소환사", Name AC enUS : "Void Summoner" ; Wowhead enUS : "Void Summoner"
UPDATE `creature_template_locale` SET `Name` = '공허의 소환사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32259;
-- AC datas : OLD Subname : "공허소환사의 소환수", Subname AC enUS : "Void Summoner's Pet" ; Wowhead enUS : "Void Summoner's Pet"
UPDATE `creature_template_locale` SET `Title` = '공허의 소환사의 소환수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32260;
-- AC datas : OLD Name : "전쟁인도자 다보스 리오트", Name AC enUS : "Warbringer Davos Rioht" ; Wowhead enUS : "Warbringer Davos Rioht"
UPDATE `creature_template_locale` SET `Name` = '전쟁의 인도자 다보스 리오트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32301;
-- AC datas : OLD Name : "금색팀 전사", Name AC enUS : "Gold Warrior" ; Wowhead enUS : "Gold Warrior"
UPDATE `creature_template_locale` SET `Name` = '황금팀 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32322;
-- AC datas : OLD Name : "금색팀 사제", Name AC enUS : "Gold Priest" ; Wowhead enUS : "Gold Priest"
UPDATE `creature_template_locale` SET `Name` = '황금팀 사제', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32325;
-- AC datas : OLD Name : "금색팀 주술사", Name AC enUS : "Gold Shaman" ; Wowhead enUS : "Gold Shaman"
UPDATE `creature_template_locale` SET `Name` = '황금팀 주술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32340;
-- AC datas : OLD Name : "금색팀 마법사", Name AC enUS : "Gold Mage" ; Wowhead enUS : "Gold Mage"
UPDATE `creature_template_locale` SET `Name` = '황금팀 마법사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32341;
-- AC datas : OLD Name : "톱니관절 장난감 고릴라", Name AC enUS : "Grindgear Toy Gorilla" ; Wowhead enUS : "Grindgear Toy Gorilla"
UPDATE `creature_template_locale` SET `Name` = '장난감 고릴라 그라인드기어', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32345;
-- AC datas : OLD Name : "싸움꾼 조크 토크렌치", Name AC enUS : "Big Zokk Torquewrench" ; Wowhead enUS : "Big Zokk Torquewrench"
UPDATE `creature_template_locale` SET `Name` = '싸움꾼 조크 토르크렌치', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32355;
-- AC datas : OLD Name : "엑튼 브라스텀블러", Name AC enUS : "Ecton Brasstumbler" ; Wowhead enUS : "Ecton Brasstumbler"
UPDATE `creature_template_locale` SET `Name` = '엑튼 브래스텀블러', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32360;
-- AC datas : OLD Name : "브롤 베어맨틀", Name AC enUS : "Broll Bearmantle" ; Wowhead enUS : "Broll Bearmantle"
UPDATE `creature_template_locale` SET `Name` = '브롤 비어맨틀', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32376;
-- AC datas : OLD Name : "부관 트리스티아", Name AC enUS : "Lieutenant Tristia" ; Wowhead enUS : "Lieutenant Tristia"
UPDATE `creature_template_locale` SET `Name` = '부관 트리시아', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32380;
-- AC datas : OLD Name : "도리스 볼란티우스", Name AC enUS : "Doris Volanthius" ; Wowhead enUS : "Doris Volanthius"
UPDATE `creature_template_locale` SET `Name` = '도리스 볼란시우스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32385;
-- AC datas : OLD Name : "교활한 공포의 군주", Name AC enUS : "Perfidious Dreadlord" ; Wowhead enUS : "Perfidious Dreadlord"
UPDATE `creature_template_locale` SET `Name` = '교활한 공포의군주', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32391;
-- AC datas : OLD Subname : "전문 낚시꾼", Subname AC enUS : "Grand Master Fishing Trainer" ; Wowhead enUS : "Grand Master Fishing Trainer"
UPDATE `creature_template_locale` SET `Title` = '낚시의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32474;
-- AC datas : OLD Name : "전쟁노래 전투호위병", Name AC enUS : "Warsong Battleguard" ; Wowhead enUS : "Warsong Battleguard"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 전투호위병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32510;
-- AC datas : OLD Subname : "결정 교환 상인", Subname AC enUS : "Shard Trader" ; Wowhead enUS : "Shard Trader"
UPDATE `creature_template_locale` SET `Title` = '결정 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32514;
-- AC datas : OLD Name : "겨울손아귀 공성 전차", Name AC enUS : "Wintergrasp Siege Engine" ; Wowhead enUS : "Wintergrasp Siege Engine"
UPDATE `creature_template_locale` SET `Name` = '겨울손아귀 공성 무기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32627;
-- AC datas : OLD Name : "전쟁노래 요새 연습용 허수아비", Name AC enUS : "Warsong Hold Practice Dummy" ; Wowhead enUS : "Warsong Hold Practice Dummy"
UPDATE `creature_template_locale` SET `Name` = '전쟁노래부족 요새 연습용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32647;
-- AC datas : OLD Name : "훈련용 허수아비", Name AC enUS : "Expert's Training Dummy" ; Wowhead enUS : "Expert's Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '전문가의 훈련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32666;
-- AC datas : OLD Name : "훈련용 허수아비", Name AC enUS : "Master's Training Dummy" ; Wowhead enUS : "Master's Training Dummy"
UPDATE `creature_template_locale` SET `Name` = '숙련자의 훈련용 허수아비', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32667;
-- AC datas : OLD Name : "크래프티쿠스 마인드벤더", Name AC enUS : "Crafticus Mindbender" ; Wowhead enUS : "Tomas Riogain"
UPDATE `creature_template_locale` SET `Name` = '토마스 리오게인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32686;
-- AC datas : OLD Name : "대사술사 오호도", Name AC enUS : "Great Hexer Ohodo" ; Wowhead enUS : "Great Hexer Ohodo"
UPDATE `creature_template_locale` SET `Name` = '대주술사 오호도', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32719;
-- AC datas : OLD Name : "달숲 귀환 차원문", Name AC enUS : "Moonglade Return Portal" ; Wowhead enUS : "Moonglade Return Portal"
UPDATE `creature_template_locale` SET `Name` = '달의 숲 귀환 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32788;
-- AC datas : OLD Name : "달숲 차원문", Name AC enUS : "Moonglade Portal" ; Wowhead enUS : "Moonglade Portal"
UPDATE `creature_template_locale` SET `Name` = '달의 숲 차원의 문', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32790;
-- AC datas : OLD Name : "붉은색 용매", Name AC enUS : "Red Dragonhawk" ; Wowhead enUS : "Red Dragonhawk"
UPDATE `creature_template_locale` SET `Name` = '붉은 용매', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32944;
-- AC datas : OLD Name : "마커스 발로 경", Name AC enUS : "Sir Marcus Barlowe" ; Wowhead enUS : "Sir Marcus Barlowe"
UPDATE `creature_template_locale` SET `Name` = '마커스 발로위 경', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33222;
-- AC datas : OLD Name : "해변게", Name AC enUS : "Strand Crawler" ; Wowhead enUS : "Strand Crawler"
UPDATE `creature_template_locale` SET `Name` = '해안 게', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33226;
-- AC datas : OLD Name : "죽음추적자 비세리", Name AC enUS : "Deathstalker Visceri" ; Wowhead enUS : "Deathstalker Visceri"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 비세리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33373;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Grand Master Tailoring Trainer" ; Wowhead enUS : "Grand Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33580;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Grand Master Leatherworking Trainer" ; Wowhead enUS : "Grand Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33581;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Grand Master Enchanting Trainer" ; Wowhead enUS : "Grand Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33583;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Grand Master Engineering Trainer" ; Wowhead enUS : "Grand Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33586;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Grand Master Cooking Trainer" ; Wowhead enUS : "Grand Master Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33587;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Grand Master Alchemy Trainer" ; Wowhead enUS : "Grand Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33588;
-- AC datas : OLD Subname : "전문 응급치료사", Subname AC enUS : "Grand Master First Aid Trainer" ; Wowhead enUS : "Grand Master First Aid Trainer"
UPDATE `creature_template_locale` SET `Title` = '응급치료의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33589;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Grand Master Jewelcrafting Trainer" ; Wowhead enUS : "Grand Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33590;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Grand Master Blacksmithing Trainer" ; Wowhead enUS : "Grand Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33591;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Grand Master Inscription Trainer" ; Wowhead enUS : "Grand Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 거장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33603;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33630;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33631;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33633;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33634;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33635;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Master Tailoring Trainer" ; Wowhead enUS : "Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33636;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33637;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Master Inscription Trainer" ; Wowhead enUS : "Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33638;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Master Herbalism Trainer" ; Wowhead enUS : "Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33639;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Master Mining Trainer" ; Wowhead enUS : "Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33640;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Master Skinning Trainer" ; Wowhead enUS : "Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33641;
-- AC datas : OLD Subname : "전문 연금술사", Subname AC enUS : "Master Alchemy Trainer" ; Wowhead enUS : "Master Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = '연금술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33674;
-- AC datas : OLD Subname : "전문 대장장이", Subname AC enUS : "Master Blacksmithing Trainer" ; Wowhead enUS : "Master Blacksmithing Trainer"
UPDATE `creature_template_locale` SET `Title` = '대장기술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33675;
-- AC datas : OLD Subname : "전문 마법부여사", Subname AC enUS : "Master Enchanting Trainer" ; Wowhead enUS : "Master Enchanting Trainer"
UPDATE `creature_template_locale` SET `Title` = '마법부여의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33676;
-- AC datas : OLD Subname : "전문 기계공학자", Subname AC enUS : "Master Engineering Trainer" ; Wowhead enUS : "Master Engineering Trainer"
UPDATE `creature_template_locale` SET `Title` = '기계공학의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33677;
-- AC datas : OLD Subname : "전문 약초채집사", Subname AC enUS : "Master Herbalism Trainer" ; Wowhead enUS : "Master Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = '약초채집의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33678;
-- AC datas : OLD Subname : "전문 주문각인사", Subname AC enUS : "Master Inscription Trainer" ; Wowhead enUS : "Master Inscription Trainer"
UPDATE `creature_template_locale` SET `Title` = '주문각인의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33679;
-- AC datas : OLD Subname : "전문 보석세공인", Subname AC enUS : "Master Jewelcrafting Trainer" ; Wowhead enUS : "Master Jewelcrafting Trainer"
UPDATE `creature_template_locale` SET `Title` = '보석세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33680;
-- AC datas : OLD Subname : "전문 가죽세공인", Subname AC enUS : "Master Leatherworking Trainer" ; Wowhead enUS : "Master Leatherworking Trainer"
UPDATE `creature_template_locale` SET `Title` = '가죽세공의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33681;
-- AC datas : OLD Subname : "전문 광부", Subname AC enUS : "Master Mining Trainer" ; Wowhead enUS : "Master Mining Trainer"
UPDATE `creature_template_locale` SET `Title` = '채광의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33682;
-- AC datas : OLD Subname : "전문 무두장이", Subname AC enUS : "Master Skinning Trainer" ; Wowhead enUS : "Master Skinning Trainer"
UPDATE `creature_template_locale` SET `Title` = '무두질의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33683;
-- AC datas : OLD Subname : "전문 재봉사", Subname AC enUS : "Master Tailoring Trainer" ; Wowhead enUS : "Master Tailoring Trainer"
UPDATE `creature_template_locale` SET `Title` = '재봉술의 대가', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33684;
-- AC datas : OLD Name : "길들인 검은창 랩터", Name AC enUS : "Stabled Darkspear Raptor" ; Wowhead enUS : "Stabled Darkspear Raptor"
UPDATE `creature_template_locale` SET `Name` = '길들인 검은창부족 랩터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33796;
-- AC datas : OLD Subname : "정복 병참 장교의 문장", Subname AC enUS : "Emblem of Conquest Quartermaster" ; Wowhead enUS : "Emblem of Conquest Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '정복의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33963;
-- AC datas : OLD Subname : "정복 병참 장교의 문장", Subname AC enUS : "Emblem of Conquest Quartermaster" ; Wowhead enUS : "Emblem of Conquest Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '정복의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33964;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34708;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34710;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34711;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34712;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34713;
-- AC datas : OLD Subname : "전문 요리사", Subname AC enUS : "Cooking Trainer" ; Wowhead enUS : "Cooking Trainer"
UPDATE `creature_template_locale` SET `Title` = '요리사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34785;
-- AC datas : OLD Name : "죽음추적자 페인", Name AC enUS : "Deathstalker Fane" ; Wowhead enUS : "Deathstalker Fane"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 페인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34983;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35068;
-- AC datas : OLD Subname : "대지 고리회", Subname AC enUS : "The Earthen Ring" ; Wowhead enUS : "The Earthen Ring"
UPDATE `creature_template_locale` SET `Title` = '속세의 고리회', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35073;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35093;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35100;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35133;
-- AC datas : OLD Subname : "비행 교관", Subname AC enUS : "Riding Trainer" ; Wowhead enUS : "Riding Trainer"
UPDATE `creature_template_locale` SET `Title` = '전문 기수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35135;
-- AC datas : OLD Subname : "승리 병참 장교의 문장", Subname AC enUS : "Emblem of Triumph Quartermaster" ; Wowhead enUS : "Emblem of Triumph Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '승전의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35494;
-- AC datas : OLD Subname : "승리 병참 장교의 문장", Subname AC enUS : "Emblem of Triumph Quartermaster" ; Wowhead enUS : "Emblem of Triumph Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '승전의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35495;
-- AC datas : OLD Subname : "옛날 정의 병참장교", Subname AC enUS : "Emblem of Triumph Quartermaster" ; Wowhead enUS : "Emblem of Triumph Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '승전의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35573;
-- AC datas : OLD Subname : "옛날 정의 병참장교", Subname AC enUS : "Emblem of Triumph Quartermaster" ; Wowhead enUS : "Emblem of Triumph Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '승전의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35574;
-- AC datas : OLD Name : "죽음추적자 비세리", Name AC enUS : "Deathstalker Visceri" ; Wowhead enUS : "Deathstalker Visceri"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 비세리', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35617;
-- AC datas : OLD Name : "죽음추적자 비세리의 탈것", Name AC enUS : "Deathstalker Visceri's Mount" ; Wowhead enUS : "Deathstalker Visceri's Mount"
UPDATE `creature_template_locale` SET `Name` = '죽음의추적자 비세리의 탈것', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35634;
-- AC datas : OLD Name : "유저리 브라이트코인", Name AC enUS : "Usuri Brightcoin" ; Wowhead enUS : "Usuri Brightcoin"
UPDATE `creature_template_locale` SET `Name` = '우수리 브라이트코인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 35790;
-- AC datas : OLD Subname : "명가", Subname AC enUS : "The Highborne" ; Wowhead enUS : "The Highborne"
UPDATE `creature_template_locale` SET `Title` = '귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36479;
-- AC datas : OLD Subname : "명가", Subname AC enUS : "The Highborne" ; Wowhead enUS : "The Highborne"
UPDATE `creature_template_locale` SET `Title` = '귀족', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36506;
-- AC datas : OLD Subname : "죽음추적자", Subname AC enUS : "The Deathstalkers" ; Wowhead enUS : "The Deathstalkers"
UPDATE `creature_template_locale` SET `Title` = '죽음의추적자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36517;
-- AC datas : OLD Name : "광기 어린 연금술사", Name AC enUS : "Crazed Apothecary" ; Wowhead enUS : "Crazed Apothecary"
UPDATE `creature_template_locale` SET `Name` = '광기어린 연금술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36568;
-- AC datas : OLD Name : "판다렌 수도사", Name AC enUS : "Pandaren Monk" ; Wowhead enUS : "Pandaren Monk"
UPDATE `creature_template_locale` SET `Name` = '판다렌 수도승', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36911;
-- AC datas : OLD Name : "서리수호 전사", Name AC enUS : "Frostwarden Warrior" ; Wowhead enUS : "Frostwarden Warrior"
UPDATE `creature_template_locale` SET `Name` = '서리수호단 전사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37228;
-- AC datas : OLD Name : "서리수호 여마술사", Name AC enUS : "Frostwarden Sorceress" ; Wowhead enUS : "Frostwarden Sorceress"
UPDATE `creature_template_locale` SET `Name` = '서리수호단 여마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37229;
-- AC datas : OLD Name : "서리수호 조련사", Name AC enUS : "Frostwarden Handler" ; Wowhead enUS : "Frostwarden Handler"
UPDATE `creature_template_locale` SET `Name` = '서리수호단 조련사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37531;
-- AC datas : OLD Name : "연금술사 핑클스타인", Name AC enUS : "Alchemist Finklestein" ; Wowhead enUS : "Alchemist Finklestein"
UPDATE `creature_template_locale` SET `Name` = '연금술사 핀클스타인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37687;
-- AC datas : OLD Subname : "서리 병참 장교의 문장", Subname AC enUS : "Emblem of Frost Quartermaster" ; Wowhead enUS : "Emblem of Frost Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '서리의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37941;
-- AC datas : OLD Subname : "서리 병참 장교의 문장", Subname AC enUS : "Emblem of Frost Quartermaster" ; Wowhead enUS : "Emblem of Frost Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '서리의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37942;
-- AC datas : OLD Name : "커다란 사랑의 로켓", Name AC enUS : "Big Love Rocket" ; Wowhead enUS : "X-45 Heartbreaker"
UPDATE `creature_template_locale` SET `Name` = 'X-45 심장폭격기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38204;
-- AC datas : OLD Name : "수사관 페젠 브라스택스", Name AC enUS : "Investigator Fezzen Brasstacks" ; Wowhead enUS : "Investigator Fezzen Brasstacks"
UPDATE `creature_template_locale` SET `Name` = '수사관 페젠 브래스택스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38208;
-- AC datas : OLD Name : "흡혈 기생충", Name AC enUS : "Blood Parasite" ; Wowhead enUS : "Blood Parasite"
UPDATE `creature_template_locale` SET `Name` = '피기생충', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38231;
-- AC datas : OLD Name : "흡혈 거미", Name AC enUS : "Blood Spider" ; Wowhead enUS : "Blood Spider"
UPDATE `creature_template_locale` SET `Name` = '피거미', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38232;
-- AC datas : OLD Name : "순교자 추적기 (IGB)", Name AC enUS : "Martyr Stalker (IGB/Saurfang)" ; Wowhead enUS : "Martyr Stalker (IGB/Saurfang)"
UPDATE `creature_template_locale` SET `Name` = '순교자 추적기 (IGB/사울팽)', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38569;
-- AC datas : OLD Subname : "옛날 정의 병참장교", Subname AC enUS : "Emblem of Frost Quartermaster" ; Wowhead enUS : "Emblem of Frost Quartermaster"
UPDATE `creature_template_locale` SET `Title` = '서리의 문장 병참장교', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38858;
-- AC datas : OLD Name : "파란색 로켓 태엽돌이", Name AC enUS : "Clockwork Rocket Bot" ; Wowhead enUS : "Clockwork Rocket Bot"
UPDATE `creature_template_locale` SET `Name` = '로켓 태엽돌이', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 40295;

-- Update existing entries, from TBC
-- AC datas : OLD Name : "Coilfang Raid Control Emote Stalker", Name AC enUS : "Coilfang Raid Control Emote Stalker" ; Wowhead enUS : "Invisible Stalker Coilfang Raid Console Emotes"
UPDATE `creature_template_locale` SET `Name` = NULL, `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 22057;
-- AC datas : OLD Name : "Cosmetic Trigger - LAB", Name AC enUS : "Cosmetic Trigger - LAB" ; Wowhead enUS : "Generic Cosmetic Trigger - LAB"
UPDATE `creature_template_locale` SET `Name` = NULL, `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24921;

-- Update existing entries, from CLASSIC
-- AC datas : OLD Name : "알 수 없는 악 변신", Name AC enUS : "Vaious" ; Wowhead enUS : "Vaious"
UPDATE `creature_template_locale` SET `Name` = '바이어스', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 229;
-- AC datas : OLD Name : "스콧의 비행기", Name AC enUS : "Scott's Flying Mount" ; Wowhead enUS : "Scott's Flying Mount"
UPDATE `creature_template_locale` SET `Name` = '스캇의 비행기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 365;
-- AC datas : OLD Name : "디버그 - 소문 그리핀 조련사", Name AC enUS : "DEBUG - Gossip Gryphon Master" ; Wowhead enUS : "DEBUG - Gossip Gryphon Master"
UPDATE `creature_template_locale` SET `Name` = '디버그 - 소문 그리핀 마스터', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 2833;
-- AC datas : OLD Name : "공용 투명 트리거", Name AC enUS : "World Invisible Trigger" ; Wowhead enUS : "Blackwing Trigger"
UPDATE `creature_template_locale` SET `Name` = '검은날개 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 12999;
-- AC datas : OLD Name : "모건 시험용", Name AC enUS : "GGOODMAN" ; Wowhead enUS : "GGOODMAN"
UPDATE `creature_template_locale` SET `Name` = '지오프 굿맨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14824;
-- AC datas : OLD Name : "고대 축복", Name AC enUS : "Primal Blessing Visual" ; Wowhead enUS : "Primal Blessing Visual"
UPDATE `creature_template_locale` SET `Name` = '원시 축복', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15109;
-- AC datas : OLD Name : "다크문 유랑단 대포", Name AC enUS : "Faire Cannon Trigger" ; Wowhead enUS : "Faire Cannon Trigger"
UPDATE `creature_template_locale` SET `Name` = '축제 대포 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15218;
-- AC datas : OLD Name : "OLDWorld Trigger (DO NOT DELETE)", Name AC enUS : "OLDWorld Trigger (DO NOT DELETE)" ; Wowhead enUS : "World Trigger"
UPDATE `creature_template_locale` SET `Name` = '월드 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15384;
-- AC datas : OLD Name : "크툰", Name AC enUS : "C'Thun Transformation Visual" ; Wowhead enUS : "C'Thun Transformation Visual"
UPDATE `creature_template_locale` SET `Name` = '쑨', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15809;
-- AC datas : OLD Name : "비시두스 트리거", Name AC enUS : "Viscidus Trigger" ; Wowhead enUS : "Viscidus Trigger"
UPDATE `creature_template_locale` SET `Name` = '비시디우스 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 15922;

-- Update existing entries, from CATA
-- AC datas : OLD Name : "고위주술사 블러드포우", Name AC enUS : "High Shaman Bloodpaw" ; Wowhead enUS : "High Shaman Bloodpaw"
UPDATE `creature_template_locale` SET `Name` = '고위주술사 블러드포', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27762;
-- AC datas : OLD Subname : "죽음의 기사 문양 상인", Subname AC enUS : "Death Knight Glyphs" ; Wowhead enUS : "Death Knight Supplies"
UPDATE `creature_template_locale` SET `Title` = '죽음의 기사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32753;
-- AC datas : OLD Subname : "드루이드 문양 상인", Subname AC enUS : "Druid Glyphs" ; Wowhead enUS : "Druid Supplies"
UPDATE `creature_template_locale` SET `Title` = '드루이드 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32754;
-- AC datas : OLD Subname : "사냥꾼 문양 상인", Subname AC enUS : "Hunter Glyphs" ; Wowhead enUS : "Hunter Supplies"
UPDATE `creature_template_locale` SET `Title` = '사냥꾼 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32755;
-- AC datas : OLD Subname : "마법사 문양 상인", Subname AC enUS : "Mage Glyphs" ; Wowhead enUS : "Mage Supplies"
UPDATE `creature_template_locale` SET `Title` = '마법사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32756;
-- AC datas : OLD Subname : "성기사 문양 상인", Subname AC enUS : "Paladin Glyphs" ; Wowhead enUS : "Paladin Supplies"
UPDATE `creature_template_locale` SET `Title` = '성기사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32757;
-- AC datas : OLD Subname : "사제 문양 상인", Subname AC enUS : "Priest Glyphs" ; Wowhead enUS : "Priest Supplies"
UPDATE `creature_template_locale` SET `Title` = '사제 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32758;
-- AC datas : OLD Subname : "도적 문양 상인", Subname AC enUS : "Rogue Glyphs" ; Wowhead enUS : "Rogue Supplies"
UPDATE `creature_template_locale` SET `Title` = '도적 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32759;
-- AC datas : OLD Subname : "주술사 문양 상인", Subname AC enUS : "Shaman Glyphs" ; Wowhead enUS : "Shaman Supplies"
UPDATE `creature_template_locale` SET `Title` = '주술사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32760;
-- AC datas : OLD Subname : "흑마법사 문양 상인", Subname AC enUS : "Warlock Glyphs" ; Wowhead enUS : "Warlock Supplies"
UPDATE `creature_template_locale` SET `Title` = '흑마법사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32761;
-- AC datas : OLD Subname : "전사 문양 상인", Subname AC enUS : "Warrior Glyphs" ; Wowhead enUS : "Warrior Supplies"
UPDATE `creature_template_locale` SET `Title` = '전사 보급품', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32762;
-- AC datas : OLD Name : "노여워하는 영혼", Name AC enUS : "Raging Spirit" ; Wowhead enUS : "Raging Spirit"
UPDATE `creature_template_locale` SET `Name` = '분노의 영혼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36701;
-- AC datas : OLD Name : "커다란 사랑의 로켓", Name AC enUS : "Flying Big Love Rocket" ; Wowhead enUS : "X-45 Heartbreaker"
UPDATE `creature_template_locale` SET `Name` = 'X-45 심장폭격기', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38207;

-- Update existing entries, from RETAIL
-- AC datas : OLD Name : "[미사용] The Clogger 루글라", Name AC enUS : "[UNUSED] Luglar the Clogger" ; Wowhead enUS : "Holiday - Hallow's End - Garrison - Spectral Alemental"
UPDATE `creature_template_locale` SET `Name` = '유령 주령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 81;
-- AC datas : OLD Name : "소년 - placeholder 05", Name AC enUS : "Boy - placeholder 05" ; Wowhead enUS : "Patrol Guy"
UPDATE `creature_template_locale` SET `Name` = '순찰자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 399;
-- AC datas : OLD Name : "첩스", Name AC enUS : "[UNUSED] Goreripper" ; Wowhead enUS : "Lord Piglet"
UPDATE `creature_template_locale` SET `Name` = '돼지왕', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 444;
-- AC datas : OLD Name : "[임시] 화염고리 경비병", Name AC enUS : "UNUSED [PH] Flamewreath Guard" ; Wowhead enUS : "UNUSED [PH] Flamewreath Guard"
UPDATE `creature_template_locale` SET `Name` = '미사용 [임시] 화염고리 경비병', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10265;
-- AC datas : OLD Name : "[미사용] 말로리 웰쉬", Name AC enUS : "[UNUSED] Mallory Welsh" ; Wowhead enUS : "[UNUSED] Mallory Welsh"
UPDATE `creature_template_locale` SET `Name` = '말로리 웰쉬', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 10444;
-- AC datas : OLD Name : "파멸의 수호병 트리거", Name AC enUS : "Doomguard Tap Trigger" ; Wowhead enUS : "Doomguard Tap Trigger"
UPDATE `creature_template_locale` SET `Name` = '파멸수호병 트리거', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 14443;
-- AC datas : OLD Name : "밤의 무희", Name AC enUS : "Concubine Transform Visual" ; Wowhead enUS : "Zealous Paramour Transform Visual"
UPDATE `creature_template_locale` SET `Name` = '열망 어린 연인 변신 시각효과', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 17065;
-- AC datas : OLD Name : "UNUSED Outland Wyvern Mount (Armored)", Name AC enUS : "UNUSED Outland Wyvern Mount (Armored)" ; Wowhead enUS : "Test Sigil"
UPDATE `creature_template_locale` SET `Name` = '시험용 인장', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 18366;
-- AC datas : OLD Name : "혼 휴령", Name AC enUS : "[PH] Horn Ghost" ; Wowhead enUS : "[PH] Horn Ghost"
UPDATE `creature_template_locale` SET `Name` = '혼 유령', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 19846;
-- AC datas : OLD Name : "PvP 대포 사격 대상", Name AC enUS : "[PH] PvP Cannon Shot Target" ; Wowhead enUS : "[PH] PvP Cannon Shot Target"
UPDATE `creature_template_locale` SET `Name` = 'PvP 포격 대상', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 23315;
-- AC datas : OLD Name : "군나르 토르바르드슨", Name AC enUS : "Gunnar Thorvardsson" ; Wowhead enUS : "Gunnar Thorvardsson"
UPDATE `creature_template_locale` SET `Name` = '군나르 토르바르드손', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 24162;
-- AC datas : OLD Name : "클레이튼 두빈 J", Name AC enUS : "Clayton Dubin J" ; Wowhead enUS : "Clayton Dubin Test J"
UPDATE `creature_template_locale` SET `Name` = '클레이튼 두빈 테스트 J', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27231;
-- AC datas : OLD Name : "용맹의 요새 보병 구경꾼", Name AC enUS : "[DND] Valiance Keep Footman Spectator" ; Wowhead enUS : "[DND] Valiance Keep Footman Spectator"
UPDATE `creature_template_locale` SET `Name` = '용맹의 성채 보병 구경꾼', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 27387;
-- AC datas : OLD Name : "수수께끼의 집시", Name AC enUS : "Mysterious Gypsy" ; Wowhead enUS : "Mysterious Trader"
UPDATE `creature_template_locale` SET `Name` = '수수께끼의 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 28652;
-- AC datas : OLD Name : "폭풍으로 벼려낸 불꽃마술사", Name AC enUS : "Stormforged Amplifier" ; Wowhead enUS : "Stormforged Amplifier"
UPDATE `creature_template_locale` SET `Name` = '폭풍벼림 불꽃마술사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30062;
-- AC datas : OLD Name : "폭풍으로 벼려낸 척살자", Name AC enUS : "Stormforged Decimator" ; Wowhead enUS : "Stormforged Decimator"
UPDATE `creature_template_locale` SET `Name` = '폭풍벼림 척살자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30503;
-- AC datas : OLD Subname : "QA Punching Bag", Subname AC enUS : "QA Punching Bag" ; Wowhead enUS : "QA Punching Bag"
UPDATE `creature_template_locale` SET `Title` = NULL, `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 30888;
-- AC datas : OLD Name : "러셀 베르나우 시험용 NPC", Name AC enUS : "Russell Bernau Test NPC" ; Wowhead enUS : "Ali Garchanter [TEST]"
UPDATE `creature_template_locale` SET `Name` = '알리 갈챈터 [시험용]', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31060;
-- AC datas : OLD Name : "일달라마르의 낙스라마스 10 휘장 상인", Name AC enUS : "Indalamar's Nax 10 Vendor" ; Wowhead enUS : "Indalamar's Nax 10 Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 낙스라마스 10 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31076;
-- AC datas : OLD Name : "일달라마르의 낙스라마스 25 휘장 상인", Name AC enUS : "Indalamar's Nax 25 Vendor" ; Wowhead enUS : "Indalamar's Nax 25 Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 낙스라마스 25 휘장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31116;
-- AC datas : OLD Name : "V", Name AC enUS : "V" ; Wowhead enUS : "zzOLDV"
UPDATE `creature_template_locale` SET `Name` = NULL, `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31168;
-- AC datas : OLD Name : "화염 저항 토템 V", Name AC enUS : "Fire Resistance Totem V" ; Wowhead enUS : "zzOLDFire Resistance Totem V"
UPDATE `creature_template_locale` SET `Name` = 'zzOLD화염 저항 토템 V', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31169;
-- AC datas : OLD Name : "자연 저항 토템 V", Name AC enUS : "Nature Resistance Totem V" ; Wowhead enUS : "zzOLDNature Resistance Totem V"
UPDATE `creature_template_locale` SET `Name` = 'zzOLD자연 저항 토템 V', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31173;
-- AC datas : OLD Name : "일달라마르의 무용의 문장 상인", Name AC enUS : "Indalamar's Emblem of Valor Vendor" ; Wowhead enUS : "Indalamar's Emblem of Valor Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 무용의 문장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31234;
-- AC datas : OLD Name : "은빛의 치유사", Name AC enUS : "Argent Healer" ; Wowhead enUS : "Argent Healer"
UPDATE `creature_template_locale` SET `Name` = '은빛십자군 치유사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31282;
-- AC datas : OLD Name : "일달라마르의 무용의 문장 상인", Name AC enUS : "Indalamar's Emblem of Heroism Vendor" ; Wowhead enUS : "Indalamar's Emblem of Heroism Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 무용의 문장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31331;
-- AC datas : OLD Name : "일달라마르의 바위 문지기의 조각 상인", Name AC enUS : "Indalamar's Stone Keeper's Shard Vendor" ; Wowhead enUS : "Indalamar's Stone Keeper's Shard Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 바위 문지기의 조각 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 31872;
-- AC datas : OLD Subname : "상인 여행자", Subname AC enUS : "Traveling Salesman" ; Wowhead enUS : "Traveling Salesman"
UPDATE `creature_template_locale` SET `Title` = '행상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32649;
-- AC datas : OLD Name : "불꽃 회오리 토템 IX", Name AC enUS : "Fire Nova Totem IX" ; Wowhead enUS : "zzOLDFire Nova Totem IX"
UPDATE `creature_template_locale` SET `Name` = 'zzOLD불꽃 회오리 토템 IX', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32775;
-- AC datas : OLD Name : "불꽃 회오리 토템 VIII", Name AC enUS : "Fire Nova Totem VIII" ; Wowhead enUS : "zzOLDFire Nova Totem VIII"
UPDATE `creature_template_locale` SET `Name` = 'zzOLD불꽃 회오리 토템 VIII', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 32776;
-- AC datas : OLD Name : "거대 전차 Mk II", Name AC enUS : "Leviathan Mk II" ; Wowhead enUS : "Leviathan Mk II"
UPDATE `creature_template_locale` SET `Name` = '거대 전차 마크 II', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33432;
-- AC datas : OLD Name : "아르객스 아이언구트", Name AC enUS : "Argex Irongut" ; Wowhead enUS : "Argex Irongut"
UPDATE `creature_template_locale` SET `Name` = '아르겍스 아이언구트', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33915;
-- AC datas : OLD Name : "일달라마르의 정복의 문장 상인", Name AC enUS : "Indalamar's Emblem of Conquest Vendor" ; Wowhead enUS : "Indalamar's Emblem of Conquest Vendor"
UPDATE `creature_template_locale` SET `Name` = '인달라마르의 정복의 문장 상인', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 33946;
-- AC datas : OLD Name : "길들일 수 있는 포자날개", Name AC enUS : "Tamable Sporebat" ; Wowhead enUS : "Tamable Sporebat"
UPDATE `creature_template_locale` SET `Name` = '길들일 수 있는 포자박쥐', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34018;
-- AC datas : OLD Name : "거대 전차 Mk II", Name AC enUS : "Leviathan Mk II" ; Wowhead enUS : "Leviathan Mk II"
UPDATE `creature_template_locale` SET `Name` = '거대 전차 마크 II', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34071;
-- AC datas : OLD Name : "폭풍으로 벼려낸 약탈자", Name AC enUS : "Stormforged Marauder" ; Wowhead enUS : "Stormforged Marauder"
UPDATE `creature_template_locale` SET `Name` = '폭풍벼림 약탈자', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 34915;
-- AC datas : OLD Name : "감독관 크라고쉬", Name AC enUS : "Overseer Kraggosh" ; Wowhead enUS : "Mutilated Body"
UPDATE `creature_template_locale` SET `Name` = '훼손된 시체', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 36217;
-- AC datas : OLD Subname : "순찰대 사령관", Subname AC enUS : "Ranger General" ; Wowhead enUS : "Ranger-General of Silvermoon"
UPDATE `creature_template_locale` SET `Title` = '실버문 순찰대 사령관', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 37527;
-- AC datas : OLD Name : "부정의 주입 처치 점수", Name AC enUS : "Unholy Infusion KC Bunny" ; Wowhead enUS : "Unholy Infusion KC Bunny"
UPDATE `creature_template_locale` SET `Name` = '부정 주입 처치 점수', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 38289;
-- AC datas : OLD Subname : "옛날 투기장 무기 상인", Subname AC enUS : "Exceptional Arena Weaponry" ; Wowhead enUS : "Savage Gladiator"
UPDATE `creature_template_locale` SET `Title` = '잔인한 검투사', `VerifiedBuild` = 0 WHERE `locale` = 'koKR' AND `entry` = 40212;

-- Insert new entries, from WOTLK
DELETE FROM `creature_template_locale` WHERE `entry` IN(230,841,1455,2286,2662,2939,3200,3697,4174,4224,4443,5002,7558,7559,15713,17515,19325,21444,21634,25537) AND `locale` = 'koKR';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(230,'koKR','손튼 펠우드','목수',0),
(841,'koKR','할 커터','목공용품 상인',0),
(1455,'koKR',NULL,'화살 상인',0),
(2286,'koKR','활잡이',NULL,0),
(2662,'koKR','항구주임 스지크','표 상인',0),
(2939,'koKR','잭슨 베이니','멧돼지 조련사',0),
(3200,'koKR','에릭의 특별한 행상인',NULL,0),
(3697,'koKR','킬른 롱클로','멧돼지 조련사',0),
(4174,'koKR','시안나이','화살 상인',0),
(4224,'koKR','탈레곤','지도제작용품 상인',0),
(4443,'koKR','와자','토템 상인',0),
(5002,'koKR','공용 멧돼지 조련사','멧돼지 조련사',0),
(7558,'koKR','솜꼬리토끼',NULL,0),
(7559,'koKR','점박이토끼',NULL,0),
(15713,'koKR','푸른 퀴라지 전차',NULL,0),
(17515,'koKR','사만다 리크래프트','빵가루 부인',0),
(19325,'koKR','바르누 크랙크러쉬','야수 관리인',0),
(21444,'koKR','템픽스 피네이글러','Temporary Karazhan Key Vendor',0),
(21634,'koKR','숲타조',NULL,0),
(25537,'koKR','Craig''s Test Human',NULL,0);

DELETE FROM `creature_template_locale` WHERE `entry` IN(39010) AND `locale` = 'koKR';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(39010,'koKR','순교자 추적기 (평판)',NULL,0);

-- Insert new entries, from CLASSIC
DELETE FROM `creature_template_locale` WHERE `entry` IN(128) AND `locale` = 'koKR';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(128,'koKR','화난 프로그래머 트위들 디',NULL,0);

-- Insert new entries, from CATA
DELETE FROM `creature_template_locale` WHERE `entry` IN(25323,25406,25411,26791,36795,38440) AND `locale` = 'koKR';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(25323,'koKR','크레이그 스틸','개발자',0),
(25406,'koKR','크레이그 스틸','개발자',0),
(25411,'koKR','크레이그 스틸','개발자',0),
(26791,'koKR','스콧 키난','암살자',0),
(36795,'koKR','러커스',NULL,0),
(38440,'koKR','토르퉁가',NULL,0);

-- Insert new entries, from RETAIL
DELETE FROM `creature_template_locale` WHERE `entry` IN(70100,179820,182758,182759,182760,182761,182764,182765,182766,182768,182769) AND `locale` = 'koKR';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(70100,'koKR','래시온',NULL,0),
(179820,'koKR','저주 추적기',NULL,0),
(182758,'koKR','붉은 원시뱀',NULL,0),
(182759,'koKR','붉은 원시뱀',NULL,0),
(182760,'koKR','대왕 원시뱀',NULL,0),
(182761,'koKR','대왕 원시뱀',NULL,0),
(182764,'koKR','대영주 다리온 모그레인','칠흑의 기사단 기수',0),
(182765,'koKR','클레이아',NULL,0),
(182766,'koKR','펠라고스',NULL,0),
(182768,'koKR','녹색 원시뱀',NULL,0),
(182769,'koKR','녹색 원시뱀',NULL,0);

-- List of entries using TBC datas :
-- 22057,24921
-- List of entries using CLASSIC datas :
-- 229,365,2833,12999,14824,15109,15218,15384,15809,15922,128
-- List of entries using CATA datas :
-- 27762,32753,32754,32755,32756,32757,32758,32759,32760,32761,32762,36701,38207,25323,25406,25411,26791,36795,38440
-- List of entries using RETAIL datas :
-- 81,399,444,10265,10444,14443,17065,18366,19846,23315,24162,27231,27387,28652,30062,30503,30888,31060,31076,31116,31168,31169,31173,31234,31282,31331,31872,32649,32775,32776,33432,33915,33946,34018,34071,34915,36217,37527,38289,40212,70100,179820,182758,182759,182760,182761,182764,182765,182766,182768,182769
