# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit acct-user

DESCRIPTION="User for paludis build"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( paludisbuild tty )
ACCT_USER_HOME="/var/tmp/paludis"

acct-user_add_deps
