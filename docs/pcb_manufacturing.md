# PCB Manufacturing

Our chosen PCB manufacturer is [Eurocircuits](https://www.eurocircuits.com/), headquartered in Belgium.

## BOM Layout

Create a BOM file using the BOM button in the schematic editor. The typical Eurocircuits BOM file layout is:

| Reference | Qty | Manufacturer | MPN | Supplier | SPN | Component package type | Description |
| --------- | --- | ------------ | --- | -------- | --- | ---------------------- | ----------- |

> [!NOTE]
> - MPN: Manufacturer part number
> - SPN: Supplier part number

Fill in these fields manually for each symbol. Use the `Edit` tab in the BOM popup window for bulk editing.

CI builds this BOM as a CSV on every push to `main`, from the fields in the symbols: see
the [board page](https://solar-cooker-uhasselt.github.io/kicad-testing-station/).

## BOM Availability

Check part availability via the [Octopart BOM Tool](https://octopart.com/bom-tool). Upload your BOM and select preferred distributors.

## Generic Components

Use [generic components](https://www.eurocircuits.com/generic-components/) from Eurocircuits. Adding them to your BOM file means you don't need to specify a manufacturer and MPN.
