// Package fixtures holds AC-specific constants shared across e2e suites.
package fixtures

import "github.com/walkline/AzerothGhost/e2e/e2eharness"

// Re-export common pads/maps so suites can depend on internal/fixtures
// without redefining coordinates.

var (
	PadStormwindOutskirts = e2eharness.PadStormwindOutskirts
	CombatPads            = e2eharness.CombatPads
)

// PadFor is e2eharness.PadFor — deterministic isolation pad for parallel packages.
var PadFor = e2eharness.PadFor

const (
	MapEasternKingdoms = e2eharness.MapEasternKingdoms
	MapOutland         = e2eharness.MapOutland
	MapNorthrend       = e2eharness.MapNorthrend
	MapUlduar          = e2eharness.MapUlduar
)
