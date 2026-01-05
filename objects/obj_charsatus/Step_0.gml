if load
{
	load = false;
	var _arr = global.saveDATA.Schara_status;
	for (var i = 0; i < array_length(_arr); i++)
	{
		var _id = _arr[i].id;
		var _struct = _arr[i].data;
		ds_grid_set(chara_status, 0, i, _id);
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
