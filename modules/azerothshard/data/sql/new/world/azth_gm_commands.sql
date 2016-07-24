#
# AzerothShard RBAC Structure
#
# Current original Roles are:
# 198 Moderator Commands
# 197 GameMaster Commands
# 196 Administrator Commands
#
# 195: Player 0
# 194: Moderator 1
# 193: GameMaster 2
# 192: Administrator 3
#
# AzerothShard custom roles: 100000+
#

# IMPORTANT RULE:  do NOT insert duplicate linked permissions for multiple non-custom roles

#
# EDIT DEFAULT PERMISSIONS
#

# Move to GM level 3 some dangerous commands
UPDATE command SET `security` = 3 WHERE NAME IN 
(
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
"gobject add",
"event stop",
"event start",
"unmute",
"mute",
"npc say",
"npc texemote",
"npc whisper",
"npc yell"
);
#
### LIVE SERVER ROLES ###
#

# [100012] Azeroth player
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
"server",
"qc",
"server motd"
);

# [100000] TIER 0: Interface shared by all GMs

#
# COMMANDS
#
UPDATE command SET `security` = 1 WHERE `name` IN
(
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
"reload rbac",
"gps",
"guild rank"
);

#
# WORLD CHANGE COMMANDS
#

UPDATE command SET `security` = 3 WHERE `name` IN
(
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
"npc add delete item",
"npc add delete",
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
"gobject add"
);


# [100001] TIER 1: Supporter
UPDATE command SET `security` = 1 WHERE `name` IN
(
"mute",
"ticket assign"
);

# [100002] TIER 2: Protector - Moderator
UPDATE command SET `security` = 2 WHERE `name` IN
(
"modify money", -- dangerous!
"unban playeraccount",
"unban ip",
"unban character",
"unban account",
"unban",
"ban playeraccount",
"ban ip",
"ban character",
"ban account",
"ban",
"morph",
"demorph",
"unmute"
);

# [100005] Entertainer
UPDATE command SET `security` = 1 WHERE `name` IN
(
"morph",
"demorph",
"wchange",
"npc say",
"npc playemote",
"npc textemote",
"npc whisper",
"npc yell",
"pet create"
);


