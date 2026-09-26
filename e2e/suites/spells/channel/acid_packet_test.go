//go:build e2e

package channel_test

import (
	"encoding/binary"
	"testing"
)

// Offline check of the packet oracle; this test never opens a realm connection.
func TestAcidDamagePacket(t *testing.T) {
	// Sparse packed GUIDs exercise both low and high bytes, followed by the
	// spell/damage prefix from Unit::SendSpellNonMeleeDamageLog.
	data := []byte{0x81, 0x42, 0xF1, 0x05, 0xAA, 0xBB}
	data = binary.LittleEndian.AppendUint32(data, 38163)
	data = binary.LittleEndian.AppendUint32(data, 1200)
	target, caster, spell, damage, ok := parseAcidDamage(data)
	if !ok || target != 0xF100000000000042 || caster != 0xBB00AA || spell != 38163 || damage != 1200 {
		t.Fatalf("incorrect damage prefix: target=%X caster=%X spell=%d damage=%d ok=%v",
			target, caster, spell, damage, ok)
	}
	for end := 0; end < len(data); end++ {
		if _, _, _, _, ok := parseAcidDamage(data[:end]); ok {
			t.Fatalf("accepted truncated damage prefix of %d bytes", end)
		}
	}
}
