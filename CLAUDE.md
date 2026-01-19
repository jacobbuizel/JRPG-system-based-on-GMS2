# GameMaker Studio 2 JRPG 项目分析

## 项目概述

**项目名称**: hgame (基于 GMS2 的 JRPG 系统)
**路径**: `E:/Files/Documents/pj/Roterground/GMS2/hgame`
**IDE 版本**: GameMaker Studio 2024.14.2.213

这是一个基于 GameMaker Studio 2 的 JRPG 游戏系统，目标是构建可复用、可拓展的 JRPG 框架。

### 游戏设计灵感
- **大地图探索**: 模仿《DELTARUNE》的大地图遇敌机制
- **战斗系统**: 计划引入类似《For The King II》、《Dungeons & Dragons》的战棋式回合制战斗

---

## 项目规模统计

| 资源类型 | 数量 |
|---------|------|
| 脚本 (.gml) | 33 个文件 |
| 对象事件 (.gml) | 106 个文件 |
| 精灵 (.yy) | 47 个 |
| 对象 (.yy) | 33 个 |
| 房间 (.yy) | 5 个 |
| 音频 (.ogg) | 35 个 |

---

## 目录结构

```
hgame/
├── datafiles/          # 数据文件
├── fonts/              # 字体资源
├── notes/              # 开发者笔记
├── objects/            # 游戏对象
│   ├── debug/          # 调试用对象
│   ├── item/           # 物品相关对象
│   ├── menu/           # 菜单系统对象
│   ├── npc/            # NPC相关对象
│   └── player/         # 玩家对象
├── options/            # 跨平台配置
├── rooms/              # 游戏房间
│   ├── room_TITLE/     # 标题画面
│   ├── room_TEST_1/    # 测试房间1
│   ├── room_TEST_2/    # 测试房间2
│   ├── room_CG/        # CG展示房间
│   └── room_game_over/ # 游戏结束房间
├── scripts/            # 脚本模块
│   ├── for_translate/  # 翻译相关
│   ├── msg/            # 消息系统
│   ├── npc_behavior/   # NPC行为AI
│   ├── player/         # 玩家相关
│   ├── rootscr/        # 核心脚本
│   ├── scr_equipment/  # 装备系统
│   ├── scr_character/  # 角色系统
│   └── scr_saving_system/ # 存档系统
├── sounds/             # 音频资源
├── sprites/            # 精灵资源
└── hgame.yyp           # 项目主文件
```

---

## 主要功能模块

### 1. 物品系统 (`scr_item`)
- 治疗药水 (ID 1.x) - 恢复 HP
- 魔晶 (ID 2.x) - 恢复 MP
- 材料、食品、杂物、重要物品
- 物品上限: 999个/种类

### 2. 装备系统 (`scr_equipment`)
**装备部位**:
- 0: 双手武器 | 1: 仅主手 | 2: 主手/副手 | 3: 护甲 | 4: 配饰 (A/B/C)

**核心功能**:
- `equipment_id()` - 获取装备定义
- `apply_equipment()` - 应用装备/计算属性
- `preview_slot_switch()` - 预览换装效果
- `calc_attr_delta()` - 计算属性差值

### 3. 角色系统 (`scr_character`)
**已定义角色**:
- **罗琳 (ID 1)**: 战士职业, 16/16/13 属性
- **丝诺 (ID 2)**: 法师职业, 高智力(16)和高敏捷(15)

**种族系统**: 人类、矮人、精灵、半身人、侏儒、半精灵、提夫林、怪物、亡灵等

**职业系统**: 野蛮人、吟游诗人、牧师、德鲁伊、战士、武僧、法师等

**属性系统**:
- 六大属性: str, dex, con, int, wis, cha
- AC = 10 + 敏捷修正 + 装备修正

### 4. 存档系统 (`scr_saving_system`)
- 保存内容: 游戏时间、物品栏、装备栏、角色状态、队伍数据
- 保存格式: JSON 文件 (`savedata*.sav`)

### 5. NPC 行为系统 (`scr_npc_behavior`)
- `0`: 待机 | `1`: 随机移动 | `2`: 对话 | `3`: 跟随 | `4`: 贴紧跟随 | `5`: 远离

### 6. 消息系统 (`scr_msg`)
- 支持对话框消息、选项、回调脚本
- 表情代码 (0-10): 普通、愤怒、哀伤、高兴、疑问、无语、大笑等

### 7. 战斗/掷骰系统 (`scr_dice`)
- `dice(num, dice)` - 掷骰 (如 2d6 返回 2-12)
- `d20c(advantage)` - d20 掷骰，支持优势/劣势

### 8. 菜单系统
- `obj_menu` - 主菜单控制器
- `obj_menu_backpack` - 物品栏
- `obj_menu_equipment` - 装备栏
- `obj_menu_charsatus` - 角色状态
- 动态显示装备差异预览

---

## 核心游戏对象

| 对象名 | 功能描述 |
|--------|----------|
| `obj_player` | 玩家角色，包含移动、交互、状态管理 |
| `obj_partner` | 伙伴NPC |
| `obj_npc` / `obj_npc_solid` | 普通NPC/实体NPC |
| `obj_hostile_npc` | 敌对NPC |
| `obj_item_p` / `obj_equip_p` | 地面物品/装备 |
| `obj_msgbox` | 消息对话框 |
| `obj_bgm` | BGM控制器 |
| `obj_control` | 全局控制器 |
| `obj_warp` | 传送门 |
| `obj_title_menu` | 标题菜单 |
| `obj_game_over` | 游戏结束画面 |

---

## 设计模式与技术特点

1. **状态机模式** - NPC 行为使用状态机管理
2. **数据驱动设计** - 物品/装备/角色数据使用结构体定义
3. **全局变量管理** - `obj_control` 初始化所有全局输入变量
4. **存档系统** - JSON 序列化，支持多存档位
5. **模块化架构** - 各系统独立封装

---

## 开发状态

### 已完成
- 菜单与UI系统 (物品栏、装备栏、状态菜单、保存界面)
- 物品与装备系统 (获取、丢弃、使用、数量上限)
- 存档系统
- 角色系统 (属性管理、动态队伍、负重计算)
- NPC AI 与交互
- 战斗过渡 BGM 无缝切换
- 时间系统
- DEBUG 调试功能 (F1 切换)

### 进行中 (WIP)
- 装备功能 (UI已完成，装备功能开发中)
- 战斗核心逻辑 (小型战棋式回合制框架)

### 未来计划
- 实装小型战棋式战斗系统
- 完善技能系统
- 更直观的UI动画与视觉表现

---

## 外部依赖

**无外部扩展库** - 本项目仅使用 GMS2 原生功能

**支持的平台**: Windows, HTML5, Android, iOS, macOS, Linux, tvOS, OperaGX

---

## 代码架构亮点

1. **属性差值计算** - 装备预览时动态计算属性变化
2. **多平台支持** - 配置了完整的跨平台选项
3. **音频组管理** - 分离 BGM/BGS/SFX/语音
4. **清晰的文件夹组织** - 资源分类明确
