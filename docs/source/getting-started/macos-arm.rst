###########################
macOS (Apple Silicon)
###########################

MUIO can run on macOS Apple Silicon (ARM64) using Homebrew-provided solvers.
This setup does not bundle solver binaries.

Prerequisites
=============

Install Homebrew (instructions: https://brew.sh):

.. code-block:: bash

   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"

Install Anaconda. Follow the official instructions on their site. You can use
either the graphical installer or the command‑line installer; we recommend the
command‑line instructions:

.. code-block:: text

   https://www.anaconda.com/docs/getting-started/anaconda/install#macos-command-line-installer

After installation, close and reopen Terminal so ``conda`` is available.

Quick install (recommended)
===========================

From the repository root:

.. code-block:: bash

   ./scripts/install-macos.sh --install-solvers
   ./scripts/run-macos.sh

This creates a ``muio-dev`` Conda environment and installs requirements.

Manual install
==============

Install solvers:

.. code-block:: bash

   brew install glpk cbc

Create the Conda environment and install Python dependencies:

.. code-block:: bash

   conda create -y -n muio-dev python=3.11 pip
   conda activate muio-dev
   python -m pip install -r requirements.txt

Run MUIO
========

From the repository root:

.. code-block:: bash

   python platform/macos_arm_launcher.py

Or using the helper script:

.. code-block:: bash

   ./scripts/run-macos.sh

Create a macOS app bundle (optional)
====================================

This creates ``dist/MUIO.app`` that launches the server in Terminal:

.. code-block:: bash

   ./scripts/create-macos-app.sh

You can create a Desktop shortcut manually if you want (for example, drag the
app **alias** to Desktop). Keep the actual app bundle inside the MUIO folder.

Optional: Override solver location
=================================

If your solvers are installed in a non-standard location, set
``MUIO_SOLVER_BIN_DIR`` before launching:

.. code-block:: bash

   export MUIO_SOLVER_BIN_DIR="/path/to/solvers/bin"
   python3 platform/macos_arm_launcher.py
