AddCSLuaFile()

SWEP.Base = "weapon_zs_basetrinket"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"

SWEP.PrintName = "Logistics Radar"
SWEP.Primary.Automatic = false

if CLIENT then
	SWEP.ViewModelFOV = 70

	SWEP.Slot = 4

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.704, 2.176, -1.538), angle = Angle(-0.361, -154.907, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/props_lab/keypad.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.654, 2.711, -1.68), angle = Angle(-17.813, 147.498, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name+"] = { type = "Model", model = "models/props_lab/harddrive02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-0.424, 0, 0), angle = Angle(0, 180, 0), size = Vector(0.079, 0.324, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["element_name++"] = { type = "Model", model = "models/props_rooftop/antenna03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(0, 0, 4.593), angle = Angle(-0, -34.119, 0), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

function SWEP:PrimaryAttack()
    if IsFirstTimePredicted() then
		if CLIENT then
            local mode = GAMEMODE.ItemLocatorMode
            local toset = mode + 1
            if toset > LOCATOR_ALL then toset = LOCATOR_NONE end
            MySelf:EmitSound("buttons/button14.wav", 0, 130, 0.4)
            RunConsoleCommand("zs_itemlocatormode", tostring(toset))
	    end
	end
end

if not CLIENT then return end

local modestrings = {
    [LOCATOR_NONE] = "None",
    [LOCATOR_DROPPED] = "Dropped Items",
    [LOCATOR_ARSENAL] = "Arsenal Crates",
    [LOCATOR_RESUPPLY] = "Resupply Boxes",
    [LOCATOR_REMANTLER] = "Remantlers",
    [LOCATOR_ALL] = "All"
}

function SWEP:DrawHUD()
	local screenscale = BetterScreenScale()
    
	surface.SetFont("ZSHUDFont")
    local mode = GAMEMODE.ItemLocatorMode
	local text = modestrings[mode]
    --print(mode)
    --PrintTable(modestrings)
    local nTEXW, nTEXH = surface.GetTextSize(text)

	draw.SimpleTextBlurry(text, "ZSHUDFont", ScrW() - nTEXW * 0.75 - 32 * screenscale, ScrH() - nTEXH * 1.5, COLOR_GRAY, TEXT_ALIGN_CENTER)

	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()
end
