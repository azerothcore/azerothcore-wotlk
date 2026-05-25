-- DB update 2024_04_27_00 -> 2024_04_29_00
UPDATE `gossip_menu_option_locale` SET `OptionText`=REPLACE(`OptionText`,'Ã¤','ä') WHERE `Locale`='deDE';
UPDATE `gossip_menu_option_locale` SET `OptionText`=REPLACE(`OptionText`,'Ã¼','ü') WHERE `Locale`='deDE';
UPDATE `gossip_menu_option_locale` SET `OptionText`=REPLACE(`OptionText`,'Ã¶','ö') WHERE `Locale`='deDE';
UPDATE `gossip_menu_option_locale` SET `BoxText`=REPLACE(`BoxText`,'Ã¤','ä') WHERE `Locale`='deDE';
UPDATE `gossip_menu_option_locale` SET `BoxText`=REPLACE(`BoxText`,'Ã¼','ü') WHERE `Locale`='deDE';
UPDATE `gossip_menu_option_locale` SET `BoxText`=REPLACE(`BoxText`,'Ã¶','ö') WHERE `Locale`='deDE';
