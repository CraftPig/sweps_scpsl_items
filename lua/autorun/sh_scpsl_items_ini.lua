AddCSLuaFile()

--[[
-----------------------------------------------------------------------------------------------------
Ammo Tables
-----------------------------------------------------------------------------------------------------
]]

game.AddAmmoType( {
name = "scp-244",
} )
game.AddAmmoType( {
name = "scp-018",
} )
game.AddAmmoType( {
name = "flashbang",
} )

--[[
-----------------------------------------------------------------------------------------------------
Sound Tables
-----------------------------------------------------------------------------------------------------
]]

---- SCP-244
---- SCP-018

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

----------------------------------------------------------------------------------------- SCP-018

sound.Add( {
    name = "scpsl_018_low",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 65,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/018/018_Bounce_Low_1.wav",
		"weapons/scpsl/018/018_Bounce_Low_2.wav",
		"weapons/scpsl/018/018_Bounce_Low_3.wav",
		"weapons/scpsl/018/018_Bounce_Low_4.wav",
		"weapons/scpsl/018/018_Bounce_Low_5.wav",
    }
} )
sound.Add( {
    name = "scpsl_018_med",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 70,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/018/018_Bounce_Med_2.wav",
		"weapons/scpsl/018/018_Bounce_Med_3.wav",
		"weapons/scpsl/018/018_Bounce_Med_4.wav",
		"weapons/scpsl/018/018_Bounce_Med_5.wav",
    }
} )
sound.Add( {
    name = "scpsl_018_high",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 75,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/018/018_Bounce_High_1.wav",
		"weapons/scpsl/018/018_Bounce_High_2.wav",
		"weapons/scpsl/018/018_Bounce_High_3.wav",
		"weapons/scpsl/018/018_Bounce_High_4.wav",
		"weapons/scpsl/018/018_Bounce_High_5.wav",
    }
} )

sound.Add( {
    name = "scpsl_grenade_equip",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/grenade/Grenade Equip.wav",
    }
} )
sound.Add( {
    name = "scpsl_grenade_begin",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/grenade/Grenade Begin.wav",
    }
} )
sound.Add( {
    name = "scpsl_grenade_cancel",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/grenade/Grenade Cancel.wav",
    }
} )
sound.Add( {
    name = "scpsl_grenade_throw",
    channel = CHAN_WEAPON,
    volume = 1,
    level = 55,
    pitch = {95, 100},
    sound = {
        "weapons/scpsl/grenade/Grenade Throw.wav",
    }
} )