
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
# 84. File Content Defintions
# 
# 109. Function Definitions
# 
# 221. Program Logic
# 
# 240. Environment Cleanup
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
errorFooter = "\n\n\x1b[31mteam@orcro.co.uk\x1b[0m\n\n"

#1
errorArgsNumber = paste0(errorHeader, 
                         "The command should have two arguments.", 
                         "The command should look like this:\n\n\t", 
                         "Rscript generate-artefacts.R \x1b[36mLicenceList\x1b[0m.csv ", 
                         "\x1b[36mScancodeOutput\x1b[0m.csv\n\n", 
                         "Replace \x1b[36mLicenceList\x1b[0m and ", 
                         "\x1b[36mScancodeOutput\x1b[0m with the names of ", 
                         "your data files.", 
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
                      "Not all components listed may be incorporated in, or may necessarily have \n", 
                      "generated derivative works which are incorporated in the firmware, but were \n", 
                      "used during the build process.\n\n", 
                      "Where a range of dates is given after a copyright notice, this should be taken \n", 
                      "to imply that copyright is asserted for every year within that range, inclusive \n", 
                      "of the years stated.\n\n", 
                      "## Components and Licences")

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

generateOverviewText = function(softwareName, componentNames, licences) {
    
    dat = as.data.frame(cbind(softwareName, 
                              componentNames, 
                              licences))
    
    dat = split(dat, dat$softwareName)
    
    t = function(d) {
        header = paste0("\n\n### ", d[1, 1], "\n\n")
        
        rest = paste0(rep("Component: ", length(d[2])), 
                      unlist(d[2]), 
                      rep(" - Licence: ", length(d[3])), 
                      unlist(d[3]), 
                      rep("\n", 4), collapse = "")
        
        paste0(header, rest)
    }
    
    pre_out = lapply(dat, t)
    
    out = paste0(pre_out, collapse = "")
    
    paste0(overviewText, out)
}

generateAppendixA = function(licences, deps_licences) {
    d = unlist(strsplit(deps_licences, " AND "))
    l = unique(c(licences, d))
    l = l[l != "N/A"]
    first = rep("https://raw.githubusercontent.com/spdx/license-list-data/master/text/", length(l))
    last = rep(".txt", length(l))
    
    dls = paste0(first, l, last)
    
    out = appendixAText
    
    cat("\n\n Licence texts will now be downloaded...\n\n")
    
    Sys.sleep(2)
    
    for (l in dls) {
        download.file(l, destfile = "licence.tmp", 
                      method = "wget", 
                      quite = TRUE)
        out = paste0(out, "\n\n--------------------\n\n", 
                     readChar("licence.tmp", file.info("licence.tmp")$size))
        file.remove("licence.tmp")
    }
    
    out
}

generateAppendixB = function(files, licences, copyrights) {
    out = appendixBText
    
    d = as.data.frame(cbind(files, licences, copyrights))
    
    d = d[d$licences != "" | d$copyrights != "", ]
    
    d = merge(d, d, by = 1)
    
    d = d[d$copyrights.x != "" & d$licences.y != "", ]
    
    d = d[c(1, 3, 4)]
    
    d$files = gsub("^sources/", "", d$files)
    
    for (i in 1:nrow(d)) {
        entry = paste0("\n\n---------------\n", 
                       "\nFile: ", d[i, 1],
                       "\nLicence: ", d[i, 2], 
                       "\nCopyright statement(s): ", d[i, 3])
        out = paste0(out, entry)
    }
    
    out
}

generateArtefacts = function() {
    data = read.csv(args[1])
    data2 = read.csv(args[2])
    
    outputFile(generateOverviewText(data[[1]], 
                                    data[[2]], 
                                    data[[4]]), 
               artefactFileNames[1])
    
    outputFile(generateAppendixA(data[[4]], 
                                 data[[8]]), 
               artefactFileNames[2])
    
    outputFile(generateAppendixB(data2[[1]], 
                                 data2[[19]], 
                                 data2[[38]]), 
               artefactFileNames[3])
}

##
# Function Definitions Start ----
##


##
# Program Logic Start ----
##

if (length(args) != 2) {
    cat(errorMessages[1])
} else if (artefactFileNames %in% dir()) {
    cat(errorMessages[2])
} else if (file.exists(args)) {
    generateArtefacts()
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
