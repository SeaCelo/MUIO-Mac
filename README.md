# Modelling User Interface for OSeMOSYS (MUIO)

![License](https://img.shields.io/github/license/OSeMOSYS/MUIO)
![Version](https://img.shields.io/github/v/release/OSeMOSYS/MUIO)
![GitHub all releases](https://img.shields.io/github/downloads/OSeMOSYS/MUIO/total)

This repository contains the user interface for the Open Source Energy Modelling System (OSeMOSYS). OSeMOSYS is a linear optimization energy system model designed to minimize total system costs while ensuring energy demands are met within specified constraints. It facilitates optimal allocation of energy resources, technologies, and investments over time, supporting long-term energy planning and policy analysis.


1.	Download the latest version of the user interface from [here](https://forms.office.com/Pages/ResponsePage.aspx?id=wE8mz7iun0SQVILORFQISwwn5YyR7ONHs-3JdG3f5AFUODlJOEQwWTBXMlRRNFUwNEpUTUZYQ1RXOS4u). 
2.	Move the .exe file from your download folder to a folder where you have administrator privileges. This may be for instance inside the folder: users>>name_of_the_user or any other folder you prefer. 
3.	Right-click on MUIO.exe and click ‘Run as administrator’. This will start the installation of the MUIO. The installation may take several minutes. Once it is complete, the installation window will simply disappear. 
4.	The App will open automatically once the installation is complete. If not, search on the Windows Taskbar for ‘’MUIO’’ and open the App. 
5.	You will see the MUIO in a new window. 

## Questions and Issues

For troubleshooting model-related issues and discussions, please visit the [Energy Modelling Community Discussion Forum](https://forum.u4ria.org/). 

If you encounter bugs or have new feature ideas, please submit them to the repository's issue tracker. We encourage contributions and discussions to further develop MUIO.

## MacOS Apple Silicon (web interface)

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

Step 3 — Get the MUIO code

If you already have the MUIO folder, skip this step.

First, go to the location where you want MUIO to live (for example, your home
folder or Documents):

```
cd ~
```

Clone this branch: 
```
git clone --branch macport https://github.com/SeaCelo/MUIO.git
```
```
cd MUIO
```

Step 4 — Install MUIO (one command)

From the MUIO folder:

```
./scripts/install-macos.sh --install-solvers
```

This command installs Python dependencies and uses Homebrew to install the
required solvers (GLPK and CBC).

Step 5 — Run MUIO

```
./scripts/run-macos.sh
```

Optional — Create a macOS app (double‑click launcher)

This creates `dist/MUIO.app` that opens Terminal and starts the server:

```
./scripts/create-macos-app.sh
```

You can create a Desktop shortcut manually if you want (for example, drag the
app **alias** to Desktop). Keep the actual app bundle inside the MUIO folder.
