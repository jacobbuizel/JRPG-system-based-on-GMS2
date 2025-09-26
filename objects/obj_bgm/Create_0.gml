c_bgm = 0;
bgm_playing = false;
bgm_looping = false;
bgm_v = global.bgm_v;
bgm = 0;
bgm2 = 0;

if !audio_group_is_loaded(audiogroup_BGM)
{
    audio_group_load(audiogroup_BGM);
}
if !audio_group_is_loaded(audiogroup_BGM_2)
{
    audio_group_load(audiogroup_BGM_2);
}

audio_group_set_gain(audiogroup_BGM_2,0,0);