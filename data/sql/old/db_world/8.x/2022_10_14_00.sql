-- DB update 2022_10_13_00 -> 2022_10_14_00
UPDATE `broadcast_text_locale` SET `MaleText`="Esta es nuestra batalla final. El paso del tiempo se hará eco de lo que aquí ocurra. Sin importar el resultado, sabrán que luchamos con honor. ¡Que luchamos por la libertad y la seguridad de nuestro pueblo!" WHERE `ID`=36923 AND `locale` IN ('esEs', 'esMX');

UPDATE `creature_text` SET `BroadcastTextId`=37037 WHERE `CreatureID`=38607 AND `GroupID`=13 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=37043 WHERE `CreatureID`=38607 AND `GroupID`=14 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=37046 WHERE `CreatureID`=38607 AND `GroupID`=15 AND `ID`=0;

UPDATE `creature_template` SET `gossip_menu_id`=10953, `npcflag`=`npcflag`|1 WHERE `entry`=37187;

DELETE FROM `gossip_menu` WHERE `MenuID`=10953;

INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(10953, 15217);
