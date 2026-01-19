/// 保存设置到 setting.sav
function scr_setting_save() {
    var _settings = {
        bgm_v: global.bgm_v,
        sfx_v: global.sfx_v,
        bgs_v: global.bgs_v,
		auto_run: global.auto_run
    };

    var _json = json_stringify(_settings);
    var _buffer = buffer_create(string_byte_length(_json) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _json);
    buffer_save(_buffer, "setting.sav");
    buffer_delete(_buffer);
}

/// 从 setting.sav 加载设置
function scr_setting_load() {
    if !file_exists("setting.sav") {
        // 默认设置
        global.bgm_v = 1;
        global.sfx_v = 1;
        global.bgs_v = 1;
        exit;
    }

    var _buffer = buffer_load("setting.sav");
    var _json = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);

    var _settings = json_parse(_json);

    global.bgm_v = _settings.bgm_v;
    global.sfx_v = _settings.sfx_v;
    global.bgs_v = _settings.bgs_v;
	global.auto_run = _settings.auto_run;

    // 应用音频设置
    audio_group_set_gain(audiogroup_BGM, global.bgm_v, 0);
    audio_group_set_gain(audiogroup_SFX, global.sfx_v, 0);
    audio_group_set_gain(audiogroup_BGS, global.bgs_v, 0);
}
