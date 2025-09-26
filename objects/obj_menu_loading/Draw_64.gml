//绘制菜单背景
var _x = 200;
var _y = op_border*5+menu_anm;
draw_sprite_stretched(spr_msgbox,image_index,_x,_y,700,height);
draw_sprite_stretched(spr_msgbox,image_index,_x+700,_y,500,height);

//绘制选项
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

_x += op_border;
_y += op_border;

draw_text(_x,_y,"存档");
_y += op_border+8;

var _oy = _y, _ox = _x;

for(var i=0;i<18;i++)
{
    var s = op_option[i + scroll_a];
    var slot_index = i + scroll_a;
    // 补零到2位：00..09，其余按原样
    var num_str = (slot_index < 10) ? "0" + string(slot_index) : string(slot_index);

    // 找到空格，取后半部分（日期或“空”）
    var space_idx = string_pos(" ", s);
    var suffix = "";
    if (space_idx > 0) {
        suffix = string_copy(s, space_idx + 1, string_length(s) - space_idx);
    }

    // 组合最终显示文本（不改原数组，只是显示）
    var display = "存档" + num_str + (suffix != "" ? " " + suffix : "");

    draw_text(_x, _y, display);
    _y += op_border;
	//draw_text(_x,_y,op_option[i+scroll_a]);
	//_y += op_border;
}
_y = _oy;
draw_rectangle(_x,_y+(pos*op_border),_x+636,_y+op_border+((pos*op_border)),true);
_x += 700;
_y = _oy-op_border;

if op_option[pos+scroll_a] != "存档"+string(pos+scroll_a)+" 空"
{
	//绘制存档详情
	var _filename_P = "savedata"+string(pos+scroll_a)+".sav";
	var _saveDATA_P_D = 
	{
			game_time_s : 0,
			game_time_m : 0,
			game_time_h : 0,
			c_date : string(current_year)+"/"+string(current_month)+"/"+string(current_day),
			
			time_m : 0,
			time_h : 0,
			time_day : 0,
			
			Sinventory : 0,
			Sinventory_h : 0,
			Sroom_status : 0,
			Schara_status : 0,
			
			room_name : 0,
			playerSX : 0,
			playerSY : 0,
			partnerSX : 0,
			partnerSY : 0,
			
			player1 : 0,
			player2 : 0
		}
	
	//读取存档预览
	var _buffer = buffer_load(_filename_P);
	var _json = buffer_read(_buffer,buffer_string);
	buffer_delete(_buffer);
	var _loadArr = json_parse(_json);
	_saveDATA_P_D = array_get(_loadArr,0);
	
	//绘制时间
	draw_text(_x,_y,"第"+string(_saveDATA_P_D.time_day)+"天 "+string(_saveDATA_P_D.time_h)+":"+string(_saveDATA_P_D.time_m));
	_y += op_border*2;
	
	//绘制角色队伍
	var players = [
		_saveDATA_P_D.player1,
		_saveDATA_P_D.player2
	];
	
	var _chara_data = _saveDATA_P_D.Schara_status;
	
	for (var i = 0; i < array_length(players); i++)
	{
		var p_id = players[i];
		if (p_id == -1) continue; //如果某个队位没有角色，跳过
		
		//在 _chara_data 里找到对应 id 的角色
		var c = undefined;
		for (var j = 0; j < array_length(_chara_data); j++)
		{
			if (_chara_data[j].id == p_id)
			{
			    c = _chara_data[j].data;
			    break;
			}
		}
		
		if (c == undefined) continue; //没找到就跳过
		
		//绘制立绘/头像
		if (c.portrait != 0)
		{
			draw_sprite_ext(c.portrait,0,_x,_y,0.25,0.25,0,c_white,1);
		}
		else
		{
			draw_rectangle_color(_x,_y,_x+128,_y+128,c_black,c_black,c_black,c_black,false);
		}
		draw_sprite_ext(spr_msge,image_index,_x,_y,0.25,0.25,0,c_white,1);
		_x += 128 + op_border/2;

		//绘制信息
		draw_text(_x,_y,c.c_name);
		_y += op_border;
		draw_text(_x,_y,"等级"+string(c.level)+c.class_name+":"+c.sub_class_name);
		_y += op_border;
		draw_text(_x,_y,"AC:"+string(c.AC_C)+" HP:"+string(c.HP_C)+"/"+string(c.HP));
		_y += op_border;
		draw_text(_x,_y,"MP:"+string(c.MP_C)+"/"+string(c.MP));

		//分隔下一个角色
		_y += op_border*2;
		_x -= 128 + op_border/2;
	}
}

_x -= 96;
_y += 256;

if global.sub_menu >= 2
{
	//动态菜单高度以及宽度
	var _new_w = 0;
	for (var i=0;i<op_length_1;i++)
	{
		var _op_w = string_width(op_option_1[i])
		_new_w = max(_new_w,_op_w);
	}
	var o_width = _new_w + op_border*2;
	var o_height = op_border*2 + string_height(op_option_1[0]) + (op_length_1-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox,image_index,736+op_border,op_border*6+(pos*op_border),o_width,o_height);

	//绘制选项
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var i=0;i<op_length_1;i++)
	{
		var _c = c_white;
		if pos_1 == i
		{
			_c = c_yellow;
		}
		draw_text_color(736+op_border*2,op_border*6+(pos*op_border)+op_border+(op_space*i),op_option_1[i],_c,_c,_c,_c,1);
	}
}
if global.sub_menu == 3
{
	_x = (display_get_width()) / 2 - 250;
    _y = (display_get_height()) / 2 - 150;
	
	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox, image_index, _x, _y, 250, 150);
	
	//绘制选项
	draw_set_font(font0);
	
	var _c = c_white;
	draw_text_color(_x + op_border, _y + op_border, "是否"+op_option_1[pos_1]+"该存档？",_c,_c,_c,_c,1);
	
	_y += op_border*1.5;
	
    for (var i = 0; i < op_length_2; i++)
    {
        _c = c_white;
        if pos_2 == i
        {
            _c = c_yellow;
        }
        draw_text_color(_x + 1.5*op_border + 3*op_border*i, _y + op_border, op_option_2[i],_c,_c,_c,_c,1);
    }
}