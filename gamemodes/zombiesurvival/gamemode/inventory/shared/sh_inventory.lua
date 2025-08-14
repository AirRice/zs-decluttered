INVCAT_TRINKETS = 1
INVCAT_COMPONENTS = 2
INVCAT_CONSUMABLES = 3
INVCAT_DEBUFF = 4

-- Item Locator
LOCATOR_NONE = 0
LOCATOR_DROPPED = 1
LOCATOR_ARSENAL = 2
LOCATOR_RESUPPLY = 3
LOCATOR_REMANTLER = 4
LOCATOR_ALL = 5

GM.ZSInventoryItemData = {}
GM.ZSInventoryCategories = {
	[INVCAT_TRINKETS] = "Trinkets",
	[INVCAT_COMPONENTS] = "Components",
	[INVCAT_CONSUMABLES] = "Consumables",
	[INVCAT_DEBUFF] = "Debuffs"
}
GM.ZSInventoryPrefix = {
	[INVCAT_TRINKETS] = "trin",
	[INVCAT_COMPONENTS] = "comp",
	[INVCAT_CONSUMABLES] = "cons"
}

GM.Assemblies = {}
GM.Breakdowns = {}
GM.AlternateWeps = {}
function GM:GetInventoryItemType(item)
	if string.sub(item, 1, 10) == "trinket_d_" then
		return INVCAT_DEBUFF
	end
	for typ, aff in pairs(self.ZSInventoryPrefix) do
		if string.sub(item, 1, 4) == aff then
			return typ
		end
	end

	return -1
end

local index = 1
function GM:AddInventoryItemData(intname, name, description, weles, tier, stocks)
	local datatab = {PrintName = name, DroppedEles = weles, Tier = tier, Description = description, Stocks = stocks, Index = index}
	self.ZSInventoryItemData[intname] = datatab
	self.ZSInventoryItemData[index] = datatab

	index = index + 1
end


function GM:AddWeaponBreakdownRecipe(weapon, result)
	local datatab = {Result = result, Index = index}
	self.Breakdowns[weapon] = datatab
	for i = 1, 3 do
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i)] = datatab
		self.Breakdowns[self:GetWeaponClassOfQuality(weapon, i, 1)] = datatab
	end

	self.Breakdowns[#self.Breakdowns + 1] = datatab
end

GM:AddWeaponBreakdownRecipe("weapon_zs_stubber",							"comp_modbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_z9000",								"comp_basicecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_blaster",							"comp_pumpaction")
GM:AddWeaponBreakdownRecipe("weapon_zs_novablaster",						"comp_contaecore")
GM:AddWeaponBreakdownRecipe("weapon_zs_waraxe", 							"comp_focusbarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_innervator",							"comp_gaussframe")
GM:AddWeaponBreakdownRecipe("weapon_zs_swissarmyknife",						"comp_shortblade")
GM:AddWeaponBreakdownRecipe("weapon_zs_owens",								"comp_multibarrel")
GM:AddWeaponBreakdownRecipe("weapon_zs_onyx",								"comp_precision")
GM:AddWeaponBreakdownRecipe("weapon_zs_minelayer",							"comp_launcher")
GM:AddWeaponBreakdownRecipe("weapon_zs_fracture",							"comp_linearactuator")
--GM:AddWeaponBreakdownRecipe("weapon_zs_harpoon",							"comp_metalpole")
GM:AddWeaponBreakdownRecipe("weapon_zs_gunturret",							"comp_turretassembly")
GM:AddWeaponBreakdownRecipe("weapon_zs_gunturret_buckshot",					"comp_turretassembly")
GM:AddWeaponBreakdownRecipe("weapon_zs_zapper",								"comp_pwrcapacitor")
GM:AddWeaponBreakdownRecipe("weapon_zs_tempest",							"comp_burstmech")
GM:AddWeaponBreakdownRecipe("weapon_zs_hurricane",							"comp_pulsespool")
GM:AddWeaponBreakdownRecipe("weapon_zs_gluon",								"comp_flak")
-- Assemblies (Assembly, Component, Weapon)
GM.Assemblies["weapon_zs_waraxe"] 								= {"comp_modbarrel", 		"weapon_zs_glock3"}
GM.Assemblies["weapon_zs_bust"] 								= {"comp_busthead", 		"weapon_zs_plank"}
GM.Assemblies["weapon_zs_sawhack"] 								= {"comp_sawblade", 		"weapon_zs_axe"}
GM.Assemblies["weapon_zs_manhack_saw"] 							= {"comp_sawblade", 		"weapon_zs_manhack"}
GM.Assemblies["weapon_zs_megamasher"] 							= {"comp_propanecan", 		"weapon_zs_sledgehammer"}
GM.Assemblies["weapon_zs_electrohammer"] 						= {"comp_electrobattery",	"weapon_zs_hammer"}
GM.Assemblies["weapon_zs_novablaster"] 							= {"comp_basicecore",		"weapon_zs_magnum"}
GM.Assemblies["weapon_zs_tithonus"] 							= {"comp_contaecore",		"weapon_zs_oberon"}
GM.Assemblies["weapon_zs_fracture"] 							= {"comp_pumpaction",		"weapon_zs_sawedoff"}
GM.Assemblies["weapon_zs_seditionist"] 							= {"comp_focusbarrel",		"weapon_zs_deagle"}
GM.Assemblies["weapon_zs_molotov"] 								= {"comp_jerrycan",			"weapon_zs_glassbottle"}
GM.Assemblies["weapon_zs_blareduct"] 							= {"comp_jerrycan",			"weapon_zs_pipe"}
GM.Assemblies["weapon_zs_cinderrod"] 							= {"comp_propanecan",		"weapon_zs_blareduct"}
GM.Assemblies["weapon_zs_innervator"] 							= {"comp_electrobattery",	"weapon_zs_jackhammer"}
GM.Assemblies["weapon_zs_hephaestus"] 							= {"comp_gaussframe",		"weapon_zs_tithonus"}
GM.Assemblies["weapon_zs_stabber"] 								= {"comp_shortblade",		"weapon_zs_annabelle"}
GM.Assemblies["weapon_zs_galestorm"] 							= {"comp_multibarrel",		"weapon_zs_uzi"}
GM.Assemblies["weapon_zs_eminence"] 							= {"comp_pulsespool",		"weapon_zs_barrage"}
GM.Assemblies["weapon_zs_gladiator"] 							= {"comp_focusbarrel",		"weapon_zs_sweepershotgun"}
GM.Assemblies["weapon_zs_ripper"]								= {"comp_sawblade",			"weapon_zs_zeus"}
GM.Assemblies["weapon_zs_avelyn"]								= {"comp_burstmech",		"weapon_zs_charon"}
GM.Assemblies["weapon_zs_asmd"]									= {"comp_precision",		"weapon_zs_quasar"}
GM.Assemblies["weapon_zs_enkindler"]							= {"comp_launcher",			"weapon_zs_cinderrod"}
GM.Assemblies["weapon_zs_proliferator"]							= {"comp_linearactuator",	"weapon_zs_galestorm"}
GM.Assemblies["trinket_electromagnet"]							= {"comp_electrobattery",	"trinket_magnet"}
--GM.Assemblies["trinket_projguide"]							= {"comp_cpuparts",			"trinket_targetingvisori"}
--GM.Assemblies["trinket_projwei"]								= {"comp_busthead",			"trinket_projguide"}
--GM.Assemblies["trinket_controlplat"]							= {"comp_cpuparts",			"trinket_mainsuite"}
GM.Assemblies["weapon_zs_rollermine"]							= {"comp_cpuparts", 		"weapon_zs_drone_hauler"}
GM.Assemblies["weapon_zs_zapper_arc"]							= {"comp_pwrcapacitor", 	"weapon_zs_rollermine"}
GM.Assemblies["weapon_zs_gunturret_assault"]					= {"comp_turretassembly", 	"weapon_zs_akbar"}
GM.Assemblies["weapon_zs_gunturret_rocket"]						= {"comp_turretassembly", 	"weapon_zs_hyena"}
GM.Assemblies["weapon_zs_zeus"]									= {"comp_pwrcapacitor", 	"weapon_zs_charon"}
GM.Assemblies["weapon_zs_gluon"]								= {"comp_pulsespool", 		"weapon_zs_tithonus"}
GM.Assemblies["weapon_zs_smelter"]								= {"comp_flak", 			"weapon_zs_barrage"}

GM.AlternateWeps["weapon_zs_drone"]								= "weapon_zs_drone_pulse"
GM.AlternateWeps["weapon_zs_gunturret"]							= "weapon_zs_gunturret_buckshot"
GM.AlternateWeps["weapon_zs_antidoteshot"]						= "weapon_zs_strengthshot"

function GM:GetAlternateWeapon(wepname)
	local out = nil
	for k, v in pairs(self.AlternateWeps) do
		if k == wepname then out = v break
		elseif v == wepname then out = k break end
	end
	return out
end

GM:AddInventoryItemData("comp_modbarrel",		"Modular Barrel",			"A modular barrel suited for pairing up with another gun barrel.",								"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_burstmech",		"Burst Fire Mechanism",		"A mechanism that could be used to make a gun burst fire.",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_basicecore",		"Basic Energy Core",		"A small energy core. Needs a weapon with a cylinder mechanism to contain the energy output.",	"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_busthead",		"Bust Head",				"A bust head that could be fitted on to something handle shaped.",								"models/props_combine/breenbust.mdl")
GM:AddInventoryItemData("comp_sawblade",		"Saw Blade",				"A sharp saw blade ready to be fitted onto fast moving objects.",								"models/props_junk/sawblade001a.mdl")
GM:AddInventoryItemData("comp_propanecan",		"Propane Canister",			"A propane canister. With the correct setup, has the potential to ignite things.",				"models/props_junk/propane_tank001a.mdl")
GM:AddInventoryItemData("comp_electrobattery",	"Electrobattery",			"An electrobattery. Could be used to improve repairing motions.",								"models/items/car_battery01.mdl")
--GM:AddInventoryItemData("comp_hungrytether",	"Hungry Tether",			"A hungry tether from a devourer that comes from a devourer rib.",								"models/gibs/HGIBS_rib.mdl")]]
GM:AddInventoryItemData("comp_contaecore",		"Contained Energy Core",	"A contained energy core, that has an internal charging mechanism.",							"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pumpaction",		"Pump Action Mechanism",	"A standard pump action mechanism from a blaster shotgun.",										"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_focusbarrel",		"Focused Barrel",			"A large focused barrel made from the barrels of the waraxe. Suitable for a handcannon.",		"models/props_c17/trappropeller_lever.mdl")
GM:AddInventoryItemData("comp_gaussframe",		"Gauss Frame",				"A highly advanced gauss frame. It's almost alien in design, making it hard to use.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_metalpole",		"Metal Pole",				"Long metal pole that could be used to attack things from a distance.",							"models/props_c17/signpole001.mdl")
GM:AddInventoryItemData("comp_salleather",		"Salvaged Leather",			"Pieces of leather that are hard enough to make a nasty impact.",								"models/props_junk/shoe001.mdl")
GM:AddInventoryItemData("comp_gyroscope",		"Gyroscope",				"A metal gyroscope used to calculate orientation.",												"models/maxofs2d/hover_rings.mdl")
GM:AddInventoryItemData("comp_reciever",		"Reciever",					"A radio reciever. Could be used for automation and communication purposes.",					"models/props_lab/reciever01b.mdl")
GM:AddInventoryItemData("comp_cpuparts",		"CPU Parts",				"Parts from a central processor.",																"models/props_lab/harddrive01.mdl")
GM:AddInventoryItemData("comp_launcher",		"Launching Tube",			"A metal tube made to launch objects.",															"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_launcherh",		"Heavy Launching Tube",		"A heavy metal tube made to launch large objects.",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_shortblade",		"Short Blade",				"A short metal blade for cutting and stabbing.",												"models/weapons/w_knife_t.mdl")
GM:AddInventoryItemData("comp_multibarrel",		"Multi-Bored Barrel",		"An unusual gun barrel which allows multiple bullets to pass through.",							"models/props_lab/pipesystem03a.mdl")
GM:AddInventoryItemData("comp_holoscope",		"Holographic Scope",		"A holographic weapon sight with magnification.",												{
	["base"] = { type = "Model", model = "models/props_c17/utilityconnecter005.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.273, 1.728, -0.843), angle = Angle(74.583, 180, 0), size = Vector(2.207, 0.105, 0.316), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0.492, -1.03, 0), angle = Angle(0, -78.715, 90), size = Vector(0.03, 0.02, 0.032), color = Color(50, 50, 66, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal02", skin = 0, bodygroup = {} }
})
GM:AddInventoryItemData("comp_linearactuator",	"Linear Actuator",			"A linear actuator from a shell holder. Requires a heavy base to mount properly.",				"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_pulsespool",		"Pulse Spool",				"Used to inject more pulse power to a system. Could be used to stabilise something.",			"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_flak",			"Flak Chamber",				"An internal chamber for projecting heated scrap.",												"models/weapons/w_rocket_launcher.mdl")
GM:AddInventoryItemData("comp_precision",		"Precision Chassis",		"A suite setup for rewarding precise shots on moving targets.",									"models/Items/combine_rifle_cartridge01.mdl")
GM:AddInventoryItemData("comp_turretassembly",	"Turret Assembly",			"The automated targeting and scanning mechanisms from a turret.",								"models/combine_turrets/floor_turret_gib1.mdl")
GM:AddInventoryItemData("comp_pwrcapacitor",	"Power Capacitor",			"A device that stores charge. Could be used to electrify things.",								"models/props_lab/powerbox02d.mdl")
GM:AddInventoryItemData("comp_jerrycan",		"Jerry Can",				"Still has a bit of fuel left inside.",															"models/props_junk/gascan001a.mdl")

-- Trinkets
local trinket, description, trinketwep
local hpveles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local hpweles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoveles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 3, -0.519), angle = Angle(0, 85.324, 101.688), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local ammoweles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2, -1.558), angle = Angle(5.843, 82.986, 111.039), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local mveles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 3, -1), angle = Angle(97.013, 29.221, 0), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local mweles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2, -0.5), angle = Angle(111.039, -92.338, 97.013), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}
local pveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -2.597), angle = Angle(5.843, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local pweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.5, -2), angle = Angle(5, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oveles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local oweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local develes = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2.5, -5.715), angle = Angle(5, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local deweles = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2, -5.715), angle = Angle(0, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}
local supveles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 2.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
local supweles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- Starter Trinkets

trinket, trinketwep = GM:AddTrinket("Armband", "armband", false, mveles, mweles, nil, "-10% melee swing impact delay\n-6% melee damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.06)
trinketwep.NoDismantle = true

trinket, trinketwep = GM:AddTrinket("Escape Manual", "emanual", false, develes, deweles, nil, "+20% phasing speed\n-12% low health slow intensity")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.20)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.12)
trinketwep.NoDismantle = true

trinket, trinketwep = GM:AddTrinket("Aiming Aid", "aimaid", false, develes, deweles, nil, "+5% tighter aiming reticule\n-7% reduced effect of aim shake effects")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.06)
trinketwep.NoDismantle = true

trinket, trinketwep = GM:AddTrinket("Welfare Shield", "welfare", false, hpveles, hpweles, nil, "-5% resupply delay\n-7% self damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.07)
trinketwep.NoDismantle = true

trinket, trinketwep = GM:AddTrinket("Chemistry Set", "chemistry", false, hpveles, hpweles, nil, "+6% medic tool effectiveness\n+12% cloud bomb time")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.06)
GM:AddSkillModifier(trinket, SKILLMOD_CLOUD_TIME, 0.12)
trinketwep.NoDismantle = true


-- Health Trinkets
trinket, trinketwep = GM:AddTrinket("Vitamin Capsules", "vitpackagei", false, hpveles, hpweles, nil, "+5 maximum health\n+5% healing received\n-12% poison damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 5)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.05)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.12)

trinket = GM:AddTrinket("Vitality Bank", "vitpackageii", false, hpveles, hpweles, 4, "+21 maximum health\n+6% healing received")
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 21)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.06)

trinket, trinketwep = GM:AddTrinket("Blood Transfusion Pack", "bloodpack", false, hpveles, hpweles, 2, "Generates 20 blood armor if health falls below 50%\nConsumes itself on activation.", nil, 15)
trinketwep.NoDismantle = true

--[[trinket, trinketwep = GM:AddTrinket("Blood Package", "cardpackagei", false, hpveles, hpweles, 2, "+10 maximum blood armor")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 10)
trinketwep.NoDismantle = true]]

-- SKILL_IRONBLOOD
GM:AddTrinket("Subdermal Hemolattice", "ironblood", false, hpveles, hpweles, 3, "+25% blood armor damage absorption\nAdditional +25% blood armor damage absorption when health is 50% or less")

-- SKILL_BLOODLETTER (but not the bleeding part)
trinket = GM:AddTrinket("Blood Bank", "cardpackageii", false, hpveles, hpweles, 4, "+30 maximum blood armor\n+100% blood armor gained from all sources")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 30)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR_GAIN_MUL, 1)

--SKILL_BLOODARMOR with SKILL_BLOODLETTER downside
trinket = GM:AddTrinket("Hemoglobin Spoofer", "hemospoofer", false, hpveles, hpweles, 2, "+10 maximum blood armor\nAutomatically generates 1 blood armor every 8 seconds\nWhen all blood armor is lost, inflicts 5 bleed damage")
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 10)

-- SKILL_REGENERATOR, time values have been exchanged.
GM:AddTrinket("Healing Enzymes", "regenenzyme", false, hpveles, hpweles, nil, "Heals 1 health every 12 seconds up to 60% max health, provided no damage was taken recently")
GM:AddTrinket("Regeneration Implant", "regenimplant", false, hpveles, hpweles, 3, "Heals 1 health every 6 seconds provided no damage was taken recently")

-- SKILL_HAEMOSTASIS added
trinket, trinketwep = GM:AddTrinket("Bio Cleanser", "biocleanser", false, hpveles, hpweles, 2, "While possessing at least 2 blood armor, expends 2 blood armor to block one harmful status effect\nAlso passively blocks one harmful status effect every 20 seconds")
trinketwep.NoDismantle = true

--SKILL_SUGARRUSH
trinket = GM:AddTrinket("Cutlery Set", "cutlery", false, hpveles, hpweles, 2, "-80% time to eat food\n+35 speed boost for 14 seconds when food is consumed")
GM:AddSkillModifier(trinket, SKILLMOD_FOODEATTIME_MUL, -0.8)

trinket = GM:AddTrinket("Hemavoric Overclock", "blooddigester", false, hpveles, hpweles, 3, "+100% recovery from food\nFood also provides up to 30 blood armor\nBlood armor gained in this way can be 40 higher than the usual maximum")
GM:AddSkillModifier(trinket, SKILLMOD_FOODRECOVERY_MUL, 1.0)

-- Melee Trinkets

description = "Every 5th unarmed strike applies significant leg and arm damage\n-15% delay between unarmed strikes"
trinket = GM:AddTrinket("Boxing Training Manual", "boxingtraining", false, mveles, mweles, nil, description)
GM:AddSkillModifier(trinket, SKILLMOD_UNARMED_SWING_DELAY_MUL, -0.15)
GM:AddSkillFunction(trinket, function(pl, active) pl.BoxingTraining = active end)

trinket, trinketwep = GM:AddTrinket("Momentum Support", "momentumsupsysii", false, mveles, mweles, 2, "-13% melee swing impact delay\n+10% melee knockback")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.1)
trinketwep.NoDismantle = true

-- SKILL_LANKY added
trinket = GM:AddTrinket("Momentum Scaffold", "momentumsupsysiii", false, mveles, mweles, 3, "-20% melee swing impact delay\n+12% melee knockback\n+20% melee range")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.20)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.12)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_RANGE_MUL, 0.2)

-- Converter I, III has been removed and consolidated into amplifier
-- SKILL_ANTIGEN also added
trinket = GM:AddTrinket("Hemo-Adrenaline Amplifier", "hemoadrenalii", false, mveles, mweles, 4, "+30 speed on melee kill for 10 seconds\n+10% melee damage converted to blood armor\n+5% blood armor damage absorption")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 30)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.05)

GM:AddSkillModifier(GM:AddTrinket("Power Gauntlet", "powergauntlet", false, mveles, mweles, 3, "Melee damage dealt increases up to an additional +45% over 4 consecutive hits\nMissing resets damage\nDamage also resets after the 4th consecutive hit"), SKILLMOD_MELEE_POWERATTACK_MUL, 0.45)

--SKILL_LIGHTWEIGHT, sharpstone trinket added
trinket = GM:AddTrinket("Finesse Kit", "sharpkit", false, mveles, mweles, 3, "Deal up to +32% melee damage to slowed zombies\n+6 speed when wielding any melee weapon\n+5% melee damage")

--SKILL_LASTSTAND, SKILL_CHEAPKNUCKLE
trinket = GM:AddTrinket("Self-Defense Manual", "selfdefense", false, mveles, mweles, 2, "+100% melee damage when below 25% maximum health\nMelee attacks slow enemies when hitting from behind\n+25% unarmed damage")
GM:AddSkillModifier(trinket, SKILLMOD_UNARMED_DAMAGE_MUL, 0.25)

--SKILL_CRITICALKNUCKLE, SKILL_KNUCKLEMASTER, SKILL_COMBOKNUCKLE
trinket = GM:AddTrinket("Martial Arts Manual", "martialarts", false, mveles, mweles, 3, "Unarmed strikes knock enemies back\nNo longer slowed while punching\n-50% time before next unarmed strike if unarmed strike connects\n+50% unarmed damage")
GM:AddSkillModifier(trinket, SKILLMOD_UNARMED_DAMAGE_MUL, 0.5)

--SKILL_MASTERCHEF
GM:AddTrinket("Master's Cookbook", "masterchef", false, mveles, mweles, nil, "When zombies you attack with a culinary weapon die within 1 second of a successful hit, you have a chance of obtaining a food item")

--SKILL_BLOODLUST (bloodborne reference)
trinket = GM:AddTrinket("Gehrmanic Converter", "bbrally", false, mveles, mweles, 3, "When hit by zombies, gain Biobuffer energy (decays at a rate of 5/second) equivalent to 50% of damage taken\nYour melee attacks restore health equivalent to 25% of damage dealt by consuming biobuffer energy\nIncoming healing also consumes biobuffer energy equivalent to amount healed")

-- Performance Trinkets
GM:AddTrinket("Oxygen Tank", "oxygentank", true, nil, {
	["base"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3, -1), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, nil, "10x breathing time underwater.", "oxygentank")

-- Removed, superseded by agility magnifier
--GM:AddSkillModifier(GM:AddTrinket("Acrobat Frame", "acrobatframe", false, pveles, pweles, nil, "+8% jump power."), SKILLMOD_JUMPPOWER_MUL, 0.08)

trinket = GM:AddTrinket("Night Vision Goggles", "nightvision", true, pveles, pweles, 2, "-50% effect of dim vision and ability to see in the dark\n-40% effect of vision affecting effects\n-45% fright duration")
GM:AddSkillModifier(trinket, SKILLMOD_DIMVISION_EFF_MUL, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_FRIGHT_DURATION_MUL, -0.45)
GM:AddSkillModifier(trinket, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.4)
GM:AddSkillFunction(trinket, function(pl, active)
	if CLIENT and pl == MySelf and GAMEMODE.m_NightVision and not active then
		surface.PlaySound("items/nvg_off.wav")
		GAMEMODE.m_NightVision = false
	end
end)
trinketwep.NoDismantle = true

trinket = GM:AddTrinket("Portable Weapons Satchel", "portablehole", false, pveles, pweles, nil, "+15% weapon draw speed\n+5% reload speed")
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.05)

trinket = GM:AddTrinket("Agility Magnifier", "pathfinder", false, pveles, pweles, 2, "+40% barricade phasing movement speed\n-45% sigil teleportation time\n+13% jump power")
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.4)
GM:AddSkillModifier(trinket, SKILLMOD_SIGIL_TELEPORT_MUL, -0.45)
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.13)

trinket = GM:AddTrinket("Galvanizer Implant", "analgestic", false, pveles, pweles, 3, "-50% low health slow intensity\n-50% slow vulnerability\n-50% knockdown time\n-66% duration of pulling attacks\n+25% weapon switch speed")
GM:AddSkillModifier(trinket, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.25)

-- Consolidated some drawspeed skills like SKILL_TRIGGER_DISCIPLINE into this
-- No need for this to exist when the portable satchel exists
--[[trinket = GM:AddTrinket("Ammo Vest", "ammovestii", false, ammoveles, ammoweles, 2, "+5% reload speed\n+5% weapon draw speed")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.05)]]
trinket = GM:AddTrinket("Ammo Bandolier", "ammovestiii", false, ammoveles, ammoweles, 4, "+15% reload speed\n+15% weapon draw speed")
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.15)

GM:AddTrinket("Automated Reloader", "autoreload", false, ammoveles, ammoweles, 2, "Weapons you switch away from will be automatically reloaded after 4 seconds")

--SKILL_BACKPEDDLER
trinket = GM:AddTrinket("Sensorineural Stimulants", "neuralstim", false, pveles, pweles, 3, "Can run backwards and sideways with no speed penalty\n+15 movement speed\n+8% jump height")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.08)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 15)
GM:AddSkillFunction(trinket, function(pl, active)
	pl.NoBWSpeedPenalty = active
end)

--SKILL_CARDIOTONIC
trinket = GM:AddTrinket("Cardiotonic Pump", "cardiotonic", false, pveles, pweles, 4, "+10 movement speed\nHold shift to sprint, temporarily gaining +40 movement speed and draining 1 blood armor/s while active\nCannot be used with no blood armor")
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 10)

-- Offensive Implants
-- Removed and replaced with Aim compensator
--trinket = GM:AddTrinket("Targeting Visor", "targetingvisori", false, oveles, oweles, nil, "+5% tighter aiming reticule.")
--GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)

-- Targeting indicator moved here
trinket = GM:AddTrinket("Targeting Unifier", "targetingvisoriii", false, oveles, oweles, 4, "+11% tighter aiming reticule.\n-50% speed reduction from using ironsights\nAn indicator now shows the health of Zombies you look at")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.11)
GM:AddSkillFunction(trinket, function(pl, active) 
	pl.NoIronSightsSlow = active
	pl.TargetLocus = active
end)

GM:AddTrinket("Refined Subscope", "refinedsub", false, oveles, oweles, 4, "+27% tighter aiming reticule with tier 3 or lower weapons")

-- Given further aimcone reduction (similar to SKILL_ORPHICFOCUS)
trinket = GM:AddTrinket("Aim Compensator", "aimcomp", false, oveles, oweles, 3, "-52% reduced effect of aim shake effects\n+5% tighter aiming reticule\n+50% tighter spread from using ironsights")
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.52)
GM:AddSkillModifier(trinket, SKILLMOD_IRONSIGHT_EFF_MUL, 0.5)

--GM:AddSkillModifier(GM:AddTrinket("Pulse Booster", "pulseampi", false, oveles, oweles, nil, "+14% slow from pulse weapons and stun batons"), SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.14)

trinket = GM:AddTrinket("Pulse Infuser", "pulseampii", false, oveles, oweles, 3, "+20% slow from pulse weapons and stun batons\n+7% explosion radius")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.2)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.07)

-- Buffed
trinket = GM:AddTrinket("Resonance Cascade Device", "resonance", false, oveles, oweles, 5, "Dealing enough slows with pulse weaponry will cause a pulse explosion\n+25% slow from pulse weapons and stun batons")
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.25)

trinket = GM:AddTrinket("Cryogenic Inductor", "cryoindu", false, oveles, oweles, 5, "Ice damage dealt to zombies has a chance to cause a shattering ice explosion based on how much health they have")

trinket = GM:AddTrinket("Extended Magazine", "extendedmag", false, oveles, oweles, 3, "Increases the clip size of weapons with 8 or more clip size by +15%")

trinket = GM:AddTrinket("Pulse Impedance Module", "pulseimpedance", false, oveles, oweles, 5, "Slows from pulse weapons and stun batons also slow zombie attack speed\n+24% slow from pulse weapons and stun batons")
GM:AddSkillFunction(trinket, function(pl, active) pl.PulseImpedance = active end)
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.24)

trinket = GM:AddTrinket("Curb Stompers", "curbstompers", false, oveles, oweles, 2, "Instantly kills headcrabs and deals 50 damage to torso classes you land on\nDeals 500% fall damage to zombies landed on\nNo fall damage taken when landing on zombies\n-25% slow down from landing or fall damage")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.25)

GM:AddTrinket("Superior Assembly", "supasm", false, oveles, oweles, 5, "Increases to weapon damage via remantling affect reload speed on tier 2 or lower weapons")

trinket = GM:AddTrinket("Olympian Frame", "olympianframe", false, oveles, oweles, 2, "+100% object throwing strength\n-25% prop carrying slow down\n-35% movement speed reduction from heavy weapons")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_THROW_STRENGTH_MUL, 1)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.25)
GM:AddSkillModifier(trinket, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.35)

trinket = GM:AddTrinket("Loading Clamps", "loadingclamp", false, oveles, oweles, 3, "+30% maximum carryable prop weight limit\n-25% prop carrying slow down\nPrevents dropping held props when zombies hit them, although you will take 20% of the damage instead")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_CAPACITY_MUL, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.25)

-- Defensive Trinkets
trinket, trinketwep = GM:AddTrinket("Kevlar Underlay", "kevlar", false, develes, deweles, 2, "-11% melee damage taken\n-11% projectile damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.11)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.11)
trinketwep.NoDismantle = true

trinket = GM:AddTrinket("Barbed Armor", "barbedarmor", false, develes, deweles, 3, "100% of melee damage taken reflected back to melee attackers\nAdditional 14 damage reflected back to melee attackers\nMelee attackers take 14 arm damage\n-4% melee damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 14)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 1)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)

trinket = GM:AddTrinket("Antitoxin Package", "antitoxinpack", false, develes, deweles, 2, "-17% poison damage taken\n-40% poison damage over time speed\n+5 maximum health\n+3% healing received")
GM:AddSkillModifier(trinket, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.17)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_SPEED_MUL, -0.4)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 5)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.03)

trinket = GM:AddTrinket("Hemostasis Implant", "hemostasis", false, develes, deweles, 2, "-30% bleed damage taken\n-60% bleeding speed\n+5 maximum health\n+2% healing received")
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.3)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_SPEED_MUL, -0.6)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 5)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.02)

trinket = GM:AddTrinket("EOD Vest", "eodvest", false, develes, deweles, 4, "-35% explosive damage taken\n-50% fire damage taken\n-80% self-inflicted damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.35)
GM:AddSkillModifier(trinket, SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, -0.50)
GM:AddSkillModifier(trinket, SKILLMOD_SELF_DAMAGE_MUL, -0.8)

-- SKILL_SAFEFALL effects added
trinket = GM:AddTrinket("Long Fall Boots", "featherfallframe", false, develes, deweles, 3, "-35% fall damage taken\n+30% fall damage threshold\n+50% faster recovery from knockdown following falls\n-65% slow down from landing or fall damage")
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.35)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.30)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.65)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_RECOVERY_MUL, -0.5)

local eicev = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.339, 2.697, -2.309), angle = Angle(4.558, -34.502, -72.395), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local eicew = {
	["base"] = { type = "Model", model = "models/gibs/glass_shard04.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.556, 2.519, -1.468), angle = Angle(0, -5.844, -75.974), size = Vector(0.5, 0.5, 0.5), color = Color(0, 137, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Iceburst Shield", "iceburst", false, eicev, eicew, nil, "Releases an ice burst when taking a melee hit, slowing zombies down\nRecharges every 40 seconds")

GM:AddSkillModifier(GM:AddTrinket("Force Dampening Field Emitter", "forcedamp", false, develes, deweles, 2, "-33% physics impact damage taken\nImmune to knockdowns from props\nTake normal physics damage from shades."), SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, -0.33)

GM:AddSkillFunction(GM:AddTrinket("Necrotic Senses Distorter", "necrosense", false, develes, deweles, 2, "Hides aura from zombies in close proximity"), function(pl, active) pl:SetDTBool(DT_PLAYER_BOOL_NECRO, active) end)

trinket, trinketwep = GM:AddTrinket("Reactive Flasher", "reactiveflasher", false, develes, deweles, 2, "Blinds and disorients melee attacker for 2 seconds\nRecharges every 75 seconds")
trinketwep.NoDismantle = true

trinket = GM:AddTrinket("Composite Underlay", "composite", false, develes, deweles, 4, "-16% melee damage taken\n-16% projectile damage taken")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.16)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, -0.16)

-- Support Trinkets
trinket, trinketwep = GM:AddTrinket("Arsenal Pack", "arsenalpack", false, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, {
	["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows nearby humans to purchase from the arsenal menu.", "arsenalpack", 3)
trinketwep.NoDismantle = true

trinket, trinketwep = GM:AddTrinket("Resupply Pack", "resupplypack", true, nil, {
	["base"] = { type = "Model", model = "models/Items/ammocrate_ar2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}, 4, "Allows humans to resupply from you\nPress LMB with the pack in your hand to resupply yourself.", "resupplypack", 3)
trinketwep.NoDismantle = true

GM:AddTrinket("Magnet", "magnet", true, supveles, supweles, nil, "Slowly pulls ammo and weapons towards you\nMust be equipped to take effect", "magnet")
GM:AddTrinket("Electromagnet", "electromagnet", true, supveles, supweles, nil, "Pulls ammo and weapons towards you quickly\nMust be equipped to take effect", "magnet_electro")

trinket, trinketwep = GM:AddTrinket("Loading Exoskeleton", "loadingex", false, supveles, supweles, 2, "-55% prop carrying slow down\n-20% deployable pack time")
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.55)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.2)
trinketwep.NoDismantle = true

--trinket, trinketwep = GM:AddTrinket("Blueprints", "blueprintsi", false, supveles, supweles, 2, "+10% repair rate")
--GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.1)
--trinketwep.NoDismantle = true

-- SKILL_BARRICADEEXPERT added
GM:AddSkillModifier(GM:AddTrinket("Advanced Blueprints", "blueprintsii", false, supveles, supweles, 4, "+20% repair rate\nProps recently repaired with a hammer will take 8% less damage for the next 2 seconds"), SKILLMOD_REPAIRRATE_MUL, 0.2)

trinket = GM:AddTrinket("Alloy Hammer", "alloyhammer", false, supveles, supweles, 2, "+10% repair rate\nCarpenter's Hammers and related weapons can be swung 20% faster")
GM:AddSkillModifier(trinket, SKILLMOD_HAMMER_SWING_DELAY_MUL, -0.2)
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.1)

-- SKILL_RECLAIMSOL added
trinket, trinketwep = GM:AddTrinket("Medical Processor", "processor", false, supveles, supweles, 2, "-5% medic kit cooldown\n-10% medic tool fire delay\nReprocess food into medical ammo with SECONDARY FIRE\nRecover 60% of medical energy wasted due to invalid medic tool targets")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.1)

--SKILL_SMARTTARGETING added
trinket = GM:AddTrinket("Curative Kit", "curativeii", false, supveles, supweles, 3, "-10% medic kit cooldown\n-20% medic tool fire delay\nProjectile-based medical weapons can now auto-lock onto a target using SECONDARY FIRE")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.2)

-- Tier increased to 4, buffed
trinket = GM:AddTrinket("Remedial Booster", "remedy", false, supveles, supweles, 4, "+20% medic tool effectiveness")
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.2)

--SKILL_LOADEDHULL
trinket, trinketwep = GM:AddTrinket("Loaded Hulls", "loadedhull", false, supveles, supweles, nil, "Controllables now explode when destroyed, dealing area damage")

-- SKILL_TURRETOVERLOAD added
trinket = GM:AddTrinket("Maintenance Suite", "mainsuite", false, supveles, supweles, 2, "+10% zapper and repair field range\n-7% zapper and repair field delay\n+10% turret range\nTurrets rotate and scan for targets 100% faster")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_SCANSPEED_MUL, 1.0)

-- SKILL_STABLEHULL added
trinket = GM:AddTrinket("Control Platform", "controlplat", false, supveles, supweles, 3, "+15% controllable health\nControllables become immune to high speed impact damage\n+15% controllable speed\n+40% controllable handling\n+20% manhack damage")
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HANDLING_MUL, 0.4)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.2)

--SKILL_TWINVOLLEY
trinket, trinketwep = GM:AddTrinket("MRSI Allocator", "mrsiallocator", false, supveles, supweles, nil, "Turrets will now fire two bullets/projectiles at once while manually controlled\n+50% shot delay while manually controlled")

trinket = GM:AddTrinket("Projectile Guidance", "projguide", false, supveles, supweles, 2, "+25% projectile speed")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, 0.25)

trinket = GM:AddTrinket("Projectile Weight", "projwei", false, supveles, supweles, 2, "-50% projectile speed\n+5% projectile damage")
GM:AddSkillModifier(trinket, SKILLMOD_PROJ_SPEED, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_PROJECTILE_DAMAGE_MUL, 0.05)

local ectov = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.381, 2.617, 2.062), angle = Angle(180, 12.243, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

local ectow = {
	["base"] = { type = "Model", model = "models/props_junk/glassjug01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.506, 1.82, 1.758), angle = Angle(-164.991, 19.691, 8.255), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, 0, 4.07), angle = Angle(180, 12.243, 0), size = Vector(0.123, 0.123, 0.085), color = Color(0, 0, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}

trinket = GM:AddTrinket("Reactive Chemicals", "reachem", false, ectov, ectow, 3, "+30% explosive damage\n+10% explosive damage radius")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_MUL, 0.3)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.1)

-- SKILL_DISPERSION and more explosion radius
trinket = GM:AddTrinket("Wide-range Aerosols", "widerange", false, ectov, ectow, 3, "+15% effect radius for most area effects and explosives")
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_RADIUS, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_CLOUD_RADIUS, 0.15)

trinket = GM:AddTrinket("Operations Matrix", "opsmatrix", false, supveles, supweles, 4, "+15% zapper and repair field range\n-13% zapper and repair field delay\n+15% turret range")
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.15)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.13)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.15)

--SKILL_FORAGER added
trinket = GM:AddTrinket("Acquisitions Manifest", "acqmanifest", false, supveles, supweles, 2, "-6% resupply delay time\n25% chance to gain a food item when resupplying\nGain a food item when a wave ends")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.06)

-- SKILL_STOWAGE added
trinket = GM:AddTrinket("Procurement Manifest", "promanifest", false, supveles, supweles, 4, "-9% resupply delay time\nResupplies will now be stored and stacked even while uncollected")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.09)
GM:AddSkillFunction(trinket, function(pl, active)
	pl.Stowage = active
end)

--SKILL_STOCKPILE
trinket, trinketwep = GM:AddTrinket("Bulk Resupply Module", "bulkstocker", false, supveles, supweles, nil, "Resupplies will provide +100% resources at a +100% longer delay time")

--SKILL_ACUITY, SKILL_VISION, SKILL_INSIGHT, SKILL_SCAVENGER
trinket, trinketwep = GM:AddTrinket("Logistics Radar", "logisticsrad", true, supveles, supweles, 2, "Can locate all resupply boxes, remantlers, arsenal crates, or dropped weapons/ammo/items through walls\nCan also locate unplaced and handheld versions of these\nCycle through each item's visibility with PRIMARY FIRE while holding the tool")
trinketwep.NoDismantle = true

trinket = GM:AddTrinket("Scrap Reactor", "scrapreactor", false, supveles, supweles, 2, "Earn 1 scrap per 200 damage dealt to zombies\nAlso receive additional scrap at the end of waves")

-- DEBUFF TRINKETS
GM:AddDebuffTrinket("DEBUFF: Crystallizer", "d_crystallizer", "3x melee damage vs. zombies\nMelee weapons have a 50% chance of shattering when hitting a zombie")

trinket = GM:AddDebuffTrinket("DEBUFF: Mercury Injector", "d_mercury", "+5 starting points\nAlmost all knockback will cause you to fall on the ground and become incapacitated")
GM:AddSkillModifier(trinket, SKILLMOD_POINTS, 5)

trinket = GM:AddDebuffTrinket("DEBUFF: Stimulant Trial", "d_stimtrial", "-3% resupply delay\nSeverely impaired aiming when health is not full")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.03)

GM:AddDebuffTrinket("DEBUFF: Gimbal-assisted Aiming", "d_gimbalaim", "Accuracy becomes completely unaffected by crouching, ironsighting, jumping, or moving")

trinket = GM:AddDebuffTrinket("DEBUFF: Late Buyer", "d_hodl", "10% arsenal discount\nUnable to spend points at arsenal crates until the second half of the round")
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, -0.1)

trinket = GM:AddDebuffTrinket("DEBUFF: Broken Exoskeleton", "d_brokenexo", "+1 starting scrap\nUnable to carry props")
GM:AddSkillModifier(trinket, SKILLMOD_SCRAP_START, 1)

trinket = GM:AddDebuffTrinket("DEBUFF: Frail", "d_insured", "+5 starting points\nCannot heal by any means beyond 25% maximum health")
GM:AddSkillModifier(trinket, SKILLMOD_POINTS, 5)
GM:AddSkillFunction(trinket, function(pl, active)
	pl:SetDTBool(DT_PLAYER_BOOL_FRAIL, active)
end)

trinket = GM:AddDebuffTrinket("DEBUFF: Oversized Harnesses", "d_overharness", "-5% resupply delay\nFor the first 6 seconds after initiating barricade phasing, you cannot move")
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.05)
GM:AddSkillFunction(trinket, function(pl, active)
	pl.SlowGhosting = active
end)

trinket = GM:AddDebuffTrinket("DEBUFF: Reclaimed Razor Wire", "d_razorwire", "+3 starting scrap\nWhen you get hit, you will take an additional 25% of the damage over time via bleeding")
GM:AddSkillModifier(trinket, SKILLMOD_SCRAP_START, 3)

trinket = GM:AddDebuffTrinket("DEBUFF: Blood Donation", "d_blooddonor", "+1 end of wave points\n-45 maximum health")
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 1)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, -45)

trinket = GM:AddDebuffTrinket("DEBUFF: Bulky Purse", "d_bulkpurse", "+1 end of wave points\n-33.75 movement speed")
GM:AddSkillModifier(trinket, SKILLMOD_ENDWAVE_POINTS, 1)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, -33.75)

--SKILL_HEAVYSTRIKES
trinket = GM:AddDebuffTrinket("DEBUFF: Swing Amplifier", "d_swingamp", "+100% melee knockback\nIf an attack knocks a zombie backwards, 20% of melee damage dealt is reflected back to you\n100% reflection rate if using unarmed strikes")
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 1)

trinket = GM:AddDebuffTrinket("DEBUFF: Predatory Loan", "d_predloan", "-20 starting points\n+10% higher arsenal prices")
GM:AddSkillModifier(trinket, SKILLMOD_POINTS, -20)
GM:AddSkillModifier(trinket, SKILLMOD_ARSENAL_DISCOUNT, 0.1)

-- Boss Trinkets

local blcorev = {
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, 0.5, -1.701), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} },
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_Spine4", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true}
}

local blcorew = {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}

GM:AddTrinket("Bleak Soul", "bleaksoul", false, blcorev, blcorew, nil, "Blinds and knocks zombies away when attacked\nRecharges every 35 seconds")

trinket = GM:AddTrinket("Spirit Essence", "spiritess", false, nil, {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(255, 255, 255, 255), nocull = false, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/shiny", skin = 0, bodygroup = {} }
}, nil, "+10% jump height.")
GM:AddSkillModifier(trinket, SKILLMOD_JUMPPOWER_MUL, 0.13)