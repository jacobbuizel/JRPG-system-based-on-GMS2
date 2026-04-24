equip_id = equipment_id(0);
amount = 1;

// 房间状态系统：Creation Code 里应设置稳定的 rs_id。
// rs_restorable：0 不刷新，20 必定刷新，1..19 按 d20 判定。
// rs_state_ready：防止每帧重复从 room_status 覆盖实例数据。
rs_id = "";
rs_restorable = 0;
rs_state_ready = false;
