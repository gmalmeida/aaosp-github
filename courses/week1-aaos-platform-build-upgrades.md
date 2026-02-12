# Week 1: AAOS Platform Build & Upgrades

**Topic**: Android Automotive OS Platform Build & Upgrades
**Duration**: 40 hours (8h/day x 5 days)
**Goal**: Build AAOS from source, understand platform architecture, modify system services, and analyze version upgrades — all skills needed to consult OEMs/Tier-1s on infotainment platform delivery.

---

## Day 1: Environment Setup & First Build (8h)

### Learning Objectives
- Set up a complete AAOS build environment on Linux
- Understand the AOSP repo tool and manifest structure
- Build an AAOS car emulator image from source
- Boot the emulator and explore the running system

### Morning (4h): Build Environment & Source

| Time | Task |
|------|------|
| 0:00–0:30 | Verify dependencies installed (`setup-deps.sh`) and disk space (need ~250GB free) |
| 0:30–1:00 | Study the AOSP manifest structure: what is `.repo/manifests/default.xml`, how `repo` works |
| 1:00–1:30 | While sync runs, read: [AOSP build system overview](https://source.android.com/docs/setup/build) |
| 1:30–2:30 | Study the AAOS-specific product configs: `device/generic/car/` directory layout |
| 2:30–3:00 | Understand build targets: `sdk_car_x86_64-ap3a-userdebug` — what each part means |
| 3:00–4:00 | Read: [AAOS Architecture](https://source.android.com/docs/automotive/start/what_automotive) |

### Afternoon (4h): Build & Boot

| Time | Task |
|------|------|
| 4:00–5:00 | Once sync completes: run `source build/envsetup.sh && lunch sdk_car_x86_64-ap3a-userdebug` |
| 5:00–6:30 | Run `m -j$(nproc)` — first build takes 1-3h depending on hardware. While waiting, study build system (Soong/Blueprint vs Make) |
| 6:30–7:00 | Boot emulator: `emulator -no-snapshot -wipe-data` |
| 7:00–7:30 | Explore via `adb shell`: list running services, check Car-specific packages |
| 7:30–8:00 | Document: what you built, what's running, first impressions in `docs/day1-notes.md` |

### Hands-On Exercises
1. Run `adb shell dumpsys car_service` — what CarService subsystems are running?
2. Run `adb shell pm list packages | grep car` — list all car-specific packages
3. Run `adb shell getprop | grep car` — find car-related system properties
4. Take a screenshot of the AAOS emulator home screen

### Key Resources
- [AOSP Build System](https://source.android.com/docs/setup/build)
- [AAOS Overview](https://source.android.com/docs/automotive/start/what_automotive)
- [Building AAOS Emulator (GrapeUp)](https://grapeup.com/blog/android-automotive-os-14-is-out-build-your-own-emulator-from-scratch)
- Source paths: `device/generic/car/`, `build/make/target/product/`

### Expected Outcomes
- [ ] AAOS source fully synced in `source/`
- [ ] Successful build with artifacts in `source/out/`
- [ ] Emulator boots to AAOS home screen
- [ ] Can connect via `adb shell`
- [ ] `docs/day1-notes.md` created with findings

---

## Day 2: Platform Architecture Deep Dive (8h)

### Learning Objectives
- Understand the AAOS layered architecture (Apps → Framework → HAL → Kernel)
- Study CarService: the core automotive system service
- Understand VHAL (Vehicle HAL): the bridge between Android and vehicle hardware
- Trace a property from app layer to HAL

### Morning (4h): Architecture & CarService

| Time | Task |
|------|------|
| 0:00–1:00 | Study AAOS architecture diagram: App layer, Car API, CarService, VHAL, vehicle bus |
| 1:00–2:00 | Explore `packages/services/Car/` — directory structure, key classes |
| 2:00–2:30 | Study `CarService.java`: how it initializes, what managers it creates |
| 2:30–3:00 | Study Car API surface: `packages/services/Car/car-lib/src/android/car/` |
| 3:00–3:30 | Explore CarPropertyService: how apps read/write vehicle properties |
| 3:30–4:00 | Read: [Car API Reference](https://source.android.com/docs/automotive/start/what_automotive#car-api) |

### Afternoon (4h): VHAL & Property Tracing

| Time | Task |
|------|------|
| 4:00–5:00 | Study VHAL interface: `hardware/interfaces/automotive/vehicle/` |
| 5:00–5:30 | Understand VehicleProperty types: INT32, FLOAT, STRING, MIXED |
| 5:30–6:00 | Understand property areas: GLOBAL, WINDOW, DOOR, SEAT, WHEEL |
| 6:00–7:00 | **Hands-on**: Trace `PERF_VEHICLE_SPEED` from app → CarPropertyManager → CarPropertyService → VHAL |
| 7:00–7:30 | Explore the default VHAL implementation (emulator): `hardware/interfaces/automotive/vehicle/aidl/default/` |
| 7:30–8:00 | Document architecture findings in `docs/day2-architecture.md` |

### Hands-On Exercises
1. Use `adb shell cmd car_service get-property PERF_VEHICLE_SPEED` to query a vehicle property
2. List all available properties: `adb shell cmd car_service list-properties`
3. Set a property value and observe the change
4. Draw/document the call flow: App → CarPropertyManager → Binder → CarPropertyService → VHAL HAL

### Key Source Paths
```
packages/services/Car/service/              # CarService implementation
packages/services/Car/car-lib/              # Car API (client-side)
hardware/interfaces/automotive/vehicle/     # VHAL AIDL interface
hardware/interfaces/automotive/vehicle/aidl/default/  # Default VHAL impl
frameworks/base/services/core/              # System server integration
```

### Key Resources
- [AAOS Architecture](https://source.android.com/docs/automotive/start/what_automotive)
- [Vehicle HAL](https://source.android.com/docs/automotive/vhal)
- [Car API](https://developer.android.com/reference/android/car/package-summary)
- [CarService deep dive (ProAndroidDev)](https://proandroiddev.com/mastering-android-automotive-os-architecture-expert-guide-33b7fa73bf8c)

### Expected Outcomes
- [ ] Can explain AAOS architecture layers
- [ ] Can navigate CarService source code
- [ ] Understand VHAL property model (property IDs, areas, types)
- [ ] Successfully traced a property end-to-end
- [ ] `docs/day2-architecture.md` created

---

## Day 3: Modify System Services & Build Car Apps (8h)

### Learning Objectives
- Modify CarService to add custom logging
- Build, push, and test changes on the emulator
- Create a simple Car app using the Car API
- Understand the AAOS app development workflow

### Morning (4h): Modifying CarService

| Time | Task |
|------|------|
| 0:00–0:30 | Set up your editor (VS Code) with the AAOS source for code navigation |
| 0:30–1:30 | **Hands-on**: Add debug logging to `CarPropertyService.java` for property get/set calls |
| 1:30–2:30 | Rebuild just the Car module: `m CarService -j$(nproc)` (incremental build) |
| 2:30–3:00 | Push to emulator: `adb root && adb remount && adb sync` or push the APK directly |
| 3:00–3:30 | Verify logging: `adb logcat -s CarPropertyService` |
| 3:30–4:00 | **Hands-on**: Modify VHAL default impl to add a custom property |

### Afternoon (4h): Car App Development

| Time | Task |
|------|------|
| 4:00–4:30 | Set up Android Studio with AAOS SDK (car system images) |
| 4:30–5:30 | Create a basic Car app: read vehicle speed, display on screen |
| 5:30–6:30 | Use `CarPropertyManager` to subscribe to property changes |
| 6:30–7:00 | Test on emulator: inject property values, observe app updates |
| 7:00–7:30 | Study car-specific UI guidelines: `packages/apps/Car/` reference apps |
| 7:30–8:00 | Document in `docs/day3-modifications.md` |

### Hands-On Exercises
1. Add a log line in CarPropertyService.getProperty() and verify it appears in logcat
2. Create a custom VHAL property (ID in vendor range 0x2000+)
3. Write a minimal Car app that reads and displays 3 vehicle properties
4. Use `adb shell cmd car_service inject-vhal-event` to simulate property changes

### Key Source Paths
```
packages/services/Car/service/src/com/android/car/CarPropertyService.java
packages/services/Car/car-lib/src/android/car/hardware/property/CarPropertyManager.java
hardware/interfaces/automotive/vehicle/aidl/default/DefaultVehicleHal.cpp
packages/apps/Car/Settings/                 # Reference: Car Settings app
packages/apps/Car/Launcher/                 # Reference: Car Launcher
```

### Expected Outcomes
- [ ] Successfully modified CarService and verified on emulator
- [ ] Understand incremental build workflow (`m Module -j`)
- [ ] Built and ran a Car app on the emulator
- [ ] Can inject VHAL events and observe app reactions
- [ ] `docs/day3-modifications.md` created

---

## Day 4: AAOS Version Upgrade Analysis (14 → 15) (8h)

### Learning Objectives
- Understand what changes between AAOS major versions
- Analyze the AAOS 14 → 15 upgrade from an OEM/Tier-1 perspective
- Create a migration checklist useful for consulting engagements
- Understand the testing and validation requirements

### Morning (4h): Version Diff Analysis

| Time | Task |
|------|------|
| 0:00–1:00 | Read AAOS 15 release notes and changelog (source.android.com) |
| 1:00–2:00 | Run `./scripts/upgrade-test.sh aaos14 aaos15` — review checklist |
| 2:00–3:00 | Analyze key diffs in CarService between versions |
| 3:00–3:30 | Study VHAL changes: AIDL migration, new properties, deprecated APIs |
| 3:30–4:00 | Study build system changes: new modules, updated configs |

### Afternoon (4h): Migration Planning (Consultant POV)

| Time | Task |
|------|------|
| 4:00–5:00 | Identify breaking changes that affect OEM customizations |
| 5:00–5:30 | Analyze SELinux policy changes and permissions model updates |
| 5:30–6:00 | Study new features OEMs can leverage (privacy, multi-display, etc.) |
| 6:00–7:00 | Create migration checklist: `docs/upgrade-aaos14-to-aaos15.md` |
| 7:00–7:30 | Estimate effort for a typical OEM upgrade (custom VHAL, custom apps, custom SystemUI) |
| 7:30–8:00 | Document in `docs/day4-upgrade-analysis.md` |

### Key Areas to Compare (14 vs 15)

| Area | What to Check |
|------|--------------|
| VHAL | AIDL interface changes, new properties, deprecations |
| CarService | New managers, changed APIs, permission model |
| SystemUI | Multi-display support, notification changes |
| Security | SELinux policy updates, new permissions |
| Build | Soong changes, new product configs |
| Apps | API level requirements, new Car APIs |

### Hands-On Exercises
1. Compare `hardware/interfaces/automotive/vehicle/` between AAOS 14 and 15 manifests
2. List all new `VehicleProperty` entries in AAOS 15
3. Identify at least 5 breaking changes that would require OEM code updates
4. Write a 1-page executive summary for an OEM CTO explaining the upgrade impact

### Key Resources
- [Android 14 Automotive Release Notes](https://source.android.com/docs/automotive/start/releases)
- [Android 15 Changes](https://developer.android.com/about/versions/15)
- [VHAL AIDL Migration Guide](https://source.android.com/docs/automotive/vhal)

### Expected Outcomes
- [ ] Clear understanding of AAOS 14 vs 15 differences
- [ ] Migration checklist in `docs/upgrade-aaos14-to-aaos15.md`
- [ ] Can articulate upgrade effort to non-technical stakeholders
- [ ] `docs/day4-upgrade-analysis.md` created

---

## Day 5: Capstone Project & Consolidation (8h)

### Learning Objectives
- Build a complete mini-project: custom VHAL property + system service extension + test app
- Review and consolidate all learnings from the week
- Prepare documentation for your consultant portfolio
- Plan transition to Week 2 (Figma → AAOS HMI/UX)

### Morning (4h): Capstone Project

**Project**: "Custom Vehicle Comfort Service"
Build an end-to-end feature: a custom vehicle property (e.g., CABIN_TEMPERATURE_TARGET) that flows from VHAL → CarService → App.

| Time | Task |
|------|------|
| 0:00–0:30 | Design the feature: property definition, service extension, app UI |
| 0:30–1:30 | Implement custom VHAL property in the default HAL implementation |
| 1:30–2:30 | Extend CarService to expose the property via a convenience API |
| 2:30–3:30 | Build a simple app that reads/writes the custom property |
| 3:30–4:00 | Test end-to-end on emulator |

### Afternoon (4h): Consolidation & Portfolio

| Time | Task |
|------|------|
| 4:00–5:00 | Review all docs created this week, ensure consistency |
| 5:00–5:30 | Create `docs/week1-summary.md`: key learnings, skills acquired, open questions |
| 5:30–6:00 | Create `docs/consultant-notes.md`: insights relevant to OEM/Tier-1 consulting |
| 6:00–6:30 | Review capstone project code, clean up, add comments |
| 6:30–7:00 | Update `course.config`: set topic1 status to `completed`, topic2 to `active` |
| 7:00–7:30 | Run `daily-review` agent to finalize README.md |
| 7:30–8:00 | Run `git-sync` agent to push everything to GitHub |

### Capstone Deliverables
1. Custom VHAL property definition and implementation
2. CarService modification exposing the property
3. Test app demonstrating read/write/subscribe
4. Architecture diagram showing the full data flow
5. Documentation covering: what, why, how, and testing steps

### Week 1 Consultant Takeaways
By end of this week you should be able to:
- **Estimate** AAOS build setup time and hardware requirements for a client
- **Explain** AAOS architecture to technical and non-technical stakeholders
- **Assess** the effort for AAOS version upgrades for any OEM
- **Implement** custom vehicle properties and system service extensions
- **Advise** on build system configuration and emulator testing strategies

### Expected Outcomes
- [ ] Capstone project working end-to-end
- [ ] All week's documentation reviewed and clean
- [ ] `docs/week1-summary.md` created
- [ ] `docs/consultant-notes.md` started
- [ ] `course.config` updated for Week 2
- [ ] Everything committed and pushed to GitHub

---

## Quick Reference: Key Commands

```bash
# Build
source build/envsetup.sh
lunch sdk_car_x86_64-ap3a-userdebug
m -j$(nproc)                    # Full build
m CarService -j$(nproc)         # Incremental: just CarService

# Emulator
emulator -no-snapshot -wipe-data

# ADB exploration
adb shell dumpsys car_service
adb shell cmd car_service list-properties
adb shell cmd car_service get-property PERF_VEHICLE_SPEED
adb shell cmd car_service inject-vhal-event 0x11600207 -i 100  # inject speed=100
adb shell pm list packages | grep car
adb shell getprop | grep car
adb logcat -s CarService CarPropertyService VehicleHal

# Push changes to emulator
adb root && adb remount && adb sync
```

## Documents to Produce This Week

| Document | Created On | Purpose |
|----------|-----------|---------|
| `docs/day1-notes.md` | Day 1 | Build environment and first boot notes |
| `docs/day2-architecture.md` | Day 2 | Architecture deep dive and VHAL tracing |
| `docs/day3-modifications.md` | Day 3 | Service modification and app development |
| `docs/day4-upgrade-analysis.md` | Day 4 | Version upgrade analysis |
| `docs/upgrade-aaos14-to-aaos15.md` | Day 4 | Migration checklist (reusable for clients) |
| `docs/week1-summary.md` | Day 5 | Week summary and key learnings |
| `docs/consultant-notes.md` | Day 5 | Consulting insights and portfolio material |
