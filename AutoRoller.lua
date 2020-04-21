-- So we can save and load our data.

local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

local lootid_rolled_on = {} -- Empty table for loot we have rolled on.

local function setup_zg(rolltype)
  if rolltype ~= "remove" then
    print("Rolling " .. rolltype .. " on all ZG coins and bijous")
  end
  if rolltype == "remove" then
    print("Removing rolling on all ZG coins and bijous")
    rolltype = nil
  end
  
  autoroller_table["Bloodscalp Coin"] = rolltype
  autoroller_table["Gurubashi Coin"] = rolltype
  autoroller_table["Hakkari Coin"] = rolltype
  autoroller_table["Razzashi Coin"] = rolltype
  autoroller_table["Sandfury Coin"] = rolltype
  autoroller_table["Skullsplitter Coin"] = rolltype
  autoroller_table["Vilebranch Coin"] = rolltype
  autoroller_table["Witherbark Coin"] = rolltype
  autoroller_table["Zulian Coin"] = rolltype
  autoroller_table["Blue Hakkari Bijou"] = rolltype
  autoroller_table["Bronze Hakkari Bijou"] = rolltype
  autoroller_table["Gold Hakkari Bijou"] = rolltype
  autoroller_table["Green Hakkari Bijou"] = rolltype
  autoroller_table["Orange Hakkari Bijou"] = rolltype
  autoroller_table["Purple Hakkari Bijou"] = rolltype
  autoroller_table["Red Hakkari Bijou"] = rolltype
  autoroller_table["Silver Hakkari Bijou"] = rolltype
  autoroller_table["Yellow Hakkari Bijou"] = rolltype
end

function frame:OnEvent(event, arg1)
  if event == "ADDON_LOADED" and arg1 == "AutoRoller" then
    -- Our saved variables are ready at this point. If there are none, both variables will set to nil and so we set defaults.
    if autoroller_on == nil then
      autoroller_on = false
    end
    if autoroller_table == nil then
      autoroller_table = {}
    end
    -- elseif event == "PLAYER_LOGOUT" then
  end
end
frame:SetScript("OnEvent", frame.OnEvent);

local function AutoRoller_Commands(msg, editbox)
  -- pattern matching that skips leading whitespace and whitespace between cmd and args
  -- any whitespace at end of args is retained
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

  -- "|cff1eff00|Hitem:11754::::::::60:::::::|h[Black Diamond]|h|r"
  if args then
    possible_name = string.match(args, "%[(.*)%]")
	if possible_name ~= nil then
	  item_name = possible_name
	else
	  item_name = args
	end
  end
  
  if ((cmd == "need" or cmd == "greed" or cmd == "pass" or cmd == "remove") and (string.lower(item_name) == "zg")) then
    setup_zg(cmd)
  elseif cmd == "need" and item_name ~= "" then
	print("Now rolling need on " .. item_name)
    autoroller_table[item_name] = "need"
  elseif cmd == "greed" and item_name ~= "" then
    print("Now rolling greed on " .. item_name)
	autoroller_table[item_name] = "greed"
  elseif cmd == "pass" and item_name ~= "" then
    print("Now passing on " .. item_name)
	autoroller_table[item_name] = "pass"
  elseif cmd == "remove" and item_name ~= "" then
    print("Now no longer automatically rolling on " .. item_name)
	autoroller_table[item_name] = nil
  elseif cmd == "print" then
    if autoroller_on == true then
	  print("Autoroller is ON")
	elseif autoroller_on == false then
	  print("Autoroller is OFF")
	end
    print("===========================")
    for table_name, table_roll in pairs(autoroller_table) do
      print("Rolling " .. table_roll .. " on " .. table_name)
    end
  elseif cmd == "clear" then
    print("Deleted all items")
    autoroller_table = {}
  elseif cmd == "on" then
    print("Autoroller now enabled")
    autoroller_on = true
  elseif cmd == "off" then
    print("Autoroller now disabled")
	autoroller_on = false
  else
    -- If not handled above, display some sort of help message
	if autoroller_on == true then
	  print("Autoroller is ON")
	elseif autoroller_on == false then
	  print("Autoroller is OFF")
	end
    print("Syntax: /autoroller (need | greed | pass | remove) item")
    print("Syntax: /autoroller (on | off | print | clear)")
	print("Using ZG instead of an item means all coins and bijous")
  end
end

SLASH_AUTOROLLER1 = '/autoroller'

SlashCmdList["AUTOROLLER"] = AutoRoller_Commands

local function autoroll(self, loot_id)
  local texture, item_name, count, quality = GetLootRollItemInfo(loot_id)
 	
  if autoroller_on == true then
    for table_name, table_roll in pairs(autoroller_table) do
      if table_name == item_name then
        if table_roll == "pass" then
		  table.insert(lootid_rolled_on, loot_id)
          RollOnLoot(loot_id, 0)
	     end
        if table_roll == "need" then
          table.insert(lootid_rolled_on, loot_id)
		  RollOnLoot(loot_id, 1)
	    end
        if table_roll == "greed" then
		  table.insert(lootid_rolled_on, loot_id)
          RollOnLoot(loot_id, 2)
	    end
      end
    end
  end
end

local function confirmloot(rollid, rolltype)
	for i, v in ipairs(lootid_rolled_on) do
		if v == rollid then
			ConfirmLootRoll(rollid,rolltype)
			StaticPopup_Hide("CONFIRM_LOOT_ROLL")
			StaticPopup_Hide("LOOT_BIND_CONFIRM")
		end
	end
end

local eventFrame2 = CreateFrame("Frame", nil, UIParent)
eventFrame2:RegisterEvent("START_LOOT_ROLL")
eventFrame2:RegisterEvent("CONFIRM_LOOT_ROLL")
eventFrame2:RegisterEvent("GROUP_ROSTER_UPDATE")
eventFrame2:RegisterEvent("PLAYER_ENTERING_WORLD")

eventFrame2:SetScript("OnEvent",function(self,event,...)
  if event == "CONFIRM_LOOT_ROLL" then
     local rollid = select(1, ...)
     local rolltype = select(2, ...)
	 confirmloot(rollid, rolltype)
  end   
  if event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" then
    lootid_rolled_on = {}
  end
  if event == "START_LOOT_ROLL" then
    local loot_id = select(1, ...)
	autoroll(self, loot_id)
  end
end)