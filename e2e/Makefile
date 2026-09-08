# AzerothCore live-stack e2e (AzerothGhost harness)
# Requires: running auth+world+MySQL and E2E_* env vars (see .env.example).

GO       ?= go
TAGS     ?= e2e
TIMEOUT  ?= 30m
# In-package test concurrency. Keep 1: PackagePad is sticky per package; parallel
# tests in the same package share one pad and thrash each other.
PARALLEL ?= 1
# Package concurrency (go test -p). IsolationPads has 27 unique pads; more packages
# than pads hash-share locations. Default 1 = safe unique pad assignment always.
P        ?= 1
COUNT    ?= 1

GOTEST = $(GO) test -tags=$(TAGS) -count=$(COUNT) -timeout $(TIMEOUT) -p $(P)

.PHONY: e2e-smoke e2e-category e2e-sub e2e-issue e2e-tags e2e-full e2e-list e2e-local e2e-mod

e2e-mod:
	$(GO) mod tidy

e2e-list:
	$(GOTEST) -list . ./...

e2e-smoke:
	$(GOTEST) -v -parallel $(PARALLEL) ./smoke/
	# Suites tagged smoke only (open-issue suites must not carry the smoke tag).
	E2E_TAGS=smoke $(GOTEST) -v -parallel $(PARALLEL) ./suites/...

e2e-category:
	@test -n "$(C)" || (echo "usage: make e2e-category C=quests"; exit 1)
	$(GOTEST) -v -parallel $(PARALLEL) ./suites/$(C)/...

e2e-sub:
	@test -n "$(C)" || (echo "usage: make e2e-sub C=spells/aura"; exit 1)
	$(GOTEST) -v -parallel $(PARALLEL) ./suites/$(C)/...

e2e-issue:
	@test -n "$(N)" || (echo "usage: make e2e-issue N=26549"; exit 1)
	# Prefer TestAC_<n>_* names; E2E_ISSUE also selects by meta.Issue.
	E2E_ISSUE=$(N) $(GOTEST) -v -parallel 1 -run 'TestAC_$(N)_' ./suites/...

e2e-tags:
	@test -n "$(TAGS_FILTER)" || (echo "usage: make e2e-tags TAGS_FILTER=smoke,short"; exit 1)
	E2E_TAGS=$(TAGS_FILTER) $(GOTEST) -v -parallel $(PARALLEL) ./...

# Scratch/debug packages under local/ (gitignored). Does not run smoke/suites.
e2e-local:
	$(GOTEST) -v -parallel 1 ./local/...

# Default 120m unless the caller set TIMEOUT= on the command line.
e2e-full: TIMEOUT = 120m
e2e-full:
	$(GOTEST) -v -parallel $(PARALLEL) ./...
