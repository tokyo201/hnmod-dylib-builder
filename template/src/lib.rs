//! Horizon Native Mod Template for iOS arm64 Dynamic Libraries (.dylib)

use std::os::raw::{c_char, c_int};

pub const MOD_ID: &str = "template_mod";
pub const MOD_VERSION: &str = "1.0.0";

#[no_mangle]
pub extern "C" fn horizon_mod_id() -> *const c_char {
    concat!("template_mod", "\0").as_ptr() as *const c_char
}

#[no_mangle]
pub extern "C" fn horizon_mod_version() -> *const c_char {
    concat!("1.0.0", "\0").as_ptr() as *const c_char
}

#[no_mangle]
pub extern "C" fn horizon_mod_init() -> c_int {
    println!("[HorizonMod:{}] Dynamic library loaded.", MOD_ID);
    0
}

/// Automatically executed by dyld upon dlopen() in Horizon Rust
#[used]
#[link_section = "__DATA,__mod_init_func"]
static CONSTRUCTOR_ENTRY: extern "C" fn() = {
    extern "C" fn init() {
        horizon_mod_init();
    }
    init
};
