# LakkaSimpleClock

A lightweight, standalone pixel-art analog and digital clock core designed specifically for **Lakka (LibreELEC / RetroArch)**. It features a full 3x5 and 8x8 bitmap font rendering pipeline custom-tailored to handle hardware horizontal mirroring anomalies natively.

## Key Features

- **No-Game Standalone Booting**: Fully implements `RETRO_ENVIRONMENT_SET_SUPPORT_NO_GAME`. Launch the clock app directly from the Lakka core menu without requiring any dummy `.txt` content files.
- **Universal Date Layout**: Formatted to the international global standard `DD/MMM/YYYY` (e.g., `14/JUN/2026`) with pixel-perfect rigid centering vectors.
- **Native OS Network Sync**: Bypasses missing `systemd-timedated` service blocks by directly parsing the Linux kernel runtime routing tables at `/proc/net/route` to dynamically trigger the green `Network ONLINE` status indicator.
- **Pure POSIX Time Adjustment**: Utilizes the standard POSIX `clock_settime(CLOCK_REALTIME)` API to directly and safely update the host system clock without relying on external BusyBox `date` shell commands.
- **Intuitive Visual Configuration**: Press **START** to enter Edit Mode. The custom blit compiler synchronizes control vectors with the visual layout grid sequentially from left-to-right (Day → Month → Year → Hour → Minute → Second).
- **Embedded Alpha Layer Branding**: Automatically loads the native compiled color byte array structure overlaying the official Lakka asset emblem seamlessly at the top layer priority plane.

## Hardware Calibration & Layout Specifications

- **Target Resolution**: 320x240 RGB565 Retro Video Buffer Stream.
- **Font Array Architecture**: Custom 15-bit packed matrix mappings mapped to native bitwise shifting operations (`14 - (row * 3 + col)`), resolving inversion distortion out of the box on embedded display panels.

## Installation & Build Instructions

Place this core within your LibreELEC/Lakka package tree framework, clear out the stale configuration binaries, and compile using the master distribution wrapper pipeline:

```bash
scripts/build LakkaSimpleClock clean
scripts/build LakkaSimpleClock
```

## License

This project is open-source software licensed under the **MIT License** [LakkaSimpleClock_GPLv2_and_MIT]. Designed with passion for the global retro emulation development ecosystem.
