if !global.talking
{
	// 先捕获当前实例数据，避免 amount 或 inventory_id 被事件临时改过后丢失。
	room_status_capture_pickup_state(id,"item");
	if (add_item_id(inventory_id.i_id,amount))
	{
		// 背包成功获得后，才把房间状态标记为移除。
		room_status_current_set_removed(rs_id,true);
		if !instance_exists(obj_msgbox)
		{
			create_msg_box("item_pickup");
		}
		instance_destroy();
	}
	else if !instance_exists(obj_msgbox)
	{
		create_msg_box("item_full");
	}
}
