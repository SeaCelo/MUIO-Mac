# Modelling User Interface for OSeMOSYS (MUIO) - MacOS port

![License](https://img.shields.io/github/license/SeaCelo/MUIO-Mac)
![Version](https://img.shields.io/github/v/release/SeaCelo/MUIO-Mac)
![GitHub all releases](https://img.shields.io/github/downloads/SeaCelo/MUIO-Mac/total)

This repository provides a macOS Apple Silicon (ARM64) port of MUIO, the user interface for the Open Source Energy Modelling System (OSeMOSYS). OSeMOSYS is a linear optimization energy system model that identifies least cost energy system pathways subject to meeting energy demands and other constraints. It supports analysis of technology choices, investment needs, and policy scenarios over time.

## macOS Apple Silicon port

This fork exists to support macOS Apple Silicon and includes platform specific adjustments (for example, macOS tooling, paths, and launch behavior). For macOS users, the `macport` branch is the supported branch in this repository.

Because the changes are specific to macOS, this repository is maintained as a separate port and is not intended for pull requests to the upstream project.

## Windows version

For the original Windows version of MUIO, use the upstream repository and installer:

- Upstream repository: https://github.com/OSeMOSYS/MUIO
- Windows download and installer: https://forms.office.com/Pages/ResponsePage.aspx?id=wE8mz7iun0SQVILORFQISwwn5YyR7ONHs-3JdG3f5AFUODlJOEQwWTBXMlRRNFUwNEpUTUZYQ1RXOS4u

## Questions and Issues

For troubleshooting model related questions and discussions, please visit the [Energy Modelling Community Discussion Forum](https://forum.u4ria.org/).

If you encounter bugs in this macOS port or have feature ideas, please open an issue in this repository so they can be tracked against the macOS specific code and scripts.

## Installing and running MUIO-Mac 

These steps are written to be beginner‑friendly. You can copy/paste each command.

Step 1 — Install Homebrew

Homebrew is required to install solver tools. Official instructions: https://brew.sh

Open **Terminal** and run:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Step 2 — Install Anaconda

Anaconda provides Python and conda. Follow the official instructions on their site.
You can use either the graphical installer or the command‑line installer; we
recommend the command‑line instructions:

```
https://www.anaconda.com/docs/getting-started/anaconda/install#macos-command-line-installer
```

After installation, close and reopen Terminal so `conda` is available.

Step 3 — Get the MUIO-Mac code

If you already have the MUIO-Mac folder, skip this step.

First, go to the location where you want MUIO-Mac to live (for example, your home
folder or Documents):

```
cd ~
```

Clone the `macport` branch of this repo: 
```
git clone --branch macport https://github.com/SeaCelo/MUIO-Mac.git
```
```
cd MUIO-Mac
```

Step 4 — Install MUIO-Mac (one command)

From the MUIO-Mac folder:

```
./scripts/install-macos.sh --install-solvers
```

This command installs Python dependencies and uses Homebrew to install the
required solvers (GLPK and CBC).

Step 5 — Run MUIO-Mac

```
./scripts/run-macos.sh
```

Optional — Create a macOS app (double‑click launcher)

This creates `dist/MUIO-Mac.app` that opens Terminal and starts the server:

```
./scripts/create-macos-app.sh
```

You can create a Desktop shortcut manually if you want (for example, drag the
app **alias** to Desktop). Keep the actual app bundle inside the MUIO-Mac folder.
