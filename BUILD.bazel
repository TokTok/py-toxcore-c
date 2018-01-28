cc_binary(
    name = "pytox.so",
    srcs = glob([
        "pytox/*.c",
        "pytox/*.h",
    ]),
    copts = ["-DENABLE_AV"],
    linkopts = ["-Wl,--version-script,$(location pytox.ld)"],
    linkshared = True,
    visibility = ["//visibility:public"],
    deps = [
        "pytox.ld",
        "//c-toxcore",
        "@python2//:python",
    ],
)
