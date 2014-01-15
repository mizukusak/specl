# Specl make rules.
# Written by Gary V. Vaughan, 2013
#
# Copyright (c) 2013-2014 Gary V. Vaughan
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


## ------ ##
## Specs. ##
## ------ ##

# Override Slingshot SPECL.
SPECL = specs/specl
SPECL_OPTS = --unicode

specl_SPECS =						\
	$(srcdir)/specs/environment_spec.yaml		\
	$(srcdir)/specs/custom_formatters_spec.yaml	\
	$(srcdir)/specs/formatter/report_spec.yaml	\
	$(srcdir)/specs/matchers_spec.yaml		\
	$(srcdir)/specs/optparse_spec.yaml		\
	$(srcdir)/specs/shell_spec.yaml			\
	$(srcdir)/specs/specl_spec.yaml			\
	$(NOTHING_ELSE)

EXTRA_DIST +=						\
	$(srcdir)/specs/spec_helper.lua			\
	$(srcdir)/specs/formatter/spec_helper.lua	\
	$(NOTHING_ELSE)

specl-check-local: $(SPECL)

$(SPECL):
	$(AM_V_at)test -d specs || mkdir -p specs
	$(AM_V_GEN){ printf '%s\n'					\
	  '#!/bin/sh'							\
	  '# DO NOT EDIT - This file is generated by specs/specs.mk'	\
	  ': $${LUA_PATH=";"}'						\
	  'LUA_PATH="$(srcdir)/lib/?.lua;$$LUA_PATH" $(srcdir)/bin/specl "$$@"'	\
	  'exit $$?';							\
	} > $@
	$(AM_V_at)chmod 555 '$@'

DISTCLEANFILES += $(SPECL)

include build-aux/specl.mk
