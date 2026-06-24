## [0.4] - 2026-06-24
### Added
- Integrated native Nintendo Switch (L4T Linux) hardware synchronization capabilities via a specialized 2-step `libdbus` communication pipeline.
- Added dynamic target platform detection inside `package.mk` to conditionally inject `dbus-1` dependencies and toolchain flags (`-D__SWITCH__`) exclusively during Switch target builds.

### Changed
- Refactored build runtime hooks to cleanly intercept `clock_settime` capability refus (`EPERM`) and gracefully fall back to ConnMan network system service injection without blocking general Linux platforms (PC, Raspberry Pi 5).

## [0.3] - 2026-06-24
### Changed
- Re-formatted and stylized core source code topology (`clock_core.c`, `clock_render.c`, `font.h`) and package scripts (`package.mk`) to rigidly comply with the Lakka/LibreELEC coding standard guidelines using a strict 3-space indentation alignment.
- Stripped all multibyte character notations and non-ASCII symbols from runtime source code comments to guarantee seamless universal compilation across strict toolchains.

### Fixed
- Preserved baseline definitions for `makefile`, `link.options`, and `png_to_header.py` to circumvent build system syntax parsing errors.

## [0.2] - 2026-06-24
### Changed
- Completely stripped redundant external shell `date` execution vectors to protect runtime context from BusyBox drop errors.
- Migrated default system adjustment logic to standard POSIX `clock_settime(CLOCK_REALTIME)` API for PC, Pi5, and general Linux reference targets.
- Implemented a clean explicit `EPERM` capability authorization failure log check specifically targeting Nintendo Switch platform fallbacks.

### Refactored
- Added `_POSIX_C_SOURCE` feature test macro to ensure standard strict compatibility for `clock_settime`.
- Centralized software version tracking into a single unified macro define (`CORE_VERSION`).
- Implemented robust `NULL` pointer check guards on all critical Libretro system callbacks (`video_cb`, `input_poll_cb`, `input_state_cb`) to completely prevent runtime segmentation faults.

## [0.1]
### Added
- Established the baseline standalone gadget clock core architecture utilizing the Libretro pipeline interfaces.
- Synchronized core video buffering mechanisms strictly with master rendering resolutions (WIDTH: 320, HEIGHT: 240).
- Embedded basic navigation button states for initial control system mapping tests.
- Included a prototype relative clock visual calculation engine using manual parameter configurations.
