if(wait_akey > 0)
{
	wait_akey--;
}

//初始化
if !setup
{
	setup = true;
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	for(var p=0;p<page_number;p++)
	{
		msg_l[p] = string_length(msg[p]);
	}
}

//开始打字
if draw_char < msg_l[page]
{
	draw_char += global.message_set_speed;
	draw_char = clamp(draw_char,0,msg_l[page]);
	if !audio_is_playing(sfx_talk)
	{
		audio_play_sound(sfx_talk,9,false);
	}
}

//嵌入脚本读取
if (is_method(msg_scr[page]))
{
    msg_scr[page]();
    msg_scr[page] = 0;
}

//翻页
if akey && wait_akey < 1
{
	if draw_char == msg_l[page]
	{
		if page < page_number-1
		{
			page++
			draw_char = 0;
		}
		else
		{
			if option_num > 0
			{
				audio_play_sound(sfx_select,9,false);
				create_msg_box(option_link_id[option_pos]);
			}
			alarm[0]=5;
		}
	}
	else
	{
		draw_char = msg_l[page];
	}	
}
if xckey
{
	draw_char = msg_l[page];
	if page < page_number-1
	{
		page++
		draw_char = 0;
	}
	else
	{
		if option_num == 0
		{
			alarm[0]=5;
		}
	}
}

//绘制文本框
var _msgb_x = 0;
var _msgb_y = msg_h+256;
var msgb_spr_w = sprite_get_width(msgb_spr);
var msgb_spr_h = sprite_get_height(msgb_spr);

draw_sprite_ext(msgb_spr,msgb_img,_msgb_x,_msgb_y,msg_w/msgb_spr_w,msg_h/msgb_spr_h,0,c_white,1);

//选项
if draw_char == msg_l[page] && page == page_number-1 && option_num > 0
{
	//切换选项
	option_pos += dpkey - upkey;
	if dpkey || upkey
	{
		audio_play_sound(sfx_click,9,false);
	}
	
	if ukey || dkey
	{
		if wait_time > 0
		{
			wait_time--;
		}
	}
	else wait_time=30;
	if wait_time <= 0
	{
		option_pos += dkey - ukey;
		if !(dkey&&ukey)
		{
			audio_play_sound(sfx_click,9,false);
		}
		wait_time = 5;
	}

	if option_pos >= option_num
	{
		option_pos=0;
	}
	if option_pos < 0
	{
		option_pos = option_num-1;
	}
	
	//动态菜单高度以及宽度
	var _new_w = 0;
	for (var i=0;i<option_num;i++)
	{
		var _op_w = string_width(option[i])
		_new_w = max(_new_w,_op_w);
	}
	var _width = _new_w + border*2;
	var _height = border*2 + string_height(option[0]) + (option_num-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(msgb_spr,msgb_img,_msgb_x,_msgb_y-_height,_width,_height);

	//绘制选项
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var i=0;i<option_num;i++)
	{
		var _c = c_white;
		if option_pos == i
		{
			_c = c_yellow;
		}
		draw_text_color(_msgb_x+border,_msgb_y-_height+border+(op_space*i),option[i],_c,_c,_c,_c,1);
	}
}

//绘制表情
if msg_portrait[page] != noone
{
	var _drawport = msg_portrait[page];
	var _expre = msg_portrait_expre[page];
		
	draw_sprite_ext(_drawport,_expre,_msgb_x+border,_msgb_y+border,0.5,0.5,0,c_white,1);
	draw_sprite_ext(spr_msge,image_index,_msgb_x+border,_msgb_y+border,0.5,0.5,0,c_white,1);
	_msgb_x += 256+border;
}

//绘制文本
var _drawmsg = string_copy(msg[page],1,draw_char);

var _wrapped_msg = string_wrap(_drawmsg, line_w);

if msg_name[page] != noone
{
	draw_text(_msgb_x+border,_msgb_y+border,msg_name[page]);
	_msgb_y += border*2;
}
draw_text(_msgb_x+border,_msgb_y+border,_wrapped_msg);
