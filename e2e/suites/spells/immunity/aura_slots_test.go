//go:build e2e

package immunity_test

import (
	"bytes"
	"encoding/binary"
	"io"
	"testing"
)

const (
	auraUpdateAll = uint16(0x495) // SMSG_AURA_UPDATE_ALL
	auraUpdate    = uint16(0x496) // SMSG_AURA_UPDATE
)

// decodeAuraSlots preserves duplicate spell IDs in separate slots. The pinned
// AzerothGhost client exposes only unique IDs and maximum stacks, so neither
// public accessor can observe Vashj's four separate Magic Barrier applications.
// Layout: AuraApplication::BuildUpdatePacket and Player::GetAurasForTarget.
func decodeAuraSlots(data []byte) (uint64, map[uint8]uint32, bool) {
	r := bytes.NewReader(data)
	readGUID := func() (uint64, error) {
		mask, err := r.ReadByte()
		if err != nil {
			return 0, err
		}
		var guid uint64
		for i := uint(0); i < 8; i++ {
			if mask&(1<<i) != 0 {
				b, err := r.ReadByte()
				if err != nil {
					return 0, err
				}
				guid |= uint64(b) << (i * 8)
			}
		}
		return guid, nil
	}
	target, err := readGUID()
	if err != nil {
		return 0, nil, false
	}
	slots := make(map[uint8]uint32)
	for r.Len() > 0 {
		slot, _ := r.ReadByte()
		var spell uint32
		if binary.Read(r, binary.LittleEndian, &spell) != nil {
			return 0, nil, false
		}
		slots[slot] = spell
		if spell == 0 {
			continue // removal has no flags, caster or duration
		}
		var header [3]byte // flags, caster level, stack count/charges
		if _, err := io.ReadFull(r, header[:]); err != nil {
			return 0, nil, false
		}
		flags := header[0]
		if flags&0x08 == 0 { // AFLAG_CASTER: caster omitted for self-cast
			if _, err := readGUID(); err != nil {
				return 0, nil, false
			}
		}
		skip := 0
		if flags&0x20 != 0 { // AFLAG_DURATION
			skip += 8
		}
		if flags&0x40 != 0 { // AFLAG_ANY_EFFECT_AMOUNT_SENT
			for bit := byte(1); bit <= 4; bit <<= 1 {
				if flags&bit != 0 {
					skip += 4
				}
			}
		}
		if r.Len() < skip {
			return 0, nil, false
		}
		r.Seek(int64(skip), io.SeekCurrent)
	}
	return target, slots, true
}

func applyAuraSlots(current, updates map[uint8]uint32, replace bool) {
	if replace {
		clear(current)
	}
	for slot, spell := range updates {
		if spell == 0 {
			delete(current, slot)
		} else {
			current[slot] = spell
		}
	}
}

func TestAuraSlotsPreserveSeparateApplications(t *testing.T) {
	var packet bytes.Buffer
	packet.Write([]byte{0x81, 0x34, 0x12}) // packed target 0x1200000000000034
	for slot := byte(0); slot < 4; slot++ {
		packet.WriteByte(slot)
		binary.Write(&packet, binary.LittleEndian, uint32(38112))
		packet.Write([]byte{0x20, 73, 0}) // duration, external caster, no stacks
		packet.Write([]byte{0x01, slot + 1})
		binary.Write(&packet, binary.LittleEndian, uint32(6000))
		binary.Write(&packet, binary.LittleEndian, uint32(5000))
	}
	target, slots, ok := decodeAuraSlots(packet.Bytes())
	if !ok || target != 0x1200000000000034 || len(slots) != 4 {
		t.Fatalf("decoded target=%X slots=%v ok=%v", target, slots, ok)
	}
	for slot := uint8(0); slot < 4; slot++ {
		if slots[slot] != 38112 {
			t.Fatalf("slot %d: got %d, want Magic Barrier", slot, slots[slot])
		}
	}
	// Updating an existing slot must not count it twice; removals and full
	// snapshots must discard stale applications.
	applyAuraSlots(slots, map[uint8]uint32{0: 38112}, false)
	if len(slots) != 4 {
		t.Fatal("repeated update changed the application count")
	}
	_, removal, ok := decodeAuraSlots([]byte{1, 1, 0, 0, 0, 0, 0})
	if !ok {
		t.Fatal("removal packet rejected")
	}
	applyAuraSlots(slots, removal, false)
	if len(slots) != 3 {
		t.Fatal("removal did not clear the slot")
	}
	applyAuraSlots(slots, map[uint8]uint32{7: 38112}, true)
	if len(slots) != 1 || slots[7] != 38112 {
		t.Fatal("full snapshot retained stale slots")
	}
	_, empty, ok := decodeAuraSlots([]byte{1, 1})
	if !ok {
		t.Fatal("empty snapshot rejected")
	}
	applyAuraSlots(slots, empty, true)
	if len(slots) != 0 {
		t.Fatal("empty snapshot did not clear slots")
	}
	// A partial nonempty record is rejected instead of partially updating state.
	for _, length := range []int{0, 1, 2, 4, 7, 9, packet.Len() - 1} {
		if _, _, ok := decodeAuraSlots(packet.Bytes()[:length]); ok {
			t.Fatalf("accepted truncated packet of length %d", length)
		}
	}
}

func TestAuraSlotsSkipSelfCastEffectAmounts(t *testing.T) {
	// Self-cast aura with effect amounts 0 and 2, followed by a removal.
	packet := []byte{1, 1, 3, 0xe0, 0x94, 0, 0, 0x4d, 73, 1}
	packet = append(packet, make([]byte, 8)...)
	packet = append(packet, 4, 0, 0, 0, 0)
	_, slots, ok := decodeAuraSlots(packet)
	if !ok || len(slots) != 2 || slots[3] != 38112 || slots[4] != 0 {
		t.Fatalf("decoded slots=%v ok=%v", slots, ok)
	}
}
