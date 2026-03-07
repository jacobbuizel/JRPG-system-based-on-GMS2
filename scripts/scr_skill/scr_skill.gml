//技能表格枚举
enum DS_SKILL
{
	NAME = 0,
	S_ID = 1,
	SOURCE_COUNT = 2
}
enum DS_SPELL
{
	NAME = 0,
	S_ID = 1,
	ISENALBE = 2,
	ISENABLE = 2
}

/// @param id
function skill_id(_id){
#region 初始化
var _s_name = "???";
var _descr = "???";
var _scr = undefined;
//todo:更多技能的详细数据
#endregion
switch(_id)//技能数据
{
	default:
		//不变
		break;
	#region 徒手攻击
	case 1:
		_s_name = "徒手攻击";
		_descr = "直接用拳头、脚踢或肘击痛殴敌人。";
		break;
	#endregion
	#region 挥打
	case 1001:
		_s_name = "挥打";
		_descr = "用短棍痛殴敌人。";
		break;
	#endregion
	#region 射击
	case 1010:
		_s_name = "射击";
		_descr = "用轻弩射击敌人。";
		break;
	#endregion
	#region 法术
	case 2000:
		_s_name = "燃烧之手";
		break;
	case 2001:
		_s_name = "魅惑人类";
		break;
	case 2002:
		_s_name = "云雾术";
		break;
	case 2003:
		_s_name = "油腻术";
		break;
	case 2004:
		_s_name = "大步奔行";
		break;
	case 2005:
		_s_name = "法师护甲";
		break;
	case 2006:
		_s_name = "魔法飞弹";
		break;
	#endregion
}
return {
	s_name			: _s_name,
	s_id			: _id,
	descr			: _descr,
	scr				: _scr
};
}

//加载技能数据
/// @param id
function spell_id(_id){
return skill_id(_id);
}
function load_skill(_chara,_id){
var _s_id = ds_grid_get(_chara.skill_list,DS_SKILL.S_ID,_id);
var _skill = skill_id(_s_id);
return {
	s_name			: _skill.s_name,
	s_id			: _s_id,
	s_count			: ds_grid_get(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_id),
	
	descr			: _skill.descr,
	scr				: _skill.scr
}
}

//增加技能

//加载法术数据
function load_spell(_chara,_id){
var _s_id = ds_grid_get(_chara.spellbook_list,DS_SPELL.S_ID,_id);
var _spell = spell_id(_s_id);
return {
	s_name			: _spell.s_name,
	s_id			: _s_id,
	is_enable		: ds_grid_get(_chara.spellbook_list,DS_SPELL.ISENALBE,_id) == 1,

	descr			: _spell.descr,
	scr				: _spell.scr
}
}
function add_skill_id(_id,_chara){
var _skill = skill_id(_id);
var _skill_list_h = ds_grid_height(_chara.skill_list);

//情况1，角色已经获得该技能
for(var _i=0;_i<_skill_list_h;_i++)
{
	if(ds_grid_get(_chara.skill_list,DS_SKILL.S_ID,_i) == _id)
	{
		ds_grid_set(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_i,ds_grid_get(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_i)+1);
		return true;
	}
}

//情况2，角色还不会该技能
//如果表格有内容，就扩展一行
if (ds_grid_get(_chara.skill_list,0,0)!=0)
{
	ds_grid_resize(_chara.skill_list,skill_w,ds_grid_height(_chara.skill_list)+1);
}
var _new_skill = ds_grid_height(_chara.skill_list)-1;
ds_grid_set(_chara.skill_list,DS_SKILL.NAME,_new_skill,_skill.s_name);
ds_grid_set(_chara.skill_list,DS_SKILL.S_ID,_new_skill,_skill.s_id);
ds_grid_set(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_new_skill,1);
return true;
}

//删除技能

/// @param id
/// @param chara
/// @param is_enable*
function add_spell_id(_id,_chara,_ref_is_enable){
if argument_count>2
{
	var _is_enable = argument[2] ? 1 : 0;
}
else var _is_enable = 0;

if !variable_struct_exists(_chara, "spellbook_list") || !ds_exists(_chara.spellbook_list, ds_type_grid)
{
	_chara.spellbook_list = ds_grid_create(skill_w,1);
}
_chara.spellbook = true;

var _spell = spell_id(_id);
var _spell_list_h = ds_grid_height(_chara.spellbook_list);

for(var _i=0;_i<_spell_list_h;_i++)
{
	if(ds_grid_get(_chara.spellbook_list,DS_SPELL.S_ID,_i) == _id)
	{
		if _is_enable
		{
			if ds_grid_get(_chara.spellbook_list,DS_SPELL.ISENALBE,_i) != 1
			{
				ds_grid_set(_chara.spellbook_list,DS_SPELL.ISENALBE,_i,1);
				add_skill_id(_id,_chara);
			}
		}
		return true;
	}
}

if (ds_grid_get(_chara.spellbook_list,0,0)!=0)
{
	ds_grid_resize(_chara.spellbook_list,skill_w,ds_grid_height(_chara.spellbook_list)+1);
}
var _new_spell = ds_grid_height(_chara.spellbook_list)-1;
ds_grid_set(_chara.spellbook_list,DS_SPELL.NAME,_new_spell,_spell.s_name);
ds_grid_set(_chara.spellbook_list,DS_SPELL.S_ID,_new_spell,_spell.s_id);
ds_grid_set(_chara.spellbook_list,DS_SPELL.ISENALBE,_new_spell,_is_enable);
if _is_enable
{
	add_skill_id(_id,_chara);
}
return true;
}

function count_enabled_spell(_chara){
if !variable_struct_exists(_chara, "spellbook_list") || !ds_exists(_chara.spellbook_list, ds_type_grid)
{
	return 0;
}
if ds_grid_get(_chara.spellbook_list,DS_SPELL.NAME,0) == 0
{
	return 0;
}

var _count = 0;
for (var _i = 0; _i < ds_grid_height(_chara.spellbook_list); _i++)
{
	if ds_grid_get(_chara.spellbook_list,DS_SPELL.ISENALBE,_i) == 1
	{
		_count++;
	}
}
return _count;
}

function get_spell_enable_limit(_chara){
if _chara == undefined
{
	return 1;
}
var _int_m = (_chara.int div 2) - 5;
if variable_struct_exists(_chara, "int_m")
{
	_int_m = _chara.int_m;
}
return max(1, _int_m + _chara.level);
}

/// @param chara
/// @param row
/// @param is_enable
function set_spell_enable_by_row(_chara,_row,_is_enable){
if !variable_struct_exists(_chara, "spellbook_list") || !ds_exists(_chara.spellbook_list, ds_type_grid)
{
	return false;
}
if _row < 0 || _row >= ds_grid_height(_chara.spellbook_list)
{
	return false;
}
if ds_grid_get(_chara.spellbook_list,DS_SPELL.NAME,_row) == 0
{
	return false;
}

var _new_state = _is_enable ? 1 : 0;
var _spell_id = ds_grid_get(_chara.spellbook_list,DS_SPELL.S_ID,_row);
if _new_state == 0
{
	if ds_grid_get(_chara.spellbook_list,DS_SPELL.ISENALBE,_row) == 1
	{
		remove_skill_id(_spell_id,_chara);
	}
	ds_grid_set(_chara.spellbook_list,DS_SPELL.ISENALBE,_row,0);
	return true;
}

if ds_grid_get(_chara.spellbook_list,DS_SPELL.ISENALBE,_row) == 1
{
	return true;
}

if count_enabled_spell(_chara) >= get_spell_enable_limit(_chara)
{
	return false;
}

ds_grid_set(_chara.spellbook_list,DS_SPELL.ISENALBE,_row,1);
add_skill_id(_spell_id,_chara);
return true;
}
function remove_skill_id(_id,_chara){
if (!ds_exists(_chara.skill_list, ds_type_grid))
{
	return false;
}
var _skill_list_h = ds_grid_height(_chara.skill_list);

for (var _i = 0; _i < _skill_list_h; _i++)
{
	if (ds_grid_get(_chara.skill_list, DS_SKILL.S_ID, _i) == _id)
	{
		var _src = ds_grid_get(_chara.skill_list, DS_SKILL.SOURCE_COUNT, _i) - 1;
		
		//还有来源，只减数量
		if (_src > 0)
		{
			ds_grid_set(_chara.skill_list, DS_SKILL.SOURCE_COUNT, _i, _src);
			return true;
		}
		
		//来源为0，删除该行
		var _from = _i + 1;
		var _to = _i;
		for (var r=_to;r<_skill_list_h-1;r++)
		{
			ds_grid_set_grid_region(_chara.skill_list,_chara.skill_list,0,_from,skill_w-1,_from,0,r);
			_from += 1;
		}
		ds_grid_resize(_chara.skill_list,skill_w,_skill_list_h-1);
		_skill_list_h--;
		return true;
	}
}

// 没找到技能
return false;
}
