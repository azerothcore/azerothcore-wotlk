-- fix https://github.com/TrinityCore/TrinityCore/issues/14845#issuecomment-180266980
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-7381 AND type=0;
INSERT INTO spell_linked_spell VALUES (-23397,-7381,0,'Berserk Nefarian - On Remove - Remove Berserker Stance passiv');
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-29763 AND type=0;
INSERT INTO spell_linked_spell VALUES 
(-23397,-29763,0,'Berserk Nefarian - On Remove - Remove Improved Berserker Stance Rank 5');
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-29762 AND type=0;
INSERT INTO spell_linked_spell VALUES 
(-23397,-29762,0,'Berserk Nefarian - On Remove - Remove Improved Berserker Stance Rank 4');
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-29761 AND type=0;
INSERT INTO spell_linked_spell VALUES 
(-23397,-29761,0,'Berserk Nefarian - On Remove - Remove Improved Berserker Stance Rank 3');
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-29760 AND type=0;
INSERT INTO spell_linked_spell VALUES 
(-23397,-29760,0,'Berserk Nefarian - On Remove - Remove Improved Berserker Stance Rank 2');
DELETE FROM spell_linked_spell WHERE spell_trigger = -23397 AND spell_effect=-29759 AND type=0;
INSERT INTO spell_linked_spell VALUES 
(-23397,-29759,0,'Berserk Nefarian - On Remove - Remove Improved Berserker Stance Rank 1');
