/// @param id
function item_id(_id){
switch _id
{
	default:
		return {i_name : "虚空404",
			weight : 0,
			price : 0,
			rarity : 0,
			type_i : "杂物",
			descr : "一个装着一张写着虚空404破纸的破袋子。",
			spr : spr_item,
			scr : undefined,
			i_id : 0,
			discardable : 1,
			consumables : 0
		}
	case 0.1:
		return {i_name : "极重无比的袋子",
			weight : 200,
			price : 0,
			rarity : 0,
			type_i : "杂物",
			descr : "这里面装的到底是啥啊，为什么这么重啊？",
			spr : spr_item_gr,
			scr : undefined,
			i_id : 0.1,
			discardable : 1,
			consumables : 0
		}
	case 0.2:
		return {i_name : "非常重要的袋子",
			weight : 0,
			price : 0,
			rarity : 0,
			type_i : "重要物品",
			descr : "一个非常重要的袋子，可不要弄丢了哦。",
			spr : spr_item_i,
			scr : [use_item_impbag],
			i_id : 0.2,
			discardable : 0,
			consumables : 0
		}
	case 1:
		return {i_name : "治疗药水",
			weight : 0.5,
			price : 50,
			rarity : 0,
			type_i : "魔药",
			descr : "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复4~10的生命值。",
			spr : spr_item_potion_r,
			scr : [use_item_1,2,4,2],
			i_id : 1,
			discardable : 1,
			consumables : 1
		}
	case 1.1:
		return {i_name : "高等治疗药水",
			weight : 0.5,
			price : 100,
			rarity : 1,
			type_i : "魔药",
			descr : "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复8~20的生命值。",
			spr : spr_item_potion_r1,
			scr : [use_item_1,4,4,4],
			i_id : 1.1,
			discardable : 1,
			consumables : 1
		}
	case 1.2:
		return {i_name : "强效治疗药水",
			weight : 0.5,
			price : 800,
			rarity : 2,
			type_i : "魔药",
			descr : "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复16~40的生命值。",
			spr : spr_item_potion_r2,
			scr : [use_item_1,8,4,8],
			i_id : 1.2,
			discardable : 1,
			consumables : 1
		}
	case 1.3:
		return {i_name : "极效治疗药水",
			weight : 0.5,
			price : 8000,
			rarity : 3,
			type_i : "魔药",
			descr : "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复30~60的生命值。",
			spr : spr_item_potion_r3,
			scr : [use_item_1,10,4,20],
			i_id : 1.3,
			discardable : 1,
			consumables : 1
		}
	case 2:
		return {i_name : "碎魔晶",
			weight : 0.5,
			price : 200,
			rarity : 1,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复2的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,2],
			i_id : 2,
			discardable : 1,
			consumables : 1
		}
	case 2.1:
		return {i_name : "魔晶",
			weight : 0.5,
			price : 400,
			rarity : 1,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复4的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,4],
			i_id : 2.1,
			discardable : 1,
			consumables : 1
		}
	case 2.2:
		return {i_name : "大块魔晶",
			weight : 0.5,
			price : 800,
			rarity : 2,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复6的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,6],
			i_id : 2.2,
			discardable : 1,
			consumables : 1
		}
	case 2.3:
		return {i_name : "小块高等魔晶",
			weight : 0.5,
			price : 3200,
			rarity : 2,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复8的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,8],
			i_id : 2.3,
			discardable : 1,
			consumables : 1
		}
	case 2.4:
		return {i_name : "高等魔晶",
			weight : 0.5,
			price : 6400,
			rarity : 3,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复10的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,10],
			i_id : 2.4,
			discardable : 1,
			consumables : 1
		}
	case 2.5:
		return {i_name : "大块高等魔晶",
			weight : 0.5,
			price : 12800,
			rarity : 3,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复12的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,12],
			i_id : 2.5,
			discardable : 1,
			consumables : 1
		}
	case 2.6:
		return {i_name : "小块纯净魔晶",
			weight : 0.5,
			price : 25600,
			rarity : 3,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复14的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,14],
			i_id : 2.6,
			discardable : 1,
			consumables : 1
		}
	case 2.7:
		return {i_name : "纯净魔晶",
			weight : 0.5,
			price : 51200,
			rarity : 4,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复16的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,16],
			i_id : 2.7,
			discardable : 1,
			consumables : 1
		}
	case 2.8:
		return {i_name : "大块纯净魔晶",
			weight : 0.5,
			price : 102400,
			rarity : 4,
			type_i : "奇物",
			descr : "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复20的法力值。",
			spr : spr_item_magic_crystal,
			scr : [use_item_2,20],
			i_id : 2.8,
			discardable : 1,
			consumables : 1
		}
	case 3:
		return {i_name : "空白卷轴",
			weight : 0,
			price : 1,
			rarity : 0,
			type_i : "卷轴",
			descr : "一张没有记录任何东西的空白卷轴。",
			spr : spr_item_scroll,
			scr : undefined,
			i_id : 3,
			discardable : 1,
			consumables : 0
		}
	case 4:
		return {i_name : "杂草",
			weight : 0,
			price : 0,
			rarity : 0,
			type_i : "材料",
			descr : "一把看上去没什么用的杂草，不过可以当成燃料烧或是紧急备用粮。",
			spr : spr_item_weed,
			scr : undefined,
			i_id : 4,
			discardable : 1,
			consumables : 0
		}
	case 5:
		return {i_name : "苹果",
			weight : 0.5,
			price : 1,
			rarity : 0,
			type_i : "食品",
			descr : "一颗熟透了的红苹果。",
			spr : spr_item_apple,
			scr : [use_item_apple],
			i_id : 5,
			discardable : 1,
			consumables : 1
		}
	case 6:
		return {i_name : "木棍",
			weight : 0.2,
			price : 0,
			rarity : 0,
			type_i : "材料",
			descr : "一根木棍，或许可以用来做点什么。",
			spr : spr_item_stick,
			scr : undefined,
			i_id : 6,
			discardable : 1,
			consumables : 0
		}
	case 7:
		return {i_name : "石头",
			weight : 0.5,
			price : 0,
			rarity : 0,
			type_i : "材料",
			descr : "一颗坚硬的石头。",
			spr : spr_item_rock,
			scr : undefined,
			i_id : 7,
			discardable : 1,
			consumables : 0
		}
	case 8:
		return {i_name : "断剑",
			weight : 3,
			price : 1,
			rarity : 0,
			type_i : "杂物",
			descr : "一把从中间断开来的剑，已经不能当作武器使用了。",
			spr : spr_item_broken_sword,
			scr : undefined,
			i_id : 8,
			discardable : 1,
			consumables : 0
		}
}
}

//这里是处理添加物品的代码
/// @param id
/// @param amount*
function add_item_id(_id,_ref_amount){
if argument_count>1
{
	var _amount = argument[1];
}
else var _amount = 1;
var _inventory_id = item_id(_id);

var i_name		= _inventory_id.i_name;
var amount		= _amount;
var i_id		= _inventory_id.i_id;

global.g_msg_name = i_name;

//情况1，物品已经在物品栏中
for(var i=0;i<ds_grid_height(inventory);i++)
{
	var _inventory = load_inventory(i);
	if(_inventory.i_id == i_id)
	{
		//判断物品是否到达上限
		var _old_amount = ds_grid_get(inventory,1,i);
        var _new_amount = _old_amount + amount;
		
		if (_new_amount > 999)
		{
			if _old_amount < 999
			{
				//限制获取量
				amount = 999 - _old_amount;
				ds_grid_set(inventory,1,i,_inventory.amount+amount);
				global.g_msg_amount = amount;
				return true;
			}
			//超过上限，不能增加
	        return false;
		}
		else
		{
			ds_grid_set(inventory,1,i,_inventory.amount+amount);
			global.g_msg_amount = amount;
			return true;
		}
	}
}

//情况2，物品未在物品栏中
if (amount > 999)
{
	//限制获取新物品的上限数量
	amount = 999;
}
if(ds_grid_get(inventory,0,0)!=0)
{
	ds_grid_resize(inventory,inventory_w,ds_grid_height(inventory)+1);
}
var new_item = ds_grid_height(inventory)-1;
ds_grid_set(inventory,0,new_item,i_name);
ds_grid_set(inventory,1,new_item,amount);
ds_grid_set(inventory,2,new_item,i_id);

global.g_msg_amount = amount;
return true;
}

//加载物品数据
function load_inventory(_id){
	var _i_id = ds_grid_get(inventory,2,_id)
	var _item = item_id(_i_id)
	return
	{
		i_name		: _item.i_name,
		amount		: ds_grid_get(inventory,1,_id),
		i_id		: _i_id,
		
		weight		: _item.weight,
		price		: _item.price,
		rarity		: _item.rarity,
		type_i		: _item.type_i,
		descr		: _item.descr,
		spr			: _item.spr,
		scr			: _item.scr,
		discardable	: _item.discardable,
		consumables	: _item.consumables,
	}
}