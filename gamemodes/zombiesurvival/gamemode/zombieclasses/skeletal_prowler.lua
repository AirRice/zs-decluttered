CLASS.Base = "skeletal_lurker"

CLASS.Name = "Skeletal Prowler"
CLASS.TranslationName = "class_skeletal_prowler"
CLASS.Description = "description_skeletal_prowler"
CLASS.Help = "controls_skeletal_prowler"

CLASS.SWEP = "weapon_zs_skeletalprowler"

CLASS.Health = 135

CLASS.VoicePitch = 0.6
local math_random = math.random
local string_format = string.format

function CLASS:PlayPainSound(pl)
	pl:EmitSound(string_format("npc/metropolice/pain%d.wav", math_random(4)), 65, math_random(60, 65))

	return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound(string_format("npc/zombie/zombie_die%d.wav", math_random(3)), 75, math_random(122, 128))

	return true
end

if not CLIENT then return end

CLASS.IconColor = Color(220, 200, 150)

local render_SetColorModulation = render.SetColorModulation

function CLASS:PrePlayerDrawOverrideModel(pl)
	render_SetColorModulation(0.6, 0.45, 0.4)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render_SetColorModulation(1, 1, 1)
end
