CLASS.Base = "shadow_lurker"

CLASS.Name = "Frigid Lurker"
CLASS.TranslationName = "class_frigid_lurker"
CLASS.Description = "description_frigid_lurker"
CLASS.Help = "controls_frigid_lurker"

CLASS.SWEP = "weapon_zs_frigidlurker"

CLASS.Health = 185

CLASS.Points = CLASS.Health/GM.TorsoZombiePointRatio

CLASS.VoicePitch = 0.45

local math_random = math.random
local ACT_IDLE = ACT_IDLE
local ACT_WALK = ACT_WALK

function CLASS:CalcMainActivity(pl, velocity)
	if velocity:Length2DSqr() <= 1 then
		return ACT_IDLE, -1
	end

	return ACT_WALK, -1
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/skeletal_lurker"
CLASS.IconColor = Color(30, 60, 135)

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local render_ModelMaterialOverride = render.ModelMaterialOverride
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld


local colGlow = Color(255, 0, 0)
local matGlow = Material("sprites/glow04_noz")
local matBlack = CreateMaterial("shadowlurkersheet", "UnlitGeneric", {["$basetexture"] = "Tools/toolsblack", ["$model"] = 1})
local vecEyeLeft = Vector(5, -3.5, -1)
local vecEyeRight = Vector(5, -3.5, 1)

function CLASS:PrePlayerDraw(pl)
	render_SetBlend(0.85)
	render_SetColorModulation(0.6, 0.3, 0.8)
end

function CLASS:PostPlayerDraw(pl)
	render_SetBlend(1)
	render_SetColorModulation(1, 1, 1)
end

function CLASS:PrePlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(matBlack)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(nil)

	if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

	local pos, ang = pl:GetBonePositionMatrixed(5)
	if pos then
		render_SetMaterial(matGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
	end
end