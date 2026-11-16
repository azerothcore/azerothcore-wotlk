//go:build e2e

package movement_test

import (
	"bytes"
	"encoding/binary"
	"testing"
	"time"

	_ "github.com/go-sql-driver/mysql"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
	"github.com/azerothcore/azerothcore-wotlk/e2e/internal/meta"
)

const (
	cmsgQueryTime              uint16 = 0x1CE
	smsgQueryTimeResponse      uint16 = 0x1CF
	smsgEnvironmentalDamageLog uint16 = 0x1FC
	damageTypeFall             uint8  = 2
)

type envDamage struct {
	victim uint64
	kind   uint8
	amount uint32
}

// Players died to "fall damage" while walking over the debris in front of the Ratchet bank: the
// client reported a fall start 69+ yards above the landing spot for a fall that lasted a fraction
// of a second. Fall damage counts at most the height reachable in the reported fall time.
// https://github.com/chromiecraft/chromiecraft/issues/8033
//
// The bot sends both falls itself. A fall start 70 yards up that lands 300 ms later must deal
// nothing (an uncapped core kills outright), while a 40 yard drop with a matching fall time must still
// deal the full formula damage, so the cap never shortens a real fall.
func TestFallDamage_CappedByFallTime(t *testing.T) {
	meta.Begin(t, meta.TestMeta{Tags: []string{"short", "protocol"}, Runtime: "short", Category: "protocol/movement"})

	bot := e2eharness.NewSolo(t, e2eharness.ScenarioOpts{
		Prefix: "FallCap",
		Race:   e2eharness.RaceHuman,
		Class:  e2eharness.ClassWarrior,
		Level:  80,
	})
	bot.TeleportPad(t, e2eharness.PackagePad(t))

	// GM mode skips fall damage; god mode stays off so the damage lands.
	bot.GM(t, ".gm off")
	bot.FlushWorld(t)

	w := bot.World
	maxHealth := w.MaxHealth()
	if maxHealth == 0 || w.Health() != maxHealth {
		e2eharness.Preconditionf(t, "bot not at full health before the falls: %d/%d", w.Health(), maxHealth)
	}

	logs := make(chan envDamage, 8)
	cancel := w.AddPacketHook(func(op uint16, data []byte) {
		if op != smsgEnvironmentalDamageLog || len(data) < 13 {
			return
		}
		logs <- envDamage{
			victim: binary.LittleEndian.Uint64(data[0:8]),
			kind:   data[8],
			amount: binary.LittleEndian.Uint32(data[9:13]),
		}
	})
	defer cancel()

	x, y, z, o, _ := w.Position()

	// Glitched start: the client reports itself 70 yards up, then lands 300 ms into the fall.
	sendHeartbeat(t, w, x, y, z+70, o)
	sendFallLand(t, w, x, y, z, o, 300)

	waitPacketsHandled(t, w)
	select {
	case glitched := <-logs:
		e2eharness.Assertf(t, "glitched 70 yard start with a 300 ms fall dealt %d (max health %d), want no damage",
			glitched.amount, maxHealth)
	default:
	}

	// Real drop: 40 yards takes about 2.04 s under 3.3.5 gravity.
	sendHeartbeat(t, w, x, y, z+40, o)
	sendFallLand(t, w, x, y, z, o, 2050)

	var first envDamage
	select {
	case first = <-logs:
	case <-time.After(10 * time.Second):
		e2eharness.Assertf(t, "no SMSG_ENVIRONMENTAL_DAMAGE_LOG for the 40 yard drop within 10s")
	}

	if first.victim != w.CharGUID() || first.kind != damageTypeFall {
		e2eharness.HarnessFailf(t, "unexpected environmental damage log victim=0x%X type=%d", first.victim, first.kind)
	}

	// Stock Rate.Damage.Fall = 1; same float math as Player::HandleFall.
	damagePerc := float32(0.018)*float32(40) + float32(-0.2426)
	want := uint32(damagePerc * float32(maxHealth))
	tolerance := int64(maxHealth/500 + 1)
	if diff := int64(first.amount) - int64(want); diff < -tolerance || diff > tolerance {
		e2eharness.Assertf(t, "40 yard drop over 2050 ms dealt %d, want %d (max health %d)", first.amount, want, maxHealth)
	}

	select {
	case extra := <-logs:
		e2eharness.Assertf(t, "unexpected second fall damage log: %d", extra.amount)
	case <-time.After(time.Second):
	}

	// Keep the harness position in step with what the server now holds.
	if err := w.SendHeartbeatAt(x, y, z, o); err != nil {
		e2eharness.HarnessFailf(t, "resync heartbeat: %v", err)
	}

	t.Logf("PASS glitched 70 yard start dealt nothing; 40 yard drop dealt %d of %d (want %d)", first.amount, maxHealth, want)
}

// waitPacketsHandled sends CMSG_QUERY_TIME and waits for its single reply. The session queue is
// handled in order, so the reply means every packet sent before it has run and its replies arrived.
func waitPacketsHandled(t *testing.T, w *client.WorldClient) {
	t.Helper()
	got := make(chan struct{}, 1)
	cancel := w.AddPacketHook(func(op uint16, _ []byte) {
		if op != smsgQueryTimeResponse {
			return
		}
		select {
		case got <- struct{}{}:
		default:
		}
	})
	defer cancel()
	if err := w.SendPacketRaw(cmsgQueryTime, nil); err != nil {
		e2eharness.HarnessFailf(t, "CMSG_QUERY_TIME: %v", err)
	}
	select {
	case <-got:
	case <-time.After(5 * time.Second):
		e2eharness.HarnessFailf(t, "no SMSG_QUERY_TIME_RESPONSE within 5s")
	}
}

func sendHeartbeat(t *testing.T, w *client.WorldClient, x, y, z, o float32) {
	t.Helper()
	if err := w.SendHeartbeatAt(x, y, z, o); err != nil {
		e2eharness.HarnessFailf(t, "MSG_MOVE_HEARTBEAT at z=%.2f: %v", z, err)
	}
}

func sendFallLand(t *testing.T, w *client.WorldClient, x, y, z, o float32, fallTime uint32) {
	t.Helper()
	buf := new(bytes.Buffer)
	writePackedGUID(buf, w.CharGUID())
	binary.Write(buf, binary.LittleEndian, uint32(0)) // movementFlags
	binary.Write(buf, binary.LittleEndian, uint16(0)) // movementFlags2
	binary.Write(buf, binary.LittleEndian, uint32(time.Now().UnixMilli()&0xFFFFFFFF))
	binary.Write(buf, binary.LittleEndian, x)
	binary.Write(buf, binary.LittleEndian, y)
	binary.Write(buf, binary.LittleEndian, z)
	binary.Write(buf, binary.LittleEndian, o)
	binary.Write(buf, binary.LittleEndian, fallTime)
	if err := w.SendPacketRaw(client.MsgMoveFallLand, buf.Bytes()); err != nil {
		e2eharness.HarnessFailf(t, "MSG_MOVE_FALL_LAND fallTime=%d: %v", fallTime, err)
	}
}

func writePackedGUID(buf *bytes.Buffer, guid uint64) {
	var mask byte
	var bytesOut []byte
	for i := 0; i < 8; i++ {
		b := byte(guid >> (8 * i))
		if b != 0 {
			mask |= 1 << i
			bytesOut = append(bytesOut, b)
		}
	}
	buf.WriteByte(mask)
	buf.Write(bytesOut)
}
