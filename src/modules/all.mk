#
#  Changes the behaviour of autoconf.h to undef definitions that would conflict
#  with module config.h files.
#
CFLAGS += -DIS_MODULE=1


SUBMAKEFILES := $(wildcard ${top_srcdir}/src/modules/rlm_*/all.mk)
SUBMAKEFILES += $(wildcard ${top_srcdir}/src/modules/proto_*/all.mk)

#
#  If we haven't run configure, ignore the modules which require it.
#  Otherwise, load in all of the module makefiles, including ones
#  which have not yet been configured.  We do the "sort" to remove
#  duplicates.
#
ifeq "$(CONFIGURE_ARGS)" ""
NEEDS_CONFIG := $(patsubst %.in,%,$(foreach file,$(SUBMAKEFILES),$(wildcard $(file).in)))
SUBMAKEFILES := $(sort $(SUBMAKEFILES) $(NEED_CONFIG))
endif

