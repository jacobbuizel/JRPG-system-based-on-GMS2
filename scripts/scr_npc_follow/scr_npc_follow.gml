function scr_npc_follow(){

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