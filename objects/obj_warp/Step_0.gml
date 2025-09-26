if place_meeting(x,y,obj_player) && global.warping == 0
{
	global.warping = 1;
	instance_create_layer(x,y,"Instances",obj_warp_anm);
}
if place_meeting(x,y,obj_player) && global.warping == 2
{
	room_goto(target_rm);
	obj_player.x = target_x;
	obj_player.y = target_y;
	obj_partner.x = target_x;
	obj_partner.y = target_y-1;
}