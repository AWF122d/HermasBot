
local MarketplaceService=game:GetService("MarketplaceService")
local Players=game:GetService("Players")
local HttpService=game:GetService("HttpService")
local API_URL="http://YOUR_SERVER_IP:3000/api/player/"

local function rainbow(label)
 task.spawn(function()
  local h=0
  while label.Parent do
   h=(h+0.01)%1
   label.TextColor3=Color3.fromHSV(h,1,1)
   task.wait(0.05)
  end
 end)
end

Players.PlayerAdded:Connect(function(player)
 player.CharacterAdded:Connect(function(char)
  local ok,data=pcall(function()
   return HttpService:JSONDecode(HttpService:GetAsync(API_URL..player.UserId))
  end)
  if not ok then return end
  local gui=char:WaitForChild("Head"):WaitForChild("Overhead2.2.1")
  gui.UsernameTag.Text=player.DisplayName.." (@"..player.Name..")"
  gui.LevelTag.Text=tostring(data.level or 0)
  local premium=false
  pcall(function() premium=player.MembershipType.Name=="Premium" end)
  local gp=false
  pcall(function() gp=MarketplaceService:UserOwnsGamePassAsync(player.UserId,1899224004) end)
  local hasRole=#(data.roles or {})>0
  if premium or gp or hasRole then rainbow(gui.UsernameTag) end
  for _,r in ipairs(data.roles or {}) do
    local x=gui.RankImageRow:FindFirstChild(r)
    if x then x.Visible=true end
  end
 end)
end)
