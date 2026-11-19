# Input Horizon Native Mods (`.hnmod`)

Place your raw `.hnmod` archives into this directory.

### Requirements for `.hnmod`:
- Must be a valid zip archive containing:
  - `horizon-native.json` (mod id and version)
  - `horizon-mixin.toml` (mod hooks and mixins configuration)
  - `mixins/` folder containing the Rust mixin source code

Upon pushing to the repository or opening a Pull Request, GitHub Actions will automatically convert every `.hnmod` here into an iOS `arm64` `.dylib` dynamic library and upload it as a downloadable release artifact!
