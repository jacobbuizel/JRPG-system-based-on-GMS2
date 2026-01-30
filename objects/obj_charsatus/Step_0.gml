if load
{
	load = false;
	var _arr = global.saveDATA.Schara_status;
	for (var i = 0; i < array_length(_arr); i++)
	{
		var _id = _arr[i].id;
		var _struct = _arr[i].data;
		ds_grid_set(chara_status, 0, i, _id);
		//重建人物技能列表
		var _skill_arr = _struct.skill_list;
		var _grid = ds_grid_create(skill_w, max(1, array_length(_skill_arr)));
		
		for (var r = 0; r < array_length(_skill_arr); r++)
		{
			ds_grid_set(_grid,DS_SKILL.NAME, r, _skill_arr[r].s_name);
			ds_grid_set(_grid,DS_SKILL.S_ID, r, _skill_arr[r].s_id);
			ds_grid_set(_grid,DS_SKILL.SOURCE_COUNT, r, _skill_arr[r].source_count);
		}
		
		_struct.skill_list = _grid;
		ds_grid_set(chara_status, 1, i, _struct);
	}

	for (var i = 0; i < global.totalchara; i++)
	{
		global.player[i] = global.saveDATA.player[i];
	}
}

//判断是否游戏结束
if load_chara(global.player[0]).HP_C<=0 && load_chara(global.player[1]).HP_C<=0 && !global.talking && !global.gameover && !global.pause
{
	create_msg_box("HPTO0");
	global.gameover = true;
}
