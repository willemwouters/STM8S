#######
# makefile for STM8S_StdPeriph_Lib and SDCC compiler
#
# note: paths in this Makefile assume unmodified SPL folder structure
#
# usage:
#   1. if SDCC not in PATH set path -> CC_ROOT
#   2. set correct STM8 device -> DEVICE
#   3. set project paths -> PRJ_ROOT, PRJ_SRC_DIR, PRJ_INC_DIR
#   4. set SPL root path -> SPL_ROOT
#   5. include required SPL modules -> SPL_SOURCE
#   6. include required STM8S_EVAL modules -> EVAL_SOURCE, EVAL_128K_SOURCE, EVAL_COMM_SOURCE
#
#######

# STM8 device (default is STM8 discovery board)
DEVICE=STM8S105

# trap handling requires SDCC >=v3.4.3
SKIP_TRAPS = 1

# set compiler path & parameters 
CC_ROOT =
CC      = sdcc
CFLAGS  = -mstm8 -lstm8 --opt-code-size

# required for some examples for STM8S EVAL board
CFLAGS += -DUSE_STM8_128_EVAL

# set output folder and target name
OUTPUT_DIR = ./$(DEVICE)
TARGET     = $(OUTPUT_DIR)/$(DEVICE).hex

# set project folder and files (all *.c)
PRJ_ROOT    = ..
PRJ_SRC_DIR = $(PRJ_ROOT)
PRJ_INC_DIR = $(PRJ_ROOT)
PRJ_SOURCE  = $(notdir $(wildcard $(PRJ_SRC_DIR)/*.c))
PRJ_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(PRJ_SOURCE:.c=.rel))

# set SPL paths
SPL_ROOT    = ../../..
SPL_SRC_DIR = $(SPL_ROOT)/Libraries/STM8S_StdPeriph_Driver/src
SPL_INC_DIR = $(SPL_ROOT)/Libraries/STM8S_StdPeriph_Driver/inc
SPL_SOURCE  = stm8s_gpio.c
SPL_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(SPL_SOURCE:.c=.rel))

# set STM8S_EVAL Utilities paths
EVAL_DIR     = $(SPL_ROOT)/Utilities/STM8S_EVAL
EVAL_SOURCE  = 
EVAL_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(EVAL_SOURCE:.c=.rel))

# set STM8S_EVAL 128K paths
EVAL_128K_DIR     = $(EVAL_DIR)/STM8-128_EVAL
EVAL_128K_SOURCE  = 
EVAL_128K_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(EVAL_128K_SOURCE:.c=.rel))

# set STM8S_EVAL Common paths
EVAL_COMM_DIR    = $(EVAL_DIR)/Common
EVAL_COMM_SOURCE  = 
EVAL_COMM_OBJECTS := $(addprefix $(OUTPUT_DIR)/, $(EVAL_COMM_SOURCE:.c=.rel))


# collect all include folders
INCLUDE = -I$(PRJ_SRC_DIR) -I$(SPL_INC_DIR) -I$(EVAL_DIR) -I$(EVAL_128K_DIR) -I$(EVAL_COMM_DIR)

# collect all source directories
VPATH=$(PRJ_SRC_DIR):$(SPL_SRC_DIR):$(EVAL_DIR):$(EVAL_128K_DIR):$(EVAL_COMM_DIR)

.PHONY: clean

all: $(TARGET)

$(OUTPUT_DIR)/%.rel: %.c
	$(CC) $(CFLAGS) $(INCLUDE) -D$(DEVICE) -DSKIP_TRAPS=$(SKIP_TRAPS) -c $?

$(OUTPUT_DIR)/%.rel: %.c
	$(CC) $(CFLAGS) $(INCLUDE) -D$(DEVICE) -DSKIP_TRAPS=$(SKIP_TRAPS) -c $? -o $@

$(TARGET): $(PRJ_OBJECTS) $(SPL_OBJECTS) $(EVAL_OBJECTS) $(EVAL_128K_OBJECTS) $(EVAL_COMM_OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $^

clean: 
	rm -fr $(OUTPUT_DIR)
