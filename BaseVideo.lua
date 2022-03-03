function Memory(TypeLib, Offset, Replaced) local info = gg.getTargetInfo() localpack = info.nativeLibraryDir local t = gg.getRangesList(localpack..'/lib'..TypeLib..'.so') for _, __ in pairs(t) do local t = gg.getValues({{address = __.start, flags = ggTYPE_DWORD}, {address = __.start + 18, flags = gg.TYPE_WORD}}) if t[1].value == 1179403647 then Offset = __['start'] + Offset end assert(Offset ~= nil, '[rwmem]: error, provided address is ngg') _rw = {} if type(Replaced) == 'number' then _ = '' for _ = 1, Replaced do _rw[_] = {address = (Offset - 1) + _, flags = gg.TYPE_BYTE} end for v, __ in ipairs(gg.getValues(_rw)) do _ = _ .. string.format('%02X', __.value & 255) end return _ end Byte = {} Replaced:gsub('..', function(x) Byte[#Byte + 1] = x _rw[#Byte] = {address = (Offset - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. 'h'} end) gg.setValues(_rw) end end


function ToastX(CMODs)
gg.toast(CMODs)
end

DEV = {
	['EXIT'] = function()
	os.exit()
	end,
	
	['SPEED'] = function()
	Memory("il2cpp",0x1018348,"1E00A0E31EFF2FE1");
	ToastX("SPEED ON")
	end
}

while true do
if gg.isVisible() or x ~= nil then
gg.setVisible(false)
gg.setRanges(gg.REGION_C_HEAP  | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_BSS | gg.REGION_C_DATA)
local ListMenu = {'SPEED','EXIT'}
x = gg.choice(ListMenu, nil)
if x ~= nil and DEV[ListMenu[x]] then DEV[ListMenu[x]]()end
end
gg.sleep(100)
end