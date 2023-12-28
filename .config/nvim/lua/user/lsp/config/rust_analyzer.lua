return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        buildScripts = {
          enable = true,
        },
        features = "all",
      },
    },
    check = {
      overrideCommand = { "cargo", "clippy", "--all-targets", "--all-features",
        "--",
        "-Wclippy::all",
        "-Wclippy::pedantic",
        "-Wclippy::style",
        "-Wclippy::nursery",
        "-Wclippy::must_use_candidate",
        "-Wclippy::missing_const_for_fn"
      },
    },
    rustfmt = {
      extraArgs = { "+nightly" },
    },
    procMacro = {
      attributes = {
        enable = true,
      },
    },
  },
}
