CC = gcc
CC_FLAGS = -O3 -Wall -pedantic -ansi
CC_INCLUDE=-Iinclude

LIB_DIR = lib
SRC_DIR = src

OUT_DIR = out
OBJ_DIR = $(OUT_DIR)/obj
BIN_DIR = $(OUT_DIR)/bin

LIB_FILES = $(wildcard $(LIB_DIR)/*.c)
OBJ_FILES = $(patsubst $(LIB_DIR)/%.c,$(OBJ_DIR)/%.o,$(LIB_FILES))

PROGRAMS = all_in_expectation bm_server bm_widget bm_run_matches dealer example_player

all: $(PROGRAMS)

clean:
	rm -rf $(OUT_DIR)

pre-build:
	mkdir -p $(OBJ_DIR) $(BIN_DIR)

all_in_expectation: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

bm_server: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

bm_widget: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

bm_run_matches: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

dealer: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

example_player: pre-build $(OBJ_FILES)
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) $(OBJ_FILES) -o $(BIN_DIR)/$@ $(SRC_DIR)/$@.c

$(OBJ_DIR)/%.o: $(LIB_DIR)/%.c
	$(CC) $(CC_FLAGS) $(CC_INCLUDE) -c -o $@ $<
