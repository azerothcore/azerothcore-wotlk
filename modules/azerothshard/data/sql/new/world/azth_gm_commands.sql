#
# EDIT DEFAULT PERMISSIONS
#
# lvl 0: Player
# lvl 1: GM T1
# lvl 2: Entertainer/Story Teller
# lvl 3: GM T2
# lvl 4: Administrator
#

# Move to GM level 4 ( admin ) some dangerous commands
UPDATE command SET `security` = 4 WHERE NAME IN 
(
"reset all",
"ticket reset",
"reset honor"
);

#
### LIVE SERVER ROLES ###
#

# lvl 0: Azeroth player
UPDATE command SET `security` = 0 WHERE `name` IN
(
"debug hostil",
"lookup",
"lookup area",
"lookup creature",
"lookup event",
"lookup faction",
"lookup item",
"lookup itemset",
"lookup object",
"lookup quest",
"lookup spell",
"lookup spell id",
"lookup taxinode",
"lookup title",
"lookup map",
"qc",
"server motd"
);

#
# TIER 1 ( lvl 1 ): GM T1 Supporter
UPDATE command SET `security` = 1 WHERE `name` IN
(
"modify money", -- dangerous!
"gm fly",
"lookup tele",
"npcinfo",
"instance getbossstate",
"pinfo",
"modify phase",
"maxskill",
"respawn",
"revive",
"set skill",
"modify rep",
"lookup player",
"lookup player ip",
"lookup player account",
"lookup player email",
"lookup skill [ can inspect other players skills ]",
"learn",
"learn all",
"learn all my",
"learn all my class",
"learn all my pettalents",
"learn all my spells",
"learn all my talents",
"learn all gm",
"learn all crafts",
"learn all default",
"learn all lang",
"learn all recipes",
"unlearn",
"banlist ip",
"banlist character",
"banlist account",
"banlist",
"baninfo ip",
"baninfo character",
"baninfo account",
"baninfo",
"repairitems",
"reset achievements",
"reset honor",
"reset level",
"reset spells",
"reset stats",
"reset talents",
"reset",
"additem",
"additemset",
"levelup",
"achievement add",
"quest",
"quest add",
"quest complete",
"quest remove",
"quest reward",
"npc follow",
"npc follow stop",
"mailbox",
"character rename",
"character customize",
"character changefaction",
"character changerace",
"instance setbossstate",
"unaura",
"die",
"list object",
"listfreeze",
"cooldown",
"npc add temp",
"reload command",
"gps",
"guild rank",
"title",
"unmute",
"mute",
"ticket assign",
"morph",
"demorph",

--
-- WORLD CHANGE COMMANDS
--

"wp unload",
"wp modify",
"wp load",
"wp event",
"wp add",
"npc move",
"npc set spawntime",
"npc set spawndist",
"npc set phase",
"npc set movetype",
"npc set model",
"npc set link",
"npc set level",
"npc set flag",
"npc set factionid",
"npc set",
"npc add follow stop",
"npc add follow",
"npc add delete item",
"npc add delete",
"npc add temp",
"npc add move",
"npc add item",
"npc add formation",
"npc add",
"gobject turn",
"gobject set state",
"gobject set phase",
"gobject set",
"gobject move",
"gobject delete",
"gobject add temp",
"gobject add"
);

# lvl 2: Entertainer
UPDATE command SET `security` = 2 WHERE `name` IN
(
"wchange",
"npc say",
"npc playemote",
"npc textemote",
"npc whisper",
"npc yell",
"pet create",
"event stop",
"event start"
);


# TIER 2 ( lvl 3 ): Protector - Moderator
UPDATE command SET `security` = 3 WHERE `name` IN
(
"unban playeraccount",
"unban ip",
"unban character",
"unban account",
"unban",
"ban playeraccount",
"ban ip",
"ban character",
"ban account",
"ban"
);