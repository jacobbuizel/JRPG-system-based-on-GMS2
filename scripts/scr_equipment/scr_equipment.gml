/// @param id
function equipment_id(_id){
var _e_name				= "皇帝的新剑";		//装备名字
var _weight				= 0;				//装备重量
var _price				= 0;				//装备价格
var _rarity				= 0;				//装备品质
var _type_e				= "longsword";		//装备类别
var _type_descr			= "剑？";			//装备类别的风味描述
//装备描述
var _descr				= "只有聪明人还有传说中的“系统管理员”才能看到的剑。　“系统管理员？”　“嘘，小声点，我们可不能让他们知道这个东西在这。”";
var _spr				= spr_equipment;	//装备贴图
var _e_id				= 0;				//装备唯一ID
var _discardable		= 1;				//是否可丢弃
var _consumables		= 0;				//是否消耗品
var _equip_parts		= 0;				//装备部位，0为双手都占用，1为仅主手（main_h），2为可主可副（main_h,sec_h），3为护甲（armor），4为配饰A到C（accessoryA,accessoryB,accessoryC），5为弹药A到D（ammunitionA,ammunitionB,ammunitionC,ammunitionD）
var _durability			= -1;				//耐久度上限，负数为不可破坏，若为正数则需要配合特殊行为脚本使用
var _stackable			= 0;				//是否可堆叠，0和1都为不可堆叠，大于1则为可堆叠的数量，建议不要大于999
var _atk_bon			= 0;				//命中加值
//伤害区间[骰子数,骰子面,伤害加值,使用属性值(0为不使用,1为使用,2为叠加使用,多个参数为1则只使用最高的属性,而多个参数为2将会包括1里的最高值一起叠加使用)]
var _atk_scale			= [1,1,0,{str:1,dex:0,con:0,int:0,wis:0,cha:0}];
var _ac_bon				= 0;				//护盾加值
var _sav_bon			= 0;				//豁免加值
//基础护盾值[基础值(0则为不更改护盾值，高于0的数值会取代角色原来的护盾值所以默认最好不要低于10),使用属性值(0为不使用,>1为使用但限制特定值,由于不作弊的情况下一个属性值不太可能能叠到加值为10以上，所以需要不设护甲加值上限的情况下写10就可以了)]
var _ac_base			= [0,{str:0,dex:1,con:0,int:0,wis:0,cha:0}];
var _resist				= {					//装备该装备后针对某伤害的修正，0为免疫，0.5为抗性，1为无任何修正，2为易伤
	damageBlunt:1,		//钝击
	damagePuncture:1,	//穿刺
	damageSlash:1,		//挥砍
	damageAcid:1,		//强酸
	damageCold:1,		//冷冻
	damageFire:1,		//火焰
	damageForce:1,		//力场
	damageLightning:1,	//闪电
	damageNecrotic:1,	//黯蚀
	damagePoison:1,		//毒素
	damagePsychic:1,	//心灵
	damageRadiant:1,	//光耀
	damageSonic:1,		//音波
}
var _attr_mod			= {					//装备该装备后修改角色面板的情况，0为无修改
	str:0,
	dex:0,
	con:0,
	int:0,
	wis:0,
	cha:0
}
//特殊行为脚本
var _on_equip_scr		= undefined;		//装备时
var _on_unequip_scr		= undefined;		//移除时
//战斗时的行为脚本
var _on_attack_scr		= undefined;		//发动攻击时
var _on_atkhit_scr		= undefined;		//攻击命中时
var _on_hit_scr			= undefined;		//受到伤害时

switch _id
{
	default:
		//保持默认值，不做处理
		break;
	
	case 1:
		_e_name				= "短棍";
		_weight				= 2;
		_price				= 1;
		_rarity				= 0;
		_type_e				= "Club";
		_type_descr			= "棍";
		_descr				= "一把小巧的棍子。造成1~4+力量调整值伤害。";
		_spr				= spr_club;
		_e_id				= 1;
		_discardable		= 1;
		_consumables		= 0;
		_equip_parts		= 2;
		_durability			= -1;
		_stackable			= 0;
		_atk_bon			= 0;
		_atk_scale			= [1,4,0,{str:1,dex:0,con:0,int:0,wis:0,cha:0}];
		break;
	
	case 10:
		_e_name				= "轻弩";
		_weight				= 5;
		_price				= 25;
		_rarity				= 0;
		_type_e				= "lightCrossbow";
		_type_descr			= "轻弩";
		_descr				= "一把便于携带的轻型弩。造成1~8+敏捷调整值伤害。";
		_spr				= spr_lightcrossbow;
		_e_id				= 10;
		_discardable		= 1;
		_consumables		= 0;
		_equip_parts		= 0;
		_durability			= -1;
		_stackable			= 0;
		_atk_bon			= 0;
		_atk_scale			= [1,8,0,{str:0,dex:1,con:0,int:0,wis:0,cha:0}];
		break;
	
	case 100:
		_e_name				= "皮甲";
		_weight				= 10;
		_price				= 10;
		_rarity				= 0;
		_type_e				= "LightArmor";
		_type_descr			= "轻甲";
		_descr				= "一种十分轻便而实惠的护甲，其护胸和护肩均使用硬化的皮制成。护甲等级为11+敏捷调整值。";
		_spr				= spr_leatherarmor;
		_e_id				= 100;
		_discardable		= 1;
		_consumables		= 0;
		_equip_parts		= 3;
		_durability			= -1;
		_stackable			= 0;
		_ac_bon				= 0;
		_sav_bon			= 0;
		_ac_base			= [11,{str:0,dex:10,con:0,int:0,wis:0,cha:0}];
		break;
	
	case 120:
		_e_name				= "小木盾";
		_weight				= 3;
		_price				= 5;
		_rarity				= 0;
		_type_e				= "Shield";
		_type_descr			= "盾牌";
		_descr				= "一个看起来不是很牢固的小木盾。装备后护甲获得+1加值。";
		_spr				= spr_woodenshield;
		_e_id				= 120;
		_discardable		= 1;
		_consumables		= 0;
		_equip_parts		= 2;
		_durability			= -1;
		_stackable			= 0;
		_atk_bon			= 0;
		_atk_scale			= [1,1,0,{str:1,dex:0,con:0,int:0,wis:0,cha:0}];
		_ac_bon				= 1;
		_sav_bon			= 0;
		_ac_base			= [0,{str:0,dex:0,con:0,int:0,wis:0,cha:0}];
		break;
	
	case 150:
		_e_name				= "弩矢";
		_weight				= 0.075;
		_price				= 0.05;
		_rarity				= 0;
		_type_e				= "CrossbowBolts";
		_type_descr			= "弩矢";
		_descr				= "用于弩一类武器的普通驽矢。";
		_spr				= spr_crossbowbolts;
		_e_id				= 150;
		_discardable		= 1;
		_consumables		= 1;
		_equip_parts		= 5;
		_durability			= -1;
		_stackable			= 80;
		_atk_bon			= 0;
		_atk_scale			= [0,0,0,{str:0,dex:0,con:0,int:0,wis:0,cha:0}];
		break;
}

//返回数据
return {
	e_name			: _e_name,
	weight			: _weight,
	price			: _price,
	rarity			: _rarity,
	type_e			: _type_e,
	type_descr		: _type_descr,
	descr			: _descr,
	spr				: _spr,
	e_id			: _e_id,
	discardable		: _discardable,
	consumables		: _consumables,
	equip_parts		: _equip_parts,
	durability		: _durability,
	stackable		: _stackable,
	atk_bon			: _atk_bon,
	atk_scale		: _atk_scale,
	ac_bon			: _ac_bon,
	sav_bon			: _sav_bon,
	ac_base			: _ac_base,
	resist			: _resist,
	attr_mod		: _attr_mod,
	on_equip_scr	: _on_equip_scr,
	on_unequip_scr	: _on_unequip_scr,
	on_attack_scr	: _on_attack_scr,
	on_atkhit_scr	: _on_atkhit_scr,
	on_hit_scr		: _on_hit_scr,
}
}

//这里是处理添加物品
/// @param id
/// @param amount*
/// @param cur_durability*
function add_equipment_id(_id,_ref_amount,_cur_durability){
var equip_id = equipment_id(_id);
if argument_count>1
{
	var _amount = argument[1];
}
else var _amount = 1;
if argument_count>2
{
	var cur_durability = argument[2];
}
else var cur_durability = equip_id.durability;
var e_name = equip_id.e_name;
var amount = _amount;
var e_id = equip_id.e_id;
var stackable = equip_id.stackable;

if (stackable > 1) //情况1，可堆叠装备
{
	//遍历已有组，填满未满的组
	for(var i=0;i<ds_grid_height(equipment);i++)
	{
		var _equipment = load_equipment(i)
		if(_equipment.e_id == e_id)
		{
			//判断并计算堆叠
			var _old_amount = ds_grid_get(equipment,1,i);
			if (_old_amount < stackable)
			{
				var _space = stackable - _old_amount;
				var _add = min(amount, _space);
					
				ds_grid_set(equipment,1,i,_old_amount+_add);
				amount -= _add;
				if (amount <= 0)
				{
					global.g_msg_name = e_name;
					global.g_msg_amount = _amount;
					return true;
				}
			}
		}
	}
}
while(amount > 0)
{
	if stackable <= 0
	{
		stackable = 1;
	}
	var _new_amount = min(amount,stackable);
	amount -= _new_amount;
	
	show_debug_message(string(_new_amount));
	
	if(ds_grid_get(equipment,0,0)!=0)
	{
		ds_grid_resize(equipment,equipment_w,ds_grid_height(equipment)+1);
	}
	
	var new_row = ds_grid_height(equipment)-1;
		
	//填充新组数据
    ds_grid_set(equipment,0,new_row,e_name);
    ds_grid_set(equipment,1,new_row,_new_amount);
    ds_grid_set(equipment,2,new_row,e_id);
	ds_grid_set(equipment,3,new_row,cur_durability);
}
global.g_msg_name = e_name;
global.g_msg_amount = _amount;
equipmentEND = min(ds_grid_height(equipment),17);
equip_empty = false;
return true;
}

//加载装备数据
function load_equipment(_id){
	var _e_id = ds_grid_get(equipment,2,_id)
	var _item = equipment_id(_e_id)
	return {
		e_name			: _item.e_name,
		amount			: ds_grid_get(equipment,1,_id),
		e_id			: _e_id,
		cur_durability	: ds_grid_get(equipment,3,_id),
		durability		: _item.durability,
		weight			: _item.weight,
		price			: _item.price,
		rarity			: _item.rarity,
		type_e			: _item.type_e,
		type_descr		: _item.type_descr,
		descr			: _item.descr,
		spr				: _item.spr,
		discardable		: _item.discardable,
		consumables		: _item.consumables,
		equip_parts		: _item.equip_parts,
		stackable		: _item.stackable,
		atk_bon			: _item.atk_bon,
		atk_scale		: _item.atk_scale,
		ac_bon			: _item.ac_bon,
		sav_bon			: _item.sav_bon,
		ac_base			: _item.ac_base,
		resist			: _item.resist,
		attr_mod		: _item.attr_mod,
		on_equip_scr	: _item.on_equip_scr,
		on_unequip_scr	: _item.on_unequip_scr,
		on_attack_scr	: _item.on_attack_scr,
		on_atkhit_scr	: _item.on_atkhit_scr,
		on_hit_scr		: _item.on_hit_scr,
	}
}