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

function battle_config_get(_config,_key,_default_value){
if !is_struct(_config) return _default_value;
if !variable_struct_exists(_config,_key) return _default_value;
return variable_struct_get(_config,_key);
}

function battle_current_exists(){
return variable_global_exists("battle_ctx") && is_struct(global.battle_ctx);
}

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
	battle_id			: battle_config_get(_config,"battle_id","normal_encounter"),
	layout_id			: battle_config_get(_config,"layout_id","default_4x8"),
	result				: BATTLE_RESULT.NONE
};
}

function battle_enemy_id(_enemy_id){
var _enemy_name = "史莱姆";
var _size = 1;
var _HP = 4;
var _HP_C = _HP;
var _AC = 8;
var _spd = 2;
var _spr = spr_slime;

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
	spr			: _spr
};
}

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

function battle_cell_inside(_state,_grid_x,_grid_y){
return _grid_x >= 0 && _grid_y >= 0 && _grid_x < _state.width && _grid_y < _state.height;
}

function battle_rect_inside(_state,_grid_x,_grid_y,_unit_size){
return battle_cell_inside(_state,_grid_x,_grid_y)
	&& battle_cell_inside(_state,_grid_x + _unit_size - 1,_grid_y + _unit_size - 1);
}

function battle_rects_overlap(_ax,_ay,_asize,_bx,_by,_bsize){
return !(_ax + _asize <= _bx || _bx + _bsize <= _ax || _ay + _asize <= _by || _by + _bsize <= _ay);
}

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

function battle_push_log(_state,_text){
array_push(_state.log,_text);
return _state;
}

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
	spr			: _chara.art,
	grid_x		: 0,
	grid_y		: 0,
	removed		: false,
	custom		: {}
};
}

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
	spr			: _enemy.spr,
	grid_x		: 0,
	grid_y		: 0,
	removed		: false,
	custom		: {}
};
}

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

function battle_start(_config){
global.battle_return_ctx = undefined;
global.battle_ctx = battle_context_make(_config);
global.battle_state = battle_make_default_state(global.battle_ctx,_config);
global.battle = true;
global.pause = true;
global.talking = false;
global.sub_menu = 0;

battle_freeze_explore_instances();
room_goto(room_BATTLE);
return true;
}

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

function battle_apply_result_to_source(_ctx,_result){
if _ctx.source_rs_id == "" return;

var _entry = room_status_get_entry(_ctx.source_room_id,_ctx.source_rs_id);
if _entry == undefined return;

switch(_result)
{
	case BATTLE_RESULT.WIN:
		_entry.removed = true;
		_entry.restore_position = false;
		global.battle_return_ctx = undefined;
		break;
	case BATTLE_RESULT.ESCAPE:
	case BATTLE_RESULT.LOSE:
	case BATTLE_RESULT.SCRIPT:
		_entry.restore_position = true;
		global.battle_return_ctx = {
			source_room_id				: _ctx.source_room_id,
			source_rs_id				: _ctx.source_rs_id,
			clear_restore_position		: true
		};
		break;
}

room_status_set_entry(_ctx.source_room_id,_ctx.source_rs_id,_entry);
}

function battle_apply_return_state_once(){
if !variable_global_exists("battle_return_ctx") return;
if !is_struct(global.battle_return_ctx) return;

var _return_ctx = global.battle_return_ctx;
if _return_ctx.source_room_id != global.roomid return;

if _return_ctx.source_rs_id != "" && _return_ctx.clear_restore_position
{
	room_status_current_set_restore_position(_return_ctx.source_rs_id,false);
}
global.battle_return_ctx = undefined;
}

function battle_finish(_result){
if !battle_current_exists() return false;

global.battle_ctx.result = _result;
var _return_room = global.battle_ctx.source_room;
battle_apply_result_to_source(global.battle_ctx,_result);

global.battle = false;
global.pause = false;
global.sub_menu = 0;
battle_restore_explore_instances();

global.battle_ctx = undefined;
global.battle_state = undefined;
room_goto(_return_room);
return true;
}
