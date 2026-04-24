if !global.talking
{
	room_status_capture_pickup_state(id,"item");
	if (add_item_id(inventory_id.i_id,amount))
	{
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
