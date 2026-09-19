-- XE-321 Boombot: keep the walking bomb model in both raid difficulties.
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (33346, 33886) AND `CreatureDisplayID` IN (28575, 26442);
