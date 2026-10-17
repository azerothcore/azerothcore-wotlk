-- DB update 2025_01_19_00 -> 2025_01_19_01
--
-- Deletes `LANG_PASSWORD_TOO_LONG` and `LANG_ACCOUNT_TOO_LONG`.
DELETE FROM `acore_string` WHERE `entry` IN (55, 1005);

INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
-- Added the missing texts (LANG_PASSWORD_TOO_LONG) for "French" and "Russian".
(55, "Your password can't be longer than 16 characters (client limit), password not changed!", NULL, "Le mot de passe ne doit pas dépasser 16 caractères (limitation technique du client), le mot de passe n'a pas été changé!", "Das Passwort kann nicht länger als 16 Zeichen sein (Client Limit). Das Passwort wurde nicht geändert!", "你的新密码不能超过16个字符 (客户端限制)， 密码没有修改！", NULL, "Su contraseña no puede tener más de 16 caracteres (límite del cliente), ¡la contraseña no se cambia!", "Su contraseña no puede tener más de 16 caracteres (límite del cliente), ¡la contraseña no se cambia!", "Ваш пароль не может быть длиннее 16 символов (клиентский лимит), пароль не изменен!"),
-- Added the missing texts (LANG_ACCOUNT_TOO_LONG) for "French", "Spain Spanish", "Mexican Spanish" and "Russian.
-- Corrcted ALL the character "client limit" to 17 (from 20).
(1005, "Account name can't be longer than 17 characters (client limit), account not created!", NULL, "Le nom de compte ne doit pas dépasser 17 caractères (limitation technique du client), le compte n'a pas été créé!", "Der Account Name kann nicht länger als 17 Zeichen sein (Client Limit). Account wurde nicht erstellt!", "帐号名长度不能超过17个字符（客户端限制），帐户创建失败！", NULL, "El nombre de la cuenta no puede tener más de 17 caracteres (límite de cliente), ¡cuenta no creada!", "El nombre de la cuenta no puede tener más de 17 caracteres (límite de cliente), ¡cuenta no creada!", "Имя учетной записи не может быть длиннее 17 символов (ограничение для клиента), учетная запись не создана!");
