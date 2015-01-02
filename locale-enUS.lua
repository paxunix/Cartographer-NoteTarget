-- $Id: locale-enUS.lua 35 2008-04-25 04:33:26Z sekuyo $

local L = AceLibrary("AceLocale-2.2"):new("NoteTarget")

L:RegisterTranslations("enUS", function() return {
    ["Diamond"] = true,
    ["Skull"] = true,
    ["Circle"] = true,

    ["Icon %s is no longer registered, using '%s'."] = true,

    ["Set %s icon for %s target notes."] = true,

    ["Foe - %s"] = true,
    ["Friend - %s"] = true,
    ["Location - %s"] = true,

    ["Sets a note for target at your location"] = true,
    ["Any arguments are stored in the note's info"] = true,

    ["Friend"] = true,
    ["Options for Friend notes"] = true,

    ["Icon"] = true,
    ["Choose icon for Friend notes"] = true,

    ["Color"] = true,
    ["Choose color for Friend note info"] = true,
    ["DogTag code"] = true,
    ["Set DogTag code for Friend notes"] = true,
    ["<any DogTag code>.  Type /dogtag for help."] = true,

    ["Foe"] = true,
    ["Options for Foe notes"] = true,

    ["Choose icon for Foe notes"] = true,

    ["Choose color for Foe note info"] = true,
    ["Set DogTag code for Foe notes"] = true,

    ["Location"] = true,
    ["Options for location notes"] = true,
    ["Choose icon for Location notes"] = true,
    ["Choose color for Location note info"] = true,

    ["Default creator"] = true,
    ["Specify the creator for new notes"] = true,
    ["If empty, your character's name is used"] = true,

    ["DefaultDogTag"] =
        "L[Level] [Classification] [CreatureType] [Class]",

    ["Slash-Commands"] = { "/ctnt", "/ctnotetarget", "/nt" },

    ["Set target note"] = true,

    ["You cannot make a note for another player."] = true,
    ["You cannot make a note for a pet or minion."] = true,

    ["^Level%s+%d+"] = true,

    ["With no target, you must give a description for the note at this location."] = true,
    ["Failed to create note:  unable to determine your location."] = true,

    ["Created note for %s"] = true,

} end)
