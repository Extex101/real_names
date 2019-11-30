rn = {}--Real names global
rn.path = minetest.get_modpath(minetest.get_current_modname())
rn.data = minetest.get_mod_storage()--Real names data writen to worldpath

rn.form = "size[5,5]"..
	"label[2.1,3.9;Are you a]"..
	"button_exit[0,2.75;2.5,5;male;Boy]"..
	"button_exit[2.6,2.75;2.5,5;female;Girl]"..
	"label[2.3,4.65;or a]"..
	"image[1.85,0.8;1.5,1.5;logo.png]"..
	"image[0.3,2.4;5.5,0.7;menu_header.png]"

minetest.register_privilege("change_name", {
	description = "Allows you to change players 'real name' using /change",
	give_to_singleplayer = false,
})
dofile(rn.path.."/chat_command_builder.lua")--Load rubenwardy's "Chat_Command_Builder"
dofile(rn.path.."/names.lua")--Load list of real names
dofile(rn.path.."/functions.lua")--Load the functions used in the mod
dofile(rn.path.."/commands.lua")--Load the Commands

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	minetest.show_formspec(name, "real_names:form", rn.form)
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "real_names:form" then
		return
	end
	if fields.male then
		rn.functionsM(player)
		return true
	elseif fields.female then
		rn.functionsF(player)
		return true
	end
	local name = player:get_player_name()
	local realName = rn.data:get_string(name)

	minetest.after(0.1, function()
		if not realname then
			minetest.show_formspec(name, "real_names:form", rn.form)
		end
	end)
end)



minetest.register_globalstep(function()
	for _, player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local realName = rn.data:get_string(name)
		if not realName then
			minetest.show_formspec(name, "real_names:form", rn.form)
		end
	end
end)
