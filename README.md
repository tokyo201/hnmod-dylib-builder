# Horizon Native Mod to iOS Dylib Builder (`hnmod-dylib-builder`)

Automated build workflow and public pipeline to convert **Horizon Native Mods** (`.hnmod`) into iOS `arm64` dynamic libraries (`.dylib`) ready for Just-In-Time (JIT) dynamic loading in Metallic Horizon Rust.

---

## 🚀 How It Works

1. **Input:** Standard `.hnmod` packages containing `horizon-native.json`, `horizon-mixin.toml`, and Rust mixin sources.
2. **Pipeline:** Automated GitHub Actions (running on Apple Silicon macOS) extracts mod metadata, constructs a native `cdylib` crate targeting `aarch64-apple-ios`, configures `__attribute__((constructor))` dyld entry points, compiles, and ad-hoc signs the `.dylib`.
3. **Output:** Standalone iOS `.dylib` libraries ready to be placed directly into Metallic Launcher.

---

## 📦 How to Add Mods (For Contributors)

1. **Fork** or clone this repository.
2. Place your `.hnmod` file(s) into the `mods/` directory:
   ```bash
   cp my_mod.hnmod mods/
   ```
3. Commit and push your changes to a branch, then open a **Pull Request**:
   ```bash
   git add mods/
   git commit -m "feat: add my_mod.hnmod"
   git push origin my-feature-branch
   ```
4. **GitHub Actions** will automatically trigger the `Build iOS Dylib Mods` workflow, convert your `.hnmod` into an iOS `arm64` `.dylib`, and attach the compiled artifact to the run.

---

## 📥 How to Download & Use Built `.dylib` Mods

1. Go to the **Actions** tab (or **Releases** tab for tagged releases).
2. Click on the latest workflow run and download the **`horizon-dylib-mods-arm64.zip`** artifact.
3. Unzip the archive to get your `.dylib` files (e.g. `elytratrails.dylib`).
4. Transfer the `.dylib` files into your Minecraft directory on your iOS device:
   ```
   Documents/Data/Application/<UUID>/Documents/Library/Application Support/minecraft/horizon-mods/
   ```
   *(or `horizon-native-mods/`)*
5. Open **Metallic Launcher**:
   - Go to the **JIT** tab on the top navigation bar.
   - Turn **ON** `Mods Support for Rust`.
   - Tap **Acquire JIT Now** (via in-app LocalDevVPN flow).
   - Launch Horizon Rust! The launcher's `jitscript` will automatically discover and `dlopen()` your compiled `.dylib` mods upon launch.

---

## 🛠 Local Build (macOS)

To build locally on macOS with Xcode and Rust installed:

```bash
# 1. Install Rust target for iOS
rustup target add aarch64-apple-ios

# 2. Run the build script
./scripts/build_all_mods.sh
```

Compiled `.dylib` binaries will be saved directly into `artifacts/`.

---

## ⚙️ Architecture & Dynamic Loading

Each generated `.dylib` contains:
- **Target Architecture:** `aarch64-apple-ios` (iOS 15.0+ 64-bit ARM).
- **Constructor Hook:** Uses Mach-O `__DATA,__mod_init_func` and `__attribute__((constructor))` so that upon `dlopen()` in Horizon Rust, the mod registers its hooks and state automatically without requiring manual symbol lookups.
- **Codesigning:** Ad-hoc signed (`codesign -s - --force`) for compatibility with sideloaded and LiveContainer iOS sandboxes.
