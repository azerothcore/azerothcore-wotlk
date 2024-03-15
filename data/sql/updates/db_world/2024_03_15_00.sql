-- DB update 2024_03_13_01 -> 2024_03_15_00
-- [START] // DB Update for .reset items command

/*---------------------------------

	Command and associated help
	
-----------------------------------*/

-- Always delete before insert to ensure script repeatability :
-- One value per line to facilitate readability
DELETE FROM `command` WHERE `name` IN(
'reset items',
'reset items equipped',
'reset items bags',
'reset items bank',
'reset items keyring',
'reset items currency',
'reset items vendor_buyback',
'reset items all',
'reset items allbags');

-- GM Security level associated with the commands
SET @GM_SECURITY_LEVEL = 3; 

-- Insert values :
INSERT INTO `command`(`name`,`security`,`help`)
VALUES (
-- .reset items (main command)
'reset items', @GM_SECURITY_LEVEL, 'Syntax : .reset items equipped|bags|bank|keyring|currency|vendor_buyback|all|allbags #playername
Delete items in the player inventory (equipped, bank, bags etc...) depending on the chosen option.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

-- .reset items _____  (Sub-commands)
('reset items equipped', @GM_SECURITY_LEVEL, 'Syntax : .reset items equipped #playername
Delete all items equipped on the target player.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items bags', @GM_SECURITY_LEVEL, 'Syntax : .reset items bags #playername
Delete all items in the selected player\'s bags.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items bank', @GM_SECURITY_LEVEL, 'Syntax : .reset items bank #playername
Delete all items in the selected player\'s bank.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items keyring', @GM_SECURITY_LEVEL, 'Syntax : .reset items keyring #playername
Delete all items in the selected player\'s keyring.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items currency', @GM_SECURITY_LEVEL, 'Syntax : .reset items currency #playername
Delete all items in the selected player\'s currencies list.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items vendor_buyback', @GM_SECURITY_LEVEL, 'Syntax : .reset items vendor_buyback #playername
Delete all items in the selected player\'s vendor buyback tab.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items all', @GM_SECURITY_LEVEL, 'Syntax : .reset items all #playername
Delete all items in the selected player\'s inventory (equipped, in bags, in bank, in keyring, in currency list and in vendor buy back tab).
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.'),

('reset items allbags', @GM_SECURITY_LEVEL, 'Syntax : .reset items allbags #playername
Delete all items in the selected player\'s inventory (equipped, in bags, in bank, in keyring, in currency list and in vendor buy back tab)
This command also deletes the bags.
#playername : Optional target player name (if player is online only). If not provided the command will execute on the selected target player.');

/*---------------------------------------------------------------------------------
	LANG_* strings used by the core at command use.
	All of them are stored in table `acore_string`
	Note : We should think to add a `enum_tag` column to the `acore_string` table 
	in order to automatize the rebuild of Language.h file
------------------------------------------------------------------------------------*/

-- Always delete before insert to ensure script repeatability :
DELETE FROM `acore_string` WHERE `entry` IN (365, 366, 367, 368, 369, 370, 371, 372);

-- Insert values :
-- Attention : Need to translate in other languages. Since I'm French I will set only english and french ones :-)
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_frFR`)
VALUES (365, '|cffffffff%d|r equipped items deleted for %s', '|cffffffff%d|r objets équipés supprimés pour %s'),
	   (366, '|cffffffff%d|r items in equipped bags deleted for %s', '|cffffffff%d|r objets supprimés dans les sacs de %s'),
	   (367, '|cffffffff%d|r items in bank deleted for %s', '|cffffffff%d|r objets supprimés de la banque de %s'),
	   (368, '|cffffffff%d|r keys in keyring deleted for %s', '|cffffffff%d|r objets supprimés du porte-clés de %s'),
	   (369, '|cffffffff%d|r currencies deleted for %s', '|cffffffff%d|r types de monnaies supprimées l\'inventaire de %s'),
	   (370, '|cffffffff%d|r items in vendors buyback deleted for %s', '|cffffffff%d|r objets supprimés dans l\'onglet rachat des vendeurs pour %s'),
	   (371, 'All items were deleted for %s :
|cffffffff%d|r items equipped
|cffffffff%d|r items in bags
|cffffffff%d|r items in bank
|cffffffff%d|r keys in keyring
|cffffffff%d|r currency types
|cffffffff%d|r items in vendor buyback', 
'Tous les objets de %s ont été supprimés :
|cffffffff%d|r objet équipés
|cffffffff%d|r objets dans les sacs
|cffffffff%d|r objets en banque
|cffffffff%d|r clés dans le porte-clés
|cffffffff%d|r types de monnaies
|cffffffff%d|r objets dans l\'onglet rachat des vendeurs'),
	   (372, 'All items were deleted for %s (bags included):
|cffffffff%d|r equipped
|cffffffff%d|r items in bags
|cffffffff%d|r items in bank
|cffffffff%d|r keys in keyring
|cffffffff%d|r currency types
|cffffffff%d|r items in vendor buyback
|cffffffff%d|r standard bags
|cffffffff%d|r bank bags', 
'Tous les objets de %s ont été supprimés (sacs y-compris):
|cffffffff%d|r objet équipés
|cffffffff%d|r objets dans les sacs
|cffffffff%d|r objets en banque
|cffffffff%d|r clés dans le porte-clés
|cffffffff%d|r types de monnaies
|cffffffff%d|r objets dans l\'onglet rachat des vendeurs
|cffffffff%d|r sacs standard
|cffffffff%d|r sacs de banque'
);

-- [END] // DB Update for .reset items command;


