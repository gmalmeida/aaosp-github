# MIB (Modular Infotainment Baukasten) Platform 

The **MIB platform** (Modular Infotainment Platform) is **not just the SoC**. It’s a complete **hardware and software architecture** designed by Volkswagen Group for infotainment systems across its brands (VW, Audi, Porsche, etc.).

## **What MIB Includes**

1.  **Hardware Layer**
    *   **SoC (System-on-Chip)**: Typically from Qualcomm (Snapdragon Automotive series) or NVIDIA in earlier generations.
    *   **Mainboard & I/O**: Interfaces for display, audio, connectivity (USB, Bluetooth, Wi-Fi).
    *   **Storage**: Flash memory for maps, apps, and OS.
    *   **Connectivity Modules**: LTE/5G modem, GNSS, Wi-Fi, Bluetooth.

2.  **Software Layer**
    *   **Operating System**: Linux-based or Android Automotive OS (for newer generations).
    *   **Middleware**: Handles communication between hardware and applications.
    *   **Applications**: Navigation, media, voice control, app integration (CarPlay, Android Auto).
    *   **Security & OTA**: Cybersecurity features and over-the-air update capability.

3.  **Integration with Vehicle**
    *   **CAN/Ethernet Interfaces**: For vehicle data exchange.
    *   **HMI Framework**: UI/UX tailored for each brand (e.g., Audi MMI, Porsche PCM).

## **Key Point**

The **SoC is the core compute element**, but the **MIB platform is the entire infotainment stack**, including:

*   Hardware (SoC + board + connectivity)
*   Software (OS + apps)
*   Integration with vehicle networks.

# MIB Concept

The MIB system is designed as a modular infotainment architecture with distinct layers:

## 1. Hardware Layer

* Main MCU: TI Jacinto processors (e.g., DRA6xx series) for infotainment logic.
* Graphics Processor: NXP i.MX6 for HMI rendering.
* Secondary Controllers: Dual Cortex-M3 cores for real-time tasks (CAN, LIN, watchdog).
* Storage: SPI NOR flash for bootloader and firmware; EEPROM for configuration keys.
* Connectivity: MOST150 optical bus, Ethernet, CAN, LIN.
* Power Management: Dedicated PMIC for automotive-grade reliability. [ti.com], [hackaday.io]

## 2. Operating System Layer

* QNX Neutrino RTOS: Runs application-level logic and HMI processes.
* Carcom RTOS Blob: Handles low-level vehicle communication (CAN/LIN) before QNX boots.
* IPC Framework: Shared memory and semaphore-based messaging between cores. [hackaday.io]

## 3. Middleware Layer

* Device Service Interface (DSI): Abstracts hardware for applications.
* MOST/Ethernet Stack: For multimedia and data exchange.
* Bluetooth/Wi-Fi Stack: For connectivity and smartphone integration. [vwts.ru]

## 4. Application Layer

* HMI Framework: Java-based UI for Composition, Discover Media, Discover Pro.
* App-Connect: Supports CarPlay, Android Auto, MirrorLink.
* Navigation & Media Services: 2.5D/3D maps, voice control, streaming apps.
* OTA Update Capability: Introduced in later MIB3/MIB4 generations. [budbrownvw.com], [carmagazine.co.uk]

# Variants

* Entry MIB: Basic radio and media playback.
* Standard MIB: Adds navigation and advanced connectivity.
* High-spec MIB: Premium graphics, larger displays, and extended features (Audi MMI Plus). [vaglinks.com]

# Diagram Structure
The diagram should show:

* Bottom Layer: Hardware (MCU, GPU, PMIC, storage, buses).
* Middle Layer: OS (QNX, RTOS), middleware (DSI, IPC, MOST stack).
* Top Layer: Applications (HMI, App-Connect, Navigation, Media).
* External Interfaces: Smartphone, cloud services, OTA updates.

# MIB Platform Comparison

| Generation | SoC Vendor           | OS                                | Key Features                                                   | Brands Using It       |
|------------|----------------------|-----------------------------------|----------------------------------------------------------------|-----------------------|
| MIB2       | NVIDIA Tegra         | Linux-based                      | Basic infotainment, navigation, CarPlay/Android Auto          | VW, Audi, Porsche    |
| MIB3       | Qualcomm Snapdragon  | Linux-based                      | Enhanced UI, voice control, online services, OTA updates      | VW, Audi, Porsche    |
| MIB4       | Qualcomm Snapdragon (latest gen) | Android Automotive OS + Linux | Advanced HMI, cloud integration, app ecosystem, high-speed connectivity | VW, Audi, Porsche    |
