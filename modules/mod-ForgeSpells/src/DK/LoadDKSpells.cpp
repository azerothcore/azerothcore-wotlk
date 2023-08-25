#include "LoadForgeSpells.cpp"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"

enum DeathKnightSpells
{
   SPELL_DK_PESTILENCE                         = 50842
   
};

class LoadDKSpells : LoadForgeSpells
{
public:
   LoadDKSpells() : LoadForgeSpells()
   {

   }

   void Load() override
   {
       //RegisterSpellScript(spell_dk_festering_strike);
   }
};
