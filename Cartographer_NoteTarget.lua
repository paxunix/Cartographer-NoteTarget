-- $Id: Cartographer_NoteTarget.lua 35 2008-04-25 04:33:26Z sekuyo $


local L = AceLibrary("AceLocale-2.2"):new("NoteTarget")
local DogTag = AceLibrary("LibDogTag-3.0")
local DogTagUnit = AceLibrary("LibDogTag-Unit-3.0")

local defaultIconName = {
    friend = L["Diamond"],
    foe = L["Skull"],
    location = L["Circle"],
}

Cartographer_NoteTarget = Cartographer:NewModule("NoteTarget", "AceConsole-2.0")


-- Save icon choice and update addon submenu with new icon
-- t.type: "friend" if setting icon for friends, "foe" if for foes,
--      "location" if for locations
-- t.iconName: name of registered icon
-- t.iconDesc: human-friendly name of registered icon
-- t.iconPath: path for iconName
function Cartographer_NoteTarget:setIcon(t)
    AceLibrary("Dewdrop-2.0"):Close()

    -- If icon is no longer registered, fall back on default
    if not Cartographer_Notes:IsIconRegistered(t.iconName)
    then
        self:Print(L["Icon %s is no longer registered, using '%s'."],
            t.iconDesc, defaultIconName[t.type])
    end

    assert(t.type == "friend" or
           t.type == "foe" or
           t.type == "location")

    -- Update saved icon name and icon path in Carto menu
    self.db.profile[t.type].icon = t.iconName
    Cartographer.options.args.NoteTarget.args[t.type].args.iconChoice.icon =
        t.iconPath

    self:Print(L["Set %s icon for %s target notes."], t.iconDesc, t.type)
end     -- setIcon


local function getAceOpts(self)
    local iconChoiceGroup = {
        friendArgs = { },
        foeArgs = { },
        locationArgs = { },
    }

    local iconList = Cartographer_Notes:GetIconList()

    for k, v in pairs(iconList)
    do
        iconChoiceGroup.foeArgs[k] = {
            type = "execute",
            name = v.name,
            desc = string.format(L["Foe - %s"], v.name),
            func = "setIcon",
            icon = v.path,
            passValue = {
                type = "foe",
                iconName = k,
                iconDesc = v.name,
                iconPath = v.path,
            },
        }

        iconChoiceGroup.friendArgs[k] = {
            type = "execute",
            name = v.name,
            desc = string.format(L["Friend - %s"], v.name),
            func = "setIcon",
            icon = v.path,
            passValue = {
                type = "friend",
                iconName = k,
                iconDesc = v.name,
                iconPath = v.path,
            },
        }

        iconChoiceGroup.locationArgs[k] = {
            type = "execute",
            name = v.name,
            desc = string.format(L["Location - %s"], v.name),
            func = "setIcon",
            icon = v.path,
            passValue = {
                type = "location",
                iconName = k,
                iconDesc = v.name,
                iconPath = v.path,
            },
        }
    end

    return {
        name = "NoteTarget",
        desc = L["Sets a note for target at your location"],
        handler = self,
        type = "group",
        args = {
            friend = {
                name = L["Friend"],
                order = 25,
                desc = L["Options for Friend notes"],
                type = "group",
                args = {
                    iconChoice = {
                        name = L["Icon"],
                        desc = L["Choose icon for Friend notes"],
                        type = "group",
                        args = iconChoiceGroup.friendArgs,
                        icon = iconList[self.db.profile.friend.icon].path or
                            defaultIconName.friend,
                    },
                    rgb = {
                        name = L["Color"],
                        desc = L["Choose color for Friend note info"],
                        type = "color",
                        get = function()
                                local color = self.db.profile.friend.color
                                return color.r, color.g, color.b
                              end,
                        set = function(r, g, b, a)
                                self.db.profile.friend.color.r = r
                                self.db.profile.friend.color.g = g
                                self.db.profile.friend.color.b = b
                              end,
                    },
                    dogtag = {
                        name = L["DogTag code"],
                        desc = L["Set DogTag code for Friend notes"],
                        type = "text",
                        get = function()
                                return self.db.profile.friend.dogtag
                              end,
                        set = function(v)
                                self.db.profile.friend.dogtag = v
                              end,
                        usage = L["<any DogTag code>.  Type /dogtag for help."],
                    },
                }   -- args
            },  -- friend
            foe = {
                name = L["Foe"],
                order = 50,
                desc = L["Options for Foe notes"],
                type = "group",
                args = {
                    iconChoice = {
                        name = L["Icon"],
                        desc = L["Choose icon for Foe notes"],
                        type = "group",
                        args = iconChoiceGroup.foeArgs,
                        icon = iconList[self.db.profile.foe.icon].path or
                                    defaultIconName.foe,
                    },
                    rgb = {
                        name = L["Color"],
                        desc = L["Choose color for Foe note info"],
                        type = "color",
                        get = function()
                                local color = self.db.profile.foe.color
                                return color.r, color.g, color.b
                              end,
                        set = function(r, g, b, a)
                                self.db.profile.foe.color.r = r
                                self.db.profile.foe.color.g = g
                                self.db.profile.foe.color.b = b
                              end,
                    },
                    dogtag = {
                        name = L["DogTag code"],
                        desc = L["Set DogTag code for Foe notes"],
                        type = "text",
                        order = -1,
                        get = function()
                                return self.db.profile.foe.dogtag
                              end,
                        set = function(v)
                                self.db.profile.foe.dogtag = v
                              end,
                        usage = L["<any DogTag code>.  Type /dogtag for help."],
                    },
                }   --args
            },  -- foe
            location = {
                name = L["Location"],
                order = 70,
                desc = L["Options for location notes"],
                type = "group",
                args = {
                    iconChoice = {
                        name = L["Icon"],
                        desc = L["Choose icon for Location notes"],
                        type = "group",
                        args = iconChoiceGroup.locationArgs,
                        icon = iconList[self.db.profile.location.icon].path or
                                    defaultIconName.location,
                    },
                    rgb = {
                        name = L["Color"],
                        desc = L["Choose color for Location note info"],
                        type = "color",
                        get = function()
                                local color = self.db.profile.location.color
                                return color.r, color.g, color.b
                              end,
                        set = function(r, g, b, a)
                                self.db.profile.location.color.r = r
                                self.db.profile.location.color.g = g
                                self.db.profile.location.color.b = b
                              end,
                    },
                }   --args
            },  -- location
            creator = {
                name = L["Default creator"],
                order = 100,
                desc = L["Specify the creator for new notes"],
                type = "text",
                get = function()
                        return self.db.profile.creator
                      end,
                set = function(v)
                        self.db.profile.creator = v
                      end,
                usage = L["If empty, your character's name is used"],
            },  -- creator
        }   -- group args
    }
end     -- getAceOpts


function Cartographer_NoteTarget:OnInitialize()
    self.author = "Sekuyo"
    self.category = "Map"
    self.email = "sekuyo13@gmail.com"
    self.license = "GPL v2"
    self.name = "Cartographer_NoteTarget"
    self.notes = "Slash command for setting notes with location or target's details"
    self.title = "Cartographer_NoteTarget"
    self.website = "http://code.google.com/p/sekuyo-wow/wiki/Cartographer_NoteTarget"

    self.db = Cartographer:AcquireDBNamespace("NoteTarget")

    local defaultDogTag = L["DefaultDogTag"]

    Cartographer:RegisterDefaults("NoteTarget", "profile",
    {
        friend = {
            color = { r = 0, g = 0.5, b = 1 },
            icon = defaultIconName.friend,
            dogtag = defaultDogTag,
        },

        foe = {
            color = { r = 1, g = 0.25, b = 0 },
            icon = defaultIconName.foe,
            dogtag = defaultDogTag,
        },

        location = {
            icon = defaultIconName.location,
            color = { r = 1, g = 1, b = 1 },
        },

        creator = "NoteTarget",
    })

    Cartographer.options.args["NoteTarget"] = getAceOpts(self)

    AceLibrary("AceConsole-2.0"):InjectAceOptionsTable(self,
        Cartographer.options.args.NoteTarget)

    self:RegisterChatCommand(L["Slash-Commands"],
        function(arg)
            self:setTargetNote(arg)
        end
        )
end     -- OnInitialize


local function getNoteInfo(self, info2)
    if UnitIsPlayer("target")
    then
        self:Print(L["You cannot make a note for another player."])
        return
    end

    if UnitPlayerControlled("target")
    then
        self:Print(L["You cannot make a note for a pet or minion."])
        return
    end

    local noteInfo = {
        title = DogTag:Evaluate("[Name]", "Unit", { unit = "target" }) or "",
        info1 = DogTag:Evaluate("[Guild]", "Unit", { unit = "target" }) or "",
        info2 = info2 or "",      -- use slash command arg, if given
        friendly = UnitIsFriend("player", "target"),
    }

    -- if something was targeted
    if noteInfo.friendly ~= nil
    then
        -- If description is only target's level, or contains the target's
        -- name then use empty description.
        if string.find(noteInfo.info1, L["^Level%s+%d+"]) or
           string.find(string.lower(noteInfo.title),
                       string.lower(noteInfo.info1))
        then
            noteInfo.info1 = ""
        end

        -- If something was targeted, use dogtag for note's info2
        noteInfo.info2 = DogTag:Evaluate(noteInfo.friendly and
                        self.db.profile.friend.dogtag or
                        self.db.profile.foe.dogtag,
                            "Unit", { unit = "target" })
    else
        -- if something wasn't targeted, the location becomes info1 and
        -- there must be a slash arg for the title
        if not info2 or info2 == ""
        then
            self:Print(L["With no target, you must give a description for the note at this location."]);
            return
        else
            noteInfo.title = info2
            noteInfo.info1 = GetMinimapZoneText()
            noteInfo.info2 = ""
        end
    end

    return noteInfo
end     -- getNoteInfo


-- Places a note with the target's details at the character's current
-- position.
-- arg:  the text after the slash command, if any.  If set, this text is
--       used as the target's info instead of the dogtag.
function Cartographer_NoteTarget:setTargetNote(arg)
    local x, y = GetPlayerMapPosition("player")
    if x == 0 and y == 0
    then
        self:Print(L["Failed to create note:  unable to determine your location."])
        return
    end

    local noteInfo = getNoteInfo(self, arg)
    if not noteInfo
    then
        return
    end

    local settings
    local theIcon

    -- .friendly is not nil if there was a target for the note
    if noteInfo.friendly ~= nil
    then
        settings = noteInfo.friendly and self.db.profile.friend or
                                         self.db.profile.foe
        theIcon = Cartographer_Notes:IsIconRegistered(settings.icon) and
                    settings.icon or
                        (noteInfo.friendly and defaultIconName.friend or
                                               defaultIconName.foe)
    else
        settings = self.db.profile.location
        theIcon = settings.icon or defaultIconName.location
    end

    local creator = self.db.profile.creator == "" and (UnitName("player")) or
                        self.db.profile.creator

    Cartographer_Notes:SetNote(GetRealZoneText(), x, y, theIcon,
        creator,
        'manual', true,
        'title', noteInfo.title,
        'titleR', settings.color.r,
        'titleG', settings.color.g,
        'titleB', settings.color.b,
        'info', noteInfo.info1,
        'info2', noteInfo.info2)

    self:Print(string.format(L["Created note for %s"],
                noteInfo.title))
end     -- setTargetNote
