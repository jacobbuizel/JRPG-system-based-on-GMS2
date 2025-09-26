if ds_grid_get(room_status,i_room_s,i_room*2) == 1
{
	instance_destroy();
}
if place_meeting(x,y,obj_interacting)
{
	alarm[0] = 1;
}