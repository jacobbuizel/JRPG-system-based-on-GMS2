function reroomsatus(){
// 房间状态注册表。
// 每个房间保存自己的实例列表和房间级 custom 数据；实例用 rs_id 作为稳定键。
// type 当前使用："item"、"equipment"、"npc"、"hostile_npc"。
// 使用流程：
// 1. 新游戏或读档前先调用 reroomsatus() 创建一份“默认世界状态”。
// 2. 读档时用 room_status_load_data() 把存档里的变化覆盖到默认状态上。
// 3. 房间实例在 Step 中调用 apply/capture 系列函数，把实例变量和 room_status 同步。
// 这样以后新增房间物品/NPC 时，只需要增加默认注册和实例 rs_id，不需要维护二维表列号。

globalvar room_status;
room_status = {
	version : 2,	// 数据结构版本号。以后如果存档格式升级，可用它做兼容判断。
	rooms : []		// 房间状态数组。每个元素由 room_status_make_room() 创建。
};

room_status_define_defaults();
}

function room_status_make_room(_room_id,_room_name){
// 创建一个房间状态容器。
// room_data 用来放“房间自身”的状态，比如机关开关、门锁、环境阶段等。
// instances 用来放这个房间内具体实例的状态，比如物品、NPC、小怪。
return {
	room_id : _room_id,
	room_name : _room_name,
	room_data : {},
	instances : []
};
}

function room_status_make_entry(_state_id,_type,_content_id,_amount,_restorable){
// 创建一个实例状态。
// _state_id：稳定 ID，建议跟房间实例命名规则一致，例如 inst_test_1_item_2。
// _type：实例类别，决定 apply/capture 时读写哪些字段。
// _content_id：物品/装备的 catalog id；NPC 暂时为 0。
// _amount：物品/装备数量；NPC 暂时为 1。
// _restorable：刷新概率，0 不刷新，20 必定刷新，中间值按 1d20 判定。
return {
	rs_id : _state_id,					// 稳定键，存档和 Creation Code 都靠它找同一个状态。
	type : _type,						// item/equipment/npc/hostile_npc。
	content_id : _content_id,			// 物品 id 或装备 id。
	amount : _amount,					// 堆叠数量。
	restorable : clamp(_restorable,0,20),// 休息刷新概率，范围固定为 0..20。
	removed : false,					// true 表示实例已经被拾取、摧毁、离场等。
	default_x : 0,						// 房间编辑器中的默认位置 x。
	default_y : 0,						// 房间编辑器中的默认位置 y。
	has_default_position : false,		// 是否已经记录过默认位置。
	x : 0,								// 运行时记录位置 x。
	y : 0,								// 运行时记录位置 y。
	has_position : false,				// 是否已经记录过运行时位置。
	restore_position : false,			// 是否在进入房间时恢复运行时位置；默认 false，避免普通进出地图时 NPC 留在随机走动后的位置。
	npc_default_behavior : 1,			// NPC 默认 AI 行为。
	npc_default_behavior_a : 4,			// 敌对 NPC 感知/追击行为。
	npc_behavior : 1,					// NPC 当前行为。
	msg_id : "",						// 普通 NPC 当前对话文本 id。
	follow_timer : 0,					// 敌对 NPC 追踪计时。
	custom : {}							// 扩展字段。复杂剧情变量优先放这里，不要为每个需求加新列。
};
}

function room_status_find_room_index(_room_id){
// 按 room_id 找房间在 room_status.rooms 里的数组下标。
// 返回 -1 表示没有注册该房间。
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
// 在某个已注册房间内，按 rs_id 查找实例状态。
// 注意这里传入的是 room 数组下标，不是 room_id。
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
// 注册房间。如果已经注册过，就不重复创建，避免默认表里出现两个同 ID 房间。
if room_status_find_room_index(_room_id) >= 0 return;
array_push(room_status.rooms,room_status_make_room(_room_id,_room_name));
}

function room_status_define_entry(_room_id,_entry){
// 注册或替换一个实例状态。
// 这个函数只操作默认表/注册表，不直接操作房间里的真实实例。
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
// 注册一个房间物品。Creation Code 中仍可设置 inventory_id/amount 作为可读默认值，
// 但真正进入游戏后会以这里的注册表和存档状态为准。
room_status_define_entry(_room_id,room_status_make_entry(_state_id,"item",_item_id,_amount,_restorable));
}

function room_status_define_equipment(_room_id,_state_id,_equipment_id,_amount,_restorable){
// 注册一个房间装备。当前和物品共用 rs_id 命名规范：inst_房间id_item_实例id。
room_status_define_entry(_room_id,room_status_make_entry(_state_id,"equipment",_equipment_id,_amount,_restorable));
}

function room_status_define_npc(_room_id,_state_id,_npc_default_behavior,_msg_id,_restorable){
// 注册普通 NPC。普通 NPC 主要记录对话 id、行为、位置、是否在场和 custom。
var _entry = room_status_make_entry(_state_id,"npc",0,1,_restorable);
_entry.npc_default_behavior = _npc_default_behavior;
_entry.npc_behavior = _npc_default_behavior;
_entry.msg_id = _msg_id;
room_status_define_entry(_room_id,_entry);
}

function room_status_define_hostile_npc(_room_id,_state_id,_npc_default_behavior,_npc_default_behavior_a,_restorable,_default_x,_default_y){
// 注册敌对 NPC。敌对 NPC 通常没有 Creation Code，所以这里必须提供默认坐标，
// 让 room_status_autobind_instance() 能通过 type + 坐标自动绑定 rs_id。
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
// 所有“默认房间状态”都集中在这里。
// 以后新增正式房间时，推荐按房间分段写：
// 1. 先 room_status_define_room()
// 2. 再逐个 room_status_define_item/equipment/npc/hostile_npc()
// 3. 最后在对应实例 Creation Code 中写同名 rs_id

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
// 读取某个实例状态。返回的是 struct；调用者修改后需要 room_status_set_entry() 写回。
var _room_index = room_status_find_room_index(_room_id);
var _entry_index = room_status_find_entry_index(_room_index,_state_id);
if _entry_index < 0 return undefined;
return room_status.rooms[_room_index].instances[_entry_index];
}

function room_status_set_entry(_room_id,_state_id,_entry){
// 写回某个实例状态。
// GML 的 struct/array 在这里最好显式写回父数组，避免以后改复杂结构时踩引用/复制语义的坑。
var _room_index = room_status_find_room_index(_room_id);
var _entry_index = room_status_find_entry_index(_room_index,_state_id);
if _entry_index < 0 return false;

var _room_data = room_status.rooms[_room_index];
_room_data.instances[_entry_index] = _entry;
room_status.rooms[_room_index] = _room_data;
return true;
}

function room_status_current_room_id(){
// 当前房间 id 统一从 global.roomid 取得。
// 这个值目前由每个房间的 obj_gamestart Creation Code 设置。
return global.roomid;
}

function room_status_autobind_instance(_inst,_type){
// 自动绑定实例到注册表。
// 主要服务于“没有 Creation Code 的敌对 NPC”：它们无法自己写 rs_id，
// 所以用 type + 默认坐标匹配到注册表里的状态。
// 普通物品/NPC 更推荐在 Creation Code 中显式写 rs_id。
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
// 把真实实例的当前位置写入状态。
// 第一次捕获时顺便记录 default_x/default_y，作为休息刷新或默认重置的位置。
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
// 例：进入战斗前调用 room_status_current_set_restore_position(rs_id,true)，
// 战斗结束回房间后位置会按记录恢复，再视情况改回 false。
if _entry.restore_position && _entry.has_position
{
	_inst.x = _entry.x;
	_inst.y = _entry.y;
}
}

function room_status_ensure_pickup_entry(_inst,_type){
// 确保物品/装备实例有状态记录。
// 如果默认注册表没有这个 rs_id，也会按实例当前变量临时创建一个状态，
// 方便你调试时先在房间里放东西，再回头整理默认注册表。
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
// 物品/装备进房间后的状态应用：
// removed 为 true 时返回 false，调用方会销毁实例；
// removed 为 false 时，把 catalog id、数量、刷新概率等覆盖到实例变量。
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
// 把物品/装备实例的当前数据写回状态。
// 目前拾取前调用一次，确保运行时被修改过的 amount/content_id 不会丢。
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
// NPC/敌对 NPC 进房间后的状态应用：
// 普通 NPC 会恢复 msg_id 和行为；
// 敌对 NPC 会恢复默认行为、追击行为、追踪计时；
// 是否恢复坐标由 restore_position 控制。
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
// 把 NPC 的运行时状态写回注册表。
// 目前在 Step 末尾持续捕获，方便之后战斗切换、剧情离场、AI 临时状态等系统直接复用。
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
// 设置当前房间某个实例是否离场。
// 物品拾取、小怪死亡、NPC 剧情消失都可以统一用这个字段表达。
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.removed = _removed;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_msg(_state_id,_msg_id){
// 设置当前房间普通 NPC 的对话 id。
// 对话树推进时优先调用这个，而不是直接写实例变量；实例变量只负责立刻刷新当前画面。
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.msg_id = _msg_id;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_position(_state_id,_new_x,_new_y){
// 手动设置当前房间某个实例的运行时坐标。
// 自动捕获不够用时可以调用，比如传送、事件强制移动、战斗前记录原地位置。
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
// 控制进房间时是否恢复运行时坐标。
// false：普通地图切换时回到房间编辑器位置。
// true：用于战斗/剧情返回后仍站在离开前的位置。
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return false;
_entry.restore_position = _restore_position;
room_status_set_entry(_room_id,_state_id,_entry);
return true;
}

function room_status_current_set_custom(_state_id,_key,_value){
// 设置当前房间某个实例的扩展状态。
// 适合复杂 NPC：例如 talked、quest_step、branch_id、is_angry、shop_unlocked 等。
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
// 读取当前房间某个实例的扩展状态。
// 没有该状态时返回 _default_value，避免到处写 variable_struct_exists。
var _room_id = room_status_current_room_id();
var _entry = room_status_get_entry(_room_id,_state_id);
if _entry == undefined return _default_value;
if !is_struct(_entry.custom) return _default_value;
if !variable_struct_exists(_entry.custom,_key) return _default_value;
return variable_struct_get(_entry.custom,_key);
}

function room_status_current_set_room_custom(_key,_value){
// 设置当前房间自己的扩展状态。
// 适合房间级内容：门是否打开、机关阶段、区域是否被清空等。
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
// 读取当前房间自己的扩展状态。
var _room_index = room_status_find_room_index(room_status_current_room_id());
if _room_index < 0 return _default_value;

var _room_data = room_status.rooms[_room_index];
if !is_struct(_room_data.room_data) return _default_value;
if !variable_struct_exists(_room_data.room_data,_key) return _default_value;
return variable_struct_get(_room_data.room_data,_key);
}

function room_status_restore_entry(_room_id,_state_id){
// 尝试刷新单个实例。
// restorable = 0 时不刷新；20 必定刷新；1..19 按 d20 判定。
// 刷新成功会清除 removed，并把位置/行为重置到默认状态。
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
// 尝试刷新某个房间的所有已注册实例。
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
// _room_id >= 0：刷新指定房间。
// _room_id == -1：刷新所有房间。
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
// 存档合并用的小工具。
// 如果存档里存在某字段，就把它覆盖到默认状态上；不存在则保留新版本默认值。
if variable_struct_exists(_source,_field_name)
{
	variable_struct_set(_target,_field_name,variable_struct_get(_source,_field_name));
}
return _target;
}

function room_status_merge_entry(_target,_source){
// 把存档中的实例状态合并进默认实例状态。
// 这种“默认值 + 存档覆盖”的方式，能让以后新增字段/新增房间实例时旧存档不直接缺字段报错。
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

function room_status_get_save_version(_save_status){
// 读取存档版本号。当前正式格式从 version 2 开始。
// 以后如果升级到 version 3/4，在这里继续判断即可。
if !is_struct(_save_status) return 0;
if variable_struct_exists(_save_status,"version")
{
	return _save_status.version;
}
return 2;
}

function room_status_load_data(_save_status){
// 存档兼容入口。
// 注意：旧 ds_grid 版本迁移代码已删除，因为当前项目阶段没有保留旧房间状态存档的必要。
// 但 version 分流仍保留，未来要升级格式时，在 switch 中新增 case 即可。
var _save_version = room_status_get_save_version(_save_status);
switch(_save_version)
{
	default:
	case 2:
		room_status_load_v2_data(_save_status);
		break;
}
}

function room_status_load_v2_data(_save_status){
// version 2 的读取逻辑。
// 只读取结构体格式；旧 ds_grid 迁移代码已删除。
// 新增字段时，优先给 room_status_make_entry() 填默认值，再把字段名加入 room_status_merge_entry()。
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
// 保存前复制一份，避免 json_stringify 期间意外持有运行时引用。
return variable_clone(room_status);
}
