# kicad-testing-station

This repository uses the design files made available by Adafruit and Arduino. The original design files from Adafruit can be found on the Adafruit site at the following [link](https://learn.adafruit.com/accessing-and-using-adafruit-pcb-design-files/finding-and-downloading). The Arduino UNO R4 WiFi CAD files are located [here](https://docs.arduino.cc/hardware/uno-r4-wifi/).

The Adafruit PCB files were created with [Autodesk Eagle](https://www.autodesk.com/products/eagle/free-download). The Arduino UNO R4 WiFi was created in [Altium Designer](https://www.altium.com/altium-designer). This repository uses [KiCad](https://www.kicad.org/download/), so the design files need to be migrated first.

## How to migrate from Eagle to KiCad

> [!IMPORTANT] 
> Before you start, make sure you download the source repository and place it somewhere on your PC.

Open KiCad and navigate to `File`> `Import Non-KiCad Project` and click on `Eagle Project`. Now you will have to navigate to the Eagle project folder with the `.sch` and `.brd` file. Click on the `.sch` or `.brd` file and choose a destination folder afterwards. This will open the Eagle project in KiCad. You will get a prompt to map the layers of the board into KiCad layers, select `Auto-Match Layers`. It's possible that you will get a popup message telling you that some layers will didn't map, don't worry, just click `OK`.

> [!IMPORTANT]  
> Don't forget to save both the PCB and schematic files, otherwise your changes will be lost!

## Switching to native KiCad symbols

When importing from other EDA software, KiCad will create an import library with all the symbols. Try to migrate all symbols to a default KiCad library.

Here is a list of symbols that are definitely in the standard KiCad library:

- buttons
- capacitors
- LEDs
- pin headers
- power symbols (GND, VCC, +3.3V, ...)
- resitors
- test points

> [!TIP]
> ICs are usually not in the standard KiCad library, but they can easily be created with the symbol editor (Create, delete and edit symbols). Make sure you place new symbols in the external_library located in the [external](external/symbols/) folder.

### Replacing a symbol

Changing a symbol is very simple and goes as follows. Double click on the symbol and select `Change Symbol`. Now click on `New library identifier` and find the correct symbol in the KiCad libraries, rewire if necessary.

### Replacing a footprint

> [!IMPORTANT] 
> Make sure you found the component you want to use in [DigiKey](https://www.digikey.com/), [Mouser](https://eu.mouser.com/) or one supplier found on [this](https://www.eurocircuits.com/eurocircuits-preferred-component-suppliers/) site.

If your component is in a [standard package](https://en.wikipedia.org/wiki/List_of_integrated_circuit_packaging_types), there is a possibility you will find it in KiCad.

> [!TIP]
> If you can't find a footprint or 3D model in KiCad, you can always try to find it online. Here are some useful sites:
> - [Component Search Engine](https://componentsearchengine.com/)
> - [SnapEDA (preferred)](https://www.snapeda.com/)
> - [Ultra Librarian](https://www.ultralibrarian.com/)

Once you found the right footprint make sure to place it in the footprint [folder](external/footprints/).

> [!NOTE]
> Footprints have the `.kicad_mod` extension

The first thing to do is to link the symbol in the schematic to the correct footprint. In the diagram, double click on the symbol whose footprint you want to replace. Then click on the footprint value in the popup window and click on the three vertical lines on the right-hand side of the text box. Find your footprint and click `OK`.

Next switch to your PCB layout file, and find the footprint you want to change. Right click on the footprint and select `Properties` (shortcut is keypress E). Next click on `Change Footprint` > `New footprint library id` and select the correct one. Don't forget to click on `Change` to actually change it. Once you close the popup window it will change the footprint. If necessary, change the orientation of the footprint. Make sure the reference value of the footprint is the same as in the schematic.

The last step is to open `Tools` > `Update PCB from Schematic` and then it will report one less error if everything has been done correctly.

> [!TIP]
> If you have the schematic and the PCB layout side by side, you can click on a symbol in the schematic and it will be highlighted in the PCB layout.

## PCB manufacturing

[Eurocircuits](https://www.eurocircuits.com/) is our chosen manufacturer of PCBs, headquartered in Belgium.

To have a PCB manufactured, Eurocircuits needs a couple of files. The first file is the `.kicad_pcb` file. Eurocircuits also needs a BOM file to know which components are needed. BOM files can easily be created using the BOM button in the schematic editor. In the `Edit` tab of the popup window, you can change the values you want to display in the BOM files. Eurocircuits has a number of fields that are mandatory to fill in.

> [!WARNING]
> Eurocircuits does not currently support KiCad version 8 PCB file, gerber files will have to be used instead.

### BOM layout

Eurocircuits typical BOM file layout

| Reference | Qty | Manufacturer | MPN | Supplier | SPN | Component package type | Description |
|-----------|-----|--------------|-----|----------|-----|------------------------|-------------|

> [!NOTE]
> - MPN: Manufacturer part number
> - SPN: Supplier part number

You will have to create these fields manually for each symbol. To bulk edit these fields you can use the `Edit` tab in the BOM popup window. Copy-paste is your friend ;).

### Generic components

Eurociruits supplies a number of [generic components](https://www.eurocircuits.com/generic-components/). You can use these capacitors and resistors from eurocircuits. If you add them to your BOM file, you don't need to specify a manufacturer and MPN.
