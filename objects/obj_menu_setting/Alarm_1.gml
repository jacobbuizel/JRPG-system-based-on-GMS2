if global.auto_run
{
	global.auto_run = false;
	op_option[0,1] = "自动奔跑:关";
}
else
{
	global.auto_run = true;
	op_option[0,1] = "自动奔跑:开";
}