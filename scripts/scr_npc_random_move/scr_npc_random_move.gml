function scr_npc_random_move(){

--wait_time
sprinting = false;
if random_movement > 8 || random_movement < 1 
{
	xm = false;
	ym = false;
}
if random_movement = 1
{
	vy += acc*2;
	ym = true;
}
if random_movement = 2
{
	vx -= acc*2;
	xm = true;
}
if random_movement = 3
{
	vy -= acc*2;
	ym = true;
}
if random_movement = 4
{
	vx += acc*2;
	xm = true;
}
if random_movement = 5
{
	vy += acc*2;
	vx -= acc*2;
	ym = true;
	xm = true;
}
if random_movement = 6
{
	vy += acc*2;
	vx += acc*2;
	ym = true;
	xm = true;
}
if random_movement = 7
{
	vy -= acc*2;
	vx -= acc*2;
	ym = true;
	xm = true;
}
if random_movement = 8
{
	vy -= acc*2;
	vx += acc*2;
	ym = true;
	xm = true;
}

if wait_time <= 0
{
	random_movement = irandom(40);
	wait_time = 15;
}
}