depth = -1001;

//高和宽
width = 256;
height = 32;

//上边框和字符上下间距
op_border = 32;
op_space = 32;

//长按切换按键
wait_time=120;
pos = 0;

//等待操作
menu_wait=1;

//声音设置界面
op_snd = 1;

global.pause = true;
global.sub_menu = 1;

op_option[0,0] = "声音";
if global.auto_run
{
	op_option[0,1] = "自动奔跑:开";
}
else
{
	op_option[0,1] = "自动奔跑:关";
}
op_option[0,2] = "高级设置";
op_option[0,3] = "返回";

op_option[1,0] = "BGM大小";
op_option[1,1] = "SFX大小";
op_option[1,2] = "BGS大小";
op_option[1,3] = "返回";

op_option[2,0] = "100%";
op_option[2,1] = "80%";
op_option[2,2] = "60%";
op_option[2,3] = "40%";
op_option[2,4] = "20%";
op_option[2,5] = "关";
op_option[2,6] = "返回";

op_length = 0;
menu_level = 0;