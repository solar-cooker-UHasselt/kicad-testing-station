set shell := ["bash", "-euo", "pipefail", "-c"]

board := "testing-station"
opener := if os() == "macos" { "open" } else { "xdg-open" }

# List the recipes
[private]
default:
    @just --list

# Run ERC on the schematic, fail on errors, full report in tmp/erc.rpt
[private]
erc:
    kicad-cli sch erc --severity-all -o tmp/erc.rpt {{ board }}.kicad_sch
    @if grep -q '; error$' tmp/erc.rpt; then echo "ERC found errors, see tmp/erc.rpt" >&2; exit 1; fi

# Run DRC with schematic parity, fail on errors, full report in tmp/drc.rpt
[private]
drc:
    kicad-cli pcb drc --severity-all --schematic-parity -o tmp/drc.rpt {{ board }}.kicad_pcb
    @if grep -q '; error$' tmp/drc.rpt; then echo "DRC found errors, see tmp/drc.rpt" >&2; exit 1; fi

# Run the KiBot CI workflow locally with act
ci:
    act push -W .github/workflows/kibot.yml

# Run ERC and DRC
check: erc drc

# Export the schematic to outputs/<board>-schematic.pdf
[private]
sch-pdf:
    kicad-cli sch export pdf -o outputs/{{ board }}-schematic.pdf {{ board }}.kicad_sch

# Export copper and silkscreen layers to outputs/<board>-board.pdf, one page per layer
[private]
pcb-pdf:
    kicad-cli pcb export pdf --mode-multipage --include-border-title --layers F.Cu,B.Cu,F.Silkscreen,B.Silkscreen --common-layers Edge.Cuts -o outputs/{{ board }}-board.pdf {{ board }}.kicad_pcb

# Export both PDFs
pdf: sch-pdf pcb-pdf

# Export both PDFs and open them
open: pdf
    {{ opener }} outputs/{{ board }}-schematic.pdf
    {{ opener }} outputs/{{ board }}-board.pdf
