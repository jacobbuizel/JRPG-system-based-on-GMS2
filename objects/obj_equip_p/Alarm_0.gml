if !global.talking
{
	if (add_equipment_id(equip_id.e_id,amount))
	{
		ds_grid_set(room_status,i_room_s,i_room*2,1);
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