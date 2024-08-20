AddCSLuaFile()

--[[
-----------------------------------------------------------------------------------------------------
Ammo Tables
-----------------------------------------------------------------------------------------------------
]]

game.AddAmmoType( {
name = "scp-244",
} )

--[[
-----------------------------------------------------------------------------------------------------
Sound Tables
-----------------------------------------------------------------------------------------------------
]]

---- SCP-244

----------------------------------------------------------------------------------------- SCP-244

sound.Add( {
    name = "scpsl_244_equip1",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/Jar1Equip.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_equip2",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/Jar2Equip.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_use1",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/Jar1Use.wav",
    }
} ) 
sound.Add( {
    name = "scpsl_244_use2",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/Jar2Use.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_use1",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/Jar1Use.wav",
    }
} ) 
sound.Add( {
    name = "scpsl_244_break",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 75,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/JarBreak_1.wav",
		"weapons/scpsl/244/JarBreak_2.wav",
		"weapons/scpsl/244/JarBreak_3.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_pressure",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 75,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/244/244Pressure.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_emit",
    channel = CHAN_CHAN,
    volume = 1,
    level = 75,
    pitch = {95, 100},
	looping = 1,
    sound = {
        "weapons/scpsl/244/244Emit3.wav",
    }
} )
sound.Add( {
    name = "scpsl_244_freeze",
    channel = CHAN_STATIC,
    volume = 0.3,
    level = 75,
    pitch = {95, 100},
	looping = 1,
    sound = {
        "weapons/scpsl/244/244Cold.wav",
    }
} )
