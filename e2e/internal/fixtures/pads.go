// Package fixtures holds AC-specific constants shared across e2e suites.
package fixtures

import "github.com/azerothcore/AzerothGhost/e2e/e2eharness"

// Re-export isolation pads so suites can depend on internal/fixtures.

var (
	// PadStormwindOutskirts is a legacy alias (AbandonHouse). Prefer PackagePad.
	PadStormwindOutskirts = e2eharness.PadStormwindOutskirts
	IsolationPads         = e2eharness.IsolationPads
	PreferredPackagePads  = e2eharness.PreferredPackagePads
)

// PackagePad is sticky per suite folder — use for all combat/social pad placement.
var PackagePad = e2eharness.PackagePad

const (
	MapEasternKingdoms = e2eharness.MapEasternKingdoms
	MapKalimdor        = e2eharness.MapKalimdor
	MapOutland         = e2eharness.MapOutland
	MapNorthrend       = e2eharness.MapNorthrend
	MapUlduar          = e2eharness.MapUlduar
)
