# AAOS Learning Lab - Project Context

## Purpose
Persistent learning lab for Android Automotive OS (AAOS) and related infotainment topics.
Goal: Become a freelance consultant for OEMs and Tier-1 suppliers building next-gen infotainment systems.

## Repo Structure
- `source/` - AAOS/AOSP source code and build artifacts (source/out/)
- `docs/` - Documentation, notes, and reference material
- `agents/` - Custom sub-agent definitions (auto-discovered by Claude Code)
- `scripts/` - Build scripts, automation, and utilities
- `courses/` - Generated course plans and materials per topic

## Configuration
- `course.config` - YAML config defining current topic and 4-week training plan
- Always read `course.config` to determine the active topic before generating content

## Workflow
1. Start session: `cd ~/aaosp-github && claude --continue`
2. Work with agents: `/agents aaos-mentor`, `/agents course-planner`, etc.
3. End of day: `/agents daily-review` then `/agents git-sync`
4. New machine: `git clone git@github.com:gmalmeida/aaosp-github.git && cd aaosp-github && claude --continue`

## Key Conventions
- Keep README.md updated daily with progress and learning notes
- Each course topic gets its own file in `courses/` (e.g., `courses/week1-aaos-platform.md`)
- Scripts must be executable and well-commented
- Agents are course-agnostic: they read `course.config` for topic context
- Minimize token usage: use scoped context, summaries, and avoid redundant reads

## Current Status
- Week: 1
- Topic: AAOS Platform Build & Upgrades
- Phase: Day 0 complete, Day 1 starts Feb 13
- Repo sync: AAOS 14 syncing in tmux session `aaos-sync` (check `source/sync.log`)
- VNC: TigerVNC on :1 (port 5901), XFCE, 1920x1080
- Remote access: SSH from Mac laptop, LAN IP 192.168.2.201
