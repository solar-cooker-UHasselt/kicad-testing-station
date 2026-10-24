# kicad-testing-station

[![ERC/DRC](https://img.shields.io/github/actions/workflow/status/solar-cooker-UHasselt/kicad-testing-station/kibot.yml?branch=main&event=push&label=ERC%2FDRC)](https://github.com/solar-cooker-UHasselt/kicad-testing-station/actions/workflows/kibot.yml)
[![KiCad 10](https://img.shields.io/badge/KiCad-10-314CB0)](https://www.kicad.org/download/)

The main board of the [solar cooker](https://github.com/solar-cooker-UHasselt) testing
station: a shield for the
[Arduino UNO R4 WiFi](https://docs.arduino.cc/hardware/uno-r4-wifi/) that logs how a
solar cooker performs. With the firmware
([arduino-code](https://github.com/solar-cooker-UHasselt/arduino-code)) it records:

- the temperature in three pots, with PT100 probes on three MAX31865 circuits
- the solar irradiance, with a pyranometer
- the wind speed, with an anemometer
- the outside temperature, with an AM2315C sensor
- the air pressure and humidity inside the box, with a BME680

Every measurement goes to a CSV file on a microSD card, stamped by a DS3231 real-time
clock, and shows on an LCD. The MAX31865, BME680, DS3231 and microSD circuits are
Adafruit's breakouts, drawn onto the shield as schematic sheets. Each also has its own
repo, see the [board overview](https://solar-cooker-uhasselt.github.io/). The sensors outside the box
connect to screw terminals, the LCD to a 20-pin FPC connector.

[![3D render of the board, top side](https://solar-cooker-uhasselt.github.io/kicad-testing-station/testing-station-render-top.png)](https://solar-cooker-uhasselt.github.io/kicad-testing-station/)

- [Board page](https://solar-cooker-uhasselt.github.io/kicad-testing-station/): 3D
  renders, drawings, schematic and board PDF, interactive BOM and the BOM CSV for
  Eurocircuits, rebuilt by CI on every push to `main`
- [Port an Eagle design to KiCad](docs/eagle_to_kicad.md): how the Adafruit and
  Arduino parts were brought into KiCad, and replacing symbols and footprints
- [PCB manufacturing](docs/pcb_manufacturing.md): the Eurocircuits BOM and checking
  part availability
- [KiCad tools](docs/kicad_tools.md): Freerouting, KiBot, KiKit and Kiri

## Installation

### Requirements

- [KiCad 10](https://www.kicad.org/download/), to open and edit the board
- [git](https://git-scm.com), to clone the repo
- Optional, for the checks: [just](https://just.systems)

### Clone

```bash
git clone https://github.com/solar-cooker-UHasselt/kicad-testing-station.git
```

Own symbols, footprints and 3D models are in `external/`, in the repo itself.

## Usage

Open `testing-station.kicad_pro` in KiCad 10. The schematic, with a sheet per breakout
circuit, and the board open from there.

Before committing, run ERC and DRC, reports in `tmp/`:

```bash
just check
```

`just --list` shows the other recipes: PDFs, and the CI workflow run locally.

## Contributing

- Work on a branch and open a pull request to `main`. It merges once CI passes and a code
  owner (listed in [.github/CODEOWNERS](.github/CODEOWNERS)) approves it. `main`
  accepts no force pushes.
- CI runs ERC and DRC on every pull request, through the shared workflows in
  [kicad-ci](https://github.com/solar-cooker-UHasselt/kicad-ci). `just check` runs the
  same check locally. A push to `main` that changes more than Markdown also rebuilds
  the board page.
- Commits follow Conventional Commits, with one change per commit. Types, scopes and the
  ERC/DRC check are in
  [.agents/commit_conventions.md](.agents/commit_conventions.md).
- Changes to the board setup, CI or docs are made and tested in
  [kicad-adafruit-ds3231](https://github.com/solar-cooker-UHasselt/kicad-adafruit-ds3231)
  first, then copied here.

## Authors and acknowledgment

The breakout circuits are Adafruit's designs, by Limor Fried/Ladyada for Adafruit
Industries
([source files](https://learn.adafruit.com/accessing-and-using-adafruit-pcb-design-files/finding-and-downloading)).
The shield follows Arduino's
[UNO R4 WiFi design files](https://docs.arduino.cc/hardware/uno-r4-wifi/). The board
is by Lowie Van Vyve for the UHasselt solar cooker project.
