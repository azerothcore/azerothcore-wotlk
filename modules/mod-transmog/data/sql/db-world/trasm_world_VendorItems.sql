SET
@HideEntry   = 57575,
@RemoveEntry = 57576,
@HideName    = "Hide Equipped",
@RemoveName  = "Clear Transmog";

DELETE FROM `item_template` WHERE `entry` = @HideEntry OR `entry` = @RemoveEntry;

INSERT INTO `item_template` (`entry`, `class`, `subclass`, `name`, `displayid`, `InventoryType`, `description`) VALUES
(@HideEntry,   15, 0, @HideName,   55112, 0, "Hide the item in this slot."),
(@RemoveEntry, 15, 0, @RemoveName, 8931,  0, "Remove active transmog for this item.");

DELETE FROM `item_template_locale` WHERE `ID` = @HideEntry OR `ID` = @RemoveEntry;
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`) VALUES
(@HideEntry,  "koKR", "장착된 아이템 숨기기", "이 슬롯의 아이템을 숨깁니다."),
(@RemoveEntry,"koKR", "변형 지우기", "이 아이템의 활성화된 변형을 제거합니다."),
(@HideEntry,  "frFR", "Masquer l'équipement", "Masquer l'objet dans cet emplacement."),
(@RemoveEntry,"frFR", "Effacer transmog", "Supprimer la transmog active."),
(@HideEntry,  "deDE", "Ausgerüstet verbergen", "Item in diesem Slot verbergen."),
(@RemoveEntry,"deDE", "Transmog zurücksetzen", "Aktive Transmogrifikation entfernen."),
(@HideEntry,  "zhCN", "隐藏已装备", "隐藏此物品。"),
(@RemoveEntry,"zhCN", "清除幻化", "移除激活的幻化。"),
(@HideEntry,  "zhTW", "隱藏已裝備", "隱藏此物品。"),
(@RemoveEntry,"zhTW", "清除幻化", "移除啟用的幻化。"),
(@HideEntry,  "esES", "Ocultar equipado", "Ocultar el objeto en esta ranura."),
(@RemoveEntry,"esES", "Borrar transmog", "Eliminar la transmog activa."),
(@HideEntry,  "esMX", "Ocultar equipado", "Ocultar el objeto en este espacio."),
(@RemoveEntry,"esMX", "Borrar transmog", "Eliminar la transmog activa."),
(@HideEntry,  "ruRU", "Скрыть экипированное", "Скрыть предмет в слоте."),
(@RemoveEntry,"ruRU", "Очистить трансмог", "Удалить активный трансмог.");
