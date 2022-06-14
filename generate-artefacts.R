
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


##
#
# Table of Contents:
#
# 27. Environment Variables and Settings
#
# 46. Error Message Definitions
#
# 82. File Content Defintions
#
# 110. Function Definitions
#
# 135. Program Logic
#
# 154. Environment Cleanup
#
##


##
# Environment Variables and Settings Start ----
##

warnStatus = getOption("warn")

options(warn = -1)

artefactFileNames = c("Licensing_Overview.md",
                      "Licensing_Appendix_1.md",
                      "Licensing_Appendix_2.md")

args = commandArgs(trailingOnly = T)

##
# Environment Variables and Settings End ----
##


##
# Error Message Definitions Start ----
##

errorHeader = "\n\x1b[31;1mError.\x1b[0m See details:\n\n"
errorFooter = "\n\nFor support, contact \x1b[31mteam@orcro.co.uk\x1b[0m\n\n"

#1
errorArgsNumber = paste0(errorHeader,
                         "The command should have a single argument.",
                         "The command should look like this:\n\n\t",
                         "Rscript generate-artefacts.R \x1b[36mLicenceList\x1b[0m.csv\n\n",
                         "Replace \x1b[36mLicenceList\x1b[0m with the name of ",
                         "your licence list file.",
                         errorFooter)
#2
errorFileExists = paste0(errorHeader,
                         "An artefact output file(s) already exists. ",
                         "To prevent data loss, move the existing file(s)",
                         " out of this directory.",
                         errorFooter)

#3
errorInputMissing = paste(errorHeader,
                          "The specified licence list file does not exist.",
                          errorFooter)

#all
errorMessages = c(errorArgsNumber,
                  errorFileExists,
                  errorInputMissing)

##
# Error Message Definitions End ----
##

##
# File Content Start ----
##

overviewText = paste0("# Overview\n\nThis software contains a number of open source components. For a summary, see \n",
                      "below. For the relevant licence texts, see Appendix A. For the relevant notices \n",
                      "and attributions etc., see Appendix B.\n\n",
                      "The following summary contains information about the main author(s) and/or\n",
                      "copyright holder(s) of each component and the overall package licence. For full \n",
                      "copyright notices etc., see Appendix B.\n\n",
                      "Not all components listed may be incorporated in, or may necessarily have \n",
                      "generated derivative works which are incorporated in the firmware, but were \n",
                      "used during the build process.\n\n",
                      "Where a range of dates is given after a copyright notice, this should be taken \n",
                      "to imply that copyright is asserted for every year within that range, inclusive \n",
                      "of the years stated.\n\n",
                      "# Component List")

appendixAText = "# Appendix A: Licence Texts"
appendixBText = "# Appendix B: Notices and Attribution"

genericFileContent = c(overviewText, appendixAText, appendixBText)

##
# File Content End ----
##


##
# Function Definitions Start ----
##

outputFile = function(fileText, fileName) {
    write(x = fileText, file = fileName)
}

generateArtefacts = function(L) {

    data = L

    # test
    print(dim(data))

    outputFile(genericFileContent[1], artefactFileNames[1])
    outputFile(genericFileContent[2], artefactFileNames[2])
    outputFile(genericFileContent[3], artefactFileNames[3])
}

##
# Function Definitions Start ----
##


##
# Program Logic Start ----
##

if (length(args) != 1) {
    cat(errorMessages[1])
} else if (artefactFileNames %in% dir()) {
    cat(errorMessages[2])
} else if (file.exists(args)) {
    generateArtefacts(read.csv(args))
} else {
    cat(errorMessages[3])
}

##
# Program Logic End ----
##


##
# Environment Cleanup ----
##

options(warn = warnStatus)

rm(args, artefactFileNames, warnStatus, generateArtefacts, outputFile)

##
# Environment Cleanup End ----
##

