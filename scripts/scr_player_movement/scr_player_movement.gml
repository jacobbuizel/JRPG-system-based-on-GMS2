function scr_player_movement(){
if shfckey || xckey
{
	if !global.auto_run
	{
		sprinting = true;
	}
	else
	{
		sprinting = false;
	}
}
else
{
	if !global.auto_run
	{
		sprinting = false;
	}
	else
	{
		sprinting = true;
	}
}

if !lkey && !rkey
{
	xm = false;
}
if !ukey && !dkey
{
	ym = false;
}
if lkey
{
	vx -= acc*2;
	xm = true;
}
if rkey
{
	vx += acc*2;
	xm = true;
}
if dkey
{
	vy += acc*2;
	ym = true;
}
if ukey
{
	vy -= acc*2;
	ym = true;
}
	if lkey && rkey
{
	xm = false;
}
if ukey && dkey
{
	ym = false;
}

}