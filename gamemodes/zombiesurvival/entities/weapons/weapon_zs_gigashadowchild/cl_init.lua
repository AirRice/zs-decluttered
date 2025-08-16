INC_CLIENT()

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation

function SWEP:PreDrawViewModel(vm)
	render_SetBlend(0.55)
	render_SetColorModulation(0.1, 0.1, 0.1)
end

function SWEP:PostDrawViewModel(vm)
	render_SetBlend(1)
	render_SetColorModulation(1, 1, 1)
end

local texGradDown = surface.GetTextureID("VGUI/gradient_down")
function SWEP:DrawHUD()
	if self.BaseClass.BaseClass.DrawHUD then
		self.BaseClass.BaseClass.DrawHUD(self)
	end

	local scrW = ScrW()
	local scrH = ScrH()
	local width = 200
	local height = 20
	local x, y = ScrW() - width - 32, ScrH() - height - 72
	local ratio = (self:GetNextCry() + self.CryImpactDelay - CurTime()) / self.CryDelay
	if ratio > 1 or ratio < 0 then return end
	local clampedratio = math.Clamp(ratio, 0, 1)

	surface.SetDrawColor(5, 5, 5, 180)
	surface.DrawRect(x, y, width, height)

	surface.SetDrawColor(255, 0, 0, 180)
	surface.SetTexture(texGradDown)
	surface.DrawTexturedRect(x, y, width*clampedratio, height)

	surface.SetDrawColor(255, 0, 0, 180)
	surface.DrawOutlinedRect(x - 1, y - 1, width + 2, height + 2)
end