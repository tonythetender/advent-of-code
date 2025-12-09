local file = io.open("../input.txt", "r")

if file then
	local state = "fresh"
	local total_fresh = 0
	local fresh_list = {}
	local available_list = {}
	for line in file:lines() do
		if #line == 0 then
			state = "available"
		end
		if state == "fresh" then
			for num in string.gmatch(line, "[^%-]+") do
				table.insert(fresh_list, num)
			end
		elseif state == "available" then
			table.insert(available_list, line)
		end
	end
	for available in available_list do
		for fresh_range in fresh_list do
			for fresh in range(0, 10)
				if available == fresh then
					total_fresh = total_fresh + 1
				end
			end
		end
	end
	print(#fresh_list)
	print(#available_list)
end
