cc_binary(
    name = "pytox.so",
    srcs = glob([
        "pytox/*.c",
        "pytox/*.h",
    ]),
    copts = [
        "-I/usr/include/python2.7",
        "-DENABLE_AV",
    ],
    linkopts = [
        "-Wl,--version-script,$(location pytox.ld)",
        "-lpython2.7",
    ],
    linkshared = True,
    visibility = ["//visibility:public"],
    deps = [
        "pytox.ld",
        "//c-toxcore",
    ],
)
