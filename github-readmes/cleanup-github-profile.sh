#!/usr/bin/env bash
# ==============================================================================
# cleanup-github-profile.sh
#
# Prunes Pratik2895's public GitHub profile from ~30 repos down to ~13 meaningful
# ones. Interactive — prompts (y/N) before EVERY destructive action.
#
# Three buckets:
#   Bucket A — DELETE forks (13)
#   Bucket B — MAKE PRIVATE (10) — not delete, just hide
#   Bucket C — LEAVE PUBLIC (keepers, listed for reference only)
#
# Usage:
#   1. Authenticate the gh CLI to PUBLIC github.com (not Enterprise):
#        gh auth login --hostname github.com
#      When prompted, grant scopes: repo, delete_repo
#   2. Run:
#        bash cleanup-github-profile.sh
#   3. Answer y / N for each prompt. Default is N (skip) — hit Enter to skip.
#
# Safe to re-run: will skip already-deleted / already-private repos.
# ==============================================================================

set -u  # error on undefined vars, but NOT -e (we handle errors per-op)

OWNER="Pratik2895"

# ---------- Bucket A: forks to DELETE ----------
FORKS_TO_DELETE=(
  "AI_Fundamentals_Data_Domain"
  "RetailProjectspark"
  "tableau-ultimate-course"
  "sql-data-warehouse-project"
  "IPL-2025--DATA-Engineering-"
  "FabricDataEngineering"
  "Trendytech-Azure-Project"
  "data-engineer-handbook-zach"
  "NotesOfYouTubeSQLSeries"
  "Fabric-NYC-Taxi-Data-Project"
  "Databricks-Certified-Data-Engineer-Associate"
  "tokyo-olympic-azure-data-engineering-project"
  "end-to-end-data-engineering-project-4413618"
)

# ---------- Bucket B: repos to MAKE PRIVATE ----------
MAKE_PRIVATE=(
  "Claude-code-project"
  "Apache-spark-project-folder-structure"
  "Finance-Spark-Project"
  "azuredatafactory"
  "Business-360-Insights"
  "python"
  "Sql-projects"
  "Tableau-dashboards"
  "ML-PYTHON-VS-R"
  "Credit-card-fraud-detection-using-machine-learning-with-R"
)

# ---------- Bucket C: keep public (reference) ----------
KEEPERS=(
  "Pratik2895.github.io"
  "Pratik2895"
  "ontario-real-estate"
  "AI-Stock-Intelligence-CAN-US-Markets"
  "F1race_Data_Engineering_DBricks"
  "Marketing-Analyst-Technical-Assignment"
  "Promotional-Analytics-Unveiling-Success-Strategies"
)

# ---------- colors ----------
if [ -t 1 ]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'
  CYAN=$'\033[36m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  RED=""; GREEN=""; YELLOW=""; CYAN=""; BOLD=""; RESET=""
fi

# ---------- helpers ----------
confirm() {
  # $1 = prompt, default NO
  local prompt="$1"
  local reply
  read -r -p "$prompt [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

repo_exists() {
  gh repo view "$OWNER/$1" --json name >/dev/null 2>&1
}

is_fork() {
  # returns 0 (true) if $1 is a fork
  local out
  out=$(gh repo view "$OWNER/$1" --json isFork --jq '.isFork' 2>/dev/null) || return 1
  [[ "$out" == "true" ]]
}

is_private() {
  local out
  out=$(gh repo view "$OWNER/$1" --json visibility --jq '.visibility' 2>/dev/null) || return 1
  [[ "$out" == "PRIVATE" ]]
}

# ---------- preflight ----------
echo "${BOLD}${CYAN}GitHub profile cleanup for $OWNER${RESET}"
echo

if ! command -v gh >/dev/null 2>&1; then
  echo "${RED}Error:${RESET} 'gh' CLI not found. Install from https://cli.github.com"
  exit 1
fi

# Check auth against public github.com (not Enterprise)
if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "${RED}Error:${RESET} gh is not authenticated to github.com."
  echo "Run: ${BOLD}gh auth login --hostname github.com${RESET}"
  echo "  → choose: HTTPS, login with browser, grant scopes: ${BOLD}repo, delete_repo${RESET}"
  exit 1
fi

# Verify the authed user is actually Pratik2895
AUTHED_USER=$(gh api user --hostname github.com --jq '.login' 2>/dev/null)
if [[ "$AUTHED_USER" != "$OWNER" ]]; then
  echo "${RED}Error:${RESET} gh is authenticated as '${AUTHED_USER}', not '${OWNER}'."
  echo "Re-run gh auth login and select the correct account."
  exit 1
fi

echo "${GREEN}✓${RESET} Authenticated as ${BOLD}$AUTHED_USER${RESET} on github.com"
echo

# ---------- summary ----------
echo "${BOLD}Planned actions:${RESET}"
echo "  ${RED}Delete${RESET} ........ ${#FORKS_TO_DELETE[@]} forks"
echo "  ${YELLOW}Make private${RESET} .. ${#MAKE_PRIVATE[@]} repos"
echo "  ${GREEN}Keep public${RESET} ... ${#KEEPERS[@]} repos (reference only)"
echo
if ! confirm "${BOLD}Proceed to interactive prompts?${RESET}"; then
  echo "Aborted."
  exit 0
fi
echo

# ---------- Bucket A: delete forks ----------
echo "${BOLD}${RED}── BUCKET A: delete forks ──${RESET}"
DELETED=0; SKIPPED=0; MISSING=0
for repo in "${FORKS_TO_DELETE[@]}"; do
  if ! repo_exists "$repo"; then
    echo "  ${YELLOW}·${RESET} $repo ${YELLOW}(not found, skipping)${RESET}"
    MISSING=$((MISSING + 1))
    continue
  fi

  # Extra safety: verify it's actually a fork
  if ! is_fork "$repo"; then
    echo "  ${YELLOW}!${RESET} $repo is ${BOLD}NOT a fork${RESET} — skipping for safety"
    echo "    If you still want to delete it, do so manually."
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if confirm "  ${RED}DELETE${RESET} $OWNER/$repo (fork)?"; then
    if gh repo delete "$OWNER/$repo" --yes 2>/tmp/gh_err; then
      echo "    ${GREEN}✓ deleted${RESET}"
      DELETED=$((DELETED + 1))
    else
      echo "    ${RED}✗ failed:${RESET} $(cat /tmp/gh_err)"
    fi
  else
    echo "    ${YELLOW}skipped${RESET}"
    SKIPPED=$((SKIPPED + 1))
  fi
done
echo "  ${BOLD}Bucket A:${RESET} deleted=$DELETED · skipped=$SKIPPED · missing=$MISSING"
echo

# ---------- Bucket B: make private ----------
echo "${BOLD}${YELLOW}── BUCKET B: make private ──${RESET}"
PRIVATED=0; SKIPPED_B=0; MISSING_B=0; ALREADY=0
for repo in "${MAKE_PRIVATE[@]}"; do
  if ! repo_exists "$repo"; then
    echo "  ${YELLOW}·${RESET} $repo ${YELLOW}(not found, skipping)${RESET}"
    MISSING_B=$((MISSING_B + 1))
    continue
  fi

  if is_private "$repo"; then
    echo "  ${GREEN}·${RESET} $repo ${GREEN}(already private)${RESET}"
    ALREADY=$((ALREADY + 1))
    continue
  fi

  if confirm "  ${YELLOW}PRIVATE${RESET} $OWNER/$repo?"; then
    if gh repo edit "$OWNER/$repo" --visibility private --accept-visibility-change-consequences 2>/tmp/gh_err; then
      echo "    ${GREEN}✓ now private${RESET}"
      PRIVATED=$((PRIVATED + 1))
    else
      echo "    ${RED}✗ failed:${RESET} $(cat /tmp/gh_err)"
    fi
  else
    echo "    ${YELLOW}skipped${RESET}"
    SKIPPED_B=$((SKIPPED_B + 1))
  fi
done
echo "  ${BOLD}Bucket B:${RESET} privated=$PRIVATED · already=$ALREADY · skipped=$SKIPPED_B · missing=$MISSING_B"
echo

# ---------- Summary ----------
echo "${BOLD}${GREEN}✓ Done.${RESET}"
echo
echo "Next steps:"
echo "  1. Run  ${CYAN}bash github-readmes/push-keeper-readmes.sh${RESET}  to push READMEs"
echo "  2. Open https://github.com/$OWNER and ${BOLD}pin${RESET} your 6 keeper repos"
echo "  3. Update your bio — see github-readmes/README.md"
