
rn.functionsM = function(player)
	local realName = 
		rn.firstnames_M[
			math.random(1, rn.firstnames_F_length)].." "..
		rn.last_names[
			math.random(1,rn.last_names_length)]
	
	local name = player:get_player_name()
	if not rn.data:get_string(name) then
		minetest.chat_send_all(name.. " has joined for the first time under the name of '"..realName.."'")
	else 
		minetest.chat_send_all(name.. "'s new name is: '"..realName.."'")
	end
	rn.data:set_string(name, realName)
end
rn.functionsF = function(player)
	local realName = 
		rn.firstnames_F[
			math.random(1, rn.firstnames_F_length)].." "..
		rn.last_names[
			math.random(1,rn.last_names_length)]
	
	local name = player:get_player_name()
	
	if not rn.data:get_string(name) then
		minetest.chat_send_all(name.. " has joined for the first time under the name of '"..realName.."'")
	else 
		minetest.chat_send_all(name.. "'s new name is: '"..realName.."'")
	end
	rn.data:set_string(name, realName)
end
