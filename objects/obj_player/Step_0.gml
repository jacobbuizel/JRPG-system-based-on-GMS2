if !global.pause && !global.talking
{
	scr_player_movement();
	scr_pause_menu();
	scr_interacting();
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

if global.warping
{
	vx = 0;
	vy = 0;
	vs = 0;
}

if collision_circle(x,y,256,obj_hostile_npc,false,true)||collision_point(x,y,obj_noresting_solid,false,true)
{
	global.noresting = true;
}
else
{
	global.noresting = false;
}