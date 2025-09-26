function scr_spriting() {
if face=1
{
	if vy !=0 || vx != 0 || vs != 0
	{
		draw_sprite_ext(sprwalk,spranimation_time,x,y,0.125,0.125,0,c_white,1);
	}
	else 
	{
		draw_sprite_ext(spridle,0,x,y,0.125,0.125,0,c_white,1);
	}
}
if face=2
{
	if vy !=0 || vx != 0 || vs != 0
	{
		draw_sprite_ext(sprwalk,spranimation_time+maxframe,x,y,0.125,0.125,0,c_white,1);
	}
	else 
	{
		draw_sprite_ext(spridle,1,x,y,0.125,0.125,0,c_white,1);
	}
}
if face=3
{
	if vy !=0 || vx != 0 || vs != 0
	{
		draw_sprite_ext(sprwalk,spranimation_time+(maxframe*2),x,y,0.125,0.125,0,c_white,1);
	}
	else 
	{
		draw_sprite_ext(spridle,2,x,y,0.125,0.125,0,c_white,1);
	}
}
if face=4
{
	if vy !=0 || vx != 0 || vs != 0
	{
		draw_sprite_ext(sprwalk,spranimation_time+(maxframe*3),x,y,0.125,0.125,0,c_white,1);
	}
	else 
	{
		draw_sprite_ext(spridle,3,x,y,0.125,0.125,0,c_white,1);
	}
}
}