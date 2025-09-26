npc_default_behavior = 0;
npc_behavior = npc_default_behavior;

msg_id = "test_npc_6";
if ds_grid_get(room_status,1,0) == 0
{
	msg_id = "test_npc_6"
}
if ds_grid_get(room_status,1,0) == 1
{
	msg_id = "test_npc_6-1";
}