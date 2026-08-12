// Package fixtures holds AC-specific constants shared across e2e suites.
package fixtures

import "github.com/walkline/AzerothGhost/e2e/e2eharness"

// Re-export common pads/maps so suites can depend on internal/fixtures
// without redefining coordinates.

var (
	PadStormwindOutskirts = e2eharness.PadStormwindOutskirts
)

const (
	MapEasternKingdoms = e2eharness.MapEasternKingdoms
	MapOutland         = e2eharness.MapOutland
	MapNorthrend       = e2eharness.MapNorthrend
	MapUlduar          = e2eharness.MapUlduar
)
