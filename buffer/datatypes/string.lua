local module = {}

local UpdateBuffer = require(script.Parent.Parent.shared).UpdateBuffer

--[[
	Writes string to the buffer starting after `Offset`
	@param Offset [number] which byte to start reading from after
	@param String [string] the string to be written to the buffer
]]
function module:WriteString(String: string, Offset: number)
	local count = string.len(self)

	if not self.Buffer then self.Buffer = buffer.create(count + Offset) end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, count)

	buffer.writestring(self.Buffer, Offset, String, count)
end

--[[
	Reads string from the buffer starting from `Offset` + 1 to `Count` + `Offset`
	@param Offset [number] which byte to start reading from
	@param Count [number] how many bytes to read the string from after `Offset`
	@return [string] the string that has been read
]]
function module:ReadString(Offset: number, Count: number): string
	if not self.Buffer then self.Buffer = buffer.create(Count + Offset); return "" end

	self.Buffer = UpdateBuffer(self.Buffer, Offset, Count)

	return buffer.readstring(self.Buffer, Offset, Count)
end

return module