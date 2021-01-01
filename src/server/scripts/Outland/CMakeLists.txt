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
  ${AC_SCRIPTS_DIR}/Outland/zone_nagrand.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/MagtheridonsLair/magtheridons_lair.h
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/MagtheridonsLair/instance_magtheridons_lair.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/MagtheridonsLair/boss_magtheridon.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/HellfireRamparts/instance_hellfire_ramparts.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_omor_the_unscarred.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_watchkeeper_gargolmar.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/HellfireRamparts/boss_vazruden_the_herald.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/HellfireRamparts/hellfire_ramparts.h
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_the_maker.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_kelidan_the_breaker.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/BloodFurnace/blood_furnace.h
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/BloodFurnace/instance_blood_furnace.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/BloodFurnace/boss_broggok.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/ShatteredHalls/shattered_halls.h
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_warchief_kargath_bladefist.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_nethekurse.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/ShatteredHalls/instance_shattered_halls.cpp
  ${AC_SCRIPTS_DIR}/Outland/HellfireCitadel/ShatteredHalls/boss_warbringer_omrogg.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SteamVault/boss_mekgineer_steamrigger.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SteamVault/instance_steam_vault.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SteamVault/boss_hydromancer_thespia.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SteamVault/boss_warlord_kalithresh.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SteamVault/steam_vault.h
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_hydross_the_unstable.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_fathomlord_karathress.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/instance_serpent_shrine.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/serpent_shrine.h
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_lady_vashj.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_leotheras_the_blind.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_lurker_below.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SerpentShrine/boss_morogrim_tidewalker.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/underbog/boss_the_black_stalker.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/underbog/instance_the_underbog.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/underbog/the_underbog.h
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SlavePens/boss_ahune.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SlavePens/instance_the_slave_pens.cpp
  ${AC_SCRIPTS_DIR}/Outland/CoilfangReservoir/SlavePens/the_slave_pens.h
  ${AC_SCRIPTS_DIR}/Outland/zone_shattrath_city.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/boss_mechano_lord_capacitus.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/boss_pathaleon_the_calculator.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/boss_nethermancer_sepethrea.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/mechanar.h
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/boss_gatewatcher_gyrokill.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/instance_mechanar.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Mechanar/boss_gatewatcher_ironhand.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/the_eye.h
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/instance_the_eye.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/boss_void_reaver.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/boss_astromancer.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/boss_alar.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/Eye/boss_kaelthas.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/the_botanica.h
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/instance_the_botanica.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/boss_commander_sarannis.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/boss_thorngrin_the_tender.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/boss_high_botanist_freywinn.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/boss_warp_splinter.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/botanica/boss_laj.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/boss_zereketh_the_unbound.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/boss_dalliah_the_doomsayer.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/boss_wrath_scryer_soccothrates.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/boss_harbinger_skyriss.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/instance_arcatraz.cpp
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/arcatraz.h
  ${AC_SCRIPTS_DIR}/Outland/TempestKeep/arcatraz/arcatraz.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/AuchenaiCrypts/boss_shirrak_the_dead_watcher.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/AuchenaiCrypts/boss_exarch_maladaar.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/AuchenaiCrypts/instance_auchenai_crypts.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/AuchenaiCrypts/auchenai_crypts.h
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ManaTombs/boss_nexusprince_shaffar.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ManaTombs/boss_pandemonius.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ManaTombs/instance_mana_tombs.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ManaTombs/mana_tombs.h
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/SethekkHalls/boss_talon_king_ikiss.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/SethekkHalls/instance_sethekk_halls.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/SethekkHalls/sethekk_halls.h
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_ambassador_hellmaw.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_blackheart_the_inciter.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_grandmaster_vorpil.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/boss_murmur.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/instance_shadow_labyrinth.cpp
  ${AC_SCRIPTS_DIR}/Outland/Auchindoun/ShadowLabyrinth/shadow_labyrinth.h
  ${AC_SCRIPTS_DIR}/Outland/boss_doomwalker.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_terokkar_forest.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_hellfire_peninsula.cpp
  ${AC_SCRIPTS_DIR}/Outland/boss_doomlord_kazzak.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_teron_gorefiend.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/black_temple.h
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/illidari_council.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_shade_of_akama.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_supremus.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_mother_shahraz.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/instance_black_temple.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_reliquary_of_souls.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_warlord_najentus.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_bloodboil.cpp
  ${AC_SCRIPTS_DIR}/Outland/BlackTemple/boss_illidan.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_shadowmoon_valley.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_blades_edge_mountains.cpp
  ${AC_SCRIPTS_DIR}/Outland/GruulsLair/boss_high_king_maulgar.cpp
  ${AC_SCRIPTS_DIR}/Outland/GruulsLair/boss_gruul.cpp
  ${AC_SCRIPTS_DIR}/Outland/GruulsLair/gruuls_lair.h
  ${AC_SCRIPTS_DIR}/Outland/GruulsLair/instance_gruuls_lair.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_netherstorm.cpp
  ${AC_SCRIPTS_DIR}/Outland/zone_zangarmarsh.cpp
)

AC_ADD_SCRIPT_LOADER("Outland" "ScriptLoader.h")

message("  -> Prepared: Outland")
