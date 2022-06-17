<!-- 
SPDX-FileCopyrightText: 2022 Orcro Ltd. <team@orcro.co.uk>

SPDX-License-Identifier: Apache-2.0 
-->

# Compliance Artefact Generator Script

This script takes a dataset that meets the Orcro licence list definition, and produces generalized compliance artefacts that are suitable for use in an [OpenChain](https://www.openchainproject.org/) compliant program.

<div align="center">

[![REUSE status](https://api.reuse.software/badge/github.com/galacticalex/compliance-artefact-generator)](https://api.reuse.software/info/github.com/galacticalex/compliance-artefact-generator) [![GitHub](https://img.shields.io/github/license/galacticalex/compliance-artefact-generator)](https://img.shields.io/github/license/galacticalex/compliance-artefact-generator)

</div>

## Usage

The script requires an [R](https://www.r-project.org/) interpreter to run. Any version should be fine, but the script is tested with 4.1.3

[GNU Wget](https://www.gnu.org/software/wget/) is used to download licence texts, ensure that it is installed. Again, any version should be fine, but the script is tested with 1.21.3

> It is expected that everything should work from a POSIX compliant shell. But the script is only tested on [GNU Bash](https://www.gnu.org/software/bash/).

Two `.csv` data files are required as input: 

1- A licence list (with appropriate metadata) for a software project
2- [Scancode toolkit](https://scancode-toolkit.readthedocs.io/en/stable/index.html) output for the corresponding software project

Lastly, and importantly, some dependencies may be installed via a package manager (specific to the project). So you should ensure that all appropriate package managers are installed (such as npm).

The recommended way to use this script is from a shell:

```bash
Rscript generate-artefacts.R LicenceList.csv ScancodeOutput.csv
```

Generated artefacts will be placed into the directory that the command was run from. The licence list and scan results should be encoded in UTF-8 and be present in the working directory.

## Licence

Copyright © 2022 Orcro Ltd.

This program and the accompanying materials are made available under the terms of the Apache License Version 2.0, a copy can be found in ./LICENSES/. 

### Dependencies

[R](https://www.r-project.org/) is released under the [GNU General Public Licence](https://www.gnu.org/licenses/gpl-3.0-standalone.html) version 3 or later.

[GNU Wget](https://www.gnu.org/software/wget/) is released under the [GNU General Public Licence](https://www.gnu.org/licenses/gpl-3.0-standalone.html) version 3 or later.

### Contact

:house_with_garden: Orcro Ltd. team@orcro.co.uk

:hammer: Maintainer alexander.murphy@orcro.co.uk

:computer: Website [orcro.co.uk](https://orcro.co.uk)
