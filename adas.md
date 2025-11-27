Starting with Android Automotive OS 14, Google added explicit ADAS (Advanced Driver Assistance Systems) interfaces via the Vehicle HAL (VHAL). These are exposed as *ADAS vehicle properties* at the HAL layer, which OEMs can integrate into higher layers such as the Car Framework and System UI.

# Where ADAS Fits in Android Automotive OS
Android Automotive OS (AAOS) is primarily an **infotainment platform**, but recent releases have expanded to support ADAS signals. Here’s how the layering works:

# Vehicle HAL (VHAL) Layer
- This is the hardware abstraction layer where vehicle properties are defined.
- In AAOS 14, Google introduced **ADAS vehicle properties** such as:
  - Automatic Emergency Braking (AEB)
  - Lane Centering Assist (LCA)
  - Forward Collision Warning (FCW)
  - Blind Spot Warning (BSW)
  - Lane Departure Warning (LDW)
  - Lane Keep Assist (LKA)
  - Adaptive Cruise Control (ACC)
  - Emergency Lane Keep Assist (ELKA)
- These properties are essentially *signals* that the OS can consume from the vehicle’s ADAS domain controller.

# Car Framework Layer
- The Car Framework translates VHAL properties into APIs accessible to Android services and apps.
- ADAS properties are surfaced here so that system components (like System UI or OEM apps) can react to them.
- Example: A lane departure warning property can trigger a visual or audio alert in the infotainment UI.

# System UI / Application Layer
- OEMs can decide how to present ADAS information to the driver.
- AAOS itself does **not implement ADAS logic** (e.g., braking or steering) — that remains in the vehicle’s safety‑critical ECUs.
- Instead, AAOS provides **interfaces for visualization and driver feedback** (alerts, icons, notifications).

# Important Boundaries
- **Safety‑critical ADAS functions (like braking or steering control) are *not* handled by Android Automotive OS.** Those remain in dedicated automotive ECUs running AUTOSAR or other real‑time OS.
- AAOS is limited to **exposing ADAS states and warnings** through its infotainment stack.
- Regulatory rules require that Android layers must not override or obscure safety‑critical displays.

# Summary
- **Interface provided:** Yes, via **ADAS vehicle properties in the Vehicle HAL (AAOS 14+)**.  
- **Layers involved:**  
  - **VHAL** → defines ADAS properties  
  - **Car Framework** → exposes them to Android services  
  - **System UI / Apps** → OEMs use them for driver alerts and visualization  
- **Not included:** Actual ADAS control logic (remains outside AAOS in safety ECUs).
