extends Node

## Lists the current networked players
## Key = EntityID : Value = PlayerName
## Bots have a 4 number ID, while players will have an 8 number ID
## All IDs are Integers
var networkedPlayers = {

}

const BOT_NAMES = [
    "Capn Obvius",
    "MoustachedWar",
    "OxfordComma",
    "JDzX",
    "BereBery",
    "Dotso",
    "Laney03",
    "CentBox",
    "Gabler",
    "Golemri",
    "Linget",
    "Prattin",
    "SoccerLyfe",
    "TrackerRoz",
    "Boltex",
    "Crawlerildr",
    "Gemmagy",
    "Haymisab",
    "LummoAbove",
    "Revini",
    "Stegoty",
    "weeddi",
    "Briconia",
    "Dinged",
    "Godatro",
    "LawnExtra",
    "MessagesWitch",
    "Scannoyer",
    "TenPrecise",
    "GoodPlayer223",
    "Everma",
    "Lindebasi",
    "Plotiona",
    "Shardis",
    "TigerBoosh",
    "BanditFix",
    "Inextsoft55",
    "Medtershe",
    "RollXan",
    "Washton",
    "Amesiani",
    "BoostMura",
    "Insides",
    "NearlyPool97",
    "ScoobyWow",
    "Truestem",
    "Bracess",
    "LessChronos",
    "NeoRadiant",
    "UnderWa",
    "BristleKemp",
    "TheSnail2",
    "PapaHeadline",
    "RealMore",
    "SpunkyBroadway",
    "xVengeans",
    "Forumenti",
    "Nanosakim",
    "Studison",
    "Bentlor",
    "CowPow1",
    "BeefyCheesy",
    "Landerne",
    "Percsha",
    "Solidgene",
    "TacticAngles",
    "Wizewiz5",
    "Callarts",
    "Hondatash",
    "Lightshma",
    "Pinkin",
    "Spydersans",
    "Talenta",
    "UntamedLlama",
    "QuotePerson87",
    "Stonefire",
    "Biocalo",
    "Currica",
    "Borgizen",
    "Florrekko",
    "Lentiva",
    "MrWar",
    "TigerNees",
    "DragonQ",
    "Godanque",
    "Pongle557",
    "UpforceSign",
    "McNephew",
    "Pandee",
    "Venuest9",
    "SweetieDown",
    "TwinkleStarSprite",
    "TickleMeBatman",
    "Casualte42",
    "JoshXoo",
    "Postic",
    "DatingSimEsports101",
    "NaanViolence09",
    "MotoHead",
    "InAMeeting",
    "AlexUhPlayDespotSeeToe",
    "BloodbathAndBeyond",
    "1v1 Me",
    "CapnTanktop",
    "8BitPoultry",
    "UnstoppableMenbun",
    "GoatOnaMission",
    "SheepOfFury",
    "UntamedSheep",
    "GoatAteMyHomework",
    "AlarminglyPeppy",
    "GooglyEyeballs",
    "BruhBruh",
    "ReinDoge",
    "SaladCat",
    "WhichButtonIsTaunt",
    "HardcoreCasual",
    "NoJons",
    "ItsMonday"
]