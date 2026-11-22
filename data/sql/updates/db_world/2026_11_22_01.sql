-- DB update 2026_11_22_00 -> 2026_11_22_01
DELETE FROM `command` WHERE `name` IN ('summon', 'groupsummon', 'group summon');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('summon', 2, 'Syntax: .summon [$charactername]\r\n\r\nTeleport the given character to you. Character can be offline, in which case only their saved position is changed. Summoning an online character into an instance requires them to already be bound or grouped to your instance copy, and summoning a non-GM account there requires the "Summon non-GM players into instances" permission.'),
('group summon', 2, 'Syntax: .group summon [$charactername]\r\n\r\nTeleport the online members of the given character''s group to you. Without a name, uses the selected character or yourself. Inside a battleground, the character''s own party is used instead of the battleground raid. Members who can''t be summoned are reported and skipped. Inside an instance, the same restrictions as .summon apply to each member.');

DELETE FROM `acore_string` WHERE `entry` IN (103, 35489, 35490);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(103, '{} can''t be summoned to your instance: their instance bind or group would place them in another copy of this map.'),
(35489, '{} is not a GM account and you lack the permission to summon players into instances.'),
(35490, '{} is in a battleground raid. Summon them out of it first, then into your instance.');

DELETE FROM `acore_string_locale` WHERE `entry` IN (103, 35489, 35490);
INSERT INTO `acore_string_locale` (`entry`, `locale`, `content`) VALUES
(103, 'koKR', '{}을(를) 인스턴스로 소환할 수 없습니다: 귀속 정보나 파티 때문에 이 지역의 다른 인스턴스로 이동하게 됩니다.'),
(103, 'frFR', '{} ne peut pas être invoqué dans votre instance : son lien d''instance ou son groupe l''enverrait dans une autre copie de cette carte.'),
(103, 'deDE', '{} kann nicht in Eure Instanz beschworen werden: Instanzbindung oder Gruppe würden ihn in eine andere Kopie dieser Karte bringen.'),
(103, 'zhCN', '无法将 {} 召唤到你的副本：其副本绑定或队伍会将其送往该地图的另一个副本。'),
(103, 'zhTW', '無法將 {} 召喚到你的副本：其副本綁定或隊伍會將其送往該地圖的另一個副本。'),
(103, 'esES', 'No se puede invocar a {} a tu instancia: su vínculo de instancia o su grupo lo llevaría a otra copia de este mapa.'),
(103, 'esMX', 'No se puede invocar a {} a tu instancia: su vínculo de instancia o su grupo lo llevaría a otra copia de este mapa.'),
(103, 'ruRU', '{} нельзя призвать в ваше подземелье: привязка или группа отправят его в другую копию этой карты.'),
(35489, 'koKR', '{}은(는) GM 계정이 아니며, 플레이어를 인스턴스로 소환할 권한이 없습니다.'),
(35489, 'frFR', '{} n''est pas un compte MJ et vous n''avez pas la permission d''invoquer des joueurs dans les instances.'),
(35489, 'deDE', '{} ist kein GM-Konto und Ihr habt keine Berechtigung, Spieler in Instanzen zu beschwören.'),
(35489, 'zhCN', '{} 不是GM账号，且你没有将玩家召唤到副本的权限。'),
(35489, 'zhTW', '{} 不是GM帳號，且你沒有將玩家召喚到副本的權限。'),
(35489, 'esES', '{} no es una cuenta de MJ y no tienes permiso para invocar jugadores a instancias.'),
(35489, 'esMX', '{} no es una cuenta de GM y no tienes permiso para invocar jugadores a instancias.'),
(35489, 'ruRU', '{} не является учётной записью ГМ, а у вас нет права призывать игроков в подземелья.'),
(35490, 'koKR', '{}은(는) 전장 공격대에 있습니다. 먼저 전장에서 소환한 뒤 인스턴스로 소환하세요.'),
(35490, 'frFR', '{} est dans un raid de champ de bataille. Invoquez-le d''abord hors de celui-ci, puis dans votre instance.'),
(35490, 'deDE', '{} ist in einem Schlachtfeldschlachtzug. Beschwört ihn zuerst heraus und dann in Eure Instanz.'),
(35490, 'zhCN', '{} 在战场团队中。请先将其召唤出战场，再召唤到你的副本。'),
(35490, 'zhTW', '{} 在戰場團隊中。請先將其召喚出戰場，再召喚到你的副本。'),
(35490, 'esES', '{} está en una banda de campo de batalla. Invócalo primero fuera de ella y luego a tu instancia.'),
(35490, 'esMX', '{} está en una banda de campo de batalla. Invócalo primero fuera de ella y luego a tu instancia.'),
(35490, 'ruRU', '{} находится в рейде поля боя. Сначала призовите его оттуда, затем в ваше подземелье.');
