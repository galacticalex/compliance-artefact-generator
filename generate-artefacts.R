
# SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>
#
# SPDX-License-Identifier: Apache-2.0


##
# Environment Variables and Settings Start ----
##

warnStatus = getOption("warn")

options(warn = -1)

artefactFileNames = c("Licensing_Overview.txt", 
                      "Licensing_Appendix_1.txt", 
                      "Licensing_Appendix_2.txt")

args = commandArgs(trailingOnly = T)

##
# Environment Variables and Settings End ----
##


##
# Function Definitions Start ----
##

outputFile = function(fileText, fileName) {
  write(x = fileText, file = fileName)
}

generateArtefacts = function(L) {
  
  data = L
  
  print(dim(data))
  
  outputFile("hi", artefactFileNames[1])
  outputFile("hi", artefactFileNames[2])
  outputFile("hi", artefactFileNames[3])
}

##
# Function Definitions Start ----
##


##
# Error Messages Start ----
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
# Error Messages End ----
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
