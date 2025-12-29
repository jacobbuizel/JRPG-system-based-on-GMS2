function reroomsatus(){
//表格x为房间内的对象实例，y1为对象实列状态，y2为刷新概率（0为绝不刷新。20为必定刷新）
//这里的代码将会重置所有房间的状态。

globalvar room_status;
room_status = ds_grid_create(1,4);

//测试房间1状态---------------
//1npc_6状态
add_roomsatus(0,0,0);

//1物品状态
add_roomsatus(0,0,0);

//2物品状态
add_roomsatus(0,0,20);

//3物品状态
add_roomsatus(0,0,20);

//4物品状态
add_roomsatus(0,0,20);

//5物品状态
add_roomsatus(0,0,20);

//6物品状态
add_roomsatus(0,0,20);

//7物品状态
add_roomsatus(0,0,20);

//8物品状态
add_roomsatus(0,0,20);

//测试房间2状态---------------
//1npc_5状态
add_roomsatus(1,0,0);

//2物品状态
add_roomsatus(1,0,20);

//3物品状态
add_roomsatus(1,0,15);

//4物品状态
add_roomsatus(1,0,10);

//5物品状态
add_roomsatus(1,0,10);

//6物品状态
add_roomsatus(1,0,5);

//7物品状态
add_roomsatus(1,0,5);

//8物品状态
add_roomsatus(1,0,0);

//9物品状态
add_roomsatus(1,0,0);

//10物品状态
add_roomsatus(1,0,0);

//11物品状态
add_roomsatus(1,0,0);

//12物品状态
add_roomsatus(1,0,10);

//13物品状态
add_roomsatus(1,0,10);

//14物品状态
add_roomsatus(1,0,10);

//15物品状态
add_roomsatus(1,0,10);

//16物品状态
add_roomsatus(1,0,10);

//17物品状态
add_roomsatus(1,0,10);

//18物品状态
add_roomsatus(1,0,10);

//19物品状态
add_roomsatus(1,0,10);

//20物品状态
add_roomsatus(1,0,10);

//21物品状态
add_roomsatus(1,0,10);

//22物品状态
add_roomsatus(1,0,10);

//23物品状态
add_roomsatus(1,0,10);

//24物品状态
add_roomsatus(1,0,10);

//25物品状态
add_roomsatus(1,0,10);

//26物品状态
add_roomsatus(1,0,0);

//27物品状态
add_roomsatus(1,0,0);

//28物品状态
add_roomsatus(1,0,0);

}

function add_roomsatus(_roomid,_status,_restorable){
ds_grid_set(room_status,0,_roomid*2,ds_grid_get(room_status,0,_roomid*2)+1);
if ds_grid_get(room_status,0,_roomid*2)>=ds_grid_width(room_status)
{
	ds_grid_resize(room_status,ds_grid_width(room_status)+1,ds_grid_height(room_status));
}
ds_grid_set(room_status,ds_grid_get(room_status,0,_roomid*2),_roomid*2,_status);
ds_grid_set(room_status,ds_grid_get(room_status,0,_roomid*2),_roomid*2+1,_restorable);
}

function restor_roomsatus(_roomid){
if _roomid >= 0
{
	for(var i = 1;i<ds_grid_width(room_status)-1;i++)
	{
		if ds_grid_get(room_status,i,_roomid*2+1)!=0
		{
			if ds_grid_get(room_status,i,_roomid*2+1)==20
			{
				ds_grid_set(room_status,i,_roomid*2,0);
			}
			else if irandom_range(1,20) <= ds_grid_get(room_status,i,_roomid*2+1)
			{
				ds_grid_set(room_status,i,_roomid*2,0);
			}
		}
	}
}
else if _roomid == -1
{
	for(var j = 0;j<ds_grid_get(room_status,0,j*2);j++)
	{
		for(var i = 1;i<ds_grid_width(room_status)-1;i++)
		{
			if ds_grid_get(room_status,i,j*2+1)!=0
			{
				if ds_grid_get(room_status,i,j*2+1)==20
				{
					ds_grid_set(room_status,i,j*2,0);
				}
				else if irandom_range(1,20) <= ds_grid_get(room_status,i,j*2+1)
				{
					ds_grid_set(room_status,i,j*2,0);
				}
			}
		}
	}
}
}