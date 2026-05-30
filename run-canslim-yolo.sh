#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -f "prompts/canslim-global-yolo.md" ]; then
  echo "Missing prompts/canslim-global-yolo.md"
  exit 1
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Missing codex command. Install Codex CLI first."
  exit 127
fi

export ENABLE_LIVE_TRADING=false
export AGENT_YOLO_ISOLATED_RUNNER="${AGENT_YOLO_ISOLATED_RUNNER:-YES}"

mkdir -p data/tickers data/ohlcv data/fundamentals data/tradability screenshots reports/symbols fixtures evals traces

echo "Running CAN SLIM global research agent in YOLO mode."
echo "Workspace: $(pwd)"
echo "Live trading: ${ENABLE_LIVE_TRADING}"
echo

codex --yolo --search < prompts/canslim-global-yolo.md
