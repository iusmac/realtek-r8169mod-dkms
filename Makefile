# SPDX-License-Identifier: GPL-2.0-only
################################################################################
#
# r8169 is the Linux device driver released for Realtek Gigabit Ethernet
# controllers with PCI-Express interface.
#
# Author:
# Copyright (c) 2002 ShuChen <shuchen@realtek.com.tw>
# Copyright (c) 2003 - 2007 Francois Romieu <romieu@fr.zoreil.com>
# Copyright (c) a lot of people too. Please respect their work.
#
################################################################################

################################################################################
#  This product is covered by one or more of the following patents:
#  US6,570,884, US6,115,776, and US6,327,625.
################################################################################

all: clean modules install

modules:
	$(MAKE) -C src/ modules

clean:
	$(MAKE) -C src/ clean

install:
	$(MAKE) -C src/ install
