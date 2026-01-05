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
global.saveDATA.Sroom_status = ds_grid_write(room_status);

//global.saveDATA.Schara_status = ds_grid_write(chara_status);

var _chara_data = [];
for (var i = 0; i < ds_grid_height(chara_status); i++)
{
	var _id     = ds_grid_get(chara_status, 0, i);
	var _struct = ds_grid_get(chara_status, 1, i);
	array_push(_chara_data, {id: _id, data: _struct});
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