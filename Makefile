PRJNAME = toastnotify
SRC := $(wildcard src/*.c)

# Output dirs
BUILD_DIR := build

# Object names
OBJS_x64 := $(patsubst src/%.c,$(BUILD_DIR)/x64/%.o,$(SRC))
OBJS_x86 := $(patsubst src/%.c,$(BUILD_DIR)/x86/%.o,$(SRC))

# Compilers
CC_x64 := x86_64-w64-mingw32-gcc
CC_x86 := i686-w64-mingw32-gcc

# Strip tools
STRIP_x64 := x86_64-w64-mingw32-strip
STRIP_x86 := i686-w64-mingw32-strip

all: x64 x86

x64: $(OBJS_x64)

x86: $(OBJS_x86)

# x64 build rule
$(BUILD_DIR)/x64/%.o: src/%.c
        mkdir -p $(BUILD_DIR)/x64
        $(CC_x64) $(CFLAGS) -I src/ -c $< -o $@
        $(STRIP_x64) --strip-unneeded $@

# x86 build rule
$(BUILD_DIR)/x86/%.o: src/%.c
        mkdir -p $(BUILD_DIR)/x86
        $(CC_x86) $(CFLAGS) -I src/ -c $< -o $@
        $(STRIP_x86) --strip-unneeded $@

clean:
        rm -rf $(BUILD_DIR)
