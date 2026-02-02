# Modelling User Interface for OSeMOSYS (MUIO) - MacOS port

![License](https://img.shields.io/github/license/SeaCelo/MUIO-Mac)
![Version](https://img.shields.io/github/v/release/SeaCelo/MUIO-Mac)
![GitHub all releases](https://img.shields.io/github/downloads/SeaCelo/MUIO-Mac/total)

This repository provides a macOS Apple Silicon (ARM64) port of MUIO.

For the Windows version: https://github.com/OSeMOSYS/MUIO
For the MUIO documentation: https://muio-modelling-user-interface-for-osemosys.readthedocs.io/en/latest/

## macOS Apple Silicon port

This repo is a standalone macOS port. The supported code is on the `main` branch.

## Documentation

Upstream documentation (applies to MUIO in general):
https://muio-modelling-user-interface-for-osemosys.readthedocs.io/en/latest/

## Questions and Issues

For community discussions, visit the [Energy Modelling Community Discussion Forum](https://forum.u4ria.org/).
For macOS port bugs or feature ideas, open an issue in this repository.

## Installing and running MUIO-Mac 

**Step 1 — Install Homebrew (required)**

Official instructions: https://brew.sh

In Terminal, run:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Step 2 — Install Anaconda (required)**

Official instructions (GUI or CLI): 

```
https://www.anaconda.com/docs/getting-started/anaconda/install#macos-command-line-installer
```

After installation, close and reopen Terminal so `conda` is available.

**Step 3 — Get the MUIO-Mac code**

If you already have the MUIO-Mac folder, skip this step.

First, go to the location where you want MUIO-Mac to live (for example, your home
folder or Documents):

```
cd ~
```

Clone the `main` branch: 
```
git clone --branch main https://github.com/SeaCelo/MUIO-Mac.git
```
```
cd MUIO-Mac
```

**Step 4 — Install demo data (optional)**

Download the demo dataset (matches the MUIO.exe demo data):

https://github.com/SeaCelo/MUIO-Mac/releases/download/demo-data-v1/CLEWs.Demo.zip

Unzip it into:

```
WebAPP/DataStorage
```

After unzipping, you should have:

```
WebAPP/DataStorage/CLEWs Demo/...
```

**Step 5 — Install MUIO-Mac**

This installs Python dependencies and Homebrew solvers (GLPK and CBC). From the MUIO-Mac folder:

```
./scripts/install-macos.sh --install-solvers
```

**Step 6 — Run MUIO-Mac**

```
./scripts/run-macos.sh
```

**Optional — Create a macOS app (double‑click launcher)**

This creates `dist/MUIO-Mac.app` that opens Terminal and starts the server:

```
./scripts/create-macos-app.sh
```

Keep the actual app bundle inside the MUIO-Mac folder. You can create a Desktop alias if desired.
