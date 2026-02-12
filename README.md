# AAOS Learning Lab

Persistent, token-efficient learning environment for Android Automotive OS and infotainment engineering.

**Goal**: Build deep expertise across 4 key infotainment topics in 1 month to work as a freelance consultant for OEMs and Tier-1 suppliers.

## Quick Start

```bash
# On a new machine:
git clone git@github.com:gmalmeida/aaosp-github.git
cd aaosp-github
claude --continue
```

## Current Status

- **Week**: 1 of 4
- **Topic**: AAOS Platform Build & Upgrades
- **Phase**: Day 0 (prep) complete — Day 1 starts tomorrow
- **Course Plan**: [`courses/week1-aaos-platform-build-upgrades.md`](courses/week1-aaos-platform-build-upgrades.md)

### What was completed today (Day 0 — Feb 12, 2026)
- Repo structure created: `agents/`, `scripts/`, `courses/`, `docs/`, `source/`
- 6 custom agents configured: daily-review, git-sync, course-planner, aaos-mentor, upgrade-diff, token-guard
- `CLAUDE.md` created for persistent Claude Code context
- `course.config` created with 4-week training plan
- Build dependencies installed via `setup-deps.sh` (openjdk-17, repo tool, build-essential, etc.)
- AAOS 14 `repo init` completed; `repo sync` running in tmux session `aaos-sync`
- Full Week 1 course plan generated (5 days, 40 hours)
- VNC server configured for remote graphical access (port 5901, XFCE desktop)
- Build/emulator/upgrade scripts created and made executable

### What to do tomorrow (Day 1)

1. **Check repo sync status**:
   ```bash
   tmux attach -t aaos-sync
   # or
   tail -20 ~/aaosp-github/source/sync.log
   ```
2. **If sync complete**, start the build:
   ```bash
   ./scripts/build.sh
   ```
3. **If sync still running**, start with Day 1 morning theory tasks (see course plan)
4. **Connect graphically from Mac** (for emulator later):
   ```bash
   # On Mac terminal:
   ssh -L 5901:localhost:5901 gabriel@192.168.2.201
   # Then in another Mac terminal:
   open vnc://localhost:5901
   ```
5. Follow the detailed Day 1 plan in [`courses/week1-aaos-platform-build-upgrades.md`](courses/week1-aaos-platform-build-upgrades.md)

## 4-Week Training Plan

| Week | Topic | Status |
|------|-------|--------|
| 1 | AAOS Platform Build & Upgrades | Active |
| 2 | Figma to AAOS HMI/UX | Pending |
| 3 | AAOS Cloud & Connectivity | Pending |
| 4 | AAOS OTA & Security | Pending |

## Week 1 Plan: AAOS Platform Build & Upgrades

| Day | Focus | Key Deliverable |
|-----|-------|----------------|
| Day 1 | Environment Setup & First Build | Emulator booting, `adb shell` access |
| Day 2 | Platform Architecture Deep Dive | CarService + VHAL property tracing |
| Day 3 | Modify Services & Build Apps | Custom logging in CarService, first Car app |
| Day 4 | AAOS 14→15 Upgrade Analysis | Migration checklist for OEM consulting |
| Day 5 | Capstone & Consolidation | End-to-end custom VHAL property + app |

Full details: [`courses/week1-aaos-platform-build-upgrades.md`](courses/week1-aaos-platform-build-upgrades.md)

## Remote Access Setup

This machine (`android` / `192.168.2.201`) is accessed via SSH from a Mac laptop.

### VNC (for emulator & GUI apps)
```bash
# On Mac: create SSH tunnel + connect
ssh -L 5901:localhost:5901 gabriel@192.168.2.201
open vnc://localhost:5901    # built-in Mac VNC viewer
```
- VNC server: TigerVNC on `:1` (port 5901), XFCE desktop, 1920x1080
- Start VNC if not running: `vncserver :1 -geometry 1920x1080 -depth 24 -localhost no`

### X11 Forwarding (for single GUI apps)
```bash
# On Mac (requires XQuartz: brew install --cask xquartz):
ssh -X gabriel@192.168.2.201
```

## Repo Structure

```
aaosp-github/
  CLAUDE.md          # Persistent context (Claude Code reads automatically)
  course.config      # Training config (edit to change topics)
  README.md          # This file — progress tracker & daily instructions
  agents/            # Custom sub-agents (auto-discovered)
    daily-review.md  # Rewrites README, summarizes progress, plans tomorrow
    git-sync.md      # Auto-commits and pushes to GitHub
    course-planner.md # Generates 1-week learning plans from course.config
    aaos-mentor.md   # AAOS expert Q&A
    upgrade-diff.md  # Version migration analysis & checklists
    token-guard.md   # Token usage optimization
  scripts/           # Automation scripts
    setup-deps.sh    # Install AAOS build dependencies
    build.sh         # Build AAOS image
    emulator.sh      # Launch car emulator
    upgrade-test.sh  # Version upgrade testing
  source/            # AAOS/AOSP source (repo sync, git-ignored)
  docs/              # Documentation, notes, and reference material
  courses/           # Generated course plans per topic
```

## Daily Workflow

1. `cd ~/aaosp-github && claude --continue`
2. Work on today's tasks, use agents as needed:
   - `aaos-mentor "how does VHAL work?"`
   - `course-planner --update`
3. End of day:
   - `daily-review` — rewrites README with progress
   - `git-sync` — commits and pushes to GitHub

## Changing Topics

To switch to a new topic (e.g., after Week 1):

1. Edit `course.config`: set `current_topic` and `current_week`
2. Run `course-planner --update` to generate the new week's plan
3. The system adapts automatically — all agents are course-agnostic

## IDE Setup

- **Recommended**: VS Code + Claude Code extension
  1. Install VS Code
  2. Install Claude Code extension
  3. Open `~/aaosp-github/`
  4. Use integrated terminal for `claude` commands
- **Fallback**: Android Studio for emulator/app debugging

## Key Learnings

_Updated daily by the daily-review agent._

- **Day 0**: Project bootstrapped. AAOS 14 source syncing. All tooling and agents in place.

---
*Powered by Claude Code with persistent agents and GitHub sync.*
