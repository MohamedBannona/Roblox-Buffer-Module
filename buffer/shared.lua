return {
	I32Shift = 2147483647, -- 2^31
	U32Shift = 4294967295, -- 2^32
	UpdateBuffer = function(Buffer: buffer, Offset: number, Size: number?)
		local length = buffer.len(Buffer)
		local requiredSize = Offset + (Size or 0)
	
		if length < requiredSize then
			local newBuffer = buffer.create(requiredSize)
			buffer.copy(newBuffer, 0, Buffer)
	
			return newBuffer
		end
	
		return Buffer
	end
}