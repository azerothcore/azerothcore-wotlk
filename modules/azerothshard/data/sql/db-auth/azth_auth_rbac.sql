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

# Set general custom permission
UPDATE IGNORE `rbac_linked_permissions` SET `id` = 195 WHERE `id` < 100000 AND `linkedId` IN (
  25, # Allow say chat between factions
  26, # Allow channel chat between factions
  27, # Two side mail interaction
  28, # See two side who list
  29, # Add friends of other faction
  51  # Allow trading between factions
);

# Move to GM level 3 some dangerous commands
UPDATE IGNORE `rbac_linked_permissions` SET `id` = 192 WHERE `id` < 100000 AND `linkedId` IN (
  772, # Command: wp unload
  771, # Command: wp modify
  770, # Command: wp load
  769, # Command: wp event
  768, # Command: wp add
  595, # Command: npc move
  591, # Command: npc set spawntime
  590, # Command: npc set spawndist
  589, # Command: npc set phase
  588, # Command: npc set movetype
  587, # Command: npc set model
  586, # Command: npc set link
  585, # Command: npc set level
  584, # Command: npc set flag
  583, # Command: npc set factionid
  580, # Command: npc set
  579, # Command: npc add follow stop
  578, # Command: npc add follow
  577, # Command: npc add delete item
  576, # Command: npc add delete
  575, # Command: npc add temp
  574, # Command: npc add move
  573, # Command: npc add item
  572, # Command: npc add formation
  571, # Command: npc add
  399, # Command: gobject turn
  397, # Command: gobject set state
  396, # Command: gobject set phase
  395, # Command: gobject set
  393, # Command: gobject move
  391, # Command: gobject delete
  390, # Command: gobject add temp
  389, # Command: gobject add
  370, # Command: event stop
  369, # Command: event start
  532, # Command: unmute
  515, # Command: mute
  597, # Command: npc say
  598, # Command: npc texemote
  599, # Command: npc whisper
  600  # Command: npc yell
);

SET FOREIGN_KEY_CHECKS=0; -- disable temporary FKEY check


#
# Create AzerothShard custom Roles
#

DELETE FROM `rbac_linked_permissions` WHERE `id` >= 100000 OR `linkedId` >= 100000;
DELETE FROM `rbac_permissions` WHERE `id` >= 100000;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
('100000', 'Role: Azeroth GM Tier 0 ( Shared Interface )'),
('100001', 'Role: Azeroth GM Tier 1 ( Supporter )'),
('100002', 'Role: Azeroth GM Tier 2 ( Protector )'),
('100003', 'Role: Azeroth GM Tier 3 ( da definire )'),
('100004', 'Role: Master Entertainer'),
('100005', 'Role: Entertainer'),
('100006', 'Role: Master Story Teller'),
('100010', 'Role: Story Teller'),
('100011', 'Role: Test Player'),
('100012', 'Role: Azeroth Player'),
('100013', 'Role: Test GM'),
('100014', 'Role: Master Test GM'),
('200000', 'DISABLED COMMANDS');

#
# Create Other AS Custom Permissions
#

DELETE FROM `rbac_permissions` WHERE `id` IN ('1000');
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
('1000', 'Quest completer command');

-- Disable dangerous commands
UPDATE `rbac_linked_permissions` SET `id` = 200000 WHERE `id` < 100000 AND `linkedId` IN (
  717    # Command: reset all
);


SET FOREIGN_KEY_CHECKS=1; -- re-enable foreign key check

# Add default permissions
# test
DELETE FROM `rbac_default_permissions` WHERE `permissionId` >= 100000;
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('0', '100011', 2);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('1', '100013', 2);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('2', '100014', 2);
# development
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('0', '100011', 3);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('1', '100013', 3);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('2', '100014', 3);
# next
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('0', '100011', 4);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('1', '100013', 4);
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES ('2', '100014', 4);

INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`) VALUES ('0', '100012');

# Query to check current used permissions
# SELECT * FROM rbac_permissions WHERE id IN (SELECT linkedId FROM rbac_linked_permissions WHERE id >= 100000);


#
### LIVE SERVER ROLES ###
#

# [100012] Azeroth player
INSERT INTO `rbac_linked_permissions` VALUES (100012, 195);  # inheriting from PLAYER
INSERT INTO `rbac_linked_permissions` VALUES (100012, 309);  # Command: debug hostil
INSERT INTO `rbac_linked_permissions` VALUES (100012, 442);  # Command: lookup
INSERT INTO `rbac_linked_permissions` VALUES (100012, 443);  # Command: lookup area
INSERT INTO `rbac_linked_permissions` VALUES (100012, 444);  # Command: lookup creature
INSERT INTO `rbac_linked_permissions` VALUES (100012, 445);  # Command: lookup event
INSERT INTO `rbac_linked_permissions` VALUES (100012, 446);  # Command: lookup faction
INSERT INTO `rbac_linked_permissions` VALUES (100012, 447);  # Command: lookup item
INSERT INTO `rbac_linked_permissions` VALUES (100012, 448);  # Command: lookup itemset
INSERT INTO `rbac_linked_permissions` VALUES (100012, 449);  # Command: lookup object
INSERT INTO `rbac_linked_permissions` VALUES (100012, 450);  # Command: lookup quest
INSERT INTO `rbac_linked_permissions` VALUES (100012, 456);  # Command: lookup spell
INSERT INTO `rbac_linked_permissions` VALUES (100012, 457);  # Command: lookup spell id
INSERT INTO `rbac_linked_permissions` VALUES (100012, 458);  # Command: lookup taxinode
INSERT INTO `rbac_linked_permissions` VALUES (100012, 460);  # Command: lookup title
INSERT INTO `rbac_linked_permissions` VALUES (100012, 461);  # Command: lookup map
INSERT INTO `rbac_linked_permissions` VALUES (100012, 718);  # Command: server
INSERT INTO `rbac_linked_permissions` VALUES (100012, 1000); # Command: qc
INSERT INTO `rbac_linked_permissions` VALUES (100012, 736);  # Command: server motd

# [100000] TIER 0: Interface shared by all GMs
#
# PERMISSIONS
#
INSERT INTO `rbac_linked_permissions` VALUES (100000, 11);     # log gm trades
INSERT INTO `rbac_linked_permissions` VALUES (100000, 45);     # join channel without announce
INSERT INTO `rbac_linked_permissions` VALUES (100000, 46);     # change channel settings without be a Moderator

#
# COMMANDS
#
INSERT INTO `rbac_linked_permissions` VALUES (100000, 194);    # inheriting from GM 1
INSERT INTO `rbac_linked_permissions` VALUES (100000, 100012); # inheriting from Azeroth Player
INSERT INTO `rbac_linked_permissions` VALUES (100000, 373);    # Command: gm fly
INSERT INTO `rbac_linked_permissions` VALUES (100000, 459);    # Command: lookup tele
INSERT INTO `rbac_linked_permissions` VALUES (100000, 593);    # Command: npcinfo
INSERT INTO `rbac_linked_permissions` VALUES (100000, 796);    # Command: instance getbossstate
INSERT INTO `rbac_linked_permissions` VALUES (100000, 517);    # Command: pinfo
INSERT INTO `rbac_linked_permissions` VALUES (100000, 556);    # Command: modify phase
INSERT INTO `rbac_linked_permissions` VALUES (100000, 513);    # Command: maxskill
INSERT INTO `rbac_linked_permissions` VALUES (100000, 522);    # Command: respawn
INSERT INTO `rbac_linked_permissions` VALUES (100000, 523);    # Command: revive
INSERT INTO `rbac_linked_permissions` VALUES (100000, 526);    # Command: set skill
INSERT INTO `rbac_linked_permissions` VALUES (100000, 558);    # Command: modify rep
INSERT INTO `rbac_linked_permissions` VALUES (100000, 451);    # Command: lookup player
INSERT INTO `rbac_linked_permissions` VALUES (100000, 452);    # Command: lookup player ip
INSERT INTO `rbac_linked_permissions` VALUES (100000, 453);    # Command: lookup player account
INSERT INTO `rbac_linked_permissions` VALUES (100000, 454);    # Command: lookup player email
INSERT INTO `rbac_linked_permissions` VALUES (100000, 455);    # Command: lookup skill [ can inspect other players skills ]
INSERT INTO `rbac_linked_permissions` VALUES (100000, 417);    # Command: learn
INSERT INTO `rbac_linked_permissions` VALUES (100000, 418);    # Command: learn all
INSERT INTO `rbac_linked_permissions` VALUES (100000, 419);    # Command: learn all my
INSERT INTO `rbac_linked_permissions` VALUES (100000, 420);    # Command: learn all my class
INSERT INTO `rbac_linked_permissions` VALUES (100000, 421);    # Command: learn all my pettalents
INSERT INTO `rbac_linked_permissions` VALUES (100000, 422);    # Command: learn all my spells
INSERT INTO `rbac_linked_permissions` VALUES (100000, 423);    # Command: learn all my talents
INSERT INTO `rbac_linked_permissions` VALUES (100000, 424);    # Command: learn all gm
INSERT INTO `rbac_linked_permissions` VALUES (100000, 425);    # Command: learn all crafts
INSERT INTO `rbac_linked_permissions` VALUES (100000, 426);    # Command: learn all default
INSERT INTO `rbac_linked_permissions` VALUES (100000, 427);    # Command: learn all lang
INSERT INTO `rbac_linked_permissions` VALUES (100000, 428);    # Command: learn all recipes
INSERT INTO `rbac_linked_permissions` VALUES (100000, 429);    # COmmand: unlearn
INSERT INTO `rbac_linked_permissions` VALUES (100000, 251);    # Command: banlist ip
INSERT INTO `rbac_linked_permissions` VALUES (100000, 250);    # Command: banlist character
INSERT INTO `rbac_linked_permissions` VALUES (100000, 249);    # Command: banlist account
INSERT INTO `rbac_linked_permissions` VALUES (100000, 248);    # Command: banlist
INSERT INTO `rbac_linked_permissions` VALUES (100000, 247);    # Command: baninfo ip
INSERT INTO `rbac_linked_permissions` VALUES (100000, 246);    # Command: baninfo character
INSERT INTO `rbac_linked_permissions` VALUES (100000, 245);    # Command: baninfo account
INSERT INTO `rbac_linked_permissions` VALUES (100000, 244);    # Command: baninfo
INSERT INTO `rbac_linked_permissions` VALUES (100000, 521);    # Command: repairitems
INSERT INTO `rbac_linked_permissions` VALUES (100000, 711);    # Command: reset achievements
INSERT INTO `rbac_linked_permissions` VALUES (100000, 712);    # Command: reset honor
INSERT INTO `rbac_linked_permissions` VALUES (100000, 713);    # Command: reset level
INSERT INTO `rbac_linked_permissions` VALUES (100000, 714);    # Command: reset spells
INSERT INTO `rbac_linked_permissions` VALUES (100000, 715);    # Command: reset stats
INSERT INTO `rbac_linked_permissions` VALUES (100000, 716);    # Command: reset talents
INSERT INTO `rbac_linked_permissions` VALUES (100000, 710);    # Command: reset
INSERT INTO `rbac_linked_permissions` VALUES (100000, 488);    # Command: additem
INSERT INTO `rbac_linked_permissions` VALUES (100000, 489);    # Command: additemset
INSERT INTO `rbac_linked_permissions` VALUES (100000, 287);    # Command: levelup
INSERT INTO `rbac_linked_permissions` VALUES (100000, 231);    # Command: achievement add
INSERT INTO `rbac_linked_permissions` VALUES (100000, 602);    # Command: quest
INSERT INTO `rbac_linked_permissions` VALUES (100000, 603);    # Command: quest add
INSERT INTO `rbac_linked_permissions` VALUES (100000, 604);    # Command: quest complete
INSERT INTO `rbac_linked_permissions` VALUES (100000, 605);    # Command: quest remove
INSERT INTO `rbac_linked_permissions` VALUES (100000, 606);    # Command: quest reward
INSERT INTO `rbac_linked_permissions` VALUES (100000, 578);    # Command: npc follow
INSERT INTO `rbac_linked_permissions` VALUES (100000, 579);    # Command: npc follow stop
INSERT INTO `rbac_linked_permissions` VALUES (100000, 777);    # Command: mailbox
INSERT INTO `rbac_linked_permissions` VALUES (100000, 284);    # Command: character rename
INSERT INTO `rbac_linked_permissions` VALUES (100000, 274);    # Command: character customize
INSERT INTO `rbac_linked_permissions` VALUES (100000, 275);    # Command: character changefaction
INSERT INTO `rbac_linked_permissions` VALUES (100000, 276);    # Command: character changerace
INSERT INTO `rbac_linked_permissions` VALUES (100000, 795);    # Command: instance setbossstate
INSERT INTO `rbac_linked_permissions` VALUES (100000, 529);    # Command: unaura
INSERT INTO `rbac_linked_permissions` VALUES (100000, 500);    # Command: die
INSERT INTO `rbac_linked_permissions` VALUES (100000, 439);    # Command: list object
INSERT INTO `rbac_linked_permissions` VALUES (100000, 512);    # Command: listfreeze
INSERT INTO `rbac_linked_permissions` VALUES (100000, 398);    # gobject target
INSERT INTO `rbac_linked_permissions` VALUES (100000, 390);    # gobject add temp
INSERT INTO `rbac_linked_permissions` VALUES (100000, 394);    # gobject near
INSERT INTO `rbac_linked_permissions` VALUES (100000, 388);    # gobject near
INSERT INTO `rbac_linked_permissions` VALUES (100000, 497);    # command: cooldown
INSERT INTO `rbac_linked_permissions` VALUES (100000, 575);    # command: npc add temp
INSERT INTO `rbac_linked_permissions` VALUES (100000, 680);    # command: reload rbac
INSERT INTO `rbac_linked_permissions` VALUES (100000, 505);    # command: gps
INSERT INTO `rbac_linked_permissions` VALUES (100000, 406);    # command: guild rank

#
# WORLD CHANGE COMMANDS
#

INSERT INTO `rbac_linked_permissions` VALUES (100000,772); # Command: wp unload
INSERT INTO `rbac_linked_permissions` VALUES (100000,771); # Command: wp modify
INSERT INTO `rbac_linked_permissions` VALUES (100000,770); # Command: wp load
INSERT INTO `rbac_linked_permissions` VALUES (100000,769); # Command: wp event
INSERT INTO `rbac_linked_permissions` VALUES (100000,768); # Command: wp add
INSERT INTO `rbac_linked_permissions` VALUES (100000,595); # Command: npc move
INSERT INTO `rbac_linked_permissions` VALUES (100000,591); # Command: npc set spawntime
INSERT INTO `rbac_linked_permissions` VALUES (100000,590); # Command: npc set spawndist
INSERT INTO `rbac_linked_permissions` VALUES (100000,589); # Command: npc set phase
INSERT INTO `rbac_linked_permissions` VALUES (100000,588); # Command: npc set movetype
INSERT INTO `rbac_linked_permissions` VALUES (100000,587); # Command: npc set model
INSERT INTO `rbac_linked_permissions` VALUES (100000,586); # Command: npc set link
INSERT INTO `rbac_linked_permissions` VALUES (100000,585); # Command: npc set level
INSERT INTO `rbac_linked_permissions` VALUES (100000,584); # Command: npc set flag
INSERT INTO `rbac_linked_permissions` VALUES (100000,583); # Command: npc set factionid
INSERT INTO `rbac_linked_permissions` VALUES (100000,580); # Command: npc set
INSERT INTO `rbac_linked_permissions` VALUES (100000,577); # Command: npc add delete item
INSERT INTO `rbac_linked_permissions` VALUES (100000,576); # Command: npc add delete
INSERT INTO `rbac_linked_permissions` VALUES (100000,574); # Command: npc add move
INSERT INTO `rbac_linked_permissions` VALUES (100000,573); # Command: npc add item
INSERT INTO `rbac_linked_permissions` VALUES (100000,572); # Command: npc add formation
INSERT INTO `rbac_linked_permissions` VALUES (100000,571); # Command: npc add
INSERT INTO `rbac_linked_permissions` VALUES (100000,399); # Command: gobject turn
INSERT INTO `rbac_linked_permissions` VALUES (100000,397); # Command: gobject set state
INSERT INTO `rbac_linked_permissions` VALUES (100000,396); # Command: gobject set phase
INSERT INTO `rbac_linked_permissions` VALUES (100000,395); # Command: gobject set
INSERT INTO `rbac_linked_permissions` VALUES (100000,393); # Command: gobject move
INSERT INTO `rbac_linked_permissions` VALUES (100000,391); # Command: gobject delete
INSERT INTO `rbac_linked_permissions` VALUES (100000,389); # Command: gobject add

# [100001] TIER 1: Supporter
INSERT INTO `rbac_linked_permissions` VALUES (100001, 100000); # inheriting from TIER 0
INSERT INTO `rbac_linked_permissions` VALUES (100001, 743);    # Command: ticket assign
INSERT INTO `rbac_linked_permissions` VALUES (100001, 515);    # Command: mute

# [100002] TIER 2: Protector - Moderator
INSERT INTO `rbac_linked_permissions` VALUES (100002, 193);    # inheriting from GM 2
INSERT INTO `rbac_linked_permissions` VALUES (100002, 100001); # inherit from TIER 1
INSERT INTO `rbac_linked_permissions` VALUES (100002, 554);    # Command: modify money [ dangerous ]
INSERT INTO `rbac_linked_permissions` VALUES (100002, 256);    # Command: unban playeraccount
INSERT INTO `rbac_linked_permissions` VALUES (100002, 255);    # Command: unban ip
INSERT INTO `rbac_linked_permissions` VALUES (100002, 254);    # Command: unban character
INSERT INTO `rbac_linked_permissions` VALUES (100002, 253);    # Command: unban account
INSERT INTO `rbac_linked_permissions` VALUES (100002, 252);    # Command: unban
INSERT INTO `rbac_linked_permissions` VALUES (100002, 243);    # Command: ban playeraccount
INSERT INTO `rbac_linked_permissions` VALUES (100002, 242);    # Command: ban ip
INSERT INTO `rbac_linked_permissions` VALUES (100002, 241);    # Command: ban character
INSERT INTO `rbac_linked_permissions` VALUES (100002, 240);    # Command: ban account
INSERT INTO `rbac_linked_permissions` VALUES (100002, 239);    # Command: ban
INSERT INTO `rbac_linked_permissions` VALUES (100002, 542);    # Command: morph
INSERT INTO `rbac_linked_permissions` VALUES (100002, 543);    # Command: demorph
INSERT INTO `rbac_linked_permissions` VALUES (100002, 532);    # Command: unmute

# [100003] TIER 3
INSERT INTO `rbac_linked_permissions` VALUES (100003, 193);    # inheriting from GM LVL 2
INSERT INTO `rbac_linked_permissions` VALUES (100003, 100002); # inherit from TIER 2

# [100005] Entertainer
INSERT INTO `rbac_linked_permissions` VALUES (100005, 100000); # inherit from TIER 0
INSERT INTO `rbac_linked_permissions` VALUES (100005, 542); # Command: morph
INSERT INTO `rbac_linked_permissions` VALUES (100005, 543); # Command: demorph
INSERT INTO `rbac_linked_permissions` VALUES (100005, 535); # Command: wchange
INSERT INTO `rbac_linked_permissions` VALUES (100005, 597); # Command: npc say
INSERT INTO `rbac_linked_permissions` VALUES (100005, 596);    # Command: npc playemote
INSERT INTO `rbac_linked_permissions` VALUES (100005, 598);    # Command: npc textemote
INSERT INTO `rbac_linked_permissions` VALUES (100005, 599);    # Command: npc whisper
INSERT INTO `rbac_linked_permissions` VALUES (100005, 600);    # Command: npc yell
INSERT INTO `rbac_linked_permissions` VALUES (100005, 480);    # Command: pet create

# [100004] Master Entertainer
INSERT INTO `rbac_linked_permissions` VALUES (100004, 100005); # inheriting from Entertainer
INSERT INTO `rbac_linked_permissions` VALUES (100004, 193);    # inheriting from GM LVL 2

# [100010] Story Teller
INSERT INTO `rbac_linked_permissions` VALUES (100010, 100005); # inherit from Entertainer

# [100006] Master Story Teller
INSERT INTO `rbac_linked_permissions` VALUES (100006, 100010); # inheriting Story Teller
INSERT INTO `rbac_linked_permissions` VALUES (100006, 193);    # inheriting from GM LVL 2


### TEST SERVER ROLES ###

# Special: test realm player
INSERT INTO `rbac_linked_permissions` VALUES (100011, 100012); # inheriting from Azeroth Player
INSERT INTO `rbac_linked_permissions` VALUES (100011, 291);    # Command: cheat
INSERT INTO `rbac_linked_permissions` VALUES (100011, 294);    # Command: cheat explore
INSERT INTO `rbac_linked_permissions` VALUES (100011, 298);    # Command: cheat taxi
INSERT INTO `rbac_linked_permissions` VALUES (100011, 377);    # Command: go
INSERT INTO `rbac_linked_permissions` VALUES (100011, 378);    # Command: go creature
INSERT INTO `rbac_linked_permissions` VALUES (100011, 442);    # Command: lookup
INSERT INTO `rbac_linked_permissions` VALUES (100011, 447);    # Command: lookup item
INSERT INTO `rbac_linked_permissions` VALUES (100011, 488);    # Command: additem
INSERT INTO `rbac_linked_permissions` VALUES (100011, 489);    # Command: additemset
INSERT INTO `rbac_linked_permissions` VALUES (100011, 287);    # Command: levelup
INSERT INTO `rbac_linked_permissions` VALUES (100011, 554);    # Command: modify money
INSERT INTO `rbac_linked_permissions` VALUES (100011, 737);    # Command: tele
INSERT INTO `rbac_linked_permissions` VALUES (100011, 459);    # Command: lookup tele
INSERT INTO `rbac_linked_permissions` VALUES (100011, 593);    # Command: npcinfo
INSERT INTO `rbac_linked_permissions` VALUES (100011, 796);    # Command: instance getbossstate

# Special: test realm GM
INSERT INTO `rbac_linked_permissions` VALUES (100013, 193);     # inheriting from GM LVL 2
INSERT INTO `rbac_linked_permissions` VALUES (100013, 100011);  # inherit from test player
INSERT INTO `rbac_linked_permissions` VALUES (100013, 100010);  # inherit from common GM interface
INSERT INTO `rbac_linked_permissions` VALUES (100013, 498);     # Command: damage
INSERT INTO `rbac_linked_permissions` VALUES (100013, 500);     # Command: die
INSERT INTO `rbac_linked_permissions` VALUES (100013, 795);     # Command: instance setbossstate
INSERT INTO `rbac_linked_permissions` VALUES (100013, 796);     # Command: instance getbossstate
INSERT INTO `rbac_linked_permissions` VALUES (100013, 370);     # Command: event stop
INSERT INTO `rbac_linked_permissions` VALUES (100013, 369);     # Command: event start
INSERT INTO `rbac_linked_permissions` VALUES (100013, 373);     # Command: gm fly
INSERT INTO `rbac_linked_permissions` VALUES (100013, 517);     # Command: pinfo
INSERT INTO `rbac_linked_permissions` VALUES (100013, 513);     # Command: maxskill
INSERT INTO `rbac_linked_permissions` VALUES (100013, 522);     # Command: respawn
INSERT INTO `rbac_linked_permissions` VALUES (100013, 523);     # Command: revive
INSERT INTO `rbac_linked_permissions` VALUES (100013, 526);     # Command: set skill
INSERT INTO `rbac_linked_permissions` VALUES (100013, 558);     # Command: modify rep
INSERT INTO `rbac_linked_permissions` VALUES (100013, 455);     # Command: lookup skill [ can inspect other players skills ]
INSERT INTO `rbac_linked_permissions` VALUES (100013, 556);     # Command: modify phase
INSERT INTO `rbac_linked_permissions` VALUES (100013, 417);     # Command: learn
INSERT INTO `rbac_linked_permissions` VALUES (100013, 418);     # Command: learn all
INSERT INTO `rbac_linked_permissions` VALUES (100013, 419);     # Command: learn all my
INSERT INTO `rbac_linked_permissions` VALUES (100013, 420);     # Command: learn all my class
INSERT INTO `rbac_linked_permissions` VALUES (100013, 421);     # Command: learn all my pettalents
INSERT INTO `rbac_linked_permissions` VALUES (100013, 422);     # Command: learn all my spells
INSERT INTO `rbac_linked_permissions` VALUES (100013, 423);     # Command: learn all my talents
INSERT INTO `rbac_linked_permissions` VALUES (100013, 424);     # Command: learn all gm
INSERT INTO `rbac_linked_permissions` VALUES (100013, 425);     # Command: learn all crafts
INSERT INTO `rbac_linked_permissions` VALUES (100013, 426);     # Command: learn all default
INSERT INTO `rbac_linked_permissions` VALUES (100013, 427);     # Command: learn all lang
INSERT INTO `rbac_linked_permissions` VALUES (100013, 428);     # Command: learn all recipes
INSERT INTO `rbac_linked_permissions` VALUES (100013, 429);     # COmmand: unlearn
INSERT INTO `rbac_linked_permissions` VALUES (100013, 521);     # Command: repairitems
INSERT INTO `rbac_linked_permissions` VALUES (100013, 711);     # Command: reset achievements
INSERT INTO `rbac_linked_permissions` VALUES (100013, 712);     # Command: reset honor
INSERT INTO `rbac_linked_permissions` VALUES (100013, 713);     # Command: reset level
INSERT INTO `rbac_linked_permissions` VALUES (100013, 714);     # Command: reset spells
INSERT INTO `rbac_linked_permissions` VALUES (100013, 715);     # Command: reset stats
INSERT INTO `rbac_linked_permissions` VALUES (100013, 716);     # Command: reset talents
INSERT INTO `rbac_linked_permissions` VALUES (100013, 710);     # Command: reset
INSERT INTO `rbac_linked_permissions` VALUES (100013, 488);     # Command: additem
INSERT INTO `rbac_linked_permissions` VALUES (100013, 489);     # Command: additemset
INSERT INTO `rbac_linked_permissions` VALUES (100013, 231);     # Command: achievement add
INSERT INTO `rbac_linked_permissions` VALUES (100013, 602);     # Command: quest
INSERT INTO `rbac_linked_permissions` VALUES (100013, 603);     # Command: quest add
INSERT INTO `rbac_linked_permissions` VALUES (100013, 604);     # Command: quest complete
INSERT INTO `rbac_linked_permissions` VALUES (100013, 605);     # Command: quest remove
INSERT INTO `rbac_linked_permissions` VALUES (100013, 606);     # Command: quest reward
INSERT INTO `rbac_linked_permissions` VALUES (100013, 777);     # Command: mailbox
INSERT INTO `rbac_linked_permissions` VALUES (100013, 284);     # Command: character rename
INSERT INTO `rbac_linked_permissions` VALUES (100013, 274);     # Command: character customize
INSERT INTO `rbac_linked_permissions` VALUES (100013, 275);     # Command: character changefaction
INSERT INTO `rbac_linked_permissions` VALUES (100013, 276);     # Command: character changerace
INSERT INTO `rbac_linked_permissions` VALUES (100013, 529);     # Command: unaura

# [100014] Master Test GM
INSERT INTO `rbac_linked_permissions` VALUES (100014, 100013); # inheriting from Test GM
