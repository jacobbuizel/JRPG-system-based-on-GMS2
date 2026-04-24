---
name: hgame-gms2-safe-edit
description: Safe editing guidance for the hgame GameMaker Studio 2 JRPG project. Use when Codex or an agent needs to inspect, modify, refactor narrowly, debug, or extend this repository's GML code, GMS2 objects, rooms, scripts, save data, inventory, equipment, character, skill, menu, NPC, movement, audio, or room-state systems.
---

# HGame GMS2 Safe Edit

## First Steps

Use this skill before changing this repository. Treat the project as a GMS2 2024.13.1+ project with hand-maintained GML conventions and fragile serialized data.

1. Inspect the local files before editing. Start with `rg --files`, then use targeted `rg` searches for function names, enum names, `global.` variables, and `ds_grid_*` access.
2. Prefer editing `.gml` script/event files. Avoid `.yy` edits unless resource metadata truly must change, such as adding/removing an event in `eventList`, changing an object parent/child relationship, or adding/removing a GMS2 resource.
3. Before using any GML API, verify that it already appears in the project or is a current built-in GameMaker function. Do not invent helper names or use plugin-only/deprecated APIs.
4. Keep changes narrow. Do not reorganize the project, rename resources, or redesign the save/inventory/equipment/character data model unless the user explicitly asks for that refactor.
5. Preserve existing `ds_grid`, struct, enum, sentinel, and save-file contracts. These are part of runtime behavior, not incidental implementation details.
6. When editing GML, prefer APIs already present in this repository. If a new GameMaker API is needed, verify it against current official GameMaker documentation before using it.

## Project Map

- `hgame.yyp` and `hgame.resource_order`: GMS2 project metadata. Avoid manual edits unless a resource change requires it.
- `scripts/`: reusable GML functions and data catalogs. This is the safest place for most logic changes.
- `objects/`: object event code. Event files are named by GMS2 event type, such as `Create_0.gml`, `Step_0.gml`, `Draw_64.gml`, and `Destroy_0.gml`.
- `rooms/`: room metadata and instance creation code. Instance creation files often set `global.bgm`, `global.roomid`, item/NPC state, or room transitions.
- `sprites/`, `sounds/`, `fonts/`, `tilesets/`, `options/`: resource metadata and assets. Treat `.yy` files here as generated/editor-owned unless a resource task requires touching them.
- `notes/`: developer notes, not runtime code.

## Core Systems

### Boot, Globals, Time, Debug

- `objects/obj_title_menu/*` initializes title-menu state, audio volume globals, settings, `global.savef`, `global.sub_menu`, `global.talking`, and `global.noresting`.
- `objects/obj_gamestart/Create_0.gml` initializes a new or loaded run: debug flag, message speed, total/game time, `global.talking`, `global.overweight`, `global.noresting`, `global.bgm`, `global.battle`, `global.gameover`, room status, and `global.saveDATA`.
- `objects/obj_gamestart/Step_0.gml` creates or re-creates persistent runtime managers and player/partner instances.
- `objects/obj_control/*` defines global input aliases via `globalvar`: `lkey`, `rkey`, `ukey`, `dkey`, `akey`, `bkey`, `xkey`, `ykey`, pressed/released variants, function keys, and `key_cooldown`.
- `objects/obj_allways/*` manages debug hotkeys, quick save/load, total/game time, in-game time, `mp_grid` pathfinding grids, battle BGM gain, and game-over transitions.
- `objects/obj_bgm/*` manages BGM start/loop tracks and fades by `global.bgm`; `global.battle` controls the second BGM group in `obj_allways`.

### Save And Load

- `scripts/scr_saving_system/scr_saving_system.gml` is the central save/load script. Be very conservative here.
- `scr_saving(_datanum)` writes `savedataN.sav` as JSON through `buffer_create`, `buffer_write`, and `buffer_save`.
- Inventory, equipment, and room status are serialized with `ds_grid_write`; their heights are stored separately.
- Character data is not saved as raw nested grids. It clones each character struct with `variable_clone`, converts `skill_list` and `spellbook_list` grids into arrays of structs, and writes `global.saveDATA.Schara_status`.
- `scr_loading(_datanum)` only parses JSON into `global.saveDATA`. Rehydration happens later in object code:
  - `obj_gamestart/Create_0.gml` restores global time and `room_status`.
  - `obj_item_manager/Step_0.gml` rebuilds `inventory` and `equipment` from `ds_grid_read`.
  - `obj_charsatus/Step_0.gml` rebuilds character structs, `skill_list`, and `spellbook_list` grids.
- Do not change save field names, grid widths, enum columns, or character struct fields without a migration plan and backwards compatibility.

### Character Data

- `scripts/scr_character/scr_character.gml` replaces the older deprecated `dis_scr_gamerule` character implementation.
- `chara_id(_id)` returns a character struct. Important fields include identity, stats, modifiers, HP/MP, class/race strings, equipment slots, `skill_list`, `spellbook`, and `spellbook_list`.
- `obj_charsatus/Create_0.gml` creates global `chara_status` with width `chara_status_w = 2`; column `0` is character id, column `1` is the character struct.
- `load_chara(_id)` searches `chara_status`, returns the stored struct, applies old-save compatibility for spellbooks, clamps HP/MP, and refreshes modifiers.
- Character equipment slots store full equipment structs or `0`: `main_h`, `sec_h`, `armor`, `accessoryA`, `accessoryB`, `accessoryC`.

### Inventory And Equipment

- `scripts/scr_item/scr_item.gml` defines `enum DS_INVENTORY`: `NAME = 0`, `AMOUNT = 1`, `I_ID = 2`.
- `obj_item_manager/Create_0.gml` creates global `inventory` with `inventory_w = 3` and global `equipment` with `equipment_w = 4`.
- `item_id(_id)` is the item catalog and returns a struct. Some item ids are decimals, such as `0.1`, `1.1`, and `2.8`; preserve that convention.
- `add_item_id()` merges stacks by item id and caps inventory amounts at `999`; empty first cell value `0` means an empty grid row.
- `scripts/scr_equipment/scr_equipment.gml` defines `enum DS_EQUIPMENT`: `NAME = 0`, `AMOUNT = 1`, `E_ID = 2`, `CUR_DURABILITY = 3`.
- `equipment_id(_id)` is the equipment catalog. `equip_parts` values are meaningful: `0` two-handed main-hand only, `1` main hand only, `2` main or off hand, `3` armor, `4` accessory slots.
- `apply_equipment()` removes old attr mods/effects, sets a slot, applies new attr mods/effects, then calls `recalc_AC()`.
- Equipment/item effect lists use arrays of structs like `{type: APP_EFFECT.ITEM_POTION, t_id:[2,4,2]}`. Route new effects through the existing `APP_EFFECT` enum and `apply_effect()` pattern.

### Skill And Spell Data

- `scripts/scr_skill/scr_skill.gml` defines `DS_SKILL` and `DS_SPELL`.
- `DS_SKILL` columns are `NAME`, `S_ID`, and `SOURCE_COUNT`. `SOURCE_COUNT` allows multiple sources for the same skill; `remove_skill_id()` decrements before removing rows.
- `DS_SPELL` columns are `NAME`, `S_ID`, and `ISENALBE = 2`; `ISENABLE = 2` is an alias. Preserve the existing misspelled `ISENALBE` uses for compatibility.
- `add_spell_id()` may also add a skill when a spell is enabled. `set_spell_enable_by_row()` enforces `get_spell_enable_limit()`.

### Room State And Instance Data

- `scripts/scr_roomsatus/scr_roomsatus.gml` creates global `room_status` as a grid. Each room uses two rows: `roomid * 2` for state, `roomid * 2 + 1` for restorable chance.
- Column `0` stores the number of tracked room entries for that room. Entry columns begin at `1`.
- Room instance creation code reads and writes `room_status` by hard-coded row/column positions. Do not reorder entries casually.
- Adding room-state entries requires updating `reroomsatus()` and matching the relevant room instance creation code.

### Menus, Messages, And Interaction

- Menu objects use `global.pause` and `global.sub_menu` as state-machine controls. Destroy events usually reset `global.sub_menu = 0`.
- Menu navigation uses input aliases from `obj_control` and helper `scr_menu_movement_jump()`.
- `scripts/scr_msg/scr_msg.gml` creates pages/options and `obj_msgbox`; `scripts/scr_msg_game/scr_msg_game.gml` contains message ids and branching text.
- Item use creates `obj_menu_useitem` and stores a closure in `u_scr`, then applies the underlying effect after a target character is chosen.

### Movement And NPCs

- `scripts/scr_movement/scr_movement.gml` applies velocity, facing, vector path movement, and solid collision nudging. It expects instance fields like `vx`, `vy`, `vs`, `acc`, `sprinting`, `face`, and `block_solid`.
- `scripts/scr_player_movement/scr_player_movement.gml` translates global input aliases into player velocity and sprint state.
- `scripts/scr_npc_behavior/scr_npc_behavior.gml` dispatches numeric NPC behaviors: idle/default, random move, talking, follow, close follow, and away.
- NPC objects initialize movement fields and `block_solid` in their `Create` events. Hostile NPCs also maintain path state with `follow_path`, `follow_target`, and `follow_timer`.

## GML Style

- Use GMS2.3+ script functions: `function name(_arg) { ... }`.
- Prefix function parameters and temporary locals with `_` where the surrounding code does so, such as `_id`, `_chara`, `_equipment`, `_row`.
- Keep catalog functions as `switch(_id)` blocks returning structs. Add new item/equipment/skill cases near similar ids and keep `#region` comments when helpful.
- Use `argument_count` and `argument[]` for optional arguments when matching existing scripts.
- Use existing input aliases (`akey`, `bkey`, `dpkey`, etc.) instead of calling raw keyboard/gamepad checks from unrelated code.
- Use `global.` for project-level state where the project already does; use `globalvar` only for the established shared grids/input variables.
- Use `0` as the existing empty sentinel in `ds_grid` rows and equipment slots; use `undefined` or `noone` only where existing code expects them.
- Keep Chinese in-game text and comments consistent with nearby files. Do not rewrite wording unless the task is text/content work.
- Preserve existing formatting in touched files. This codebase uses mixed semicolon style and GML brace conventions; do not run broad formatters.

## Forbidden Changes

- Do not manually churn `.yy` files, `hgame.yyp`, or `hgame.resource_order` for normal logic edits.
- Do not invent GML functions, resource names, audio groups, sprites, object names, or scripts. Verify first with `rg` or official GameMaker docs.
- Do not use plugin-only APIs or deprecated APIs. Deprecated files here, such as `dis_scr_gamerule` and `dis_scr_item_script_execute`, are reference/legacy material, not patterns to revive.
- Do not broadly refactor the save system, inventory/equipment grids, character structs, `room_status`, or menu state machines without explicit user approval.
- Do not break these enum/grid contracts:
  - `DS_INVENTORY`: `NAME`, `AMOUNT`, `I_ID`
  - `DS_EQUIPMENT`: `NAME`, `AMOUNT`, `E_ID`, `CUR_DURABILITY`
  - `DS_SKILL`: `NAME`, `S_ID`, `SOURCE_COUNT`
  - `DS_SPELL`: `NAME`, `S_ID`, `ISENALBE`/`ISENABLE`
- Do not remove old-save compatibility checks from `load_chara()` or `obj_charsatus/Step_0.gml`.
- Do not change save JSON field names or grid widths unless also handling migration.

## Staged Resource Creation

When a new GMS2 script/object/resource is needed, do not directly register it as a real project resource unless explicitly approved.

Preferred workflow:

1. Create staged files using the prefix `NEW_`.
   - Example: `NEW_scr_potion_system.gml`
   - Example: `NEW_obj_potion_menu_Create_0.gml`
   - Example: `NEW_obj_potion_menu_Step_0.gml`

2. Do not modify:
   - `hgame.yyp`
   - `hgame.resource_order`
   - resource tree metadata

3. Tell the user what to create manually in GameMaker IDE.
   - Example: create a script named `scr_potion_system`
   - Example: create an object named `obj_potion_menu`
   - Example: add Create / Step / Draw GUI events as needed

4. After the user creates the resource in GameMaker IDE, move/copy the staged `NEW_` code into the corresponding `.gml` event/script file, or let the user do it own.

5. Remove the `NEW_` prefix only after the IDE-created resource exists.

6. Never treat `NEW_` files as runtime code. They are drafts/templates only.

## Encoding

All project text files are UTF-8 encoded.

Rules:
- Always read and write text files as UTF-8.
- Preserve Chinese comments, strings, dialogue, and UI text.
- If Chinese text appears garbled, assume the file was read with the wrong encoding and re-read it as UTF-8.
- Do not rewrite, normalize, or “repair” garbled text unless the user explicitly asks.
- Do not change line endings or file encoding during unrelated edits.

## Safe Edit Checklist

Before editing:

1. Identify the owning system and read its script plus the relevant object events.
2. Search every function/enum/global/grid column you plan to touch.
3. Check whether the target file participates in save/load or room instance creation.
4. If a `.yy` edit seems necessary, explain why and limit the diff to the exact metadata field.

While editing:

1. Prefer adding a small function, enum case, catalog case, or localized branch over changing shared flow.
2. Keep data shape stable. Extend structs additively and add fallback checks for old saves.
3. Use existing helpers: `load_chara`, `load_inventory`, `load_equipment`, `add_item_id`, `add_equipment_id`, `apply_effect_list`, `create_msg_box`, `scr_menu_movement_jump`.
4. Keep room state ids, item/equipment ids, and skill ids deterministic and documented near their cases.

After editing:

1. Run `rg -n` checks for typos in changed function, enum, and field names.
2. Review `git diff` and confirm no unintended `.yy`, asset, or generated metadata churn.
3. For save-related changes, reason through new game, old save load, save, reload, and empty-grid cases.
4. If GameMaker is not available for a full compile, state that limitation clearly in the final response.

## Skill Maintenance

This skill may be updated when the project architecture changes.

Rules:
- Do not weaken or remove safety rules without explicit user approval.
- Prefer appending new project facts over rewriting old sections.
- When code and this skill disagree, inspect the current code and report the mismatch before editing the skill.
- Mark uncertain observations as unconfirmed.
- Keep this skill focused on durable project conventions, not one-off task notes.