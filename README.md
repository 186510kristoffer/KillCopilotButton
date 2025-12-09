

# KillCopilot

A lightweight AutoHotkey v2 script that remaps the dedicated Windows Copilot key to function as an AltGr modifier (or other user-defined keys).

## Background

On newer Windows keyboards, the Copilot key is not a standard HID key. Instead, it functions as a hardware macro that instantly transmits `Left Windows + Left Shift + F23`.

Attempting to remap this key using standard methods often fails due to "modifier leakage." Since the physical Windows key is held down during the macro sequence, the operating system frequently interprets subsequent key presses as Windows shortcuts (e.g., `Win + R`) rather than the intended remapped output.

## Solution

This script solves the leakage issue by using a state-based approach combined with the `{Blind}` SendInput mode. This forces AutoHotkey to ignore the physical state of the modifier keys, preventing the operating system from re-engaging the Windows key when blocking the native Copilot signal.

## Requirements

* Windows 10 or 11
* [AutoHotkey v2](https://www.autohotkey.com/)

## Installation

1.  Download `KillCopilot.ahk`.
2.  Ensure AutoHotkey v2 is installed.
3.  Double-click the script to run it.

To run the script automatically at login:
1.  Press `Win + R`.
2.  Type `shell:startup` and press Enter.
3.  Place a shortcut to the script in the folder.

## Default Mappings

The script is currently configured for a Nordic layout, treating the Copilot key as an AltGr modifier for programming syntax.

| Key Combination | Output |
| :--- | :--- |
| **Copilot + 7** | `{` |
| **Copilot + 8** | `[` |
| **Copilot + 9** | `]` |
| **Copilot + 0** | `}` |
| **Copilot + 2** | `@` |
| **Copilot + 4** | `$` |
| **Copilot + E** | `€` |
| **Copilot + <** | `|` |
| **Copilot + +** | `\` |

## Configuration

You can modify the mappings in the `KillCopilot.ahk` file under the `#HotIf CopilotActive` block.

To map new keys, use the following format to ensure modifiers do not interfere:

```autohotkey
*key::Send "{Blind}{Text}YourCharacter"
