local function range(from, to)
	return function(_, last)
		if last >= to then
			return nil
		else
			return last + 1
		end
	end, nil, from - 1
end

local function solution1()
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
				for start_str, end_str in string.gmatch(line, "(%w+)-(%w+)") do
					table.insert(fresh_list, { tonumber(start_str), tonumber(end_str) })
				end
			elseif state == "available" then
				table.insert(available_list, tonumber(line))
			end
		end
		for _, available in ipairs(available_list) do
			for _, fresh_range in ipairs(fresh_list) do
				local startNum = fresh_range[1]
				local endNum = fresh_range[2]
				if available >= startNum and available <= endNum then
					total_fresh = total_fresh + 1
					break
				end
			end
		end
		print(total_fresh)
	end
end

local function solution2()
	local file = io.open("../22-2.txt", "r")
	if file then
		local total_fresh = 0
		local fresh_list = {}
		for line in file:lines() do
			if #line == 0 then
				break
			end
			for start_str, end_str in string.gmatch(line, "(%w+)-(%w+)") do
				table.insert(fresh_list, { tonumber(start_str), tonumber(end_str) })
			end
		end
		local findings = {}
		for _, fresh_range in ipairs(fresh_list) do
			local startNum = fresh_range[1]
			local endNum = fresh_range[2]
			for _, found in ipairs(findings) do
				if startNum >= found[1] and startNum <= found[2] then
					print("start > found[1]: " .. startNum)
					startNum = found[2] + 1
					print("start > found[1]: " .. startNum)
				end
				if endNum <= found[2] and endNum >= found[1] then
					print("end < found[2]: " .. endNum)
					endNum = found[1] - 1
					print("end < found[2]: " .. endNum)
				end
			end
			if startNum > endNum then
				break
			end
			print("start: " .. startNum)
			print("end: " .. endNum)
			table.insert(findings, { startNum, endNum })
			total_fresh = total_fresh + ((endNum - startNum) + 1)
			print("total: " .. total_fresh)
			print("")
		end
		print(total_fresh)
	end
end

solution1()
solution2()
