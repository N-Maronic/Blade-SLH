OBJ_DIR := obj
SRC_DIR := src
SRC_FILES := $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRC_FILES))

CPPFLAGS := -stdlib=libc++ $(shell llvm-config-14 --ldflags --libs)
CXXFLAGS := -MMD $(shell llvm-config-14 --cxxflags)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	clang++ $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

blade: $(OBJ_FILES)
	clang++ -o $@ $(CPPFLAGS) $(CXXFLAGS) $(LIBRARY) $^

$(OBJ_DIR):
	mkdir -p $@
