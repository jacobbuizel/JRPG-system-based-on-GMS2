//npc跟随初始参数
follow_path = path_add();
follow_target = obj_player;

//初始速度
oacc = follow_target.oacc;
//当前速度
acc = oacc;
//奔跑速度
sacc = oacc*2;
//奔跑状态
sprinting = false;

//xy速度
vx = 0;
vy = 0;
//xy移动状态
xm = false;
ym = false;
//速度
vs = 0;
//最高速度
maxSpeed = acc * 15;

//朝向
face = 1;
//判断是否为npc
npc = true;

//精灵贴图
spridle = spr_snow;
sprwalk = spr_snow_w;
spranimation_time = 0;
maxframe = 2;
sprtime = 5;

//npc默认行为
npc_default_behavior = NPC_BEHAVIOR.FOLLOW;
npc_behavior = npc_default_behavior;
//npc阻挡物
block_solid = obj_solid;