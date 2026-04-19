#!/usr/bin/env bash
# ==============================================================================
# push-keeper-readmes.sh
#
# Pushes the 6 prepared README files into their corresponding GitHub repos
# using the gh CLI. Non-destructive — creates or updates README.md only.
#
# Usage:
#   1. gh auth login --hostname github.com  (must be Pratik2895, scope: repo)
#   2. bash push-keeper-readmes.sh
#
# The script:
#   - Clones each keeper repo into a tempdir
#   - Strips the top HTML comment from the local .md file
#   - Writes it as README.md in the repo
#   - Commits + pushes to the default branch
#   - Cleans up the tempdir
#
# Safe to re-run: overwrites README.md every time.
# ==============================================================================

set -u

OWNER="Pratik2895"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Force every gh invocation in this script to hit PUBLIC github.com,
# not an Enterprise host that might be set as the default (e.g. Intuit).
export GH_HOST="github.com"

# [local_md_file]="remote_repo_name"
declare -a MAPPINGS=(
  "PROFILE_README.md|Pratik2895"
  "Pratik2895.github.io.md|Pratik2895.github.io"
  "ontario-real-estate.md|ontario-real-estate"
  "AI-Stock-Intelligence-CAN-US-Markets.md|AI-Stock-Intelligence-CAN-US-Markets"
  "F1race_Data_Engineering_DBricks.md|F1race_Data_Engineering_DBricks"
  "Marketing-Analyst-Technical-Assignment.md|Marketing-Analyst-Technical-Assignment"
)

# ---------- colors ----------
if [ -t 1 ]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'
  CYAN=$'\033[36m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  RED=""; GREEN=""; YELLOW=""; CYAN=""; BOLD=""; RESET=""
fi

confirm() {
  local reply
  read -r -p "$1 [y/N] " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

# ---------- preflight ----------
echo "${BOLD}${CYAN}Push keeper READMEs to $OWNER's repos${RESET}"
echo

if ! command -v gh >/dev/null 2>&1; then
  echo "${RED}Error:${RESET} 'gh' CLI not found."
  exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo "${RED}Error:${RESET} 'git' not found."
  exit 1
fi

if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "${RED}Error:${RESET} gh not authenticated to github.com."
  echo "Run: ${BOLD}gh auth login --hostname github.com${RESET}"
  exit 1
fi

AUTHED_USER=$(gh api user --hostname github.com --jq '.login' 2>/dev/null)
if [[ "$AUTHED_USER" != "$OWNER" ]]; then
  echo "${RED}Error:${RESET} gh authed as '$AUTHED_USER', expected '$OWNER'."
  exit 1
fi

echo "${GREEN}✓${RESET} Authenticated as ${BOLD}$AUTHED_USER${RESET}"
echo
echo "Will push README.md to ${#MAPPINGS[@]} repos:"
for m in "${MAPPINGS[@]}"; do
  repo="${m#*|}"
  echo "  → $OWNER/$repo"
done
echo
if ! confirm "Proceed?"; then
  echo "Aborted."
  exit 0
fi
echo

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

SUCCESS=0; SKIPPED=0; FAILED=0

for mapping in "${MAPPINGS[@]}"; do
  local_file="${mapping%|*}"
  repo_name="${mapping#*|}"
  local_path="$SCRIPT_DIR/$local_file"

  echo "${BOLD}─── $repo_name ───${RESET}"

  if [[ ! -f "$local_path" ]]; then
    echo "  ${RED}✗${RESET} Local file not found: $local_path"
    FAILED=$((FAILED + 1))
    continue
  fi

  # For the profile repo, auto-create if missing
  if [[ "$repo_name" == "$OWNER" ]]; then
    if ! gh repo view "$OWNER/$repo_name" >/dev/null 2>&1; then
      echo "  ${YELLOW}·${RESET} Profile repo doesn't exist, creating..."
      if gh repo create "$OWNER/$repo_name" --public --description "Profile README" 2>/tmp/gh_err; then
        echo "    ${GREEN}✓ created${RESET}"
      else
        echo "    ${RED}✗ failed:${RESET} $(cat /tmp/gh_err)"
        FAILED=$((FAILED + 1))
        continue
      fi
    fi
  fi

  if ! gh repo view "$OWNER/$repo_name" >/dev/null 2>&1; then
    echo "  ${YELLOW}·${RESET} Repo not found, skipping"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if ! confirm "  Push README.md to $OWNER/$repo_name?"; then
    echo "    ${YELLOW}skipped${RESET}"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  # Clone, strip HTML comment header, commit, push
  work="$TMPDIR/$repo_name"
  (
    set -e
    git clone --depth=1 --quiet "https://github.com/$OWNER/$repo_name.git" "$work" 2>/dev/null
    cd "$work"

    # Strip leading <!-- ... --> block from the local md, if present
    # This removes everything from the first `<!--` through the matching `-->`
    awk 'BEGIN{inhdr=0; done=0}
         /^<!--/ && !done {inhdr=1; next}
         inhdr && /-->/ {inhdr=0; done=1; next}
         inhdr {next}
         {print}' "$local_path" > README.md

    git add README.md
    # Configure committer if not already (GH auth uses your token for push)
    if ! git config user.email >/dev/null 2>&1; then
      git config user.email "$OWNER@users.noreply.github.com"
      git config user.name "$OWNER"
    fi

    if git diff --cached --quiet; then
      echo "  ${YELLOW}·${RESET} No changes (README identical)"
      exit 10
    fi

    git commit -m "docs: add professional README" --quiet
    # Detect default branch
    default_branch=$(git remote show origin | awk '/HEAD branch/ {print $NF}')
    git push origin "HEAD:${default_branch}" --quiet
  )
  rc=$?

  if [[ $rc -eq 0 ]]; then
    echo "  ${GREEN}✓ pushed${RESET}"
    SUCCESS=$((SUCCESS + 1))
  elif [[ $rc -eq 10 ]]; then
    echo "  ${GREEN}✓ already up to date${RESET}"
    SUCCESS=$((SUCCESS + 1))
  else
    echo "  ${RED}✗ failed (rc=$rc)${RESET}"
    FAILED=$((FAILED + 1))
  fi
  echo
done

echo "${BOLD}Summary:${RESET} pushed=$SUCCESS · skipped=$SKIPPED · failed=$FAILED"
echo
echo "${GREEN}✓ Done.${RESET} Next: open https://github.com/$OWNER and pin your 6 keeper repos."
