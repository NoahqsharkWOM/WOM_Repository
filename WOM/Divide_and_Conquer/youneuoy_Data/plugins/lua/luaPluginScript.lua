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
    M2TWEOP.setMaxBgSize(100);
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
    --Non-Music Events
    if eventData.eventCounter == "historic_event bree_wight_warning_1" then
        --local ourNamedCharacter = stratmap.game.getFaction(0):getNamedCharacter(1)
        --ourNamedCharacter.character:kill()
        --ourNamedCharacter.character:moveToTile(162,380)
    end

    --Music Intergation Start
    if eventData.eventCounter == "shire_start" then
        --local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DawnOfFaith.wav")
        --playSound(234, ourNewSound, true)
        --local ourType=ourCharacter:getTypeName("Bilbo");
        local ourNamedCharacter = stratmap.game.getFaction(0):getNamedCharacter(1)
        ourNamedCharacter.character:moveToTile(166,380)



        --local ourType=ourCharacter:getTypeName("Andy");
        --local army = stratmap.game.spawnArmy(
        --CAMPAIGN:getFaction("normans"),
        --"Bilbo",
        --"Bilbo Baggins",
        --characterType.named_character,
        --"bilbo_test",
        --"Bilbo",
        --166, 385,
        --90, false, 31,
        --M2TWEOPDU.getEduIndexByType("Dwarven Travellers"), 3, 0, 0
        --)
    end

    if eventData.eventCounter == "anduin_hobbit_journey_conclusion" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/Moss.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "anduin_greenwood_explored_1" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/SomewhereinBetween.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bd_ho_angmar_alliance_signed" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/LucifersWaltz.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bd_ho_angmar_dunedain_suppression_army_strike_victory" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/MethodsofMadness.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_merc_bandits_nephew_1" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/WrenhavenRiver.wav")
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

    if eventData.eventCounter == "bree_good_reinforcements_3" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/BurningStars.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_umbar_good" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/DawnOfFaith.wav")
        playSound(234, ourNewSound, true)
    end

    if eventData.eventCounter == "bree_finale_umbar_neutral" then
        local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/HeresaHealthtotheCompany.wav")
        playSound(234, ourNewSound, true)
    end

    --if eventData.eventCounter == "reginard_quest_start" then
    --    local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/CarmenHabanera.wav")
    --    playSound(234, ourNewSound, true)
    --end

    --if eventData.eventCounter == "lond_daer_mercenary_3" then
    --    local ourNewSound=M2TWEOPSounds.createEOPSound(M2TWEOP.getModPath().."/eopData/music/StormtheCastle.wav")
    --    playSound(234, ourNewSound, true)
    --end

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

--[[

Makes sure unique character names are actually unique by renaming the doppelgangers.
No more spies called "The Witch-king" or captains named "Captain Gandalf" etc.

Script by Wicked with help from Medik and Fynn (thanks to both of you, you beautiful people).

]]

function uniqueNames(charRecord)
    local angmarFactions = { "portugal", "slave" }
    local angmarNames = { "The Witch-king", "Agandaûr", "Hûnvorn", "Drangû", "Aphanuzîr" }
    local angmarCaptainNames = { "Captain The Witch-king", "Captain Agandaûr", "Captain Hûnvorn", "Captain Drangû",
            "Captain Aphanuzîr" }
    local angmarLabels = { "nazgula_p1", "agandaur_1", "hunvorn_1", "drangu_1", "aphanuzir_1" }

    local dunedainFactions = { "turks", "sicily", "denmark", "slave" }
    local dunedainNames = { "Aragorn", "Eldarion", "Gandalf", "Bilbo Baggins" }
    local dunedainCaptainNames = { "Captain Aragorn", "Captain Eldarion", "Captain Gandalf", "Captain Bilbo Baggins" }
    local dunedainLabels = { "aragorn_1", "eldarion_1", "gandalf_1", "gandalf_2", "bilbo_2" }

    local elvenFactions = { "saxons", "mongols", "ireland", "byzantium", "slave" }
    local elvenNames = { "Círdan", "Elrond", "Elladan", "Elrohir", "Gildor", "Dornornoston", "Glorfindel",
            "Thranduil", "Legolas", "Orthordir",
            "Celeborn", "Galadriel", "Haldir", "Rumil", "Orophin", "Enpremi", "Avl'yn", "Nurwe", "Elendil" }
    local elvenCaptainNames = { "Captain Círdan", "Captain Elrond", "Captain Elladan", "Captain Elrohir",
            "Captain Gildor", "Captain Dornornoston",
            "Captain Glorfindel", "Captain Thranduil", "Captain Legolas", "Captain Orthordir", "Captain Celeborn",
            "Captain Galadriel",
            "Captain Haldir", "Captain Rumil", "Captain Orophin", "Captain Enpremi", "Captain Avl'yn",
            "Captain Nurwe", "Captain Elendil" }
    local elvenLabels = { "cirdan_1", "elrond_1", "elladan_1", "elrohir_1", "gildor_1", "dornornoston_1",
            "glorfindel_1", "thranduil_1", "legolas_1",
            "orthordir_1", "celeborn_1", "galadriel_1", "galadriel_2", "haldir_1", "rumil_1", "orophin_1",
            "enpremi_1", "avlyn_1", "avlyn_2",
            "avlyn_3", "nurwe_1", "thranduil_union", "legolas_union", "orthordir_union", "celeborn_union",
            "haldir_union", "rumil_union,",
            "orophin_union", "enpremi_union" }

    local breeFactions = { "normans", "slave" }
    local breeNames = { "Bilbo Baggins", "Brathor", "Gandalf", "Aldaron", "Reginard", "The Wicked One", "Ajax, Defender Of Arnor", "Leao", "The Fog Lurker", "Karl", "Medik", "Galu The Gilded", 
    "Maverick", "Gareth", "Hazwood", "The Original Eclipse", "Fynn", "The Supreme One", "John", "Perry", "Lonesome Drifter", "Maximus", "Lerynian", 
    "The Frozen Stag", "Jojo", "Illanor", "Laneig", "Hûnaer", "The Councilor", "Farmer Maggot", "Behewan", "Borûg", "Dreadful Death", "Frodo", "Eredrim", "Frárín", "Gothmog", "Glorfindel", "Lorin", "The Witch-king", 
    "Overseer", "Pippin", "Merry", "Redhand", "Samwise", "Tithe-Keeper", "Aegnor", "Aragorn", "Barliman", "Bofur", "Brathor" }
    local breeCaptainNames = { "Captain Bilbo Baggins", "Captain Brathor", "Captain Gandalf", "Captain Aldaron",
            "Captain Reginard", "Captain The Wicked One", "Captain Ajax, Defender Of Arnor", "Captain Leao", "Captain The Fog Lurker", "Captain Karl", "Captain Medik", 
            "Captain Galu The Gilded", "Captain Maverick", "Captain Gareth", "Captain Hazwood", "Captain The Original Eclipse", "Captain Fynn", "Captain The Supreme One", "Captain John", 
            "Captain Perry", "Captain Lonesome Drifter", "Captain Maximus", "Captain Lerynian", "Captain The Frozen Stag", "Captain Jojo", "Captain Illanor", "Captain Laneig", 
            "Captain Hûnaer",  "Captain The Councilor", "Captain Farmer Maggot", "Captain Behewan", "Captain Borûg", "Captain Dreadful Death", "Captain Frodo", "Captain Eredrim", "Captain Frárín", "Captain Gothmog", 
            "Captain Glorfindel", "Captain Lorin", "Captain The Witch-king", "Captain Overseer", "Captain Pippin", "Captain Merry", "Captain Redhand", "Captain Samwise", "Captain Tithe-Keeper", "Captain Aegnor", 
            "Captain Aragorn", "Captain Barliman", "Captain Bofur", "Captain Brathor" }
    local breeLabels = { "bilbo_1", "gandalf_1", "gandalf_2", "brathor1", "aldaron_1", "reginard_1", "wicked_1", "ajax_1", "leao_1", "fog_1", "karl_1", "medik_1", "galu_1", "mav_1", "gareth_1", "hazwood_1", 
    "clips_1", "fynn_1", "nuke_1", "john_1", "perry_1", "ldrl_1", "yeet_1", "lerynian_1", "frozenstag_1", "jojo_1", "illanor_company", "laneig_company", "hunaer_company", "evil_councilor", "maggot_loyal", 
    "maggot_resistance", "behewan_mercenary", "borug_expedition", "borug_mercenary", "Dreadful", "frodo_1", "eredrim_1", "frarin_direct", "frarin_king", "frarin_normal", "gothmog_bree", "glorfindel_bree", 
    "lorin_company", "WKBree_1", "overseer_company", "lond_daer_attacker", "lond_daer_occupier", "mp_hobbit_journey", "pippin_greenway", "pippin_ents", "merry_greenway", "merry_ents", "redhand_company", 
    "redhand_company_trolls", "redhand_company_trolls_expedition", "redhand_company_expedition", "samwise_1", "tithe_keepers_1", "slave_attackers_Beorns_Hall_1", "aegnor_1", "aegnor_crusade", "aragorn_wulfrun", 
    "barliman_1", "barliman_resistance", "barliman_2", "bd_bofur_alive", "bd_bofur_dead", "brathor_1", "brathor_returned", "brathor_resistance" }

    local nazgulFactions = { "england", "poland", "france", "slave" }
    local nazgulNames = { "The Witch-king", "Gan Altan", "Balak’nar", "Khamûl", "Lagoren", "Aglarâkhôr", "Shi-vuus",
            "Zagar", "Leofric" }
    local nazgulCaptainNames = { "Captain The Witch-king", "Captain Gan Altan", "Captain Balak’nar", "Captain Khamûl",
            "Captain Lagoren", "Captain Aglarâkhôr",
            "Captain Shi-vuus", "Captain Zagar", "Captain Leofric" }
    local mordorFactions = { "england", "slave" }
    local mordorNames = { "Mouth Of Sauron", "Ancântar", "Sauron" }
    local mordorCaptainNames = { "Captain Mouth Of Sauron", "Captain Ancântar", "Captain Sauron" }
    local mordorLabels = { "mouthofsauron_1", "ancantar_1", "ancantar_2", "ancantar_3", "ancantar_4", "ancantar_5",
            "sauron_1" }

    local khandFactions = { "khand", "slave" }
    local khandNames = { "Alatar", "Pallando", "Ancântar" }
    local khandCaptainNames = { "Captain Alatar", "Captain Pallando", "Captain Ancântar" }
    local khandLabels = { "ancantar_1", "ancantar_2", "ancantar_3", "ancantar_4", "ancantar_5", "alatar_1",
            "alatar_2", "alatar_3", "alatar_4", "pallando_1",
            "pallando_2", "pallando_3", "pallando_4" }

    local anduinFactions = { "timurids", "slave" }

    local isengardFactions = { "france", "slave" }
    local isengardNames = { "Saruman", "Lúrtz", "Uglúk" }
    local isengardCaptainNames = { "Captain Saruman", "Captain Lúrtz", "Captain Uglúk" }
    local isengardLabels = { "saruman_1", "lurtz_1", "ugluk_1" }

    local dolguldurFactions = { "poland", "slave" }

    local dunlandFactions = { "aztecs", "slave" }

    local facName = charRecord.faction.name
    local displayName = charRecord.localizedDisplayName
    local charLabel = charRecord.label

    --- for Angmar
    if tableContainsElement(angmarFactions, facName) then
            if tableContainsElement(angmarNames, displayName)
                and not tableContainsElement(angmarLabels, charLabel) then
                    charRecord.savedDisplayName = "Fimran"
            end
            if tableContainsElement(angmarCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Éogan"
            end
    --- for ND, Gondor and Dol Amroth
    elseif tableContainsElement(dunedainFactions, facName) then
            if tableContainsElement(dunedainNames, displayName)
                and not tableContainsElement(dunedainLabels, charLabel) then
                    charRecord.savedDisplayName = "Hamen"
            end
            if tableContainsElement(dunedainCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Hallas"
            end
    --- for High Elves, Woodland Realm, Lorien and Dorwinion
    elseif tableContainsElement(elvenFactions, facName) then
            if tableContainsElement(elvenNames, displayName)
                and not tableContainsElement(elvenLabels, charLabel) then
                    charRecord.savedDisplayName = "Calanon"
            end
            if tableContainsElement(elvenCaptainNames, displayName) then
                    charRecord.savedDisplayName =
                    "Captain Elenion" --- needs label for avlyn_1, avlyn_2 and avlyn_3
            end
    --- Nazgul for Mordor, Dol Guldur, Isengard
    elseif tableContainsElement(nazgulFactions, facName) then
            if tableContainsElement(nazgulNames, displayName)
                and hasTrait(character.characterRecord, "Nazgul") == false then
                    charRecord.savedDisplayName = "Ishgaz"
            end
            if tableContainsElement(nazgulCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Grublik"
            end
    --- Mouth Of Sauron and Ancantar for Mordor
    elseif tableContainsElement(mordorFactions, facName) then
            if tableContainsElement(mordorNames, displayName)
                and not tableContainsElement(mordorLabels, charLabel) then
                    charRecord.savedDisplayName = "Nazdug"
            end
            if tableContainsElement(mordorCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Nazrôlg"
            end
    --- Khand
    elseif tableContainsElement(khandFactions, facName) then
            if tableContainsElement(khandNames, displayName)
                and not tableContainsElement(khandLabels, charLabel) then
                    charRecord.savedDisplayName = "Abáan"
            end
            if tableContainsElement(khandCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Tastán"
            end
    --- for Anduin Vale
    elseif tableContainsElement(anduinFactions, facName) then
            if displayName == "Radagast the Brown"
                and charLabel ~= "radagast_1" then
                    charRecord.savedDisplayName = "Barac"
            end
            if displayName == "Captain Radagast the Brown" then
                    charRecord.savedDisplayName = "Captain Barac"
            end
    --- for Bree
    elseif tableContainsElement(breeFactions, facName) then
            if tableContainsElement(breeNames, displayName)
                and not tableContainsElement(breeLabels, charLabel) then
                    charRecord.savedDisplayName = "Edmund"
            end
            if tableContainsElement(breeCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Largo"
            end
    --- for Isengard
    elseif tableContainsElement(isengardFactions, facName) then
            if tableContainsElement(isengardNames, displayName)
                and not tableContainsElement(isengardLabels, charLabel) then
                    charRecord.savedDisplayName = "Shaglúk"
            end
            if tableContainsElement(isengardCaptainNames, displayName) then
                    charRecord.savedDisplayName = "Captain Múggrish"
            end
    --- Ulairon for Dol Guldur
    elseif tableContainsElement(dolguldurFactions, facName) then
            if displayName == "Úlairon"
                and charLabel ~= "ulairon_1" then
                    charRecord.savedDisplayName = "Ûshbaká"
            end
            if displayName == "Captain Úlairon" then
                    charRecord.savedDisplayName = "Captain Yaglun"
            end
    --- Lurtz for Dunland
    elseif tableContainsElement(dunlandFactions, facName) then
            if displayName == "Lúrtz"
                and charLabel ~= "lurtz_1" then
                    charRecord.savedDisplayName = "Branan"
            end
            if displayName == "Captain Lúrtz" then
                    charRecord.savedDisplayName = "Captain Gorsad"
            end
    end
    M2TWEOP.logGame("log message");
end

