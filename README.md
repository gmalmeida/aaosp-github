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
- **Phase**: Initial setup
- **Progress**: Repo structure created, agents configured

## 4-Week Training Plan

| Week | Topic | Status |
|------|-------|--------|
| 1 | AAOS Platform Build & Upgrades | Active |
| 2 | Figma to AAOS HMI/UX | Pending |
| 3 | AAOS Cloud & Connectivity | Pending |
| 4 | AAOS OTA & Security | Pending |

## Week 1 Plan: AAOS Platform Build & Upgrades

### Day 1: Setup & First Build
- Install dependencies: `sudo ./scripts/setup-deps.sh`
- Initialize AAOS source: `repo init` + `repo sync` in `source/`
- Build car emulator image: `./scripts/build.sh`
- Boot emulator: `./scripts/emulator.sh`
- Explore the running system via `adb shell`

### Day 2: Platform Architecture
- Study AAOS architecture: CarService, VHAL, Car SystemUI
- Explore `packages/services/Car/` source code
- Understand the AAOS-specific HAL interfaces
- Hands-on: trace a VHAL property from app to HAL

### Day 3: Modify System Services
- Modify CarService to add custom logging
- Build and push changes to emulator
- Understand the Car API surface (`android.car.*`)
- Hands-on: create a simple Car app using Car API

### Day 4: AAOS 14 to 15 Upgrade Analysis
- Run `./scripts/upgrade-test.sh` to understand scope
- Use `/agents upgrade-diff aaos14 aaos15` for detailed analysis
- Study breaking changes in VHAL, CarService, permissions
- Document migration checklist

### Day 5: Consolidation & Capstone
- Build a mini-project: custom VHAL property + test app
- Review and update all documentation
- Run `/agents daily-review` and `/agents git-sync`
- Plan Week 2 topics

## Repo Structure

```
aaosp-github/
  CLAUDE.md        # Persistent context for Claude Code
  course.config    # Training configuration (edit to change topics)
  README.md        # This file - daily progress & instructions
  agents/          # Custom sub-agents (auto-discovered)
    daily-review.md
    git-sync.md
    course-planner.md
    aaos-mentor.md
    upgrade-diff.md
    token-guard.md
  scripts/         # Automation scripts
    setup-deps.sh  # Install build dependencies
    build.sh       # Build AAOS image
    emulator.sh    # Launch emulator
    upgrade-test.sh
  source/          # AAOS/AOSP source code (after repo sync)
  docs/            # Documentation and notes
  courses/         # Generated course plans per topic
```

## Daily Workflow

1. `cd ~/aaosp-github && claude --continue`
2. Work on today's tasks, use agents as needed:
   - `/agents aaos-mentor "how does VHAL work?"`
   - `/agents course-planner --update`
3. End of day:
   - `/agents daily-review` - rewrites README with progress
   - `/agents git-sync` - commits and pushes to GitHub

## Changing Topics

To switch to a new topic (e.g., after Week 1):

1. Edit `course.config`: set `current_topic` and `current_week`
2. Run `/agents course-planner --update` to generate the new week's plan
3. The system adapts automatically - all agents are course-agnostic

## IDE Setup

- **Recommended**: VS Code + Claude Code extension
  1. Install VS Code
  2. Install Claude Code extension
  3. Open `~/aaosp-github/`
  4. Use integrated terminal for `claude` commands
- **Fallback**: Android Studio for emulator/app debugging

## Key Learnings

_Updated daily by the daily-review agent._

---
*Powered by Claude Code with persistent agents and GitHub sync.*
