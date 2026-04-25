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

// 逃跑或剧情返回后，原敌人会先恢复到离开前的位置，然后清理一次性恢复标记。
if battle_apply_return_state_for_entry(rs_id)
{
	battle_touch_cooldown = 60;
	follow_timer = 0;
}

// 接触冷却只影响开战，不影响敌人本身的普通移动/追击。
if battle_touch_cooldown > 0
{
	battle_touch_cooldown--;
}
// 全局遇敌冷却用于处理多个敌人同时贴住玩家的情况，防止逃跑后立刻又被其它敌人拖回战斗。
var _global_battle_touch_cooldown = 0;
if variable_global_exists("battle_touch_cooldown")
{
	_global_battle_touch_cooldown = global.battle_touch_cooldown;
}

if !global.pause && !global.talking
{
	npc_behavior_list(npc_behavior);
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
			npc_behavior = NPC_BEHAVIOR.IDLE; //与玩家碰撞后待机
			// 真正进入战斗的入口。战斗系统会记录来源房间和 rs_id。
			if battle_touch_cooldown <= 0 && _global_battle_touch_cooldown <= 0 && !global.battle
			{
				battle_start_from_hostile(id);
				exit;
			}
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
