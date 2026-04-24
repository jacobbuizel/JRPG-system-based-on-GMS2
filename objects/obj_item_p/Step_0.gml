if !rs_state_ready
{
	// 第一次 Step 时从房间状态读取物品数据。
	// 如果状态里 removed=true，说明已经被拾取/摧毁，直接销毁实例。
	if !room_status_apply_pickup_state(id,"item")
	{
		instance_destroy();
		exit;
	}
	rs_state_ready = true;
}
if place_meeting(x,y,obj_interacting)
{
	// 与交互对象接触后延迟到 Alarm 处理，沿用原来的拾取流程。
	alarm[0] = 1;
}
