# Основные модули и пакеты
TOP_MODULE  = top.sv
TB_PKG      = apb_pkg.sv

ifeq ($(DUT_VARIANT),master)
    DUT_MODULE     ?= APB_master.v
    DEFINE_DUT     := +define+APB_MASTER_DUT
else ifeq ($(DUT_VARIANT),slave)
    DUT_MODULE     ?= APB_slave.v
    DEFINE_DUT     := +define+APB_SLAVE_DUT
else ifeq ($(DUT_VARIANT),top)
    DUT_MODULE     ?= APB_top.v
    DEFINE_DUT     := +define+APB_TOP_DUT
endif


# Определения тестов и количества запусков (<имя_теста>:<количество_запусков>)
TESTS = simple_test:1 

master: ; @$(MAKE) compile run_sims DUT_VARIANT=master

include ../common.mk