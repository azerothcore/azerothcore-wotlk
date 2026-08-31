module github.com/azerothcore/azerothcore-wotlk/e2e

go 1.26.0

require (
	github.com/azerothcore/AzerothGhost v1.0.8
	github.com/go-sql-driver/mysql v1.10.0
)

require filippo.io/edwards25519 v1.2.0 // indirect

// Pinned to azerothcore/AzerothGhost v1.0.8 == d2e0dee
// (module github.com/azerothcore/AzerothGhost; Go 1.26). Immutable tag — do not force-move.
// Local co-dev: go.work (gitignored). CI: go mod download from this pin.
