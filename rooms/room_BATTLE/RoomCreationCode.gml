global.roomid = -100;
global.battle = true;
global.pause = true;

if !instance_exists(obj_battle_controller)
{
	instance_create_layer(0,0,"Instances",obj_battle_controller);
}
