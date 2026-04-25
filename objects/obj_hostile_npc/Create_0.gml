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
spridle = spr_slime;
sprwalk = spr_slime_w;
spranimation_time = 0;
maxframe = 2;
sprtime = 5;

//npc默认行为
npc_default_behavior = NPC_BEHAVIOR.RANDOM_MOVE;
//玩家角色靠近npc的行为
npc_default_behavior_a = NPC_BEHAVIOR.OFOLLOW;
//npc行为初始化
npc_behavior = npc_default_behavior;
//npc阻挡物
block_solid = obj_h_npc_solid;

//npc随机移动初始参数
wait_time = 15;
random_movement = 0;

//npc跟随初始参数
follow_path = path_add();
follow_target = obj_player;
follow_timer = 0;
follow_timer_max = 120;
// 战斗返回后的短暂接触冷却，避免逃跑回地图后立刻再次进战斗。
battle_touch_cooldown = 0;

// 房间状态系统：记录敌对 NPC 的刷新、行为和位置。
// 没有 Creation Code 的敌对 NPC 会尝试用“注册表默认坐标 + 类型”自动绑定 rs_id。
// rs_restorable 默认为 20，表示休息刷新时必定重新出现。
rs_id = "";
rs_restorable = 20;
rs_state_ready = false;
