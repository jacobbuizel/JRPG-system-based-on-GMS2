//NPC的AI行为枚举
enum NPC_BEHAVIOR
{
	IDLE = 0,
	RANDOM_MOVE = 1,
	TALKING = 2,
	FOLLOW = 3,
	OFOLLOW = 4,
	AWAY = 5	
}

function npc_behavior_list(_npc_behavior){
switch(_npc_behavior)
{
	default:
		npc_idle();//待机
		break;
	case NPC_BEHAVIOR.RANDOM_MOVE:
		npc_random_move();//随机移动
		break;
	case NPC_BEHAVIOR.TALKING:
		npc_talking();//谈话
		break;
	case NPC_BEHAVIOR.FOLLOW:
		npc_follow();//跟随
		break;
	case NPC_BEHAVIOR.OFOLLOW:
		npc_ofollow();//贴紧跟随
		break;
	case NPC_BEHAVIOR.AWAY:
		npc_away();//远离
		break;
}
}

function npc_away(){

//判断疾跑
sprinting = false;
if !collision_circle(x,y,16,follow_target,false,true)
{
	vs += acc*2
	sprinting = true;
}

//初始化路径
var _dx = follow_target.x - x;
var _dy = follow_target.y - y;

//创建路径
path_delete(follow_path);
follow_path = path_add();
mp_potential_path_object(follow_path,x-_dx,y-_dy,vs,1,block_solid);
path_start(follow_path,vs,path_action_stop,true);
}

function npc_follow(){

//疾跑检测
if !collision_circle(x,y,64,follow_target,false,true) || follow_target.sprinting
{
	sprinting = true;
}
else
{
	sprinting = false;
}
//处理移动
if !collision_circle(x,y,32,follow_target,false,true)
{
	vs += acc*2;
}

//初始化路径
path_delete(follow_path);
follow_path = path_add();

//创建路径
mp_potential_path_object(follow_path,follow_target.x,follow_target.y,vs,2,block_solid);
if !collision_circle(x,y,96,follow_target,false,true)
{
	mp_grid_path(global.grid_solid,follow_path,x,y,follow_target.x,follow_target.y,true);
}
path_start(follow_path,vs,path_action_stop,true);
}

function npc_idle(){
vx = 0;
vy = 0;
sprinting = false;
}

function npc_ofollow(){

//判断疾跑
sprinting = false;
if !collision_circle(x,y,16,follow_target,false,true)
{
	vs += acc*2;
	sprinting = true;
}

//初始化路径
path_delete(follow_path);
follow_path = path_add();

//创建路径
mp_potential_path_object(follow_path,follow_target.x,follow_target.y,vs,2,block_solid);
if !collision_circle(x,y,224,follow_target,false,true)
{
	mp_grid_path(global.grid_h_npc_solid,follow_path,x,y,follow_target.x,follow_target.y,true);
}
path_start(follow_path,vs,path_action_stop,true);
}

function npc_random_move(){

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

function npc_talking(){

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