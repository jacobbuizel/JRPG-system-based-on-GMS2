enum BATTLE_TEAM
{
	PLAYER,
	ENEMY,
	NEUTRAL
}

enum BATTLE_RESULT
{
	NONE,
	WIN,
	LOSE,
	ESCAPE,
	SCRIPT
}

enum BATTLE_OBJECT_TYPE
{
	OBSTACLE,
	ITEM,
	TERRAIN
}

// 从可选配置 struct 里安全取值；没有配置时使用默认值。
function battle_config_get(_config,_key,_default_value){
if !is_struct(_config) return _default_value;
if !variable_struct_exists(_config,_key) return _default_value;
return variable_struct_get(_config,_key);
}

// 当前是否处于一个有效的战斗上下文中。
function battle_current_exists(){
return variable_global_exists("battle_ctx") && is_struct(global.battle_ctx);
}

// 记录战斗来源。结束战斗时会靠它返回原房间并写回原房间状态。
function battle_context_make(_config){
var _source_player_x = 0;
var _source_player_y = 0;
var _source_partner_x = 0;
var _source_partner_y = 0;

if instance_exists(obj_player)
{
	_source_player_x = obj_player.x;
	_source_player_y = obj_player.y;
}
if instance_exists(obj_partner)
{
	_source_partner_x = obj_partner.x;
	_source_partner_y = obj_partner.y;
}

return {
	source_room			: battle_config_get(_config,"source_room",room),
	source_room_name	: room_get_name(room),
	source_room_id		: battle_config_get(_config,"source_room_id",global.roomid),
	source_rs_id		: battle_config_get(_config,"source_rs_id",""),
	source_player_x		: battle_config_get(_config,"source_player_x",_source_player_x),
	source_player_y		: battle_config_get(_config,"source_player_y",_source_player_y),
	source_partner_x	: battle_config_get(_config,"source_partner_x",_source_partner_x),
	source_partner_y	: battle_config_get(_config,"source_partner_y",_source_partner_y),
	return_entries		: battle_config_get(_config,"return_entries",[]),
	battle_id			: battle_config_get(_config,"battle_id","normal_encounter"),
	layout_id			: battle_config_get(_config,"layout_id","default_4x8"),
	result				: BATTLE_RESULT.NONE
};
}

// 临时敌人数据库。以后可以扩展成正式 enemy catalog。
function battle_enemy_id(_enemy_id){
var _enemy_name = "史莱姆";
var _size = 1;
var _HP = 4;
var _HP_C = _HP;
var _AC = 8;
var _spd = 2;
var _spr = spr_slime;
var _spr_walk = spr_slime_w;

switch(_enemy_id)
{
	default:
	case 0:
		break;
}

return {
	enemy_id	: _enemy_id,
	c_name		: _enemy_name,
	size		: _size,
	HP			: _HP,
	HP_C		: _HP_C,
	AC			: _AC,
	AC_C		: _AC,
	spd			: _spd,
	spr_idle	: _spr,
	spr_walk	: _spr_walk
};
}

// 创建一场战斗的运行时状态。这里的 units/objects 都是临时战场数据。
function battle_state_make(_ctx,_config){
return {
	width			: battle_config_get(_config,"width",8),
	height			: battle_config_get(_config,"height",4),
	turn_index		: 0,
	phase			: "setup",
	selected_unit	: "",
	units			: [],
	objects			: [],
	log				: [],
	layout_id		: _ctx.layout_id,
	battle_id		: _ctx.battle_id
};
}

// 单格是否在 4x8 棋盘内。
function battle_cell_inside(_state,_grid_x,_grid_y){
return _grid_x >= 0 && _grid_y >= 0 && _grid_x < _state.width && _grid_y < _state.height;
}

// 一个 size x size 的占格矩形是否完整落在棋盘内。
function battle_rect_inside(_state,_grid_x,_grid_y,_unit_size){
return battle_cell_inside(_state,_grid_x,_grid_y)
	&& battle_cell_inside(_state,_grid_x + _unit_size - 1,_grid_y + _unit_size - 1);
}

// 判断两个占格矩形是否重叠。角色、障碍物、道具占格都走这个规则。
function battle_rects_overlap(_ax,_ay,_asize,_bx,_by,_bsize){
return !(_ax + _asize <= _bx || _bx + _bsize <= _ax || _ay + _asize <= _by || _by + _bsize <= _ay);
}

// 检查某个占格位置是否可放置单位。
function battle_rect_is_free(_state,_grid_x,_grid_y,_unit_size,_ignore_unit_id){
if !battle_rect_inside(_state,_grid_x,_grid_y,_unit_size) return false;

for (var _i = 0; _i < array_length(_state.objects); _i++)
{
	var _obj = _state.objects[_i];
	if _obj.removed continue;
	if !_obj.blocking continue;
	var _obj_size = max(1,_obj.size);
	if battle_rects_overlap(_grid_x,_grid_y,_unit_size,_obj.grid_x,_obj.grid_y,_obj_size)
	{
		return false;
	}
}

for (var _u = 0; _u < array_length(_state.units); _u++)
{
	var _unit = _state.units[_u];
	if _unit.removed continue;
	if _unit.HP_C <= 0 continue;
	if _unit.unit_id == _ignore_unit_id continue;
	var _other_size = max(1,_unit.size);
	if battle_rects_overlap(_grid_x,_grid_y,_unit_size,_unit.grid_x,_unit.grid_y,_other_size)
	{
		return false;
	}
}
return true;
}

// 战斗日志暂时只保存在内存里，后面接行动系统时继续复用。
function battle_push_log(_state,_text){
array_push(_state.log,_text);
return _state;
}

// 玩家角色的战斗待机贴图。后面有 battle_idle 资源时主要改这里。
function battle_chara_idle_sprite(_chara_id){
switch(_chara_id)
{
	case 1:
		return spr_rowling;
	case 2:
		return spr_snow;
}
return spr_rowling;
}

// 玩家角色的战斗移动贴图。后面有 battle_walk 资源时主要改这里。
function battle_chara_walk_sprite(_chara_id){
switch(_chara_id)
{
	case 1:
		return spr_rowling_w;
	case 2:
		return spr_snow_w;
}
return spr_rowling_w;
}

// 把队伍里的角色 struct 转成战斗单位。不要直接改原角色数据。
function battle_make_party_unit(_chara_id,_unit_index){
var _chara = load_chara(_chara_id);
return {
	unit_id		: "party_" + string(_unit_index),
	source_type	: "chara",
	source_id	: _chara_id,
	team		: BATTLE_TEAM.PLAYER,
	c_name		: _chara.c_name,
	size		: clamp(floor(_chara.size),1,3),
	HP			: _chara.HP,
	HP_C		: _chara.HP_C,
	MP			: _chara.MP,
	MP_C		: _chara.MP_C,
	AC			: _chara.AC,
	AC_C		: _chara.AC_C,
	spd			: _chara.spd,
	spr_idle	: battle_chara_idle_sprite(_chara_id),
	spr_walk	: battle_chara_walk_sprite(_chara_id),
	grid_x		: 0,
	grid_y		: 0,
	removed		: false,
	custom		: {}
};
}

// 把敌人数据库条目转成战斗单位。
function battle_make_enemy_unit(_enemy_id,_unit_index){
var _enemy = battle_enemy_id(_enemy_id);
return {
	unit_id		: "enemy_" + string(_unit_index),
	source_type	: "enemy",
	source_id	: _enemy_id,
	team		: BATTLE_TEAM.ENEMY,
	c_name		: _enemy.c_name,
	size		: clamp(floor(_enemy.size),1,3),
	HP			: _enemy.HP,
	HP_C		: _enemy.HP_C,
	MP			: 0,
	MP_C		: 0,
	AC			: _enemy.AC,
	AC_C		: _enemy.AC_C,
	spd			: _enemy.spd,
	spr_idle	: _enemy.spr_idle,
	spr_walk	: _enemy.spr_walk,
	grid_x		: 0,
	grid_y		: 0,
	removed		: false,
	custom		: {}
};
}

// 按给定候选站位放置单位。默认站位满了时只写日志，不强行覆盖。
function battle_place_unit(_state,_unit,_positions){
for (var _i = 0; _i < array_length(_positions); _i++)
{
	var _pos = _positions[_i];
	if battle_rect_is_free(_state,_pos.grid_x,_pos.grid_y,_unit.size,_unit.unit_id)
	{
		_unit.grid_x = _pos.grid_x;
		_unit.grid_y = _pos.grid_y;
		array_push(_state.units,_unit);
		return _state;
	}
}

_state = battle_push_log(_state,_unit.c_name + " 没有可用站位。");
return _state;
}

// 往战场上放置障碍物、道具或特殊地形块。
function battle_add_object(_state,_object_id,_object_type,_grid_x,_grid_y,_object_size,_blocking,_custom){
array_push(_state.objects,{
	object_id	: _object_id,
	type		: _object_type,
	grid_x		: _grid_x,
	grid_y		: _grid_y,
	size		: clamp(floor(_object_size),1,3),
	blocking	: _blocking,
	removed		: false,
	custom		: _custom
});
return _state;
}

// 第一版默认战斗生成器：左 4x4 玩家，右 4x4 敌人。
function battle_make_default_state(_ctx,_config){
var _state = battle_state_make(_ctx,_config);

var _objects = battle_config_get(_config,"objects",[]);
for (var _o = 0; _o < array_length(_objects); _o++)
{
	var _obj = _objects[_o];
	_state = battle_add_object(
		_state,
		battle_config_get(_obj,"object_id","object_" + string(_o)),
		battle_config_get(_obj,"type",BATTLE_OBJECT_TYPE.OBSTACLE),
		battle_config_get(_obj,"grid_x",4),
		battle_config_get(_obj,"grid_y",1),
		battle_config_get(_obj,"size",1),
		battle_config_get(_obj,"blocking",true),
		battle_config_get(_obj,"custom",{})
	);
}

var _party_positions = battle_config_get(_config,"party_positions",[
	{grid_x:1,grid_y:2},
	{grid_x:1,grid_y:1},
	{grid_x:0,grid_y:2},
	{grid_x:0,grid_y:1}
]);
for (var _p = 0; _p < global.totalchara; _p++)
{
	var _party_unit = battle_make_party_unit(global.player[_p],_p);
	_state = battle_place_unit(_state,_party_unit,_party_positions);
}

var _enemy_ids = battle_config_get(_config,"enemy_ids",[0]);
var _enemy_positions = battle_config_get(_config,"enemy_positions",[
	{grid_x:6,grid_y:2},
	{grid_x:6,grid_y:1},
	{grid_x:5,grid_y:2},
	{grid_x:5,grid_y:1}
]);
for (var _e = 0; _e < array_length(_enemy_ids); _e++)
{
	var _enemy_unit = battle_make_enemy_unit(_enemy_ids[_e],_e);
	_state = battle_place_unit(_state,_enemy_unit,_enemy_positions);
}

_state.phase = "ready";
_state = battle_push_log(_state,"进入战斗。");
return _state;
}

// 进入战斗房间前隐藏探索用的 persistent 玩家/伙伴实例。
function battle_freeze_explore_instances(){
if instance_exists(obj_player)
{
	with(obj_player)
	{
		visible = false;
		vx = 0;
		vy = 0;
		vs = 0;
	}
}
if instance_exists(obj_partner)
{
	with(obj_partner)
	{
		visible = false;
		vx = 0;
		vy = 0;
		vs = 0;
	}
}
}

// 离开战斗房间时恢复探索用的 persistent 玩家/伙伴实例显示。
function battle_restore_explore_instances(){
if instance_exists(obj_player)
{
	with(obj_player)
	{
		visible = true;
	}
}
if instance_exists(obj_partner)
{
	with(obj_partner)
	{
		visible = true;
	}
}
}

// 把一个 NPC/敌对 NPC 的当前位置写入 room_status，并登记为本次战斗返回时需要恢复的位置。
function battle_preserve_return_instance(_entries,_inst,_type){
if !instance_exists(_inst) return _entries;
if !variable_instance_exists(_inst,"rs_id") return _entries;
room_status_autobind_instance(_inst,_type);
if _inst.rs_id == "" return _entries;

room_status_current_set_position(_inst.rs_id,_inst.x,_inst.y);
room_status_current_set_restore_position(_inst.rs_id,true);
array_push(_entries,{
	rs_id	: _inst.rs_id,
	cleared	: false
});
return _entries;
}

// 进入战斗前保存当前房间所有 NPC/敌对 NPC 的运行时位置，避免战斗返回后只有触发者被恢复。
function battle_preserve_current_room_npcs_for_return(){
var _entries = [];

for (var _npc_i = 0; _npc_i < instance_number(obj_npc); _npc_i++)
{
	_entries = battle_preserve_return_instance(_entries,instance_find(obj_npc,_npc_i),"npc");
}

for (var _hostile_i = 0; _hostile_i < instance_number(obj_hostile_npc); _hostile_i++)
{
	_entries = battle_preserve_return_instance(_entries,instance_find(obj_hostile_npc,_hostile_i),"hostile_npc");
}

return _entries;
}

// 战斗结束回到地图后，逐个实例清除临时 restore_position，避免影响之后普通的房间切换/刷新。
function battle_apply_return_state_for_entry(_state_id){
if !variable_global_exists("battle_return_ctx") return false;
if !is_struct(global.battle_return_ctx) return false;
if _state_id == "" return false;

var _return_ctx = global.battle_return_ctx;
if _return_ctx.source_room_id != global.roomid return false;

// 兼容旧的单目标返回上下文，方便测试存档或旧运行状态不直接报错。
if variable_struct_exists(_return_ctx,"source_rs_id")
{
	if _return_ctx.source_rs_id == _state_id
	{
		room_status_current_set_restore_position(_state_id,false);
		global.battle_return_ctx = undefined;
		return true;
	}
	return false;
}

if !variable_struct_exists(_return_ctx,"return_entries") return false;

var _entries = _return_ctx.return_entries;
var _did_apply = false;
var _all_cleared = true;
for (var _i = 0; _i < array_length(_entries); _i++)
{
	var _entry = _entries[_i];
	if !_entry.cleared && _entry.rs_id == _state_id
	{
		room_status_current_set_restore_position(_state_id,false);
		_entry.cleared = true;
		_entries[_i] = _entry;
		_did_apply = true;
	}
	if !_entry.cleared
	{
		_all_cleared = false;
	}
}

_return_ctx.return_entries = _entries;
if _all_cleared
{
	global.battle_return_ctx = undefined;
}
else
{
	global.battle_return_ctx = _return_ctx;
}
return _did_apply;
}

// 根据战斗结果生成本次返回地图时需要逐个清理的位置恢复列表。
function battle_prepare_return_context(_ctx,_result){
var _entries = [];
if variable_struct_exists(_ctx,"return_entries")
{
	for (var _i = 0; _i < array_length(_ctx.return_entries); _i++)
	{
		var _entry = _ctx.return_entries[_i];
		if _result == BATTLE_RESULT.WIN && _entry.rs_id == _ctx.source_rs_id
		{
			continue;
		}
		array_push(_entries,{
			rs_id	: _entry.rs_id,
			cleared	: false
		});
	}
}

if array_length(_entries) > 0
{
	global.battle_return_ctx = {
		source_room_id	: _ctx.source_room_id,
		return_entries	: _entries
	};
}
else
{
	global.battle_return_ctx = undefined;
}
}

// 通用开战入口。剧情战、Boss 战和普通敌人接触战都应该最终调用这里。
function battle_start(_config){
global.battle_return_ctx = undefined;
var _battle_config = _config;
if !is_struct(_battle_config)
{
	_battle_config = {};
}
if !variable_struct_exists(_battle_config,"return_entries")
{
	_battle_config.return_entries = battle_preserve_current_room_npcs_for_return();
}
global.battle_ctx = battle_context_make(_battle_config);
global.battle_state = battle_make_default_state(global.battle_ctx,_battle_config);
global.battle = true;
global.pause = true;
global.talking = false;
global.sub_menu = 0;

battle_freeze_explore_instances();
room_goto(room_BATTLE);
return true;
}

// 普通敌对 NPC 接触开战入口。这里负责记录原敌人的 rs_id 和返回坐标。
function battle_start_from_hostile(_hostile_inst){
if !instance_exists(_hostile_inst) return false;

var _battle_id = "normal_hostile";
var _layout_id = "default_4x8";
if argument_count > 1 _battle_id = argument[1];
if argument_count > 2 _layout_id = argument[2];

var _source_rs_id = _hostile_inst.rs_id;
if _source_rs_id != ""
{
	room_status_current_set_position(_source_rs_id,_hostile_inst.x,_hostile_inst.y);
	room_status_current_set_restore_position(_source_rs_id,true);
}

return battle_start({
	source_room		: room,
	source_room_id	: global.roomid,
	source_rs_id	: _source_rs_id,
	battle_id		: _battle_id,
	layout_id		: _layout_id,
	enemy_ids		: [0]
});
}

// 把战斗结果写回来源房间的 room_status。
function battle_apply_result_to_source(_ctx,_result){
if _ctx.source_rs_id != ""
{
	var _entry = room_status_get_entry(_ctx.source_room_id,_ctx.source_rs_id);
	if _entry != undefined
	{
		switch(_result)
		{
			case BATTLE_RESULT.WIN:
				_entry.removed = true;
				_entry.restore_position = false;
				break;
			case BATTLE_RESULT.ESCAPE:
			case BATTLE_RESULT.LOSE:
			case BATTLE_RESULT.SCRIPT:
				_entry.restore_position = true;
				break;
		}
		room_status_set_entry(_ctx.source_room_id,_ctx.source_rs_id,_entry);
	}
}

battle_prepare_return_context(_ctx,_result);
}

// 逃跑/剧情返回后，原房间实例重新应用状态时清理一次性 restore_position。
function battle_apply_return_state_once(){
if !variable_global_exists("battle_return_ctx") return false;
if !is_struct(global.battle_return_ctx) return false;
if !variable_struct_exists(global.battle_return_ctx,"source_rs_id") return false;
return battle_apply_return_state_for_entry(global.battle_return_ctx.source_rs_id);
}

// 通用结束战斗入口。当前测试阶段 Z=胜利，X=逃跑。
function battle_finish(_result){
if !battle_current_exists() return false;

global.battle_ctx.result = _result;
var _return_room = global.battle_ctx.source_room;
battle_apply_result_to_source(global.battle_ctx,_result);

global.battle_touch_cooldown = 60;
global.battle = false;
global.pause = false;
global.sub_menu = 0;
battle_restore_explore_instances();

global.battle_ctx = undefined;
global.battle_state = undefined;
room_goto(_return_room);
return true;
}
