require('myconfigs')

-- Helper for managing persistence of tables across save/load
require('helpers/tableSave')

-- Uncomment to use EOP Helper functions
-- require('helpers/EopLuaHelpers')

-- Uncomment to use external debugger
-- require('helpers/mobdebug').start()

-- Our campaign config table.
campaignConfig = { ["someConfigValue"] = 5 };

-- Fires when loading a save file
function onLoadSaveFile(paths)
    campaignPopup = true;

    for index, path in pairs(paths) do
        if (string.find(path, "configTable.lua"))
        then
            -- Function from helper, load saved table
            campaignConfig = persistence.load(path);
        end
    end
end

-- Fires when creating a save file
-- Returns a list of M2TWEOP save files
function onCreateSaveFile()
    local savefiles = {};
    currentPath = M2TWEOP.getPluginPath();

    -- Function from helper, save our table
    persistence.store(currentPath .. "configTable.lua", campaignConfig);

    savefiles[1] = currentPath .. "configTable.lua";
    return savefiles;
end

-- Fires when the plugin is first loaded at game start or restarted with restartLua()
function onPluginLoad()
    M2TWEOP.unlockGameConsoleCommands();
    -- UNCOMMENT TO ENABLE BELOW SETTINGS
    --M2TWEOP.setAncillariesLimit(8);
    --M2TWEOP.setMaxBgSize(31);
    --M2TWEOP.setReligionsLimit(10);
    --M2TWEOP.setBuildingChainLimit(9);
    --M2TWEOP.setGuildCooldown(3);
end


--- Called after loading the campaign map
function onCampaignMapLoaded() 
    GAME_DATA = gameDataAll.get()
    CAMPAIGN = GAME_DATA.campaignStruct
    STRAT_MAP = GAME_DATA.stratMap
    BATTLE = GAME_DATA.battleStruct
    UI_MANAGER = GAME_DATA.uiCardManager
end


--- Called every time an image is rendered for display
---@param pDevice LPDIRECT3DDEVICE9 
function draw(pDevice)

    if soundPlaying.isPlaying then
        endSound()
    end

    ---- modder stuff
    if (ImGui.IsKeyPressed(ImGuiKey.GraveAccent))
    and (ImGui.IsKeyDown(ImGuiKey.LeftCtrl))
    then
        M2TWEOP.toggleConsole()
    elseif (ImGui.IsKeyPressed(ImGuiKey.GraveAccent))
    and (ImGui.IsKeyDown(ImGuiKey.LeftAlt))
    then
        M2TWEOP.toggleDeveloperMode()
    elseif (ImGui.IsKeyPressed(ImGuiKey.R))
        and (ImGui.IsKeyDown(ImGuiKey.LeftCtrl))
        and (ImGui.IsKeyDown(ImGuiKey.LeftShift))
    then
        M2TWEOP.restartLua()
    end
end


soundPlaying = {
    startTime = 0,
    duration = 0,
    userMusicVolume = 0,
    isPlaying = false
}

function playSound(duration, filename, force)
    if soundPlaying.isPlaying and not force then
        return
    end
    soundPlaying.userMusicVolume = M2TWEOP.getOptions2().musicVolume
    M2TWEOPSounds.playEOPSound(filename)
    soundPlaying.startTime = os.time()
    soundPlaying.duration = duration
    soundPlaying.isPlaying = true
    M2TWEOP.getOptions2().musicVolume = 0
end

function endSound()
    if os.time() > soundPlaying.startTime + soundPlaying.duration then
        M2TWEOP.getOptions2().musicVolume = soundPlaying.userMusicVolume
        soundPlaying.isPlaying = false
    end
end

--Event Triggers
function onEventCounter(eventData)
    --Music Intergation Start
    if eventData.eventCounter == "bree_unlock_script_info" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DawnOfFaith.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DawnOfFaith.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_neutral_finale_home_conclusion_start" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Deadwood.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_neutral_finale_home_conclusion_battle_won" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/FoundGodinaTomato.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_neutral_finale_home_conclusion_pre_battle_speech" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/ArmyoftheNight.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_neutral_finale_home_gambit" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/ToBeBetter.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_neutral_finale_home_wargs_predicament" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/TheHighWilderness.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_mission_complete" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/RedWaterDreams.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_mission" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/IBleedForYou.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_rangers_dead" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DevilsPrice.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_rangers" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Providence.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_resistance_intro" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Ashes.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_home_evil_start" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/CreepyMusicBox.wav")
        playSound(234, ourNewSound, true)
    end


    if eventData.eventCounter == "bree_finale_home_omen" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/ComeLittleChildren.wav")
        playSound(234, ourNewSound, true)
    end


    if eventData.eventCounter == "bree_evil_finale_home_intro" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DreamSweetinSeaMajor.wav")
        playSound(234, ourNewSound, true)
    end


    if eventData.eventCounter == "bree_good_finale_home_wulfrun_last_chance" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/ThroughtheFireandFlames.wav")
        playSound(234, ourNewSound, true)
    end


    if eventData.eventCounter == "bree_good_finale_home_wulfrun_gandalf" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/WeAllLiftTogether.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_good_finale_home_wulfrun_landed" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/TheStorm.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_umbar_evil" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Goetia.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "reginard_quest_start" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/CarmenHabanera.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "lond_daer_mercenary_3" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/StormtheCastle.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "lond_daer_mercenary_victory" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Weregonnabedrinking.wav")
        playSound(234, ourNewSound, true)
    end









    --Evil Homeland Finale Assassin Spawns
	if eventData.eventCounter == "home_finale_evil_rebellion" then
		newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 164, 380);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 165, 378);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 167, 378);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 165, 381);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 167, 381);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 166, 382);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 166, 377);
        newCharacter=stratmap.game.createCharacterByString("assassin",CAMPAIGN:getFaction("normans"),18,"Dreadful","Dreadful",31,"Maggot", 168, 380);
	end
end
