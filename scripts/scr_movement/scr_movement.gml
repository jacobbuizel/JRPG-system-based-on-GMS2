function scr_movement() {
depth = -y;

//处理疾跑
acc = sprinting ? sacc : oacc;

//处理斜角移动
if xm && ym
{
	acc /= sqrt(2);
}

maxSpeed = acc * 15;

//处理水平移动
if vx > 0
{
	vx -= acc;
	face = 4;
}
else if vx < 0
{
	vx += acc;
	face = 2;
}
vx = clamp(vx,-maxSpeed,maxSpeed);
if vx > -acc && vx < acc
{
	vx = 0;
}

//处理垂直移动
if vy > 0
{
	vy -= acc;
	face = 1;
}
else if vy < 0
{
	vy += acc;
	face = 3;
}
vy = clamp(vy,-maxSpeed,maxSpeed);
if vy > -acc && vy < acc
{
	vy = 0;
}

//处理矢量移动
if vs > 0
{
	vs -= acc;
}
vs = clamp(vs,0,maxSpeed*0.87);
/*
由于某种神秘的计算公式或者代码发力了，总之NPC使用路径的方式进行移动的时候，
其最大速度要比上面的垂直、水平移动速度要快，
多次实验和测试后发现0.87的乘数可以让两种移动方式的速度相同（至少趋近），故在后面加上乘0.87
*/

//使用矢量移动时的朝向
if (vs != 0)
{
	//先偏移46度进行计算，至于为什么不能是45度，因为斜方向（正45度）移动的时候朝向会抽风
	var _dir = (direction + 46) mod 360;
	var _index = floor(_dir / 90);
	switch (_index)
	{
		case 0: face = 4; break; //右
		case 1: face = 3; break; //上
		case 2: face = 2; break; //左
		case 3: face = 1; break; //下
	}
}

//防卡死和阻挡物
if (!variable_instance_exists(id, "block_solid"))
{
	block_solid = obj_solid;
}
if place_meeting(x + hspeed, y, block_solid)
{
	if !place_meeting(x + hspeed, y + 1, block_solid)
	{
		y += 1;
	}
	else if !place_meeting(x + hspeed, y - 1, block_solid)
	{
		y -= 1;
	}
	else
	{
		hspeed = 0;
	}
}
repeat(abs(vx))
{
	if (!place_meeting(x+sign(vx),y,block_solid))
	{
		x += sign(vx);
	}
	else
	{
		vx = 0;
		break;
	}
}
repeat(abs(vy))
{
	if (!place_meeting(x,y+sign(vy),block_solid))
	{
		y += sign(vy);
	}
	else
	{
		vy = 0;
		break;
	}
}
}