randomise();

//初始速度
oacc = 0.15;
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
spridle = spr_rowling;
sprwalk = spr_rowling_w;
spranimation_time = 0;
maxframe = 2;
sprtime = 5;

//npc默认行为
npc_default_behavior = 1;
npc_behavior = npc_default_behavior;
//npc阻挡物
block_solid = obj_npc_solid;

//npc随机移动初始参数
wait_time = 15;
random_movement = 0;

//npc对话初始参数
msg_id = "";

// 房间状态系统：记录 NPC 对话、行为、位置和是否在场。
// 普通 NPC 建议在 Creation Code 写 rs_id，并把初始 msg_id/npc_default_behavior 写清楚。
// 复杂剧情变量不要新增零散全局变量，优先放到 room_status 的 custom 里。
rs_id = "";
rs_restorable = 0;
rs_state_ready = false;
