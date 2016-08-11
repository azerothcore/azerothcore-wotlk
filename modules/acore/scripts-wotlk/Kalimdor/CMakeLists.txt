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
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_stonetalon_mountains.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_silithus.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_moonglade.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RazorfenDowns/razorfen_downs.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RazorfenDowns/instance_razorfen_downs.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RazorfenDowns/razorfen_downs.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/ZulFarrak/instance_zulfarrak.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/ZulFarrak/zulfarrak.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_epoch_hunter.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/old_hillsbrad.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_lieutenant_drake.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/old_hillsbrad.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/instance_old_hillsbrad.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/EscapeFromDurnholdeKeep/boss_captain_skarloc.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_archimonde.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjalAI.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal_trash.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_kazrogal.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal_trash.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjalAI.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/instance_hyjal.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_rage_winterchill.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/hyjal.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_azgalor.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/BattleForMountHyjal/boss_anetheron.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_infinite.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_salramm.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_meathook.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_mal_ganis.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/boss_epoch.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/culling_of_stratholme.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/instance_culling_of_stratholme.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/CullingOfStratholme/culling_of_stratholme.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/the_black_morass.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/instance_the_black_morass.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_chrono_lord_deja.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/the_black_morass.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_aeonus.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/CavernsOfTime/TheBlackMorass/boss_temporus.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/BlackfathomDeeps/instance_blackfathom_deeps.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/BlackfathomDeeps/blackfathom_deeps.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_azuremyst_isle.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_orgrimmar.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_desolace.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_feralas.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/Maraudon/instance_maraudon.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/Maraudon/maraudon.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_fankriss.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_huhuran.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/instance_temple_of_ahnqiraj.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/mob_anubisath_sentinel.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_viscidus.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_twinemperors.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_sartura.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_cthun.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/temple_of_ahnqiraj.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_skeram.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_ouro.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/TempleOfAhnQiraj/boss_bug_trio.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_darkshore.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_buru.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/instance_ruins_of_ahnqiraj.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_rajaxx.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_ossirian.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_ayamiss.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_moam.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/ruins_of_ahnqiraj.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RuinsOfAhnQiraj/boss_kurinnaxx.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_mulgore.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_bloodmyst_isle.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_thunder_bluff.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_azshara.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RazorfenKraul/instance_razorfen_kraul.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_the_barrens.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_ungoro_crater.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/WailingCaverns/wailing_caverns.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/WailingCaverns/instance_wailing_caverns.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_durotar.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_felwood.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/boss_azuregos.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_tanaris.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_dustwallow_marsh.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_winterspring.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_thousand_needles.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_ashenvale.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/zone_teldrassil.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/OnyxiasLair/boss_onyxia.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/OnyxiasLair/onyxias_lair.h
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/OnyxiasLair/instance_onyxias_lair.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/RagefireChasm/instance_ragefire_chasm.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/DireMaul/instance_dire_maul.cpp
  ${CMAKE_AC_MODULE_DIR}/Kalimdor/DireMaul/dire_maul.h
)

AC_ADD_SCRIPT_LOADER("Kalimdor" "${CMAKE_AC_MODULE_DIR}/ScriptWotlkLoader.h")

message("  -> Prepared: Kalimdor")
