
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0

outputFile = function(fileText, fileName) {
  write(fileText, file = fileName)
}

generateArtefacts = function() {
  "nice"
}

args = commandArgs(trailingOnly = T)

errorArgsNumber = paste0("\n\x1b[31;1mError.\x1b[0m See details:", 
                         "\n\nThe command should have a single argument.", 
                         "The command should look like this:\n\n\t", 
                         "Rscript generate-artefacts.R \x1b[36mLicenceList\x1b[0m.csv\n\n", 
                         "Replace \x1b[36mLicenceList\x1b[0m with the name of ", "your licence list file.\n\n")

errorMessages = c(errorArgsNumber)

if (length(args) != 1) {
  cat(errorMessages[1])
} else {
  outputFile("well done", "test.txt")
}