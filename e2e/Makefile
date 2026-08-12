# AzerothCore live-stack e2e (AzerothGhost harness)
# Requires: running auth+world+MySQL and E2E_* env vars (see .env.example).

GO       ?= go
TAGS     ?= e2e
TIMEOUT  ?= 30m
PARALLEL ?= 2
COUNT    ?= 1

GOTEST = $(GO) test -tags=$(TAGS) -count=$(COUNT) -timeout $(TIMEOUT)

.PHONY: e2e-smoke e2e-category e2e-sub e2e-issue e2e-tags e2e-full e2e-list e2e-mod

e2e-mod:
	$(GO) mod tidy

e2e-list:
	$(GOTEST) -list . ./...

e2e-smoke:
	$(GOTEST) -v -parallel $(PARALLEL) ./smoke/
	E2E_TAGS=smoke $(GOTEST) -v -parallel $(PARALLEL) ./suites/...

e2e-category:
	@test -n "$(C)" || (echo "usage: make e2e-category C=quests"; exit 1)
	$(GOTEST) -v -parallel $(PARALLEL) ./suites/$(C)/...

e2e-sub:
	@test -n "$(C)" || (echo "usage: make e2e-sub C=spells/aura"; exit 1)
	$(GOTEST) -v -parallel $(PARALLEL) ./suites/$(C)/...

e2e-issue:
	@test -n "$(N)" || (echo "usage: make e2e-issue N=26549"; exit 1)
	$(GOTEST) -v -parallel 1 -run 'TestAC_$(N)_' ./suites/issues/ ./suites/...

e2e-tags:
	@test -n "$(TAGS_FILTER)" || (echo "usage: make e2e-tags TAGS_FILTER=smoke,short"; exit 1)
	E2E_TAGS=$(TAGS_FILTER) $(GOTEST) -v -parallel $(PARALLEL) ./...

e2e-full:
	$(GOTEST) -v -parallel $(PARALLEL) -timeout 120m ./...
