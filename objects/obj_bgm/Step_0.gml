//BGM管理
if c_bgm != global.bgm
{
	bgm_v -= 0.1;
	audio_group_set_gain(audiogroup_BGM,bgm_v,0);
	if audio_group_get_gain(audiogroup_BGM)==0
	{
		audio_group_stop_all(audiogroup_BGM);
		audio_group_stop_all(audiogroup_BGM_2);
		bgm_looping = false;
		bgm_playing = false;
		c_bgm = global.bgm;
		audio_group_set_gain(audiogroup_BGM,global.bgm_v,0.5);
		bgm_v = global.bgm_v;
	}
}

if !bgm_playing
{
	switch c_bgm
	{
		default:
			bgm = 0;
			bgm2 = 0;
			audio_group_stop_all(audiogroup_BGM);
			bgm_looping = true;
			break;
		case 1:
			bgm = bgm_1_roterground_start;
			bgm2 = 0;
			audio_play_sound(bgm,10,false);
			bgm_looping = false;
			break;
		case 2:
			bgm = bgm_2_roterground_musicbox_start;
			bgm2 = 0;
			audio_play_sound(bgm,10,false);
			bgm_looping = false;
			break;
		case 3:
			bgm = bgm_3_start_with_one_step;
			bgm2 = bgm_3_start_with_one_step_battle_remix;
			audio_play_sound(bgm,10,true);
			audio_play_sound(bgm2,10,true);
			bgm_looping = true;
			break;
	}
	bgm_playing = true;
}

if !bgm_looping && bgm_playing
{
	switch c_bgm
	{
		default:
			bgm_looping = true;
			break;
		case 1:
			if !audio_is_playing(bgm)
			{
				bgm = bgm_1_roterground_loop;
				bgm2 = 0;
				audio_play_sound(bgm,10,true);
				bgm_looping = true;
			}
			break;
		case 2:
			if !audio_is_playing(bgm)
			{
				bgm = bgm_2_roterground_musicbox_loop;
				bgm2 = 0;
				audio_play_sound(bgm,10,true);
				bgm_looping = true;
			}
			break;
	}
}