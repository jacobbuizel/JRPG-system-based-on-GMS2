if !rs_state_ready
{
	if !room_status_apply_pickup_state(id,"equipment")
	{
		instance_destroy();
		exit;
	}
	rs_state_ready = true;
}
if place_meeting(x,y,obj_interacting)
{
	alarm[0] = 1;
}
