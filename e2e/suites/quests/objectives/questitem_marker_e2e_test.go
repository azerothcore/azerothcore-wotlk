//go:build e2e

package objectives_test

import (
	"encoding/binary"
	"sync"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

// SMSG_CREATURE_QUERY_RESPONSE. The harness has no dispatch case for this opcode,
// so the payload is read through a raw packet hook: WorldClient.handlePacket calls
// invokePacketHooks for every opcode before its own switch, so unparsed packets are
// still observable. Same approach as suites/spells/immunity.
const smsgCreatureQueryResponse uint16 = 0x0061

// Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/27553
//
// Quests 10262 and 10308 ask for Zaxxis Insignia (29209). Hovering a mob that drops
// it showed no objective, because that marker is not a server-side flag: creatures
// have no equivalent of GameObject::ActivateToQuest, and the client learns which
// quest items a creature carries from the questItems array in
// SMSG_CREATURE_QUERY_RESPONSE, filled from creature_questitem.
//
// This asks the server for each dropping creature and asserts the insignia is among
// the six advertised items. On unfixed data all six are zero.
func TestAC_27553_ZaxxisMobsAdvertiseQuestItem(t *testing.T) {
	meta.Begin(t, meta.TestMeta{
		Tags:     []string{"short", "quests", "issue", "serial"},
		Runtime:  "short",
		Issue:    27553,
		Category: "quests/objectives",
	})

	const itemZaxxisInsignia = uint32(29209)
	mobs := []struct {
		entry uint32
		name  string
	}{
		{18875, "ZaxxisRaider"},
		{19641, "WarpRaiderNesaad"},
		{19642, "ZaxxisStalker"},
	}

	// CMSG_CREATURE_QUERY is STATUS_LOGGEDIN and the handler ignores the guid it is
	// given, so the bot can ask from wherever it logs in. No travel or spawn needed.
	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{Prefix: "QItem", Level: 80})

	for _, m := range mobs {
		t.Run(m.name, func(t *testing.T) {
			items := creatureQuestItems(t, bot, m.entry)
			for _, it := range items {
				if it == itemZaxxisInsignia {
					t.Logf("OK %s (%d) advertises item %d", m.name, m.entry, itemZaxxisInsignia)
					return
				}
			}
			e2eharness.Assertf(t,
				"%s (%d) advertises %v; expected %d among them, without which the client shows no objective on hover",
				m.name, m.entry, items, itemZaxxisInsignia)
		})
	}

	bot.AssertWorldAlive(t)
}

// creatureQuestItems asks the server about one creature and returns the six
// questItems slots. The response ends with questItems[6] followed by movementId,
// so they are the last 28 bytes less that trailing uint32.
func creatureQuestItems(t *testing.T, bot *e2eharness.ScenarioBot, entry uint32) []uint32 {
	t.Helper()

	var (
		mu   sync.Mutex
		got  []uint32
		once sync.Once
	)
	done := make(chan struct{})

	cancel := bot.World.AddPacketHook(func(opcode uint16, data []byte) {
		// A creature the server does not know answers with entry|0x80000000 and no
		// body, which the length check drops.
		if opcode != smsgCreatureQueryResponse || len(data) < 32 {
			return
		}
		if binary.LittleEndian.Uint32(data[:4]) != entry {
			return
		}
		tail := data[len(data)-28:]
		out := make([]uint32, 6)
		for i := range out {
			out[i] = binary.LittleEndian.Uint32(tail[i*4 : i*4+4])
		}
		mu.Lock()
		got = out
		mu.Unlock()
		once.Do(func() { close(done) })
	})
	defer cancel()

	if err := bot.World.CreatureQuery(entry, 0); err != nil {
		e2eharness.HarnessFailf(t, "CreatureQuery(%d): %v", entry, err)
	}

	select {
	case <-done:
	case <-time.After(15 * time.Second):
		e2eharness.HarnessFailf(t, "no creature query response for entry %d within 15s", entry)
	}

	mu.Lock()
	defer mu.Unlock()
	return got
}
