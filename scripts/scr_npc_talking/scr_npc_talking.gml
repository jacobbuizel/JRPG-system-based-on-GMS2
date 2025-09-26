function scr_npc_talking(){

if !global.talking npc_behavior = npc_default_behavior;

xm = false;
ym = false;
sprinting = false;

if place_meeting(x,y+16,obj_player)
{
	face = 1;
}
if place_meeting(x-16,y,obj_player)
{
	face = 2;
}
if place_meeting(x,y-16,obj_player)
{
	face = 3;
}
if place_meeting(x+16,y,obj_player)
{
	face = 4;
}
}