# KiCad Testing Station

This repository uses design files from Adafruit and Arduino. The original design files from Adafruit are available [here](https://learn.adafruit.com/accessing-and-using-adafruit-pcb-design-files/finding-and-downloading). The Arduino UNO R4 WiFi CAD files can be found [here](https://docs.arduino.cc/hardware/uno-r4-wifi/).

The Adafruit PCB files were created with [Autodesk Eagle](https://www.autodesk.com/products/eagle/free-download), and the Arduino UNO R4 WiFi was created in [Altium Designer](https://www.altium.com/altium-designer). This repository uses [KiCad](https://www.kicad.org/download/), so the design files need to be migrated first.

## Index

- [Migration from Eagle to KiCad](#migration-from-eagle-to-kicad)
- [Switching to Native KiCad Symbols](#switching-to-native-kicad-symbols)
  - [Replacing a Symbol](#replacing-a-symbol)
  - [Replacing a Footprint](#replacing-a-footprint)
- [PCB Manufacturing](#pcb-manufacturing)
  - [BOM Layout](#bom-layout)
  - [BOM Availability](#bom-availability)
  - [Generic Components](#generic-components)
- [Useful KiCad Tools](#useful-kicad-tools)
  - [Kiri](#kiri)

## Migration from Eagle to KiCad

> [!IMPORTANT]
> Before you start, make sure you download the source repository and place it on your PC.

1. Open KiCad and navigate to `File > Import Non-KiCad Project` and select `Eagle Project`.
2. Navigate to the Eagle project folder and select the `.sch` or `.brd` file. Choose a destination folder.
3. The Eagle project will open in KiCad. Select `Auto-Match Layers` when prompted to map the board layers.
4. If a popup message appears about unmapped layers, click `OK`.

> [!IMPORTANT]
> Don't forget to save both the PCB and schematic files to avoid losing your changes.

**[⬆ Back to Index](#index)**

## Switching to Native KiCad Symbols

When importing from other EDA software, KiCad creates an import library with all the symbols. Migrate all symbols to a default KiCad library.

Common symbols available in the standard KiCad library:

- Buttons
- Capacitors
- LEDs
- Pin headers
- Power symbols (GND, VCC, +3.3V, etc.)
- Resistors
- Test points

> [!TIP]
> ICs are usually not in the standard KiCad library. Use the symbol editor to create them and place new symbols in the [external/symbols/](external/symbols/) folder.

### Replacing a Symbol

1. Double-click on the symbol and select `Change Symbol`.
2. Click on `New library identifier` and find the correct symbol in the KiCad libraries. Rewire if necessary.

### Replacing a Footprint

> [!IMPORTANT]
> Ensure the component is available from [DigiKey](https://www.digikey.com/), [Mouser](https://eu.mouser.com/), or a supplier listed [here](https://www.eurocircuits.com/eurocircuits-preferred-component-suppliers/).

1. Find your component in a [standard package](https://en.wikipedia.org/wiki/List_of_integrated_circuit_packaging_types) within KiCad or online:
   - [Component Search Engine](https://componentsearchengine.com/)
   - [SnapEDA (preferred)](https://www.snapeda.com/)
   - [Ultra Librarian](https://www.ultralibrarian.com/)
   - [Octopart](https://octopart.com/)
2. Place the footprint in the [external/footprints/](external/footprints/) folder. Footprints have the `.kicad_mod` extension.
3. In the schematic, double-click the symbol and link the correct footprint.
4. In the PCB layout, right-click the footprint, select `Properties` (shortcut E), and change to the new footprint. Ensure the reference value matches the schematic.

> [!TIP]
> Click on a symbol in the schematic to highlight it in the PCB layout.

**[⬆ Back to Index](#index)**

## PCB Manufacturing

Our chosen PCB manufacturer is [Eurocircuits](https://www.eurocircuits.com/), headquartered in Belgium.

### BOM Layout

Create a BOM file using the BOM button in the schematic editor. The typical Eurocircuits BOM file layout is:

| Reference | Qty | Manufacturer | MPN | Supplier | SPN | Component package type | Description |
| --------- | --- | ------------ | --- | -------- | --- | ---------------------- | ----------- |

> [!NOTE]
> - MPN: Manufacturer part number
> - SPN: Supplier part number

Fill in these fields manually for each symbol. Use the `Edit` tab in the BOM popup window for bulk editing.

### BOM Availability

Check part availability via the [Octopart BOM Tool](https://octopart.com/bom-tool). Upload your BOM and select preferred distributors.

### Generic Components

Use [generic components](https://www.eurocircuits.com/generic-components/) from Eurocircuits. Adding them to your BOM file means you don't need to specify a manufacturer and MPN.

**[⬆ Back to Index](#index)**

## Useful KiCad Tools

- [Freerouting](https://github.com/freerouting/freerouting): Auto route PCB boards.
- [KiBot](https://github.com/INTI-CMNB/KiBot): KiCad automation (CI/CD).
- [KiKit](https://github.com/yaqwsx/KiKit): Present PCB boards.
  - [PcbDraw](https://github.com/yaqwsx/PcbDraw)
- [Kiri](https://github.com/leoheck/kiri): Visual diff tool for KiCad projects.

### Kiri

Kiri allows you to quickly see changes from previous commits.

Find installation instructions [here](https://github.com/leoheck/kiri/blob/main/INSTALL.md). Once installed, run the following command in your git project folder:

```zsh
kiri
```

A browser tab will open automatically.

**[⬆ Back to Index](#index)**
