# Copyright (C) 
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_nagrand.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/MagtheridonsLair/magtheridons_lair.h
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/MagtheridonsLair/instance_magtheridons_lair.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/MagtheridonsLair/boss_magtheridon.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/HellfireRamparts/instance_hellfire_ramparts.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_omor_the_unscarred.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_watchkeeper_gargolmar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_vazruden_the_herald.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/HellfireRamparts/hellfire_ramparts.h
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_the_maker.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_kelidan_the_breaker.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/BloodFurnace/blood_furnace.h
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/BloodFurnace/instance_blood_furnace.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_broggok.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/ShatteredHalls/shattered_halls.h
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_warchief_kargath_bladefist.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_nethekurse.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/ShatteredHalls/instance_shattered_halls.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_warbringer_omrogg.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SteamVault/boss_mekgineer_steamrigger.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SteamVault/instance_steam_vault.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SteamVault/boss_hydromancer_thespia.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SteamVault/boss_warlord_kalithresh.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SteamVault/steam_vault.h
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_hydross_the_unstable.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_fathomlord_karathress.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/instance_serpent_shrine.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/serpent_shrine.h
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_lady_vashj.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_leotheras_the_blind.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_lurker_below.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_morogrim_tidewalker.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/underbog/boss_the_black_stalker.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/CoilfangReservoir/SlavePens/boss_ahune.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_shattrath_city.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/boss_mechano_lord_capacitus.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/boss_pathaleon_the_calculator.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/boss_nethermancer_sepethrea.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/mechanar.h
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/boss_gatewatcher_gyrokill.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/instance_mechanar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Mechanar/boss_gatewatcher_ironhand.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/the_eye.h
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/instance_the_eye.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/boss_void_reaver.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/boss_astromancer.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/boss_alar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/Eye/boss_kaelthas.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/the_botanica.h
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/instance_the_botanica.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/boss_commander_sarannis.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/boss_thorngrin_the_tender.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/boss_high_botanist_freywinn.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/boss_warp_splinter.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/botanica/boss_laj.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/boss_zereketh_the_unbound.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/boss_dalliah_the_doomsayer.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/boss_wrath_scryer_soccothrates.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/boss_harbinger_skyriss.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/instance_arcatraz.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/arcatraz.h
  ${CMAKE_AC_MODULE_DIR}/Outland/TempestKeep/arcatraz/arcatraz.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/AuchenaiCrypts/boss_shirrak_the_dead_watcher.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/AuchenaiCrypts/boss_exarch_maladaar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ManaTombs/boss_nexusprince_shaffar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/SethekkHalls/boss_talon_king_ikiss.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/SethekkHalls/instance_sethekk_halls.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/SethekkHalls/sethekk_halls.h
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_ambassador_hellmaw.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_blackheart_the_inciter.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_grandmaster_vorpil.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_murmur.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/instance_shadow_labyrinth.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/Auchindoun/ShadowLabyrinth/shadow_labyrinth.h
  ${CMAKE_AC_MODULE_DIR}/Outland/boss_doomwalker.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_terokkar_forest.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_hellfire_peninsula.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/boss_doomlord_kazzak.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_teron_gorefiend.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/black_temple.h
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/illidari_council.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_shade_of_akama.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_supremus.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_mother_shahraz.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/instance_black_temple.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_reliquary_of_souls.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_warlord_najentus.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_bloodboil.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/BlackTemple/boss_illidan.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_shadowmoon_valley.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_blades_edge_mountains.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/GruulsLair/boss_high_king_maulgar.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/GruulsLair/boss_gruul.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/GruulsLair/gruuls_lair.h
  ${CMAKE_AC_MODULE_DIR}/Outland/GruulsLair/instance_gruuls_lair.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_netherstorm.cpp
  ${CMAKE_AC_MODULE_DIR}/Outland/zone_zangarmarsh.cpp
)

AC_ADD_SCRIPT_LOADER("Outland" "${CMAKE_AC_MODULE_DIR}/ScriptWotlkLoader.h")

message("  -> Prepared: Outland")
