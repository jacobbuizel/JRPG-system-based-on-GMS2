/// @param datanum
function scr_saving(_datanum){

var _saveArr = array_create(0);

global.saveDATA.game_time_s = global.game_time_s;
global.saveDATA.game_time_m = global.game_time_m;
global.saveDATA.game_time_h = global.game_time_h;
global.saveDATA.c_date = string(current_year)+"/"+string(current_month)+"/"+string(current_day);

global.saveDATA.time_m = global.time_m;
global.saveDATA.time_h = global.time_h;
global.saveDATA.time_day = global.time_day;

global.saveDATA.Sinventory = ds_grid_write(inventory);
global.saveDATA.Sinventory_h = ds_grid_height(inventory);
global.saveDATA.Sequipment = ds_grid_write(equipment);
global.saveDATA.Sequipment_h = ds_grid_height(equipment);
global.saveDATA.Sroom_status_version = room_status.version;
global.saveDATA.Sroom_status = room_status_save_data();

var _chara_data = [];
for (var i = 0; i < ds_grid_height(chara_status); i++)
{
	var _id = ds_grid_get(chara_status, 0, i);
	var _struct = ds_grid_get(chara_status, 1, i);
	
	//复制一份 struct
	var _save_struct = variable_clone(_struct);
	
	//单独处理 skill_list
	var _skill_grid = _struct.skill_list;
	var _skill_save = [];
	
	if ds_exists(_skill_grid, ds_type_grid)
	{
		for (var r = 0; r < ds_grid_height(_skill_grid); r++)
		{
			array_push(_skill_save, {
				s_name : ds_grid_get(_skill_grid, DS_SKILL.NAME, r),
				s_id : ds_grid_get(_skill_grid, DS_SKILL.S_ID, r),
				source_count : ds_grid_get(_skill_grid, DS_SKILL.SOURCE_COUNT, r)
			});
		}
	}

	//把“数组版技能和法术书”放进存档struct
	var _spell_grid = -1;
	var _spell_save = [];
	if variable_struct_exists(_struct, "spellbook_list")
	{
		_spell_grid = _struct.spellbook_list;
	}
	if ds_exists(_spell_grid, ds_type_grid)
	{
		for (var sr = 0; sr < ds_grid_height(_spell_grid); sr++)
		{
			array_push(_spell_save, {
				s_name : ds_grid_get(_spell_grid, DS_SPELL.NAME, sr),
				s_id : ds_grid_get(_spell_grid, DS_SPELL.S_ID, sr),
				is_enable : ds_grid_get(_spell_grid, DS_SPELL.ISENALBE, sr)
			});
		}
	}

	_save_struct.skill_list = _skill_save;
	_save_struct.spellbook_list = _spell_save;
	if variable_struct_exists(_struct, "spellbook")
	{
		_save_struct.spellbook = _struct.spellbook;
	}
	else
	{
		_save_struct.spellbook = (_struct.class_id == 11);
	}

	//存
	array_push(_chara_data, {id : _id,data : _save_struct});
}
global.saveDATA.Schara_status = _chara_data;

global.saveDATA.room_name = room_get_name(room);
global.saveDATA.playerSX = obj_player.x;
global.saveDATA.playerSY = obj_player.y;
global.saveDATA.partnerSX = obj_partner.x;
global.saveDATA.partnerSY = obj_partner.y;

for (var i = 0; i < global.totalchara; i++)
{
	global.saveDATA.player[i] = global.player[i]
}

array_push(_saveArr,global.saveDATA);

var _filename = "savedata"+string(_datanum)+".sav"
var _json = json_stringify(_saveArr);
var _buffer = buffer_create(string_byte_length(_json)+1,buffer_fixed,1);

buffer_write(_buffer,buffer_string,_json);
buffer_save(_buffer,_filename);
buffer_delete(_buffer);
}

/// @param datanum
function scr_loading(_datanum){

var _filename = "savedata"+string(_datanum)+".sav"
if !file_exists(_filename) exit;

var _buffer = buffer_load(_filename);
var _json = buffer_read(_buffer,buffer_string);
buffer_delete(_buffer);

var _loadArr = json_parse(_json);

global.saveDATA = array_get(_loadArr,0);
}
