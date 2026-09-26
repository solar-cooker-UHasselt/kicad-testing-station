# Commit conventions

This repo's commit rules. The shared procedure is the `propose-commit` skill, which
reads this file first and follows it where the two differ.

## Check

Every commit leaves ERC and DRC no worse than the commit before it:

```bash
kicad-cli sch erc --severity-all -o tmp/erc.rpt testing-station.kicad_sch
kicad-cli pcb drc --severity-all --schematic-parity -o tmp/drc.rpt testing-station.kicad_pcb
```

Run ERC on the top-level sheet only. It includes the sub-sheets (`BME680`, `DS3231`,
`MAX31865`, `microSD`).

Compare the violation counts with the previous commit. A commit that fixes violations
says which ones in its body.

## Types

Choose by the change's *nature*, not by copying past messages.

| Type       | When to use                                                          |
| ---------- | -------------------------------------------------------------------- |
| `feat`     | A new part, circuit or board feature                                 |
| `fix`      | Corrects a design error: ERC/DRC violation, footprint, value         |
| `refactor` | Placement or routing changed, same netlist                           |
| `style`    | Silkscreen or schematic layout only, no electrical change            |
| `build`    | KiCad file format or library format upgrades                         |
| `ci`       | `.github/workflows/` and `config.kibot.yml`                          |
| `docs`     | README and other documentation                                       |
| `chore`    | `.gitignore`, agent files, other maintenance                         |

## Scope

Optional. In use: `sch` (schematic), `pcb` (board), `bom` (BOM fields), `lib`
(`external/`: symbols, footprints, 3D models). For a change inside one sub-sheet, the
sheet name works as scope: `bme680`, `ds3231`, `max31865`, `microsd`. Leave the scope
out when a commit spans several.

## Rules

- Breaking changes: a KiCad file format upgrade is one-way, older KiCad versions can
  no longer open the files. Mark it with `!` and a `BREAKING CHANGE:` footer naming the
  KiCad version now required.
- One kind of change per commit. A format upgrade contains only what KiCad rewrote on
  save: no zone refill, no library updates, no fixes.
- Never commit `*.kicad_prl`, lock files (`~*`) or generated outputs. `.gitignore`
  covers them.

## Well-formed examples

```
build!: upgrade schematic and board to KiCad 10
build(lib): upgrade footprint library to KiCad 10 format
ci: pin KiBot to the KiCad 10 image
fix(max31865): add PWR_FLAG on the RTD supply
chore: add commit conventions and ignore tmp/
```
