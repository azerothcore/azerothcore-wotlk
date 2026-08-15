module github.com/azerothcore/azerothcore-wotlk/e2e

go 1.24.0

require (
	github.com/go-sql-driver/mysql v1.10.0
	github.com/walkline/AzerothGhost v1.0.6
)

require filippo.io/edwards25519 v1.2.0 // indirect

// Pinned to walkline/AzerothGhost v1.0.6 == 9a432b7
// (Engage does not FlushWorld; CMSG_TOGGLE_PVP). Immutable tag — do not force-move.
// Local co-dev: go.work (gitignored). CI: go mod download from this pin.
