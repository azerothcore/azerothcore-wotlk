#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "Creature.h"
#include "ScriptedCreature.h"

typedef struct { float x, y; } Point;

static const Point V[] =
{
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f },
	{ 500.0f, 250.0f }
};

static const int n = 14;

class npc_dismount : public CreatureScript
{
public:
	npc_dismount() : CreatureScript("npc_dismount") { }

	CreatureAI* GetAI(Creature* creature) const
	{
		return new npc_dismountAI(creature);
	}

	struct npc_dismountAI : public BossAI
	{
		uint32 timer;

		npc_dismountAI(Creature* creature) : BossAI(creature, NULL) {}

		int isLeft(Point P0, Point P1, Point P2)
		{
			return ((P1.x - P0.x) * (P2.y - P0.y) - (P2.x - P0.x) * (P1.y - P0.y));
		}

		bool IsInArea(Point P)
		{
			int wn = 0;

			for (int i = 0; i < n; i++)
			{
				if (V[i].y <= P.y)
				{
					if (V[i + 1].y > P.y)
					if (isLeft(V[i], V[i + 1], P) > 0)
						++wn;
				}
				else
				{
					if (V[i + 1].y <= P.y)
					if (isLeft(V[i], V[i + 1], P) < 0)
						--wn;
				}
			}
			return wn != 0;
		}

		void Reset()
		{
			timer = 1000;
		}

		void UpdateAI(uint32 diff)
		{
			if (timer <= diff)
			{
				Map::PlayerList const& Players = me->GetMap()->GetPlayers();
				for (Map::PlayerList::const_iterator itr = Players.begin(); itr != Players.end(); ++itr)
				{
					if (Player* player = itr->GetSource())
					{
						if (player->GetAreaId() != me->GetAreaId())
							continue;
						Point p = { player->GetPositionX(), player->GetPositionY() };
						if (IsInArea(p)){
							player->Dismount();
							player->RemoveAurasByType(SPELL_AURA_MOUNTED);
							player->RemoveAura(300133);
							player->RemoveAura(300194);
							player->RemoveAura(300048);
                            player->RemoveAura(49303);
						}
						else
						{
							player->Dismount();
							player->RemoveAurasByType(SPELL_AURA_MOUNTED);
							player->RemoveAura(300133);
							player->RemoveAura(300194);
							player->RemoveAura(300048);
                            player->RemoveAura(49303);
						}
					}
				}
				timer = 1000;
			}
			else
				timer -= diff;
		}
	};
};

void AddSC_NPC_Dismount()
{
	new npc_dismount();
}
