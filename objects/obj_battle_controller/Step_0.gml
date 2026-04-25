if !battle_current_exists()
{
	global.battle = false;
	global.pause = false;
	exit;
}

global.battle = true;
global.pause = true;

// Temporary debug exits until the real turn UI exists.
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
