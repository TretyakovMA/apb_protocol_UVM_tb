# Основные модули и пакеты
TOP_MODULE  = top.sv
TB_PKG      = apb_pkg.sv

DUT_VARIANT ?= master

ifeq ($(DUT_VARIANT),master)
    DUT_MODULE     ?= APB_master.v
    DEFINE_DUT     := +define+APB_MASTER_DUT
else ifeq ($(DUT_VARIANT),slave)
    DUT_MODULE     ?= APB_slave.v
    DEFINE_DUT     := +define+APB_SLAVE_DUT
else ifeq ($(DUT_VARIANT),top)
    DUT_MODULE     ?= APB_top.v
    DEFINE_DUT     := +define+APB_TOP_DUT
else
    $(error "Unknown DUT_VARIANT=$(DUT_VARIANT). Valid: master, slave, top")
endif


# Определения тестов и количества запусков (<имя_теста>:<количество_запусков>)
TESTS = back_to_back_rw_test:1 

VERBOSITY  = UVM_MEDIUM

master: ; @$(MAKE) compile run_sims DUT_VARIANT=master

include common.mk