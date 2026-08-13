module github.com/azerothcore/azerothcore-wotlk/e2e

go 1.24.0

require (
	github.com/go-sql-driver/mysql v1.10.0
	github.com/walkline/AzerothGhost v0.0.0
)

require filippo.io/edwards25519 v1.2.0 // indirect

// Local harness co-dev: use e2e/go.work (gitignored) — see go.work.example.
// CI checkouts walkline/AzerothGhost and path-replaces this module (see e2e-live.yml).
