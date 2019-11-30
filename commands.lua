
ChatCmdBuilder.new("info", function(cmd)
    cmd:sub(":target", function(name, target)
		local player = minetest.get_player_by_name(target)
		local realName
		if not player then
			return false, "Please chose valid player name"
		else
			return true, target.."'s real name is '"..rn.data:get_string(target)
		end
    end)
    cmd:sub("", function(caller)
		local realName = rn.data:get_string(caller)
       	return true, "Your Real Name is: "..realName
     end)
   end,
   {
		params = "<player>",
    	description = "Get the real name of a player",
   }
)
ChatCmdBuilder.new("change", function(cmd)
    cmd:sub(":target", function(name, target)
		local player = minetest.get_player_by_name(target)
		if not player then
			return false, "Please chose valid player name"
		else
			minetest.show_formspec(target, "real_names:form", rn.form)
		end
    end)
	cmd:sub("", function(caller)
		local player = minetest.get_player_by_name(caller)
		if not player then
			return false, "You must be online to do this"
		else
			minetest.show_formspec(caller, "real_names:form", rn.form)
		end
    end)
    cmd:sub(":target :firstname :lastname", function(caller, target, firstname, lastname)
		local player = minetest.get_player_by_name(target)
		local newname = firstname.." "..lastname
		local original_name = rn.data:get_string(target)
		if not player then
			return false, "Please chose valid player name"
		else
			rn.data:set_string(player:get_player_name(), newname)
			minetest.chat_send_all(rn.data:get_string(target)..", "..newname)
			if rn.data:get_string(target) == tostring(newname) then
				minetest.chat_send_player(target, "Your name has been changed to "..newname)
				return true, target.."'s name successfully set to "..newname
			else
				rn.data:set_string(player:get_player_name(), original_name)
				return false, "Something went wrong, name reset to orginal"
			end
		end
     end)
   end,
   {
		params = "<player> |<new name>|",
    	description = "Send a gender and name change or sets players name to <new name>",
		privs = {
			change_name = true
		},
   }
)
