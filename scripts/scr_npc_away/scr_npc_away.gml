function scr_npc_away(){

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