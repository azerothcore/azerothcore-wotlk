#!/usr/bin/env bash
# deploy.sh — build the NostrumWoW worldserver Docker image locally and deploy to VPS.
#
# Usage:
#   ./deploy.sh              # build → push → deploy
#   ./deploy.sh --build-only # build + push, skip VPS deploy
#   ./deploy.sh --no-push    # build only, no push, no deploy
#
# Requirements:
#   - Docker logged in to Docker Hub (docker login)
#   - VPS SSH key at ~/.ssh/id_ed25519 (or set DEPLOY_SSH_KEY)
#   - VPS_HOST set in env or edit the default below

set -euo pipefail

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------

IMAGE="dockerdan247/nostrum-worldserver"
VPS_HOST="${VPS_HOST:-62.238.22.143}"
VPS_USER="${VPS_USER:-daniel}"
VPS_DIR="${VPS_DIR:-/opt/nostrum}"
SSH_KEY="${DEPLOY_SSH_KEY:-$HOME/.ssh/id_ed25519}"
JOBS="${JOBS:-$(nproc)}"

BUILD_ONLY=false
NO_PUSH=false

for arg in "$@"; do
  case "$arg" in
    --build-only) BUILD_ONLY=true ;;
    --no-push)    NO_PUSH=true ;;
  esac
done

GIT_SHA=$(git rev-parse --short HEAD)
TAG_SHA="${IMAGE}:${GIT_SHA}"
TAG_LATEST="${IMAGE}:latest"

echo "======================================"
echo "  NostrumWoW Deploy"
echo "  commit : $GIT_SHA"
echo "  image  : $TAG_LATEST"
echo "  jobs   : $JOBS"
echo "======================================"

# ---------------------------------------------------------------------------
# Write Dockerfile
# ---------------------------------------------------------------------------

DOCKERFILE=$(mktemp /tmp/Dockerfile.worldserver.XXXXXX)
trap 'rm -f "$DOCKERFILE"' EXIT

cat > "$DOCKERFILE" <<'DOCKERFILE_EOF'
FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    file \
    clang \
    libmysqlclient-dev \
    libssl-dev \
    libboost-all-dev \
    libreadline-dev \
    zlib1g-dev \
    libbz2-dev \
    libncurses-dev \
    git \
    pax-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /azerothcore-src

COPY . .

ARG BUILD_JOBS=4
RUN mkdir -p build && \
    cd build && \
    cmake .. \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_INSTALL_PREFIX=/azerothcore/env/dist \
      -DTOOLS=0 \
      -DSCRIPTS=static && \
    cmake --build . --target worldserver -- -j${BUILD_JOBS}

RUN mkdir -p /tmp/worldserver-build /tmp/worldserver-runtime-libs && \
    WORLD_BIN="$(find build -type f -name worldserver -perm /111 | head -n 1)" && \
    if [ -z "$WORLD_BIN" ]; then \
      echo "ERROR: worldserver binary not found"; exit 1; \
    fi && \
    echo "Binary: $WORLD_BIN" && \
    cp "$WORLD_BIN" /tmp/worldserver-build/worldserver && \
    chmod +x /tmp/worldserver-build/worldserver && \
    lddtree -l /tmp/worldserver-build/worldserver \
      | grep '^/' \
      | sort -u \
      | while read lib; do \
          if [ -f "$lib" ] && [ "$lib" != "/tmp/worldserver-build/worldserver" ]; then \
            cp -v "$lib" /tmp/worldserver-runtime-libs/; \
          fi; \
        done

FROM acore/ac-wotlk-worldserver:master

USER root

COPY --from=build /tmp/worldserver-build/worldserver /azerothcore/env/dist/bin/worldserver
COPY --from=build /tmp/worldserver-runtime-libs/ /opt/nostrum-libs/

ENV LD_LIBRARY_PATH="/opt/nostrum-libs:${LD_LIBRARY_PATH}"

RUN chmod +x /azerothcore/env/dist/bin/worldserver && \
    chown acore:acore /azerothcore/env/dist/bin/worldserver

COPY modules/mod-dual-spec-19/conf/mod-dual-spec-19.conf.dist /azerothcore/env/dist/etc/mod-dual-spec-19.conf
COPY modules/mod-level-rewards/conf/mod-level-rewards.conf.dist /azerothcore/env/dist/etc/mod-level-rewards.conf
COPY modules/mod-nostrum-rates/conf/nostrum_rates.conf.dist /azerothcore/env/dist/etc/nostrum_rates.conf
COPY modules/mod-nostrum-bg-xp/conf/nostrum_bg_xp.conf.dist /azerothcore/env/dist/etc/nostrum_bg_xp.conf
COPY modules/mod-nostrum-guide/conf/mod_nostrum_guide.conf.dist /azerothcore/env/dist/etc/mod_nostrum_guide.conf
COPY modules/mod-nostrum-hardcore/conf/mod_nostrum_hardcore.conf.dist /azerothcore/env/dist/etc/mod_nostrum_hardcore.conf
COPY modules/mod_nostrum_instant_mail/conf/mod_nostrum_instant_mail.conf.dist /azerothcore/env/dist/etc/mod_nostrum_instant_mail.conf
COPY modules/mod-nostrum-progression/conf/mod_nostrum_progression.conf.dist /azerothcore/env/dist/etc/mod_nostrum_progression.conf
COPY modules/mod-nostrum-starter/conf/mod_nostrum_starter.conf.dist /azerothcore/env/dist/etc/mod_nostrum_starter.conf
COPY modules/mod-cfbg/conf/CFBG.conf.dist /azerothcore/env/dist/etc/CFBG.conf
COPY modules/mod-transmog/conf/transmog.conf.dist /azerothcore/env/dist/etc/transmog.conf
COPY modules/mod-world-chat/conf/WorldChat.conf.dist /azerothcore/env/dist/etc/WorldChat.conf
COPY modules/mod-ah-bot-plus/conf/mod_ahbot.conf.dist /azerothcore/env/dist/etc/mod_ahbot.conf
COPY modules/mod-reserved-names/conf/mod_reserved_names.conf.dist /azerothcore/env/dist/etc/mod_reserved_names.conf

USER acore
DOCKERFILE_EOF

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------

echo ""
echo ">>> Building image..."
docker build \
  --file "$DOCKERFILE" \
  --build-arg "BUILD_JOBS=${JOBS}" \
  --tag "${TAG_LATEST}" \
  --tag "${TAG_SHA}" \
  .

echo ""
echo ">>> Build complete: ${TAG_LATEST} (${GIT_SHA})"

if $NO_PUSH; then
  echo ">>> --no-push set, skipping push and deploy."
  exit 0
fi

# ---------------------------------------------------------------------------
# Push
# ---------------------------------------------------------------------------

echo ""
echo ">>> Pushing to Docker Hub..."
docker push "${TAG_LATEST}"
docker push "${TAG_SHA}"

if $BUILD_ONLY; then
  echo ">>> --build-only set, skipping VPS deploy."
  exit 0
fi

# ---------------------------------------------------------------------------
# Deploy to VPS
# ---------------------------------------------------------------------------

echo ""
echo ">>> Deploying to VPS ${VPS_HOST}..."

ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no "${VPS_USER}@${VPS_HOST}" "
  set -e
  cd ${VPS_DIR}
  echo '--- pulling new image ---'
  docker compose pull ac-worldserver
  echo '--- restarting worldserver ---'
  docker compose up -d --no-deps ac-worldserver
  echo '--- waiting for worldserver to be healthy ---'
  sleep 5
  docker compose ps ac-worldserver
"

echo ""
echo "======================================"
echo "  Deploy complete!"
echo "  ${TAG_LATEST} (${GIT_SHA})"
echo "======================================"
