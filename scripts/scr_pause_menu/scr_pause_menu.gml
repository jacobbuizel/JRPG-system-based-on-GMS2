function scr_pause_menu(){
if bkey && !instance_exists(obj_menu)
{
	audio_play_sound(sfx_click,9,false);
	instance_create_layer(0,0,"Instances",obj_menu);
}
}