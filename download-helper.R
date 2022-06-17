# SPDX-FileCopyrightText: 2022 Orcro Limited. <team@orcro.co.uk>
# 
# SPDX-License-Identifier: Apache-2.0

# download sources using commands within an orcro licence list
# this may take a while

download_commands = unique(read.csv("LicenceList.csv")$Download)

system("mkdir sources")

cwd = getwd()

setwd("sources")

for (command in download_commands) {
    system(command)
}

setwd(cwd)