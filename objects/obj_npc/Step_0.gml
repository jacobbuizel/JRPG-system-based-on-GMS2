if !rs_state_ready
{
	// 第一次 Step 时把存档状态应用到 NPC。
	// 如果 removed=true，表示剧情上已经离场，直接销毁实例。
	if !room_status_apply_npc_state(id,"npc")
	{
		instance_destroy();
		exit;
	}
	rs_state_ready = true;
}

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

// 每帧记录行为、位置和 msg_id。
// 默认不会在进房间时恢复位置；需要战斗返回原位时再开启 restore_position。
room_status_capture_npc_state(id,"npc");
