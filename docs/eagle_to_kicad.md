# Port an Eagle design to KiCad

This repository uses design files from Adafruit and Arduino. The original design files from Adafruit are available [here](https://learn.adafruit.com/accessing-and-using-adafruit-pcb-design-files/finding-and-downloading). The Arduino UNO R4 WiFi CAD files can be found [here](https://docs.arduino.cc/hardware/uno-r4-wifi/).

The Adafruit PCB files were created with [Autodesk Eagle](https://www.autodesk.com/products/eagle/free-download), and the Arduino UNO R4 WiFi was created in [Altium Designer](https://www.altium.com/altium-designer). This repository uses [KiCad](https://www.kicad.org/download/), so the design files need to be migrated first.

## Import the Eagle project

> [!IMPORTANT]
> Before you start, make sure you download the source repository and place it on your PC.

1. Open KiCad and navigate to `File > Import Non-KiCad Project` and select `Eagle Project`.
2. Navigate to the Eagle project folder and select the `.sch` or `.brd` file. Choose a destination folder.
3. The Eagle project will open in KiCad. Select `Auto-Match Layers` when prompted to map the board layers.
4. If a popup message appears about unmapped layers, click `OK`.

> [!IMPORTANT]
> Don't forget to save both the PCB and schematic files to avoid losing your changes.


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
> ICs are usually not in the standard KiCad library. Use the symbol editor to create them and place new symbols in the [external/symbols/](../external/symbols/) folder.

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
2. Place the footprint in the [external/footprints/](../external/footprints/) folder. Footprints have the `.kicad_mod` extension.
3. In the schematic, double-click the symbol and link the correct footprint.
4. In the PCB layout, right-click the footprint, select `Properties` (shortcut E), and change to the new footprint. Ensure the reference value matches the schematic.

> [!TIP]
> Click on a symbol in the schematic to highlight it in the PCB layout.
