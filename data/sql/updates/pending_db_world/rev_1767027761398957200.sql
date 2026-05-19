-- From: "Account not exist: {}" to "No account with that name: {} was found."
UPDATE `acore_string` SET
    `content_default` = 'No account with that name: {} was found.',
    `locale_koKR`     = '해당 이름을 사용하는 계정을 찾을 수 없습니다: {}',
    `locale_frFR`     = 'Aucun compte avec ce nom : {} n''a été trouvé.',
    `locale_deDE`     = 'Kein Konto mit diesem Namen: {} gefunden.',
    `locale_zhCN`     = '未找到使用此名称的账号：{}',
    `locale_zhTW`     = '未找到使用此名稱的帳號：{}',
    `locale_esES`     = 'No se encontró ninguna cuenta con ese nombre: {}',
    `locale_esMX`     = 'No se encontró ninguna cuenta con ese nombre: {}',
    `locale_ruRU`     = 'Учётная запись с именем: {} не найдена.'
WHERE `entry` = 413;

DELETE FROM `acore_string` WHERE `entry` IN (604, 605, 606, 607);
INSERT INTO `acore_string`
    (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`)
VALUES
(604,
    'No account with that IP: {} was found.',
    '해당 IP를 사용하는 계정을 찾을 수 없습니다: {}',  -- koKR
    'Aucun compte avec cette IP : {} n''a été trouvé.',  -- frFR
    'Kein Konto mit dieser IP: {} gefunden.',  -- deDE
    '未找到使用此 IP 的账号:{}',  -- zhCN
    '未找到使用此 IP 的帳號:{}',  -- zhTW
    'No se encontró ninguna cuenta con esa IP: {}',  -- esES
    'No se encontró ninguna cuenta con esa IP: {}',  -- esMX
    'Учётная запись с IP: {} не найдена.'  -- ruRU
),
(605,
    'No account with that e-mail: {} was found.',
    '해당 이메일을 사용하는 계정을 찾을 수 없습니다: {}',  -- koKR
    'Aucun compte avec cet e-mail : {} n''a été trouvé.',  -- frFR
    'Kein Konto mit dieser E-Mail: {} gefunden.',  -- deDE
    '未找到使用此电子邮件的账号:{}',  -- zhCN
    '未找到使用此電子郵件的帳號:{}',  -- zhTW
    'No se encontró ninguna cuenta con ese correo: {}',  -- esES
    'No se encontró ninguna cuenta con ese correo: {}',  -- esMX
    'Учётная запись с эл. почтой: {} не найдена.'  -- ruRU
),
(606,
    'Found a total of: {} accounts.',
    '총 {}개의 계정을 찾았습니다.',  -- koKR
    'Total trouvé : {} compte(s).',  -- frFR
    'Insgesamt gefunden: {} Konto/Konten.',  -- deDE
    '共找到 {} 个账号。',  -- zhCN
    '共找到 {} 個帳號。',  -- zhTW
    'Se encontraron en total: {} cuenta(s).',  -- esES
    'Se encontraron en total: {} cuenta(s).',  -- esMX
    'Всего найдено учётных записей: {}.'  -- ruRU
),
(607,
    'Found a total of: {} characters.',
    '총 {}개의 캐릭터를 찾았습니다.',  -- koKR
    'Total trouvé : {} personnage(s).',  -- frFR
    'Insgesamt gefunden: {} Charakter(e).',  -- deDE
    '共找到 {} 个角色。',  -- zhCN
    '共找到 {} 個角色。',  -- zhTW
    'Se encontraron en total: {} personaje(s).',  -- esES
    'Se encontraron en total: {} personaje(s).',  -- esMX
    'Всего найдено персонажей: {}.'  -- ruRU
);

-- From: "No players found!" to "No characters were found!"
UPDATE `acore_string` SET
    `content_default` = 'No characters were found!',
    `locale_koKR`     = '캐릭터를 찾을 수 없습니다!',
    `locale_frFR`     = 'Aucun personnage trouvé !',
    `locale_deDE`     = 'Keine Charaktere gefunden!',
    `locale_zhCN`     = '未找到任何角色!',
    `locale_zhTW`     = '未找到任何角色!',
    `locale_esES`     = '¡No se encontraron personajes!',
    `locale_esMX`     = '¡No se encontraron personajes!',
    `locale_ruRU`     = 'Персонажи не найдены!'
WHERE `entry` = 330;
