depth = -1000;

//高和宽
width = 256;
height = 32;

//上边框和字符上下间距
op_border = 32;
op_space = 64;

//长按切换按键
wait_time=30;
pos = 0;

//房间切换
roomgoto=false;

op_option[0] = "开始游戏";
op_option[1] = "继续游戏";
op_option[2] = "回想屋";
op_option[3] = "设置";
op_option[4] = "退出游戏";

op_length = array_length(op_option);

global.bgm = 1;
global.bgm_v = 1;
global.sfx_v = 1;
global.bgs_v = 1;
global.savef = 0;

global.sub_menu = 0;
global.talking = false;
global.noresting = false;

if !audio_group_is_loaded(audiogroup_SFX)
{
	audio_group_load(audiogroup_SFX);
}
if !audio_group_is_loaded(audiogroup_BGS)
{
	audio_group_load(audiogroup_BGS);
}