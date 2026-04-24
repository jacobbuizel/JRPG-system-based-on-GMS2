function reroomsatus(){
// 房间状态注册表。
// 每个房间保存自己的实例列表和房间级 custom 数据；实例用 rs_id 作为稳定键。
// type 当前使用："item"、"equipment"、"npc"、"hostile_npc"。

globalvar room_status;
room_status = {
	// 数据结构版本号。以后如果存档格式升级，可用它做兼容判断。
	version : 2,
	// 房间状态数组。每个元素由 room_status_make_room() 创建。
	rooms : []
};

room_status_define_defaults();
}

function room_status_make_room(_room_id,_room_name){
return {
	room_id : _room_id,
	room_name : _room_name,
	room_data : {},
	instances : []
};
}

function room_status_make_entry(_state_id,_type,_content_id,_amount,_restorable){
return {
	rs_id : _state_id,
	type : _type,
	content_id : _content_id,
	amount : _amount,
	restorable : clamp(_restorable,0,20),
	removed : false,
	default_x : 0,
	default_y : 0,
	has_default_position : false,
	x : 0,
	y : 0,
	has_position : false,
	restore_position : false,
	npc_default_behavior : 1,
	npc_default_behavior_a : 4,
	npc_behavior : 1,
	msg_id : "",
	follow_timer : 0,
	custom : {}
};
}

function room_status_find_room_index(_room_id){
if !is_struct(room_status) return -1;
for (var _i = 0; _i < array_length(room_status.rooms); _i++)
{
	if room_status.rooms[_i].room_id == _room_id
	{
		return _i;
	}
}
return -1;
}

function room_status_find_entry_index(_room_index,_state_id){
if _room_index < 0 return -1;
var _room_data = room_status.rooms[_room_index];
for (var _i = 0; _i < array_length(_room_data.instances); _i++)
{
	if _room_data.instances[_i].rs_id == _state_id
	{
		return _i;
	}
}
return -1;
}

function room_status_define_room(_room_id,_room_name){
if room_status_find_room_index(_room_id) >= 0 return;
array_push(room_status.rooms,room_status_make_room(_room_id,_room_name));
}

function room_status_define_entry(_room_id,_entry){
var _room_index = room_status_find_room_index(_room_id);
if _room_index < 0 return;

var _room_data = room_status.rooms[_room_index];
var _entry_index = room_status_find_entry_index(_room_index,_entry.rs_id);
if _entry_index >= 0
{
	_room_data.instances[_entry_index] = _entry;
}
else
{
	array_push(_room_data.instances,_entry);
}
room_status.rooms[_room_index] = _room_data;
}

function room_status_define_item(_room_id,_state_id,_item_id,_amount,_restorable){
room_status_define_entry(_room_id,room_status_make_entry(_state_id,"item",_item_id,_amount,_restorable));
}

function room_status_define_equipment(_room_id,_state_id,_equipment_id,_amount,_restorable){
room_status_define_entry(_room_id,room_status_make_entry(_state_id,"equipment",_equipment_id,_amount,_restorable));
}

function room_status_define_npc(_room_id,_state_id,_npc_default_behavior,_msg_id,_restorable){
var _entry = room_status_make_entry(_state_id,"npc",0,1,_restorable);
_entry.npc_default_behavior = _npc_default_behavior;
_entry.npc_behavior = _npc_default_behavior;
_entry.msg_id = _msg_id;
room_status_define_entry(_room_id,_entry);
}

function room_status_define_hostile_npc(_room_id,_state_id,_npc_default_behavior,_npc_default_behavior_a,_restorable,_default_x,_default_y){
var _entry = room_status_make_entry(_state_id,"hostile_npc",0,1,_restorable);
_entry.npc_default_behavior = _npc_default_behavior;
_entry.npc_default_behavior_a = _npc_default_behavior_a;
_entry.npc_behavior = _npc_default_behavior;
_entry.default_x = _default_x;
_entry.default_y = _default_y;
_entry.has_default_position = true;
_entry.x = _default_x;
_entry.y = _default_y;
_entry.has_position = true;
room_status_define_entry(_room_id,_entry);
}

function room_status_define_defaults(){
// 测试房间 1
room_status_define_room(0,"room_TEST_1");
room_status_define_npc(0,"inst_test_1_npc_1",1,"test_npc_1",0);
room_status_define_npc(0,"inst_test_1_npc_2",1,"test_npc_2",0);
room_status_define_npc(0,"inst_test_1_npc_3",1,"test_npc_3",0);
room_status_define_npc(0,"inst_test_1_npc_4",1,"test_npc_4",0);
room_status_define_npc(0,"inst_test_1_npc_6",0,"test_npc_6",0);
room_status_define_hostile_npc(0,"inst_test_1_hostile_npc_1",1,5,20,720,944);
room_status_define_item(0,"inst_test_1_item_1",0.2,1,0);
room_status_define_item(0,"inst_test_1_item_2",1,500,20);
room_status_define_item(0,"inst_test_1_item_3",1,1000,20);
room_status_define_equipment(0,"inst_test_1_item_4",0,1,20);
room_status_define_equipment(0,"inst_test_1_item_5",1,1,20);
room_status_define_equipment(0,"inst_test_1_item_6",10,1,20);
room_status_define_equipment(0,"inst_test_1_item_7",100,1,20);
room_status_define_equipment(0,"inst_test_1_item_8",120,1,20);
room_status_define_equipment(0,"inst_test_1_item_9",1000,1,20);
room_status_define_equipment(0,"inst_test_1_item_10",1001,1,20);

// 测试房间 2
room_status_define_room(1,"room_TEST_2");
room_status_define_npc(1,"inst_test_2_npc_5",0,"test_npc_5",0);
room_status_define_hostile_npc(1,"inst_test_2_hostile_npc_1",1,4,20,1088,352);
room_status_define_hostile_npc(1,"inst_test_2_hostile_npc_2",1,4,20,976,848);
room_status_define_hostile_npc(1,"inst_test_2_hostile_npc_3",1,4,20,1680,848);
room_status_define_hostile_npc(1,"inst_test_2_hostile_npc_4",1,4,20,1600,688);
room_status_define_hostile_npc(1,"inst_test_2_hostile_npc_5",1,4,20,1552,96);
room_status_define_item(1,"inst_test_2_item_2",1,1,20);
room_status_define_item(1,"inst_test_2_item_3",1.1,1,15);
room_status_define_item(1,"inst_test_2_item_4",1.2,1,10);
room_status_define_item(1,"inst_test_2_item_5",1.3,1,10);
room_status_define_item(1,"inst_test_2_item_6",2,1,5);
room_status_define_item(1,"inst_test_2_item_7",2.1,1,5);
room_status_define_item(1,"inst_test_2_item_8",2.2,1,0);
room_status_define_item(1,"inst_test_2_item_9",2.3,1,0);
room_status_define_item(1,"inst_test_2_item_10",0,1,0);
room_status_define_item(1,"inst_test_2_item_11",2.4,1,0);
room_status_define_item(1,"inst_test_2_item_12",2.5,1,10);
room_status_define_item(1,"inst_test_2_item_13",2.6,1,10);
room_status_define_item(1,"inst_test_2_item_14",2.7,1,10);
room_status_define_item(1,"inst_test_2_item_15",2.8,1,10);
room_status_define_item(1,"inst_test_2_item_16",4,1,10);
room_status_define_item(1,"inst_test_2_item_17",4,1,10);
room_status_define_item(1,"inst_test_2_item_18",4,1,10);
room_status_define_item(1,"inst_test_2_item_19",4,1,10);
room_status_define_item(1,"inst_test_2_item_20",4,1,10);
room_status_define_item(1,"inst_test_2_item_21",4,1,10);
room_status_define_item(1,"inst_test_2_item_22",4,1,10);
room_status_define_item(1,"inst_test_2_item_23",5,1,10);
room_status_define_item(1,"inst_test_2_item_24",6,1,10);
room_status_define_item(1,"inst_test_2_item_25",7,1,10);
room_status_define_item(1,"inst_test_2_item_26",8,1,0);
room_status_define_item(1,"inst_test_2_item_27",3,1,0);
room_status_define_item(1,"inst_test_2_item_28",0.1,1,0);
}

function room_status_get_entry(_room_id,_state_id){
var _room_index = room_status_find_room_index(_room_id);
var _entry_index = room_status_find_entry_index(_room_index,_state_id);
if _entry_index < 0 return undefined;
return room_status.rooms[_room_index].instances[_entry_index];
}

function room_status_set_entry(_room_id,_state_id,_entry){
var _room_index = room_status_find_room_index(_room_id);
var _entry_index = room_status_find_entry_index(_room_index,_state_id);
if _entry_index < 0 return false;

var _room_data = room_status.rooms[_room_index];
_room_data.instances[_entry_index] = _entry;
room_status.rooms[_room_index] = _room_data;
return true;
}

function room_status_current_room_id(){
return global.roomid;
}

function room_status_autobind_instance(_inst,_type){
if _inst.rs_id != "" return;

var _room_index = room_status_find_room_index(room_status_current_room_id());
if _room_index < 0 return;

var _room_data = room_status.rooms[_room_index];
for (var _i = 0; _i < array_length(_room_data.instances); _i++)
{
	var _entry = _room_data.instances[_i];
	if _entry.type == _type && _entry.has_default_position
	{
		if _entry.default_x == _inst.x && _entry.default_y == _inst.y
		{
			_inst.rs_id = _entry.rs_id;
			return;
		}
	}
}
}

function room_status_capture_position(_entry,_inst){
if !_entry.has_default_position
{
	_entry.default_x = _inst.x;
	_entry.default_y = _inst.y;
	_entry.has_default_position = true;
}
_entry.x = _inst.x;
_entry.y = _inst.y;
_entry.has_position = true;
return _entry;
}

function room_status_apply_position(_entry,_inst){
// 普通地图进出默认重置到房间摆放位置；需要战斗返回原位时，把 restore_position 设为 true。
if _entry.restore_position && _entry.has_position
{
	_inst.x = _entry.x;
	_inst.y = _entry.y;
}
}

function room_status_ensure_pickup_entry(_inst,_type){
if _inst.rs_id == "" return undefined;

var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_inst.rs_id);
if _entry == undefined
{
	var _content_id = 0;
	if _type == "item"
	{
		_content_id = _inst.inventory_id.i_id;
	}
	else
	{
		_content_id = _inst.equip_id.e_id;
	}
	_entry = room_status_make_entry(_inst.rs_id,_type,_content_id,_inst.amount,_inst.rs_restorable);
	room_status_define_entry(_room_id,_entry);
}
_entry = room_status_capture_position(_entry,_inst);
room_status_set_entry(_room_id,_inst.rs_id,_entry);
return _entry;
}

function room_status_apply_pickup_state(_inst,_type){
room_status_autobind_instance(_inst,_type);
var _entry = room_status_ensure_pickup_entry(_inst,_type);
if _entry == undefined return true;

if _entry.removed return false;

if _type == "item"
{
	_inst.inventory_id = item_id(_entry.content_id);
}
else
{
	_inst.equip_id = equipment_id(_entry.content_id);
}
_inst.amount = _entry.amount;
_inst.rs_restorable = _entry.restorable;
room_status_apply_position(_entry,_inst);
return true;
}

function room_status_capture_pickup_state(_inst,_type){
if _inst.rs_id == "" return;

var _entry = room_status_ensure_pickup_entry(_inst,_type);
if _entry == undefined return;

if _type == "item"
{
	_entry.content_id = _inst.inventory_id.i_id;
}
else
{
	_entry.content_id = _inst.equip_id.e_id;
}
_entry.amount = _inst.amount;
_entry.restorable = clamp(_inst.rs_restorable,0,20);
_entry = room_status_capture_position(_entry,_inst);
room_status_set_entry(room_status_current_room_id(),_inst.rs_id,_entry);
}

function room_status_apply_npc_state(_inst,_type){
room_status_autobind_instance(_inst,_type);
if _inst.rs_id == "" return true;

var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_inst.rs_id);
if _entry == undefined
{
	_entry = room_status_make_entry(_inst.rs_id,_type,0,1,_inst.rs_restorable);
	_entry.npc_default_behavior = _inst.npc_default_behavior;
	_entry.npc_behavior = _inst.npc_behavior;
	if _type == "hostile_npc"
	{
		_entry.npc_default_behavior_a = _inst.npc_default_behavior_a;
		_entry.follow_timer = _inst.follow_timer;
	}
	else
	{
		_entry.msg_id = _inst.msg_id;
	}
	room_status_define_entry(_room_id,_entry);
}

if _entry.removed return false;

_inst.npc_default_behavior = _entry.npc_default_behavior;
_inst.npc_behavior = _entry.npc_behavior;
if _type == "hostile_npc"
{
	_inst.npc_default_behavior_a = _entry.npc_default_behavior_a;
	_inst.follow_timer = _entry.follow_timer;
}
else
{
	_inst.msg_id = _entry.msg_id;
}
room_status_apply_position(_entry,_inst);
_entry = room_status_capture_position(_entry,_inst);
room_status_set_entry(_room_id,_inst.rs_id,_entry);
return true;
}

function room_status_capture_npc_state(_inst,_type){
if _inst.rs_id == "" return;

var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_inst.rs_id);
if _entry == undefined return;

_entry.npc_default_behavior = _inst.npc_default_behavior;
_entry.npc_behavior = _inst.npc_behavior;
if _type == "hostile_npc"
{
	_entry.npc_default_behavior_a = _inst.npc_default_behavior_a;
	_entry.follow_timer = _inst.follow_timer;
}
else
{
	_entry.msg_id = _inst.msg_id;
}
_entry = room_status_capture_position(_entry,_inst);
room_status_set_entry(_room_id,_inst.rs_id,_entry);
}

function room_status_current_set_removed(_state_id,_removed){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.removed = _removed;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_msg(_state_id,_msg_id){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.msg_id = _msg_id;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_position(_state_id,_new_x,_new_y){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.x = _new_x;
_entry.y = _new_y;
_entry.has_position = true;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_restore_position(_state_id,_restore_position){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.restore_position = _restore_position;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_custom(_state_id,_key,_value){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
if !is_struct(_entry.custom)
{
	_entry.custom = {};
}
variable_struct_set(_entry.custom,_key,_value);
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_get_custom(_state_id,_key,_default_value){
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return _default_value;
if !is_struct(_entry.custom) return _default_value;
if !variable_struct_exists(_entry.custom,_key) return _default_value;
return variable_struct_get(_entry.custom,_key);
}

function room_status_current_set_room_custom(_key,_value){
var _room_index = room_status_find_room_index(room_status_current_room_id());
if _room_index < 0 return false;

var _room_data = room_status.rooms[_room_index];
if !is_struct(_room_data.room_data)
{
	_room_data.room_data = {};
}
variable_struct_set(_room_data.room_data,_key,_value);
room_status.rooms[_room_index] = _room_data;
return true;
}

function room_status_current_get_room_custom(_key,_default_value){
var _room_index = room_status_find_room_index(room_status_current_room_id());
if _room_index < 0 return _default_value;

var _room_data = room_status.rooms[_room_index];
if !is_struct(_room_data.room_data) return _default_value;
if !variable_struct_exists(_room_data.room_data,_key) return _default_value;
return variable_struct_get(_room_data.room_data,_key);
}

function room_status_restore_entry(_room_id,_state_id){
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return;
if _entry.restorable <= 0 return;

if _entry.restorable == 20 || irandom_range(1,20) <= _entry.restorable
{
	_entry.removed = false;
	_entry.x = _entry.default_x;
	_entry.y = _entry.default_y;
	_entry.has_position = _entry.has_default_position;
	_entry.npc_behavior = _entry.npc_default_behavior;
	_entry.follow_timer = 0;
	room_status_set_entry(_room_id,_state_id,_entry);
}
}

function room_status_restore_room(_room_id){
var _room_index = room_status_find_room_index(_room_id);
if _room_index < 0 return;

var _room_data = room_status.rooms[_room_index];
for (var _i = 0; _i < array_length(_room_data.instances); _i++)
{
	room_status_restore_entry(_room_id,_room_data.instances[_i].rs_id);
}
}

function restor_roomsatus(_room_id){
// 旧入口保留给休息菜单和调试键使用。
if _room_id >= 0
{
	room_status_restore_room(_room_id);
}
else if _room_id == -1
{
	for (var _i = 0; _i < array_length(room_status.rooms); _i++)
	{
		room_status_restore_room(room_status.rooms[_i].room_id);
	}
}
}

function room_status_copy_field(_target,_source,_field_name){
if variable_struct_exists(_source,_field_name)
{
	variable_struct_set(_target,_field_name,variable_struct_get(_source,_field_name));
}
return _target;
}

function room_status_merge_entry(_target,_source){
var _fields = [
	"type","content_id","amount","restorable","removed",
	"default_x","default_y","has_default_position",
	"x","y","has_position","restore_position",
	"npc_default_behavior","npc_default_behavior_a","npc_behavior",
	"msg_id","follow_timer","custom"
];
for (var _i = 0; _i < array_length(_fields); _i++)
{
	_target = room_status_copy_field(_target,_source,_fields[_i]);
}
return _target;
}

function room_status_load_legacy_slot(_legacy_grid,_room_id,_slot,_state_id,_done_msg){
var _state_row = _room_id*2;
var _restore_row = _state_row+1;
if _state_row >= ds_grid_height(_legacy_grid) return;
if _slot >= ds_grid_width(_legacy_grid) return;

var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return;

var _old_state = ds_grid_get(_legacy_grid,_slot,_state_row);
if _restore_row < ds_grid_height(_legacy_grid)
{
	_entry.restorable = ds_grid_get(_legacy_grid,_slot,_restore_row);
}

if _entry.type == "npc"
{
	if _old_state != 0 && _done_msg != ""
	{
		_entry.msg_id = _done_msg;
		variable_struct_set(_entry.custom,"talked",true);
	}
}
else
{
	_entry.removed = (_old_state == 1);
}

room_status_set_entry(_room_id,_state_id,_entry);
}

function room_status_load_legacy_grid(_save_status){
var _legacy_grid = ds_grid_create(1,1);
ds_grid_read(_legacy_grid,_save_status);

room_status_load_legacy_slot(_legacy_grid,0,1,"inst_test_1_npc_6","test_npc_6-1");
room_status_load_legacy_slot(_legacy_grid,0,2,"inst_test_1_item_1","");
room_status_load_legacy_slot(_legacy_grid,0,3,"inst_test_1_item_2","");
room_status_load_legacy_slot(_legacy_grid,0,4,"inst_test_1_item_3","");
room_status_load_legacy_slot(_legacy_grid,0,5,"inst_test_1_item_4","");
room_status_load_legacy_slot(_legacy_grid,0,6,"inst_test_1_item_5","");
room_status_load_legacy_slot(_legacy_grid,0,7,"inst_test_1_item_6","");
room_status_load_legacy_slot(_legacy_grid,0,8,"inst_test_1_item_7","");
room_status_load_legacy_slot(_legacy_grid,0,9,"inst_test_1_item_8","");
room_status_load_legacy_slot(_legacy_grid,0,10,"inst_test_1_item_9","");
room_status_load_legacy_slot(_legacy_grid,0,11,"inst_test_1_item_10","");

room_status_load_legacy_slot(_legacy_grid,1,1,"inst_test_2_npc_5","test_npc_5-1");
room_status_load_legacy_slot(_legacy_grid,1,2,"inst_test_2_item_2","");
room_status_load_legacy_slot(_legacy_grid,1,3,"inst_test_2_item_3","");
room_status_load_legacy_slot(_legacy_grid,1,4,"inst_test_2_item_4","");
room_status_load_legacy_slot(_legacy_grid,1,5,"inst_test_2_item_5","");
room_status_load_legacy_slot(_legacy_grid,1,6,"inst_test_2_item_6","");
room_status_load_legacy_slot(_legacy_grid,1,7,"inst_test_2_item_7","");
room_status_load_legacy_slot(_legacy_grid,1,8,"inst_test_2_item_8","");
room_status_load_legacy_slot(_legacy_grid,1,9,"inst_test_2_item_9","");
room_status_load_legacy_slot(_legacy_grid,1,10,"inst_test_2_item_10","");
room_status_load_legacy_slot(_legacy_grid,1,11,"inst_test_2_item_11","");
room_status_load_legacy_slot(_legacy_grid,1,12,"inst_test_2_item_12","");
room_status_load_legacy_slot(_legacy_grid,1,13,"inst_test_2_item_13","");
room_status_load_legacy_slot(_legacy_grid,1,14,"inst_test_2_item_14","");
room_status_load_legacy_slot(_legacy_grid,1,15,"inst_test_2_item_15","");
room_status_load_legacy_slot(_legacy_grid,1,16,"inst_test_2_item_16","");
room_status_load_legacy_slot(_legacy_grid,1,17,"inst_test_2_item_17","");
room_status_load_legacy_slot(_legacy_grid,1,18,"inst_test_2_item_18","");
room_status_load_legacy_slot(_legacy_grid,1,19,"inst_test_2_item_19","");
room_status_load_legacy_slot(_legacy_grid,1,20,"inst_test_2_item_20","");
room_status_load_legacy_slot(_legacy_grid,1,21,"inst_test_2_item_21","");
room_status_load_legacy_slot(_legacy_grid,1,22,"inst_test_2_item_22","");
room_status_load_legacy_slot(_legacy_grid,1,23,"inst_test_2_item_23","");
room_status_load_legacy_slot(_legacy_grid,1,24,"inst_test_2_item_24","");
room_status_load_legacy_slot(_legacy_grid,1,25,"inst_test_2_item_25","");
room_status_load_legacy_slot(_legacy_grid,1,26,"inst_test_2_item_26","");
room_status_load_legacy_slot(_legacy_grid,1,27,"inst_test_2_item_27","");
room_status_load_legacy_slot(_legacy_grid,1,28,"inst_test_2_item_28","");

ds_grid_destroy(_legacy_grid);
}

function room_status_load_data(_save_status){
if is_string(_save_status)
{
	room_status_load_legacy_grid(_save_status);
	return;
}
if !is_struct(_save_status) return;
if !variable_struct_exists(_save_status,"rooms") return;

var _save_rooms = _save_status.rooms;
for (var _r = 0; _r < array_length(_save_rooms); _r++)
{
	var _save_room = _save_rooms[_r];
	if !is_struct(_save_room) continue;
	if !variable_struct_exists(_save_room,"room_id") continue;

	var _room_index = room_status_find_room_index(_save_room.room_id);
	if _room_index < 0
	{
		var _room_name = "";
		if variable_struct_exists(_save_room,"room_name")
		{
			_room_name = _save_room.room_name;
		}
		room_status_define_room(_save_room.room_id,_room_name);
		_room_index = room_status_find_room_index(_save_room.room_id);
	}

	var _room_data = room_status.rooms[_room_index];
	if variable_struct_exists(_save_room,"room_data")
	{
		_room_data.room_data = _save_room.room_data;
	}

	if variable_struct_exists(_save_room,"instances")
	{
		var _save_instances = _save_room.instances;
		for (var _i = 0; _i < array_length(_save_instances); _i++)
		{
			var _save_entry = _save_instances[_i];
			if !is_struct(_save_entry) continue;
			if !variable_struct_exists(_save_entry,"rs_id") continue;

			var _entry_index = room_status_find_entry_index(_room_index,_save_entry.rs_id);
			if _entry_index >= 0
			{
				_room_data.instances[_entry_index] = room_status_merge_entry(_room_data.instances[_entry_index],_save_entry);
			}
			else
			{
				array_push(_room_data.instances,_save_entry);
			}
		}
	}
	room_status.rooms[_room_index] = _room_data;
}
}

function room_status_save_data(){
return variable_clone(room_status);
}
