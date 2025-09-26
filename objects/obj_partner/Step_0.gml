if !global.pause && !global.talking
{
	scr_npc_behavior();
	scr_movement();
	//精灵贴图设置
	sprtime--;
	if sprtime<=0
	{
		++spranimation_time;
		if spranimation_time >= maxframe
		{
			spranimation_time = 0;
		}
		sprtime = 5;
	}
}
if global.pause || global.talking
{
	path_end();
}

if global.warping
{
	vx = 0;
	vy = 0;
	vs = 0;
}