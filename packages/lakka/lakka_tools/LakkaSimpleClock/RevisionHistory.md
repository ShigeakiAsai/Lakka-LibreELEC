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
