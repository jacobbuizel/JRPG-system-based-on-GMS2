if !rs_state_ready
{
	// 第一次 Step 时把存档状态应用到敌对 NPC。
	// 如果 removed=true，表示已经被击败/清除，直接销毁实例。
	if !room_status_apply_npc_state(id,"hostile_npc")
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
	if collision_circle(x,y,256,follow_target,false,true)
	{
		follow_timer = follow_timer_max;
	}
	
	if follow_timer > 0
	{
		follow_timer--
		if place_meeting(x,y,obj_player)
		{
			path_end();
			npc_behavior = 0; //与玩家碰撞后待机
		}
		else
		{
			npc_behavior = npc_default_behavior_a;
		}
	}
	else if npc_behavior == npc_default_behavior_a
	{
		vs -= acc*1.1;
		if vs <= 0
		{
			path_end();
			npc_behavior = npc_default_behavior;
		}
	}
	else
	{
		path_end();
		npc_behavior = npc_default_behavior;
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
if global.pause || global.talking
{
	path_end();
}

// 持续记录行为、位置和追踪计时，方便以后接战斗返回、清怪、刷新等逻辑。
room_status_capture_npc_state(id,"hostile_npc");
