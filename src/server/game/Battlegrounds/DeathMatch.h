#ifndef DEATHMATCH_H
#define DEATHMATCH_H

#include "Player.h"

/* записываем игроков в зоне */
static std::unordered_map<std::string, ObjectGuid> _players;

class DeathMatch
{
public:
   static DeathMatch* instance()
   {
       static DeathMatch* instance = new DeathMatch();
       return instance;
   }

   void TeleportToRandomLocation(Player* /*player*/);
   void RemovePlayer(Player* /*player*/);
   void RevivePlayer(Player* /*player*/);
   bool CanOpenMenu(Player* /*player*/);
   void AddPlayer(Player* /*player*/);
   bool IsDeathMatchZone(uint32 /* areaId*/);
   uint32 GetSpellFamily(const Player* /*player*/);
   void SetBuffForClassSpec(Player* /*player*/);
   void ResetHpMana(Player* /*player*/);

   /* голова меню */
   void DeathMatchHead(Player* /* player */, Creature*);
   void DeathMatchWelcome(Player* /* player */, Creature*);
   void GetInfoNpc(Player* /* player */);

   struct AddSpell
   {
       uint32 spellId;
       uint32 spec = 0;
   };

   using SpellFamilyToExtraSpells = std::unordered_map<uint32, std::vector<AddSpell>>;

   SpellFamilyToExtraSpells m_additionalSpells = {
       { SPELLFAMILY_WARRIOR, {
           AddSpell{ .spellId = 47436 } } },
       { SPELLFAMILY_SHAMAN, {
           AddSpell{ .spellId = 57960, .spec = TALENT_TREE_SHAMAN_ELEMENTAL },
           AddSpell{ .spellId = 49281, .spec = TALENT_TREE_SHAMAN_ENHANCEMENT },
           AddSpell{ .spellId = 974, .spec = TALENT_TREE_SHAMAN_RESTORATION },
           AddSpell{ .spellId = 546 },
           AddSpell{ .spellId = 131 } } },
       { SPELLFAMILY_MAGE, {
           AddSpell{ .spellId = 43024, .spec = TALENT_TREE_MAGE_ARCANE },
           AddSpell{ .spellId = 43024, .spec = TALENT_TREE_MAGE_FROST },
           AddSpell{ .spellId = 43024, .spec = TALENT_TREE_MAGE_FIRE },
           AddSpell{ .spellId = 43015 },
           AddSpell{ .spellId = 42995 },
           AddSpell{ .spellId = 43020 } } },
       { SPELLFAMILY_DEATHKNIGHT, {
           AddSpell{ .spellId = 57623 },
           AddSpell{ .spellId = 49222, .spec = TALENT_TREE_DEATH_KNIGHT_UNHOLY },
           AddSpell{ .spellId = 49584, .spec = TALENT_TREE_DEATH_KNIGHT_UNHOLY } } },
       { SPELLFAMILY_WARLOCK, {
           AddSpell{ .spellId = 47893 },
           AddSpell{ .spellId = 132 },
           AddSpell{ .spellId = 5697 }, } },
       { SPELLFAMILY_PALADIN, {
           AddSpell{ .spellId = 25780 },
           AddSpell{ .spellId = 25898 },
           AddSpell{ .spellId = 53601 },
           AddSpell{ .spellId = 21084, .spec = TALENT_TREE_PALADIN_RETRIBUTION },
           AddSpell{ .spellId = 53736, .spec = TALENT_TREE_PALADIN_PROTECTION }, // horde
           AddSpell{ .spellId = 31801, .spec = TALENT_TREE_PALADIN_PROTECTION }, // alliance
           AddSpell{ .spellId = 20165, .spec = TALENT_TREE_PALADIN_HOLY } } },
       { SPELLFAMILY_PRIEST, {
           AddSpell{ .spellId = 48168 } ,
           AddSpell{ .spellId = 6346 },
           AddSpell{ .spellId = 48162 },
           AddSpell{ .spellId = 48074 },
           AddSpell{ .spellId = 48170 },
           AddSpell{ .spellId = 48066 },
           AddSpell{ .spellId = 15473, .spec = TALENT_TREE_PRIEST_SHADOW },
           AddSpell{ .spellId = 15286, .spec = TALENT_TREE_PRIEST_SHADOW } } },
       { SPELLFAMILY_HUNTER, {
           AddSpell{ .spellId = 61847 },
           AddSpell{ .spellId = 19506, .spec = TALENT_TREE_HUNTER_MARKSMANSHIP } } },
       { SPELLFAMILY_DRUID, {
           AddSpell{ .spellId = 53307 },
           AddSpell{ .spellId = 48469 } } },
       { SPELLFAMILY_ROGUE, {}}
   };
};

#define DeathMatchMgr DeathMatch::instance()
#endif