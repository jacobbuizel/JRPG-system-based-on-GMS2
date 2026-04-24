if !global.talking
{
	room_status_capture_pickup_state(id,"equipment");
	if (add_equipment_id(equip_id.e_id,amount))
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
