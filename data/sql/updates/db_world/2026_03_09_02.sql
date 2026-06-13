-- DB update 2026_03_09_01 -> 2026_03_09_02
-- DB update 2026_03_06_00 -> rev_1772756451514538300
-- chore(DB/Text): Add German (deDE) translations for acore_string

-- Command system
UPDATE `acore_string` SET `locale_deDE` = 'Befehl ''{}'' existiert nicht.' WHERE `entry` = 6;
UPDATE `acore_string` SET `locale_deDE` = 'Unterbefehl ''{}{}{}'' ist mehrdeutig:' WHERE `entry` = 7;
UPDATE `acore_string` SET `locale_deDE` = 'Mögliche Unterbefehle:' WHERE `entry` = 8;
UPDATE `acore_string` SET `locale_deDE` = 'Der Unterbefehl ''{}{}{}'' existiert nicht.' WHERE `entry` = 193;
UPDATE `acore_string` SET `locale_deDE` = 'Befehl ''{}'' ist mehrdeutig:' WHERE `entry` = 194;
UPDATE `acore_string` SET `locale_deDE` = '### VERWENDUNG: .{} ...' WHERE `entry` = 195;
UPDATE `acore_string` SET `locale_deDE` = 'Für ''{}'' sind keine detaillierten Verwendungsinformationen vorhanden.\nDies sollte bei Standard-AzerothCore-Befehlen nicht auftreten – bitte als Fehler melden.' WHERE `entry` = 196;

-- Account permissions
UPDATE `acore_string` SET `locale_deDE` = 'Falscher Parameter-ID: {}, existiert nicht.' WHERE `entry` = 63;
UPDATE `acore_string` SET `locale_deDE` = 'Falscher realmId-Parameter: {}' WHERE `entry` = 64;
UPDATE `acore_string` SET `locale_deDE` = 'Konto {} ({}) wurden Berechtigungen erteilt:' WHERE `entry` = 65;
UPDATE `acore_string` SET `locale_deDE` = 'Konto {} ({}) wurden Berechtigungen verweigert:' WHERE `entry` = 66;
UPDATE `acore_string` SET `locale_deDE` = 'Konto {} ({}) hat Berechtigungen durch Sicherheitsstufe {} geerbt:' WHERE `entry` = 67;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigungen:' WHERE `entry` = 68;
UPDATE `acore_string` SET `locale_deDE` = 'Verknüpfte Berechtigungen:' WHERE `entry` = 69;
UPDATE `acore_string` SET `locale_deDE` = 'Leere Liste' WHERE `entry` = 70;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} konnte nicht erteilt werden. Konto {} ({}) besitzt diese Berechtigung bereits.' WHERE `entry` = 72;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} konnte nicht erteilt werden. Konto {} ({}) hat diese Berechtigung in der Sperrliste.' WHERE `entry` = 73;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} wurde Konto {} ({}) erteilt.' WHERE `entry` = 74;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} konnte nicht gesperrt werden. Konto {} ({}) besitzt diese Berechtigung bereits.' WHERE `entry` = 75;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} konnte nicht gesperrt werden. Konto {} ({}) hat diese Berechtigung in der Sperrliste.' WHERE `entry` = 76;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} wurde Konto {} ({}) gesperrt.' WHERE `entry` = 77;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} wurde Konto {} ({}) entzogen.' WHERE `entry` = 78;
UPDATE `acore_string` SET `locale_deDE` = 'Berechtigung {} ({}) realmId {} konnte nicht entzogen werden. Konto {} ({}) besitzt diese Berechtigung nicht.' WHERE `entry` = 79;
UPDATE `acore_string` SET `locale_deDE` = 'Schlachtfeld-Siege in den letzten 7 Tagen\nAllianz: {}\nHorde: {}' WHERE `entry` = 80;
UPDATE `acore_string` SET `locale_deDE` = 'Das Speichern von Schlachtfeld-Punkteständen ist deaktiviert!' WHERE `entry` = 81;

-- Two-factor authentication
UPDATE `acore_string` SET `locale_deDE` = 'UNBEKANNTER_FEHLER' WHERE `entry` = 87;
UPDATE `acore_string` SET `locale_deDE` = 'Die Zwei-Faktor-Authentifizierungsbefehle sind nicht ordnungsgemäß eingerichtet.' WHERE `entry` = 88;
UPDATE `acore_string` SET `locale_deDE` = 'Die Zwei-Faktor-Authentifizierung ist für dieses Konto bereits aktiviert.' WHERE `entry` = 89;
UPDATE `acore_string` SET `locale_deDE` = 'Der angegebene Zwei-Faktor-Authentifizierungstoken ist ungültig.' WHERE `entry` = 90;
UPDATE `acore_string` SET `locale_deDE` = 'Um die Einrichtung abzuschließen, müsst Ihr das Gerät einrichten, das Ihr als zweiten Faktor verwenden werdet.\nEuer 2FA-Schlüssel: {}\nSobald Ihr Euer Gerät eingerichtet habt, bestätigt dies mit .account 2fa setup <token> und dem generierten Token.' WHERE `entry` = 91;
UPDATE `acore_string` SET `locale_deDE` = 'Die Zwei-Faktor-Authentifizierung wurde erfolgreich eingerichtet.' WHERE `entry` = 92;
UPDATE `acore_string` SET `locale_deDE` = 'Die Zwei-Faktor-Authentifizierung ist für dieses Konto nicht aktiviert.' WHERE `entry` = 93;
UPDATE `acore_string` SET `locale_deDE` = 'Um die Zwei-Faktor-Authentifizierung zu entfernen, gebt bitte einen aktuellen Token von Eurem Authentifizierungsgerät an.' WHERE `entry` = 94;
UPDATE `acore_string` SET `locale_deDE` = 'Die Zwei-Faktor-Authentifizierung wurde erfolgreich deaktiviert.' WHERE `entry` = 95;
UPDATE `acore_string` SET `locale_deDE` = 'Das angegebene Zwei-Faktor-Authentifizierungsgeheimnis ist zu lang.' WHERE `entry` = 188;
UPDATE `acore_string` SET `locale_deDE` = 'Das angegebene Zwei-Faktor-Authentifizierungsgeheimnis ist ungültig.' WHERE `entry` = 189;
UPDATE `acore_string` SET `locale_deDE` = 'Zwei-Faktor-Authentifizierung für ''{}'' mit dem angegebenen Geheimnis erfolgreich aktiviert.' WHERE `entry` = 190;

-- Guild and character name validation
UPDATE `acore_string` SET `locale_deDE` = 'Der Gildenname ''{}'' ist bereits vergeben.' WHERE `entry` = 96;
UPDATE `acore_string` SET `locale_deDE` = 'Gildenname ''{}'' wurde in ''{}'' geändert.' WHERE `entry` = 97;
UPDATE `acore_string` SET `locale_deDE` = '''{}'' existiert bereits als Charaktername, bitte einen anderen wählen.' WHERE `entry` = 98;
UPDATE `acore_string` SET `locale_deDE` = 'Spieler ''{}'' wurde zur Umbenennung in ''{}'' gezwungen.' WHERE `entry` = 99;
UPDATE `acore_string` SET `locale_deDE` = 'Dieser Name ist reserviert, bitte einen anderen wählen.' WHERE `entry` = 167;
UPDATE `acore_string` SET `locale_deDE` = 'Dieser Name ist anstößig, bitte einen anderen wählen.' WHERE `entry` = 187;

-- Gameobject
UPDATE `acore_string` SET `locale_deDE` = 'Ungültiger Spielobjekttyp, muss ein zerstörbares Gebäude sein.' WHERE `entry` = 176;
UPDATE `acore_string` SET `locale_deDE` = 'Spielobjekt {} (GUID: {}) hat {} Schaden genommen (aktuelle Gesundheit: {}).' WHERE `entry` = 177;
UPDATE `acore_string` SET `locale_deDE` = '| Kontoflags:' WHERE `entry` = 179;

UPDATE `acore_string` SET `locale_deDE` = 'Wiederherstellungs-ID: {} | Gegenstand: {} ({}) | Anzahl: {}' WHERE `entry` = 197;
UPDATE `acore_string` SET `locale_deDE` = 'Der Spieler hat keine wiederherstellbaren Gegenstände.' WHERE `entry` = 198;
UPDATE `acore_string` SET `locale_deDE` = 'Der Spieler hat keinen wiederherstellbaren Gegenstand mit ID {}.' WHERE `entry` = 199;

-- Spawn / go
UPDATE `acore_string` SET `locale_deDE` = 'Kann nicht zu Spawn {} wechseln, da nur {} vorhanden sind.' WHERE `entry` = 288;

-- Cheat commands
UPDATE `acore_string` SET `locale_deDE` = 'Cheat-Befehlsstatus:' WHERE `entry` = 357;
UPDATE `acore_string` SET `locale_deDE` = 'Gottmodus: {}.' WHERE `entry` = 358;
UPDATE `acore_string` SET `locale_deDE` = 'Zauberzeit: {}.' WHERE `entry` = 359;
UPDATE `acore_string` SET `locale_deDE` = 'Abklingzeit: {}.' WHERE `entry` = 360;
UPDATE `acore_string` SET `locale_deDE` = 'Energie: {}.' WHERE `entry` = 361;
UPDATE `acore_string` SET `locale_deDE` = 'Wasserlauf: {}.' WHERE `entry` = 362;
UPDATE `acore_string` SET `locale_deDE` = 'Spieler {} kann Euch nicht mehr zuflüstern.' WHERE `entry` = 363;
UPDATE `acore_string` SET `locale_deDE` = 'Taxiknoten: {}.' WHERE `entry` = 364;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r ausgerüstete Gegenstände für {} gelöscht.' WHERE `entry` = 365;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r Gegenstände in ausgerüsteten Taschen für {} gelöscht.' WHERE `entry` = 366;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r Gegenstände in der Bank für {} gelöscht.' WHERE `entry` = 367;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r Schlüssel im Schlüsselbund für {} gelöscht.' WHERE `entry` = 368;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r Währungen für {} gelöscht.' WHERE `entry` = 369;
UPDATE `acore_string` SET `locale_deDE` = '|cffffffff{}|r Gegenstände im Händler-Rückkauf für {} gelöscht.' WHERE `entry` = 370;
UPDATE `acore_string` SET `locale_deDE` = 'Alle Gegenstände für {} gelöscht:\n|cffffffff{}|r ausgerüstet\n|cffffffff{}|r in Taschen\n|cffffffff{}|r in der Bank\n|cffffffff{}|r im Schlüsselbund\n|cffffffff{}|r Währungstypen\n|cffffffff{}|r im Händler-Rückkauf' WHERE `entry` = 371;
UPDATE `acore_string` SET `locale_deDE` = 'Alle Gegenstände für {} gelöscht (inkl. Taschen):\n|cffffffff{}|r ausgerüstet\n|cffffffff{}|r in Taschen\n|cffffffff{}|r in der Bank\n|cffffffff{}|r im Schlüsselbund\n|cffffffff{}|r Währungstypen\n|cffffffff{}|r im Händler-Rückkauf\n|cffffffff{}|r normale Taschen\n|cffffffff{}|r Banktaschen' WHERE `entry` = 372;
UPDATE `acore_string` SET `locale_deDE` = 'Das Ziel besitzt die Aura {} nicht!' WHERE `entry` = 373;
UPDATE `acore_string` SET `locale_deDE` = 'Keine Stapelanzahl angegeben!' WHERE `entry` = 374;
UPDATE `acore_string` SET `locale_deDE` = 'Zauber {} kann keine Stapel haben!' WHERE `entry` = 375;

-- Quest management
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) entfernt.' WHERE `entry` = 473;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) belohnt.' WHERE `entry` = 474;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) abgeschlossen.' WHERE `entry` = 475;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) ist bereits aktiv.' WHERE `entry` = 476;

-- Events / Do Action
UPDATE `acore_string` SET `locale_deDE` = 'Ereignis {} ({}) wurde gestartet.' WHERE `entry` = 600;
UPDATE `acore_string` SET `locale_deDE` = 'Ereignis {} ({}) wurde gestoppt.' WHERE `entry` = 601;
UPDATE `acore_string` SET `locale_deDE` = ' [belohnt]' WHERE `entry` = 602;
UPDATE `acore_string` SET `locale_deDE` = 'Aktion ausgeführt auf [GUID: {}, Eintrag: {}, Name: {}] Aktion: {}' WHERE `entry` = 603;

-- Battleground / Arena queue
UPDATE `acore_string` SET `locale_deDE` = 'Warteschlangenstatus für {} (Scharmützel {}) (Stufe: {} bis {})\nIn Warteschlange: {} (Mindestens {} weitere benötigt)' WHERE `entry` = 713;
UPDATE `acore_string` SET `locale_deDE` = '|cffff0000[Arena-Warteschlange]:|r {} (Scharmützel {}) -- [{}-{}] [{}/{}]|r' WHERE `entry` = 726;

-- NPC type indicators (GM info)
UPDATE `acore_string` SET `locale_deDE` = '* hat Klatsch ({})' WHERE `entry` = 820;
UPDATE `acore_string` SET `locale_deDE` = '* ist Questgeber ({})' WHERE `entry` = 821;
UPDATE `acore_string` SET `locale_deDE` = '* ist Klassentrainer ({})' WHERE `entry` = 822;
UPDATE `acore_string` SET `locale_deDE` = '* ist Berufslehrer ({})' WHERE `entry` = 823;
UPDATE `acore_string` SET `locale_deDE` = '* ist Munitionshändler ({})' WHERE `entry` = 824;
UPDATE `acore_string` SET `locale_deDE` = '* ist Lebensmittelhändler ({})' WHERE `entry` = 825;
UPDATE `acore_string` SET `locale_deDE` = '* ist Gifthändler ({})' WHERE `entry` = 826;
UPDATE `acore_string` SET `locale_deDE` = '* ist Reagenzienhändler ({})' WHERE `entry` = 827;
UPDATE `acore_string` SET `locale_deDE` = '* kann reparieren ({})' WHERE `entry` = 828;
UPDATE `acore_string` SET `locale_deDE` = '* ist Flugmeister ({})' WHERE `entry` = 829;
UPDATE `acore_string` SET `locale_deDE` = '* ist Geistheiler ({})' WHERE `entry` = 830;
UPDATE `acore_string` SET `locale_deDE` = '* ist Geistführer ({})' WHERE `entry` = 831;
UPDATE `acore_string` SET `locale_deDE` = '* ist Gastwirt ({})' WHERE `entry` = 832;
UPDATE `acore_string` SET `locale_deDE` = '* ist Banker ({})' WHERE `entry` = 833;
UPDATE `acore_string` SET `locale_deDE` = '* ist Petitionär ({})' WHERE `entry` = 834;
UPDATE `acore_string` SET `locale_deDE` = '* ist Wappenröckegestalter ({})' WHERE `entry` = 835;
UPDATE `acore_string` SET `locale_deDE` = '* ist Schlachtfeldmeister ({})' WHERE `entry` = 836;
UPDATE `acore_string` SET `locale_deDE` = '* ist Auktionator ({})' WHERE `entry` = 837;
UPDATE `acore_string` SET `locale_deDE` = '* ist Stallmeister ({})' WHERE `entry` = 838;
UPDATE `acore_string` SET `locale_deDE` = '* ist Gildenbanker ({})' WHERE `entry` = 839;
UPDATE `acore_string` SET `locale_deDE` = '* hat Zauberklick ({})' WHERE `entry` = 840;
UPDATE `acore_string` SET `locale_deDE` = '* ist Postkasten ({})' WHERE `entry` = 841;
UPDATE `acore_string` SET `locale_deDE` = '* ist Spielerfahrzeug ({})' WHERE `entry` = 842;

-- Arena team management
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam [{}] nicht gefunden.' WHERE `entry` = 857;
UPDATE `acore_string` SET `locale_deDE` = 'Es gibt bereits ein Arenateam namens "{}".' WHERE `entry` = 858;
UPDATE `acore_string` SET `locale_deDE` = '{} ist bereits in einem Arenateam dieser Größe.' WHERE `entry` = 859;
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam im Kampf.' WHERE `entry` = 860;
UPDATE `acore_string` SET `locale_deDE` = 'Arena mit dem Namen "{}" oder ähnlichem nicht gefunden.' WHERE `entry` = 861;
UPDATE `acore_string` SET `locale_deDE` = '[{}] ist kein Mitglied des Teams "{}".' WHERE `entry` = 862;
UPDATE `acore_string` SET `locale_deDE` = '[{}] ist bereits Kapitän des Teams "{}".' WHERE `entry` = 863;
UPDATE `acore_string` SET `locale_deDE` = 'Neues Arenateam erstellt [Name: "{}"][Id: {}][Typ: {}][Kapitän-GUID: {}].' WHERE `entry` = 864;
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam "{}\"[Id: {}] aufgelöst.' WHERE `entry` = 865;
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam [Id: {}] von "{}" in "{}" umbenannt.' WHERE `entry` = 866;
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam "{}\"[Id: {}]: Kapitän von [{}] zu [{}] geändert.' WHERE `entry` = 867;
UPDATE `acore_string` SET `locale_deDE` = 'Arenateam: "{}\"[{}] - Bewertung: {} - Typ: {}x{}' WHERE `entry` = 868;
UPDATE `acore_string` SET `locale_deDE` = 'Name:"{}\"[guid:{}] - PR: {} - {}' WHERE `entry` = 869;
UPDATE `acore_string` SET `locale_deDE` = '|"{}\"[ID:{}]({}x{})|' WHERE `entry` = 870;

-- Email management (player-facing)
UPDATE `acore_string` SET `locale_deDE` = 'Die eingegebene E-Mail-Adresse stimmt nicht mit der Registrierungs-E-Mail überein, bitte Eingabe prüfen.' WHERE `entry` = 872;
UPDATE `acore_string` SET `locale_deDE` = 'Die neuen E-Mail-Adressen stimmen nicht überein.' WHERE `entry` = 873;
UPDATE `acore_string` SET `locale_deDE` = 'Die E-Mail-Adresse wurde geändert.' WHERE `entry` = 874;
UPDATE `acore_string` SET `locale_deDE` = 'Eure E-Mail-Adresse darf nicht länger als 255 Zeichen sein, E-Mail-Adresse nicht geändert!' WHERE `entry` = 875;
UPDATE `acore_string` SET `locale_deDE` = 'E-Mail-Adresse nicht geändert (unbekannter Fehler)!' WHERE `entry` = 876;
UPDATE `acore_string` SET `locale_deDE` = 'Änderung nicht nötig, neue E-Mail-Adresse ist identisch mit der alten.' WHERE `entry` = 877;
UPDATE `acore_string` SET `locale_deDE` = 'Eure E-Mail-Adresse ist: {}' WHERE `entry` = 878;
UPDATE `acore_string` SET `locale_deDE` = 'Sicherheitsstufe: {}' WHERE `entry` = 880;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr benötigt eine E-Mail-Adresse, um Euer Passwort zu ändern.' WHERE `entry` = 881;

-- Instance access requirements (player-facing)
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, müsst Ihr folgende Quest(s) abschließen:' WHERE `entry` = 882;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, müsst Ihr folgende Erfolg(e) erzielen:' WHERE `entry` = 883;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, müsst Ihr folgende(n) Gegenstand/Gegenstände in Eurem Inventar haben:' WHERE `entry` = 884;
UPDATE `acore_string` SET `locale_deDE` = '- Hinweis:' WHERE `entry` = 885;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr könnt nicht eintreten. Die Zugangsvoraussetzungen wurden nicht erfüllt.' WHERE `entry` = 886;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, muss der durchschnittliche Gegenstandslevel Eurer Ausrüstung mindestens {} betragen. Euer aktueller durchschnittlicher Gegenstandslevel beträgt: {}.' WHERE `entry` = 887;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr müsst unter Stufe {} sein, um einzutreten.' WHERE `entry` = 888;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, muss der Gruppenanführer ({}) folgende Quest(s) abgeschlossen haben:' WHERE `entry` = 889;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, muss der Gruppenanführer ({}) folgende Erfolg(e) erzielt haben:' WHERE `entry` = 890;
UPDATE `acore_string` SET `locale_deDE` = 'Um einzutreten, muss der Gruppenanführer ({}) folgende(n) Gegenstand/Gegenstände in seinem/ihrem Inventar haben:' WHERE `entry` = 891;

-- Account creation
UPDATE `acore_string` SET `locale_deDE` = 'Ein Kontopasswort darf NICHT länger als 16 Zeichen sein (Client-Beschränkung). Konto NICHT erstellt.' WHERE `entry` = 1031;

-- Group management (GM)
UPDATE `acore_string` SET `locale_deDE` = '{} ist bereits in einer Gruppe!' WHERE `entry` = 1145;
UPDATE `acore_string` SET `locale_deDE` = '{} ist der Gruppe von {} beigetreten.' WHERE `entry` = 1146;
UPDATE `acore_string` SET `locale_deDE` = '{} ist in keiner Gruppe!' WHERE `entry` = 1147;
UPDATE `acore_string` SET `locale_deDE` = 'Die Gruppe ist voll!' WHERE `entry` = 1148;
UPDATE `acore_string` SET `locale_deDE` = 'Gruppentyp: {} mit {} Spielern.' WHERE `entry` = 1149;
UPDATE `acore_string` SET `locale_deDE` = 'Name: {} ({}),\n\n Zone: {}, Phase: {}, GUID: {}, Flags: {}, Rollen: {}' WHERE `entry` = 1150;

-- Config reload
UPDATE `acore_string` SET `locale_deDE` = 'Alle Konfigurationen wurden aus der/den Konfigurationsdatei(en) neu geladen.' WHERE `entry` = 1157;

-- Guild details (GM)
UPDATE `acore_string` SET `locale_deDE` = 'Zeige Gildendetails für {} (ID: {})' WHERE `entry` = 1177;
UPDATE `acore_string` SET `locale_deDE` = '| Gildenmeister: {} (GUID: {})' WHERE `entry` = 1178;
UPDATE `acore_string` SET `locale_deDE` = '| Erstellungsdatum der Gilde: {}' WHERE `entry` = 1179;
UPDATE `acore_string` SET `locale_deDE` = '| Gildenmitglieder: {}' WHERE `entry` = 1180;
UPDATE `acore_string` SET `locale_deDE` = '| Gildenbank: {} Gold' WHERE `entry` = 1181;
UPDATE `acore_string` SET `locale_deDE` = '| Gilden-MOTD: {}' WHERE `entry` = 1182;
UPDATE `acore_string` SET `locale_deDE` = '| Gildeninformationen: {}' WHERE `entry` = 1183;
UPDATE `acore_string` SET `locale_deDE` = '| Gildenränge:' WHERE `entry` = 1184;

-- Tickets (player-facing)
UPDATE `acore_string` SET `locale_deDE` = 'Euer Ticket wurde geschlossen.' WHERE `entry` = 1334;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr habt eine Ticketantwort erhalten.' WHERE `entry` = 1335;

-- Error messages
UPDATE `acore_string` SET `locale_deDE` = 'Entweder:' WHERE `entry` = 1500;
UPDATE `acore_string` SET `locale_deDE` = 'Oder:   ' WHERE `entry` = 1501;
UPDATE `acore_string` SET `locale_deDE` = 'Wert ''{}'' ist für den Typ {} nicht gültig.' WHERE `entry` = 1502;
UPDATE `acore_string` SET `locale_deDE` = 'Ungültige UTF-8-Sequenzen in der Zeichenkette gefunden.' WHERE `entry` = 1503;
UPDATE `acore_string` SET `locale_deDE` = 'Der angegebene Link enthält ungültige Linkdaten.' WHERE `entry` = 1504;
UPDATE `acore_string` SET `locale_deDE` = 'Konto ''{}'' existiert nicht.' WHERE `entry` = 1505;
UPDATE `acore_string` SET `locale_deDE` = 'Konto-ID {} existiert nicht.' WHERE `entry` = 1506;
UPDATE `acore_string` SET `locale_deDE` = '{} existiert nicht.' WHERE `entry` = 1507;
UPDATE `acore_string` SET `locale_deDE` = 'Charakter ''{}'' existiert nicht.' WHERE `entry` = 1508;
UPDATE `acore_string` SET `locale_deDE` = '''{}'' ist kein gültiger Charaktername.' WHERE `entry` = 1509;
UPDATE `acore_string` SET `locale_deDE` = 'Erfolgs-ID {} existiert nicht.' WHERE `entry` = 1510;
UPDATE `acore_string` SET `locale_deDE` = 'Teleportort {} existiert nicht.' WHERE `entry` = 1511;
UPDATE `acore_string` SET `locale_deDE` = 'Teleportort ''{}'' existiert nicht.' WHERE `entry` = 1512;
UPDATE `acore_string` SET `locale_deDE` = 'Gegenstand-ID {} existiert nicht.' WHERE `entry` = 1513;
UPDATE `acore_string` SET `locale_deDE` = 'Zauber-ID {} existiert nicht.' WHERE `entry` = 1514;
UPDATE `acore_string` SET `locale_deDE` = 'Erwartet ''{}'', aber ''{}'' erhalten.' WHERE `entry` = 1515;
UPDATE `acore_string` SET `locale_deDE` = 'Quest-ID {} existiert nicht.' WHERE `entry` = 1516;

-- Ticket response
UPDATE `acore_string` SET `locale_deDE` = '|cff00ff00Ticketantwort|r: [{}]|r' WHERE `entry` = 2029;
UPDATE `acore_string` SET `locale_deDE` = '|cff00ff00Bearbeitet von|r:|cff00ccff {}|r' WHERE `entry` = 2030;
UPDATE `acore_string` SET `locale_deDE` = '|cff00ff00Antwort hinzugefügt|r:|cff00ccff [{}]|r' WHERE `entry` = 2031;
UPDATE `acore_string` SET `locale_deDE` = '|cff00ff00Antwort gelöscht von|r:|cff00ccff {}|r' WHERE `entry` = 2032;

-- GM diagnostic / debug strings
UPDATE `acore_string` SET `locale_deDE` = 'KIName: {} Skriptname: {}' WHERE `entry` = 5031;
UPDATE `acore_string` SET `locale_deDE` = 'Kein Schlachtfeld gefunden!' WHERE `entry` = 5032;
UPDATE `acore_string` SET `locale_deDE` = 'Keine Erfolgskriterien gefunden!' WHERE `entry` = 5033;
UPDATE `acore_string` SET `locale_deDE` = 'Kein offenes PvP gefunden!' WHERE `entry` = 5034;
UPDATE `acore_string` SET `locale_deDE` = 'Konsole' WHERE `entry` = 5039;
UPDATE `acore_string` SET `locale_deDE` = 'Charakter' WHERE `entry` = 5040;
UPDATE `acore_string` SET `locale_deDE` = 'Dauerhaft' WHERE `entry` = 5041;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr seid im Freien.' WHERE `entry` = 5042;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr seid in einem Innenbereich.' WHERE `entry` = 5043;
UPDATE `acore_string` SET `locale_deDE` = 'Keine VMAP-Daten für Gebietsinformationen verfügbar.' WHERE `entry` = 5044;
UPDATE `acore_string` SET `locale_deDE` = 'Karte: {} | ID: {} | perm: {} | erweitert: {} | diff: {} | canReset: {} | TTR: {}' WHERE `entry` = 5045;
UPDATE `acore_string` SET `locale_deDE` = 'Spielerbindungen: {}' WHERE `entry` = 5046;
UPDATE `acore_string` SET `locale_deDE` = 'Gruppenbindungen: {}' WHERE `entry` = 5047;
UPDATE `acore_string` SET `locale_deDE` = 'Kartenbindung aufgehoben: {} Instanz: {} perm: {} diff: {} canReset: {} TTR: {}' WHERE `entry` = 5048;
UPDATE `acore_string` SET `locale_deDE` = 'Aufgehobene Instanzen: {}' WHERE `entry` = 5049;
UPDATE `acore_string` SET `locale_deDE` = 'Geladene Instanzen: {}' WHERE `entry` = 5050;
UPDATE `acore_string` SET `locale_deDE` = 'Spieler in Instanzen: {}' WHERE `entry` = 5051;
UPDATE `acore_string` SET `locale_deDE` = 'Instanzspeicherungen: {}' WHERE `entry` = 5052;
UPDATE `acore_string` SET `locale_deDE` = 'Gebundene Spieler: {}' WHERE `entry` = 5053;
UPDATE `acore_string` SET `locale_deDE` = 'Gebundene Gruppen: {}' WHERE `entry` = 5054;
UPDATE `acore_string` SET `locale_deDE` = 'Die Karte ist kein Dungeon.' WHERE `entry` = 5055;
UPDATE `acore_string` SET `locale_deDE` = 'Die Karte hat keine Instanzdaten.' WHERE `entry` = 5056;
UPDATE `acore_string` SET `locale_deDE` = 'Boss-ID {} Status wurde auf {} ({}) gesetzt.' WHERE `entry` = 5057;
UPDATE `acore_string` SET `locale_deDE` = 'Boss-ID {} ({}) Status ist {} ({}).' WHERE `entry` = 5058;
UPDATE `acore_string` SET `locale_deDE` = 'Stummschaltungen für Konto: {}' WHERE `entry` = 5059;
UPDATE `acore_string` SET `locale_deDE` = 'Keine Stummschaltungen für Konto: {}' WHERE `entry` = 5060;
UPDATE `acore_string` SET `locale_deDE` = 'Stummschaltungsdatum: {} Dauer: {} Min. Grund: {} Gesetzt von: {}' WHERE `entry` = 5061;
UPDATE `acore_string` SET `locale_deDE` = 'Gecachte Daten für Charakter {} ({}) wurden geleert.' WHERE `entry` = 5064;
UPDATE `acore_string` SET `locale_deDE` = 'Gecachte Daten für Charakter {} ({}) wurden aktualisiert.' WHERE `entry` = 5065;
UPDATE `acore_string` SET `locale_deDE` = 'Cache für Charakter {} nicht gefunden.' WHERE `entry` = 5066;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) hinzugefügt.' WHERE `entry` = 5067;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} ({}) nicht im Questprotokoll gefunden.' WHERE `entry` = 5068;
UPDATE `acore_string` SET `locale_deDE` = 'Die Quest muss aktiv und abgeschlossen sein, bevor sie belohnt werden kann.' WHERE `entry` = 5069;
UPDATE `acore_string` SET `locale_deDE` = 'Der Befehl ist durch die Konfiguration deaktiviert.' WHERE `entry` = 5070;
UPDATE `acore_string` SET `locale_deDE` = 'Der angegebene Erweiterungskosten-Eintrag existiert nicht.' WHERE `entry` = 5071;

-- Honor / arena refund (player-facing)
UPDATE `acore_string` SET `locale_deDE` = 'Die Rückerstattung von {} ({}) würde das Ehrenpunkte-Limit überschreiten (Limit: {}, aktuelle Ehrenpunkte: {}, zu erstattende Ehrenpunkte: {}).' WHERE `entry` = 5072;
UPDATE `acore_string` SET `locale_deDE` = 'Die Rückerstattung von Gegenstand {} ist fehlgeschlagen, da dadurch das Ehrenpunkte-Limit überschritten würde.' WHERE `entry` = 5073;
UPDATE `acore_string` SET `locale_deDE` = 'Gegenstand {} ({}) wurde zurückerstattet und {} Ehrenpunkte wiederhergestellt.' WHERE `entry` = 5074;
UPDATE `acore_string` SET `locale_deDE` = 'Die Rückerstattung von {} ({}) würde das Arenapunkte-Limit überschreiten (Limit: {}, aktuelle Arenapunkte: {}, zu erstattende Arenapunkte: {}).' WHERE `entry` = 5075;
UPDATE `acore_string` SET `locale_deDE` = 'Die Rückerstattung von Gegenstand {} ist fehlgeschlagen, da dadurch das Arenapunkte-Limit überschritten würde.' WHERE `entry` = 5076;
UPDATE `acore_string` SET `locale_deDE` = 'Gegenstand {} ({}) wurde zurückerstattet und {} Arenapunkte wiederhergestellt.' WHERE `entry` = 5077;
UPDATE `acore_string` SET `locale_deDE` = 'Gegenstand nicht im Inventar des Charakters gefunden (einschließlich Bank).' WHERE `entry` = 5078;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr müsst mindestens Stufe {} sein, um automatische Rundfunknachrichten zu deaktivieren.' WHERE `entry` = 5079;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr erhaltet jetzt globale {}-Nachrichten.' WHERE `entry` = 5080;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr erhaltet keine globalen {}-Nachrichten mehr.' WHERE `entry` = 5081;
UPDATE `acore_string` SET `locale_deDE` = 'Charakter {} ({}) von Konto {} ({}) zu Konto {} ({}) verschoben.' WHERE `entry` = 5083;
UPDATE `acore_string` SET `locale_deDE` = 'Zauberausführung fehlgeschlagen! SpellCastResult: {} ({}).' WHERE `entry` = 5084;
UPDATE `acore_string` SET `locale_deDE` = 'Objekt {} (Eintrag: {} GUID: {}) neu erschaffen!' WHERE `entry` = 5085;
UPDATE `acore_string` SET `locale_deDE` = 'Keine Türen in Reichweite ({} Yards) gefunden.' WHERE `entry` = 5086;
UPDATE `acore_string` SET `locale_deDE` = 'Tür {} (Eintrag: {}) geöffnet!' WHERE `entry` = 5087;
UPDATE `acore_string` SET `locale_deDE` = 'Quest: {} ({})\nStatus: {}' WHERE `entry` = 5088;
UPDATE `acore_string` SET `locale_deDE` = 'Quest {} kann nicht angenommen werden. Gründe:' WHERE `entry` = 5089;
UPDATE `acore_string` SET `locale_deDE` = '  - Quest ist deaktiviert.' WHERE `entry` = 5090;
UPDATE `acore_string` SET `locale_deDE` = '  - Quest wurde bereits angenommen oder abgeschlossen.' WHERE `entry` = 5091;
UPDATE `acore_string` SET `locale_deDE` = '  - Klassenanforderung nicht erfüllt.' WHERE `entry` = 5092;
UPDATE `acore_string` SET `locale_deDE` = '  - Rassenanforderung nicht erfüllt.' WHERE `entry` = 5093;
UPDATE `acore_string` SET `locale_deDE` = '  - Spielerstufe zu niedrig (erforderlich: {}).' WHERE `entry` = 5094;
UPDATE `acore_string` SET `locale_deDE` = '  - Spielerstufe zu hoch (Maximum: {}).' WHERE `entry` = 5095;
UPDATE `acore_string` SET `locale_deDE` = '  - Fertigkeitsanforderung nicht erfüllt.' WHERE `entry` = 5096;
UPDATE `acore_string` SET `locale_deDE` = '  - Rufanforderung nicht erfüllt.' WHERE `entry` = 5097;
UPDATE `acore_string` SET `locale_deDE` = '  - Vorherige Quest in der Kette nicht abgeschlossen.' WHERE `entry` = 5098;
UPDATE `acore_string` SET `locale_deDE` = '  - Bereits eine zeitbegrenzte Quest aktiv.' WHERE `entry` = 5099;
UPDATE `acore_string` SET `locale_deDE` = '  - Konflikt mit exklusiver Gruppenquest.' WHERE `entry` = 5100;
UPDATE `acore_string` SET `locale_deDE` = '  - Nächste Quest in der Kette bereits begonnen.' WHERE `entry` = 5101;
UPDATE `acore_string` SET `locale_deDE` = '  - Vorherige Quest in der Kette noch aktiv.' WHERE `entry` = 5102;
UPDATE `acore_string` SET `locale_deDE` = '  - Brotkrumen-Quest-Konflikt.' WHERE `entry` = 5103;
UPDATE `acore_string` SET `locale_deDE` = '  - Tagesquest heute nicht verfügbar.' WHERE `entry` = 5104;
UPDATE `acore_string` SET `locale_deDE` = '  - Wochenquest diese Woche bereits abgeschlossen.' WHERE `entry` = 5105;
UPDATE `acore_string` SET `locale_deDE` = '  - Monatsquest diesen Monat bereits abgeschlossen.' WHERE `entry` = 5106;
UPDATE `acore_string` SET `locale_deDE` = '  - Saisonquest diese Saison bereits abgeschlossen.' WHERE `entry` = 5107;
UPDATE `acore_string` SET `locale_deDE` = '  - Bedingungsanforderungen nicht erfüllt:' WHERE `entry` = 5108;
UPDATE `acore_string` SET `locale_deDE` = '  - Questprotokoll ist voll.' WHERE `entry` = 5109;
UPDATE `acore_string` SET `locale_deDE` = '    - Bedingung nicht erfüllt: Typ {} Wert1: {} Wert2: {} Wert3: {}' WHERE `entry` = 5110;

-- GM Spectator
UPDATE `acore_string` SET `locale_deDE` = 'GM-Zuschauer ist AN' WHERE `entry` = 6617;
UPDATE `acore_string` SET `locale_deDE` = 'GM-Zuschauer ist AUS' WHERE `entry` = 6618;

-- LFG states
UPDATE `acore_string` SET `locale_deDE` = 'Spielername: {}, Status: {}, Dungeons: {} ({}),\n\n Rollen: {}, Kommentar: {}' WHERE `entry` = 9980;
UPDATE `acore_string` SET `locale_deDE` = 'LFG-Gruppe?: {}, Status: {}, Dungeon: {}' WHERE `entry` = 9981;
UPDATE `acore_string` SET `locale_deDE` = 'Nicht in einer Gruppe' WHERE `entry` = 9982;
UPDATE `acore_string` SET `locale_deDE` = 'Warteschlangen geleert' WHERE `entry` = 9983;
UPDATE `acore_string` SET `locale_deDE` = 'LFG-Optionen: {}' WHERE `entry` = 9984;
UPDATE `acore_string` SET `locale_deDE` = 'LFG-Optionen geändert' WHERE `entry` = 9985;
UPDATE `acore_string` SET `locale_deDE` = 'Keine' WHERE `entry` = 9986;
UPDATE `acore_string` SET `locale_deDE` = 'Rollenprüfung' WHERE `entry` = 9987;
UPDATE `acore_string` SET `locale_deDE` = 'In Warteschlange' WHERE `entry` = 9988;
UPDATE `acore_string` SET `locale_deDE` = 'Vorschlag' WHERE `entry` = 9989;
UPDATE `acore_string` SET `locale_deDE` = 'Abstimmung: Rauswurf' WHERE `entry` = 9990;
UPDATE `acore_string` SET `locale_deDE` = 'Im Dungeon' WHERE `entry` = 9991;
UPDATE `acore_string` SET `locale_deDE` = 'Dungeon beendet' WHERE `entry` = 9992;
UPDATE `acore_string` SET `locale_deDE` = 'Raid-Browser' WHERE `entry` = 9993;
UPDATE `acore_string` SET `locale_deDE` = 'Tank' WHERE `entry` = 9994;
UPDATE `acore_string` SET `locale_deDE` = 'Heiler' WHERE `entry` = 9995;
UPDATE `acore_string` SET `locale_deDE` = 'DPS' WHERE `entry` = 9996;
UPDATE `acore_string` SET `locale_deDE` = 'Gruppenanführer' WHERE `entry` = 9997;
UPDATE `acore_string` SET `locale_deDE` = 'Keine' WHERE `entry` = 9998;
UPDATE `acore_string` SET `locale_deDE` = 'Fehler' WHERE `entry` = 9999;

-- Halaa
UPDATE `acore_string` SET `locale_deDE` = 'Halaa ist schutzlos!' WHERE `entry` = 10074;

-- Server action announcements
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat {} rausgeworfen, Grund: {}' WHERE `entry` = 11002;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat {} für {} stummgeschaltet, Grund: {}' WHERE `entry` = 11003;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat Charakter {} für {} gesperrt, Grund: {}' WHERE `entry` = 11004;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat Charakter {} dauerhaft gesperrt, Grund: {}' WHERE `entry` = 11005;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat Konto {} für {} gesperrt, Grund: {}' WHERE `entry` = 11006;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat Konto {} dauerhaft gesperrt, Grund: {}' WHERE `entry` = 11007;
UPDATE `acore_string` SET `locale_deDE` = 'Bewegungstyp: {}' WHERE `entry` = 11008;
UPDATE `acore_string` SET `locale_deDE` = 'Zusätzliche Flags: {}' WHERE `entry` = 11009;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr seid bereits an {} gebunden.' WHERE `entry` = 11014;
UPDATE `acore_string` SET `locale_deDE` = 'Dieser Kreatur ist keine aktive CreatureAI zugewiesen.' WHERE `entry` = 11015;
UPDATE `acore_string` SET `locale_deDE` = 'Bitte einen Spieler oder sein Haustier auswählen.' WHERE `entry` = 11016;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat IP {} für {} gesperrt, Grund: {}' WHERE `entry` = 11017;
UPDATE `acore_string` SET `locale_deDE` = 'Server: {} hat IP {} dauerhaft gesperrt, Grund: {}' WHERE `entry` = 11018;

-- Module: Transmog / XP
UPDATE `acore_string` SET `locale_deDE` = 'Der Transmog-NPC zeigt nun verfügbare Erscheinungsbilder als Händlerinterface an (mit Vorschau).\nHINWEIS: Bei zu vielen Erscheinungsbildern werden einige aufgrund einer Client-Beschränkung nicht angezeigt. Deaktiviert in diesem Fall diese Option.' WHERE `entry` = 11117;
UPDATE `acore_string` SET `locale_deDE` = 'Der Transmog-NPC zeigt nun verfügbare Erscheinungsbilder als Klatschliste an.' WHERE `entry` = 11118;
UPDATE `acore_string` SET `locale_deDE` = 'Eure Erfahrungsrate wurde auf {} gesetzt.' WHERE `entry` = 11120;
UPDATE `acore_string` SET `locale_deDE` = 'Falscher Wert angegeben. Bitte einen Wert zwischen 0 und {} angeben.' WHERE `entry` = 11121;
UPDATE `acore_string` SET `locale_deDE` = 'Die auf Euch angewendete Rate beträgt {}.\nAktuelle Wochenend-XP-Konfiguration:\nAnnounce {}\nAlwaysEnabled {}\nQuestOnly {}\nMaxLevel {}\nxpAmount {}\nIndividualXPEnabled {}\nEnabled {}\nMaxAllowedRate {}' WHERE `entry` = 11122;

-- Wintergrasp
UPDATE `acore_string` SET `locale_deDE` = '{} wurde von {} gefangen.' WHERE `entry` = 12050;
UPDATE `acore_string` SET `locale_deDE` = '{} wird von {} angegriffen.' WHERE `entry` = 12051;
UPDATE `acore_string` SET `locale_deDE` = 'Belagerungswerkstatt des Zerbrochenen Tempels' WHERE `entry` = 12052;
UPDATE `acore_string` SET `locale_deDE` = 'Ostspark-Belagerungswerkstatt' WHERE `entry` = 12053;
UPDATE `acore_string` SET `locale_deDE` = 'Westspark-Belagerungswerkstatt' WHERE `entry` = 12054;
UPDATE `acore_string` SET `locale_deDE` = 'Belagerungswerkstatt des Gesunkenen Rings' WHERE `entry` = 12055;
UPDATE `acore_string` SET `locale_deDE` = 'Allianz' WHERE `entry` = 12057;
UPDATE `acore_string` SET `locale_deDE` = 'Die Schlacht um Wintersturm beginnt gleich!' WHERE `entry` = 12058;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr habt Rang 1 erreicht: Gefreiter' WHERE `entry` = 12059;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr habt Rang 2 erreicht: Leutnant' WHERE `entry` = 12060;
UPDATE `acore_string` SET `locale_deDE` = 'Der südöstliche Festungsturm' WHERE `entry` = 12061;
UPDATE `acore_string` SET `locale_deDE` = 'Der nordöstliche Festungsturm' WHERE `entry` = 12062;
UPDATE `acore_string` SET `locale_deDE` = 'Der südwestliche Festungsturm' WHERE `entry` = 12063;
UPDATE `acore_string` SET `locale_deDE` = 'Der nordwestliche Festungsturm' WHERE `entry` = 12064;
UPDATE `acore_string` SET `locale_deDE` = '{} wurde beschädigt!' WHERE `entry` = 12065;
UPDATE `acore_string` SET `locale_deDE` = '{} wurde zerstört!' WHERE `entry` = 12066;
UPDATE `acore_string` SET `locale_deDE` = 'Die Schlacht um Wintersturm beginnt!' WHERE `entry` = 12067;
UPDATE `acore_string` SET `locale_deDE` = '{} hat die Wintersturm-Festung erfolgreich verteidigt!' WHERE `entry` = 12068;
UPDATE `acore_string` SET `locale_deDE` = 'Der südliche Turm' WHERE `entry` = 12069;
UPDATE `acore_string` SET `locale_deDE` = 'Der östliche Turm' WHERE `entry` = 12070;
UPDATE `acore_string` SET `locale_deDE` = 'Der westliche Turm' WHERE `entry` = 12071;
UPDATE `acore_string` SET `locale_deDE` = 'Die Wintersturm-Festung wurde von {} erobert!' WHERE `entry` = 12072;

-- Wintergrasp NPC gossip (player-facing)
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zum Festungsfriedhof.' WHERE `entry` = 20070;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zum Friedhof des Gesunkenen Rings.' WHERE `entry` = 20071;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zum Friedhof des Zerbrochenen Tempels.' WHERE `entry` = 20072;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zum Westspark-Friedhof.' WHERE `entry` = 20073;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zum Ostspark-Friedhof.' WHERE `entry` = 20074;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zurück zum Horden-Landungscamp.' WHERE `entry` = 20075;
UPDATE `acore_string` SET `locale_deDE` = 'Bring mich zurück zum Allianz-Landungscamp.' WHERE `entry` = 20076;
UPDATE `acore_string` SET `locale_deDE` = 'Für Wintersturm anmelden.' WHERE `entry` = 20077;
UPDATE `acore_string` SET `locale_deDE` = '|cffff0000[Wintersturm]:|r Kampf hat begonnen!|r' WHERE `entry` = 20078;

-- Quest tracking
UPDATE `acore_string` SET `locale_deDE` = 'Diese Spuren müssen Shango gehören.' WHERE `entry` = 28634;
UPDATE `acore_string` SET `locale_deDE` = 'Das sind nicht Shangos Spuren.' WHERE `entry` = 28635;

-- Miscellaneous player-facing
UPDATE `acore_string` SET `locale_deDE` = 'Sprechen ist erst nach mindestens {} Spielzeit erlaubt. Ihr könnt die Gruppen- und Gildenchats verwenden.' WHERE `entry` = 30000;
UPDATE `acore_string` SET `locale_deDE` = 'Sofortflug umschalten' WHERE `entry` = 30077;
UPDATE `acore_string` SET `locale_deDE` = 'Sofortflug AN' WHERE `entry` = 30078;
UPDATE `acore_string` SET `locale_deDE` = 'Sofortflug AUS' WHERE `entry` = 30079;
UPDATE `acore_string` SET `locale_deDE` = 'Die Datei ''opcode.txt'' fehlt im Server-Arbeitsverzeichnis.' WHERE `entry` = 30080;
UPDATE `acore_string` SET `locale_deDE` = '{} hat keinen Gegenstand mit itemID = {}, kann daher nicht entfernt werden.' WHERE `entry` = 30081;
UPDATE `acore_string` SET `locale_deDE` = '{} hat nicht so viele Gegenstände mit itemID = {}, daher wurden keine entfernt.' WHERE `entry` = 30082;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr könnt keine Quests teilen, während Ihr auf einem Schlachtfeld seid.' WHERE `entry` = 30083;
UPDATE `acore_string` SET `locale_deDE` = 'Ihr könnt keine Bereitschaftsprüfung starten, während Ihr auf einem Schlachtfeld seid.' WHERE `entry` = 30084;
UPDATE `acore_string` SET `locale_deDE` = 'Das Schlachtfeld-Debugging ist in der Konfiguration bereits aktiviert und kann nicht per Befehl ein-/ausgeschaltet werden.' WHERE `entry` = 30085;
UPDATE `acore_string` SET `locale_deDE` = 'Das Arena-Debugging ist in der Konfiguration bereits aktiviert und kann nicht per Befehl ein-/ausgeschaltet werden.' WHERE `entry` = 30086;
UPDATE `acore_string` SET `locale_deDE` = 'LFG ist für das Debugging auf 1-Spieler-Warteschlange gesetzt.' WHERE `entry` = 30096;
UPDATE `acore_string` SET `locale_deDE` = 'LFG ist auf normale Warteschlange gesetzt.' WHERE `entry` = 30097;
UPDATE `acore_string` SET `locale_deDE` = 'Das LFG-Debugging ist in der Konfiguration bereits aktiviert und kann nicht per Befehl ein-/ausgeschaltet werden.' WHERE `entry` = 30098;

-- Player info display (GM)
UPDATE `acore_string` SET `locale_deDE` = '¦ Spieler {} {} (GUID: {})' WHERE `entry` = 35400;
UPDATE `acore_string` SET `locale_deDE` = '¦ GM-Modus aktiv, Phase: -1' WHERE `entry` = 35401;
UPDATE `acore_string` SET `locale_deDE` = '├─ Gesperrt: (Typ: {}, Grund: {}, Zeit: {}, Von: {})' WHERE `entry` = 35402;
UPDATE `acore_string` SET `locale_deDE` = '├─ Stummgeschaltet: (Grund: {}, Zeit: {}, Von: {})' WHERE `entry` = 35403;
UPDATE `acore_string` SET `locale_deDE` = '¦ Konto: {} (ID: {}),\n\n GM-Stufe: {}' WHERE `entry` = 35404;
UPDATE `acore_string` SET `locale_deDE` = '¦ Letzter Login: {} (Fehlgeschlagene Logins: {})' WHERE `entry` = 35405;
UPDATE `acore_string` SET `locale_deDE` = '¦ Registrierungs-E-Mail: {} - E-Mail: {}' WHERE `entry` = 35406;
UPDATE `acore_string` SET `locale_deDE` = 'Kein Grund angegeben.' WHERE `entry` = 35407;
UPDATE `acore_string` SET `locale_deDE` = '<nicht autorisiert>' WHERE `entry` = 35408;
UPDATE `acore_string` SET `locale_deDE` = '¦ Karte: {}, Zone: {}, Bereich: {}' WHERE `entry` = 35409;
