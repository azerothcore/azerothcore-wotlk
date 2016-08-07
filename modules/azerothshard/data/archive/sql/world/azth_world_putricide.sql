-- hackfix for https://github.com/TrinityCore/TrinityCore/issues/16059
UPDATE `creature_template` SET `mechanic_immune_mask` = 650854271 WHERE `entry` IN (
  37697,  -- 10N Volatile Ooze
  38604,  -- 10H Volatile Ooze
  38758,  -- 25N Volatize Ooze
  38759,  -- 25H Volatile Ooze
  37562,  -- 10N Gas Cloud
  38602,  -- 10H Gas Cloud
  38760,  -- 25N Gas Cloud
  38761   -- 25H Gas Cloud
);
