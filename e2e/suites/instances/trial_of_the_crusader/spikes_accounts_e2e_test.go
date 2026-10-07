//go:build e2e

package trial_of_the_crusader_test

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/azerothcore/AzerothGhost/client"
	"github.com/azerothcore/AzerothGhost/e2e/e2eharness"
)

// NewScenario in AzerothGhost v1.0.8 closes sessions, but does not delete accounts.
// Own creation here so even a failure during login runs account cleanup. INSERT
// must not upsert: a name collision must never give us ownership of an old account.
func newSpikeBots(t *testing.T) []*e2eharness.ScenarioBot {
	t.Helper()
	authDB, charDB := e2eharness.OpenTestDBs(t)
	idents := e2eharness.MakeBotIdentsRaceClass("Spike", 2, e2eharness.RaceHuman, e2eharness.ClassPaladin)
	for _, ident := range idents {
		username := strings.ToUpper(ident.Account)
		salt, verifier := e2eharness.ComputeSRP6(username, strings.ToUpper(e2eharness.DefaultPassword))
		result, err := authDB.Exec(`INSERT INTO account (username, salt, verifier, expansion) VALUES (?, ?, ?, 2)`, username, salt, verifier)
		if err != nil {
			e2eharness.HarnessFailf(t, "create owned account %s: %v", username, err)
		}
		accountID, err := result.LastInsertId()
		if err != nil {
			e2eharness.HarnessFailf(t, "read created account ID for %s: %v", username, err)
		}
		// Registered before permissions/login, after DB Close callbacks. Session
		// and summon callbacks registered later run first (t.Cleanup is LIFO).
		t.Cleanup(func() {
			if err := cleanupSpikeAccount(authDB, charDB, accountID, username); err != nil {
				t.Errorf("harness: cleanup account %s (id %d): %v", username, accountID, err)
			} else {
				t.Logf("removed test account %s (id %d)", username, accountID)
			}
		})
		if err := e2eharness.SetGM(authDB, username, 3); err != nil {
			e2eharness.HarnessFailf(t, "grant test permissions to %s: %v", username, err)
		}
	}

	sessions := e2eharness.LoginBots(t, idents)
	bots := make([]*e2eharness.ScenarioBot, len(sessions))
	for i, session := range sessions {
		bot := &e2eharness.ScenarioBot{Session: session, AuthDB: authDB, CharDB: charDB, Ident: idents[i]}
		bot.Ident.CharName = session.Name
		bots[i] = bot
		t.Cleanup(func() { bot.CleanupOwnedSummons(t) })
		e2eharness.EnableGM(t, session.World)
		e2eharness.SetLevel(t, session.World, 80)
	}
	return bots
}

func cleanupSpikeAccount(authDB, charDB *sql.DB, accountID int64, username string) (cleanupErr error) {
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Minute)
	defer cancel()
	var actual string
	if err := authDB.QueryRowContext(ctx, `SELECT username FROM account WHERE id = ?`, accountID).Scan(&actual); err != nil {
		return err
	}
	if actual != username {
		return fmt.Errorf("account ownership changed; refusing cleanup")
	}
	// Revoke GM even if character cleanup later fails. If deletion fails, try
	// to ban the residue and report quarantine failures rather than hiding them.
	defer func() {
		if cleanupErr == nil {
			return
		}
		// Fresh context: the cleanup timeout must not prevent quarantining residue.
		lockCtx, lockCancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer lockCancel()
		if _, err := authDB.ExecContext(lockCtx, `INSERT INTO account_banned (id, bandate, unbandate, bannedby, banreason, active) SELECT id, UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 'E2E cleanup', 'Incomplete Spike test cleanup', 1 FROM account WHERE id = ? AND username = ?`, accountID, username); err != nil {
			cleanupErr = errors.Join(cleanupErr, fmt.Errorf("quarantine failed: %w", err))
		}
	}()
	if _, err := authDB.ExecContext(ctx, `DELETE FROM account_access WHERE id = ?`, accountID); err != nil {
		return err
	}

	if err := waitSpikeDB(ctx, charDB, `SELECT COUNT(*) FROM characters WHERE account = ? AND online <> 0`, accountID); err != nil {
		return fmt.Errorf("wait for character logout: %w", err)
	}
	var count int
	if err := charDB.QueryRowContext(ctx, `SELECT COUNT(*) FROM characters WHERE account = ?`, accountID).Scan(&count); err != nil {
		return err
	}
	if count != 0 {
		if err := deleteSpikeCharacters(ctx, username); err != nil {
			return err
		}
		if err := waitSpikeDB(ctx, charDB, `SELECT COUNT(*) FROM characters WHERE account = ?`, accountID); err != nil {
			return fmt.Errorf("wait for character deletion: %w", err)
		}
	}
	if err := waitSpikeDB(ctx, authDB, `SELECT COUNT(*) FROM account WHERE id = ? AND online <> 0`, accountID); err != nil {
		return fmt.Errorf("wait for cleanup session logout: %w", err)
	}
	// These are the account-scoped character rows AccountMgr::DeleteAccount
	// removes in addition to Player::DeleteFromDB's character-scoped cleanup.
	for _, query := range []string{
		`DELETE FROM account_tutorial WHERE accountId = ?`,
		`DELETE FROM account_data WHERE accountId = ?`,
	} {
		if _, err := charDB.ExecContext(ctx, query, accountID); err != nil {
			return err
		}
	}
	tx, err := authDB.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()
	for _, query := range []string{
		`DELETE FROM account_access WHERE id = ?`,
		`DELETE FROM realmcharacters WHERE acctid = ?`,
		`DELETE FROM account_banned WHERE id = ?`,
		`DELETE FROM account_muted WHERE guid = ?`,
		`DELETE FROM account WHERE id = ?`,
	} {
		if _, err := tx.ExecContext(ctx, query, accountID); err != nil {
			return err
		}
	}
	return tx.Commit()
}

func waitSpikeDB(ctx context.Context, db *sql.DB, query string, accountID int64) error {
	ticker := time.NewTicker(100 * time.Millisecond)
	defer ticker.Stop()
	for {
		var count int
		if err := db.QueryRowContext(ctx, query, accountID).Scan(&count); err != nil {
			return err
		}
		if count == 0 {
			return nil
		}
		select {
		case <-ctx.Done():
			return ctx.Err()
		case <-ticker.C:
		}
	}
}

// Delete through the character-selection protocol, not ad-hoc character SQL:
// the server owns inventory, spells, pets, groups and its in-memory caches.
func deleteSpikeCharacters(ctx context.Context, username string) error {
	auth := client.NewAuthClient(username, e2eharness.DefaultPassword)
	realms, err := auth.Authenticate(e2eharness.AuthAddr)
	if err != nil {
		return fmt.Errorf("cleanup auth: %w", err)
	}
	if len(realms) == 0 {
		return fmt.Errorf("cleanup auth returned no realms")
	}
	w := client.NewWorldClient(username, auth.SessionKey(), func(string, ...interface{}) {})
	defer w.Close()
	lists := make(chan []client.CharEnumEntry, 1)
	w.OnCharList = func(chars []client.CharEnumEntry) {
		select {
		case lists <- chars:
		default:
		}
	}
	deleted := make(chan byte, 1)
	stop := w.AddPacketHook(func(opcode uint16, data []byte) {
		if opcode == 0x003C && len(data) > 0 { // SMSG_CHAR_DELETE
			select {
			case deleted <- data[0]:
			default:
			}
		}
	})
	defer stop()
	if err := w.Connect(realms[0].Address); err != nil {
		return err
	}
	go func() { _ = w.Run() }()
	if err := w.WaitForSessionPhase(client.PhaseAuthed, 20*time.Second); err != nil {
		return err
	}
	for _, send := range []func() error{w.SendReadyForAccountDataTimes, w.SendRealmSplit, w.RequestCharList} {
		if err := send(); err != nil {
			return err
		}
	}
	var chars []client.CharEnumEntry
	select {
	case chars = <-lists:
	case <-ctx.Done():
		return fmt.Errorf("cleanup character list: %w", ctx.Err())
	}
	for _, char := range chars {
		if err := w.DeleteCharacter(char.GUID); err != nil {
			return err
		}
		select {
		case code := <-deleted:
			if code != 0x47 { // CHAR_DELETE_SUCCESS
				return fmt.Errorf("delete character %d: response %#x", char.GUID, code)
			}
		case <-ctx.Done():
			return fmt.Errorf("delete character %d: %w", char.GUID, ctx.Err())
		}
	}
	return nil
}
