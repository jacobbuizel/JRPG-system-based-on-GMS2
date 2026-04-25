// 如果没有战斗上下文，说明不是从 battle_start 进入的，直接恢复普通状态。
if !battle_current_exists()
{
	global.battle = false;
	global.pause = false;
	exit;
}

// 战斗房间期间强制暂停探索逻辑，避免 persistent 玩家/伙伴继续移动。
global.battle = true;
global.pause = true;

// 临时测试键：Z 按胜利结算，X 按逃跑结算。正式 UI 完成后会替换掉。
if akey
{
	battle_finish(BATTLE_RESULT.WIN);
	exit;
}
if bkey
{
	battle_finish(BATTLE_RESULT.ESCAPE);
	exit;
}
