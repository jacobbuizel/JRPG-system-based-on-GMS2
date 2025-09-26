if !global.pause && !global.talking
{
	scr_npc_behavior();
	scr_movement();
	if place_meeting(x,y,obj_interacting)
	{
		npc_behavior = 2;
		wait_time = 15;
		random_movement = 0;
		vx = 0;
		vy = 0;
		if !instance_exists(obj_msgbox)
		{
			create_msg_box(msg_id);
		}
	}
	
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

if global.talking && npc_behavior == 2
{
	scr_npc_talking();
}