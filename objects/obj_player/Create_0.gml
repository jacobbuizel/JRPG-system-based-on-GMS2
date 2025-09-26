//初始速度
oacc = 0.20;
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
maxSpeed = oacc * 15;

//朝向
face = 1;
//判断是否为npc
npc = false;

//精灵贴图
spridle = spr_rowling;
sprwalk = spr_rowling_w;
maxframe = 2;
spranimation_time = 0;
sprtime = 5;