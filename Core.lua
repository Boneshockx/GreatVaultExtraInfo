local ADDON_NAME = ...
local Private = select(2, ...)
Private.frame = Private.frame or CreateFrame("Frame", ADDON_NAME)
local frame = Private.frame

-- Simple, reusable grid/table generator for Weekly Rewards data
-- Creates a hidden frame anchored to WeeklyRewardsFrame (or UIParent)
-- and provides easy layout options: firstColWidth, firstColHeight, headerWidth, headerHeight, spacing

local DEFAULT_LAYOUT = {
    anchorParentName = "WeeklyRewardsFrame",
    firstColWidth = 70,  -- width of the left-most column
    firstColHeight = 20, -- height of data rows
    headerWidth = 70,    -- width of header columns (defaults to firstColWidth)
    headerHeight = 20,   -- height of the header row (defaults to firstColHeight)
    spacing = -1,
    bgColor = {0, 0, 0, 1},
    headerColor = {0.2, 0.2, 0.2, 1},
    cellColor = {0.05, 0.05, 0.05, 1},
}

local function _normalizeColor(c)
    if not c then return {0,0,0,1} end
    local r = c[1] or 0
    local g = c[2] or 0
    local b = c[3] or 0
    local a = c[4] or 1
    -- If values appear to be 0-255, normalize to 0-1
    if r > 1 or g > 1 or b > 1 then
        r = r / 255.0
        g = g / 255.0
        b = b / 255.0
    end
    return {r, g, b, a}
end

local function _createCell(parent, w, h, text, bgColor, borders)
    borders = borders or {}

    local cell = CreateFrame("Frame", nil, parent)
    cell:SetSize(w, h)

    cell.bg = cell:CreateTexture(nil, "BACKGROUND")
    cell.bg:SetAllPoints(cell)
    cell.bg:SetColorTexture(unpack(_normalizeColor(bgColor)))

    -- 1px inner border (top, bottom, left, right)
    cell._borderTop = cell:CreateTexture(nil, "OVERLAY")
    cell._borderTop:SetColorTexture(0, 0, 0, 1)
    cell._borderTop:SetPoint("TOPLEFT", cell, "TOPLEFT", 0, 0)
    cell._borderTop:SetPoint("TOPRIGHT", cell, "TOPRIGHT", 0, 0)
    cell._borderTop:SetHeight(1)

    cell._borderBottom = cell:CreateTexture(nil, "OVERLAY")
    cell._borderBottom:SetColorTexture(0, 0, 0, 1)
    cell._borderBottom:SetPoint("BOTTOMLEFT", cell, "BOTTOMLEFT", 0, 0)
    cell._borderBottom:SetPoint("BOTTOMRIGHT", cell, "BOTTOMRIGHT", 0, 0)
    cell._borderBottom:SetHeight(1)

    cell._borderLeft = cell:CreateTexture(nil, "OVERLAY")
    cell._borderLeft:SetColorTexture(0, 0, 0, 1)
    cell._borderLeft:SetPoint("TOPLEFT", cell, "TOPLEFT", 0, 0)
    cell._borderLeft:SetPoint("BOTTOMLEFT", cell, "BOTTOMLEFT", 0, 0)
    cell._borderLeft:SetWidth(1)

    cell._borderRight = cell:CreateTexture(nil, "OVERLAY")
    cell._borderRight:SetColorTexture(0, 0, 0, 1)
    cell._borderRight:SetPoint("TOPRIGHT", cell, "TOPRIGHT", 0, 0)
    cell._borderRight:SetPoint("BOTTOMRIGHT", cell, "BOTTOMRIGHT", 0, 0)
    cell._borderRight:SetWidth(1)

    -- Optionally hide borders to avoid double-thickness where cells meet
    if borders.hideTop then cell._borderTop:Hide() end
    if borders.hideBottom then cell._borderBottom:Hide() end
    if borders.hideLeft then cell._borderLeft:Hide() end
    if borders.hideRight then cell._borderRight:Hide() end

    cell.fs = cell:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    cell.fs:SetPoint("CENTER", 0, 0)
    cell.fs:SetText(text or "")

    return cell
end

local function CreateGrid(parent, data, layout)
    layout = layout or {}
    for k, v in pairs(DEFAULT_LAYOUT) do if layout[k] == nil then layout[k] = v end end

    local rows = data.rows or {}
    local headers = data.headers or {}
    local ilevels = data.ilevels or {}

    local firstColWidth = layout.firstColWidth or DEFAULT_LAYOUT.firstColWidth
    local firstColHeight = layout.firstColHeight or DEFAULT_LAYOUT.firstColHeight
    local headerWidth = layout.headerWidth or DEFAULT_LAYOUT.headerWidth
    local headerHeight = layout.headerHeight or DEFAULT_LAYOUT.headerHeight
    local spacing = layout.spacing or DEFAULT_LAYOUT.spacing

    local cols = #headers
    local rowCount = #rows

    local width = firstColWidth + (cols * headerWidth) + (cols + 1) * spacing
    local height = headerHeight + (rowCount * firstColHeight) + (rowCount + 1) * spacing

    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(width, height)

    f.bg = f:CreateTexture(nil, "BACKGROUND")
    f.bg:SetAllPoints(f)
    f.bg:SetColorTexture(unpack(layout.bgColor))

    -- Top-left corner (empty or label)
    local tl = _createCell(f, firstColWidth, headerHeight, "", layout.headerColor, { hideRight = true })
    tl:SetPoint("TOPLEFT", f, "TOPLEFT", spacing, -spacing)

    -- Headers (top row)
    f._headers = {}
    for c = 1, cols do
        local htext = tostring(headers[c] or headers[c])
        local x = spacing + firstColWidth + (c - 1) * (headerWidth + spacing)
        local cell = _createCell(f, headerWidth, headerHeight, htext, layout.headerColor)
        cell:SetPoint("TOPLEFT", f, "TOPLEFT", x, -spacing)
        f._headers[c] = cell
    end

    -- Rows (first column) and inner cells
    f._rows = {}
    f._cells = {}
    for r = 1, rowCount do
        -- position rows below the header row (header top is at -spacing)
        -- first data row top should be -(headerHeight + 2*spacing), subsequent rows stack using firstColHeight
        local y = - (headerHeight + 2 * spacing + (r - 1) * (firstColHeight + spacing))
        local rowLabel = tostring(rows[r])
        local rowCell = _createCell(f, firstColWidth, firstColHeight, rowLabel, layout.headerColor, { hideRight = true })
        rowCell:SetPoint("TOPLEFT", f, "TOPLEFT", spacing, y)
        f._rows[r] = rowCell

        f._cells[r] = {}
        for c = 1, cols do
            local x = spacing + firstColWidth + (c - 1) * (headerWidth + spacing)
            local yCell = y
            local value = nil
            local cellBg = layout.cellColor
            if ilevels[r] then
                local key = headers[c]
                value = ilevels[r][key] or ilevels[r][c]
                if value and Private and Private.VersionedData then
                    local track = Private.VersionedData.tracks and Private.VersionedData.tracks[value]
                    local color = track and Private.VersionedData.colors and Private.VersionedData.colors[track]
                    if color then
                        cellBg = { color[1] / 255, color[2] / 255, color[3] / 255, (layout.cellColor and layout.cellColor[4]) or 1 }
                    end
                end
            end
            local text = value and tostring(value) or ""
            local cell = _createCell(f, headerWidth, firstColHeight, text, cellBg)
            -- make inner cell text white with a shadow for readability on light bg
            cell.fs:SetTextColor(1, 1, 1, 1)
            cell.fs:SetShadowColor(0, 0, 0, 1)
            cell.fs:SetShadowOffset(1, -1)
            -- ensure no outline; preserve other font flags
            do
                local fpath, fsize, fflags = cell.fs:GetFont()
                local newflags = ""
                if fflags then
                    newflags = fflags:gsub("THICKOUTLINE", ""):gsub("OUTLINE", "")
                    newflags = newflags:gsub("%s%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
                end
                cell.fs:SetFont(fpath, fsize, newflags)
            end
            cell:SetPoint("TOPLEFT", f, "TOPLEFT", x, yCell)
            f._cells[r][c] = cell
        end
    end

    function f:SetLayout(opts)
        if not opts then return end
        -- simple approach: recreate the grid with the provided opts
        local parent = f:GetParent()
        f:Hide()
        f:ClearAllPoints()
        f:SetParent(nil)
        f = CreateGrid(parent, data, opts)
        return f
    end

    return f
end

-- Create the three tables and hook them to WeeklyRewardsFrame visibility
local function _ensureTables()
    Private.WeeklyTables = Private.WeeklyTables or {}

    local parent = _G[DEFAULT_LAYOUT.anchorParentName] or UIParent

    if not Private.WeeklyTables.raid then
        Private.WeeklyTables.raid = CreateGrid(
            parent, 
            Private.VersionedData.raid, 
            { headerHeight = 18, headerWidth = 50, firstColWidth = 30, firstColHeight = 18 }
        )
        Private.WeeklyTables.raid:SetPoint("TOPLEFT", parent, "TOPLEFT", 168, -127)
    end

    if not Private.WeeklyTables.mythicplus then
        Private.WeeklyTables.mythicplus = CreateGrid(
            parent, 
            Private.VersionedData.mythicplus, 
            { headerHeight = 24, headerWidth = 36, firstColWidth = 40,  firstColHeight = 22 }
        )
        Private.WeeklyTables.mythicplus:SetPoint("TOPLEFT", parent, "TOPLEFT", 40, -365)
    end

    if not Private.WeeklyTables.delves then
        Private.WeeklyTables.delves = CreateGrid(
            parent, 
            Private.VersionedData.delves, 
            { headerHeight = 24, headerWidth = 36, firstColWidth = 40,  firstColHeight = 22 }
        )
        Private.WeeklyTables.delves:SetPoint("TOPLEFT", parent, "TOPLEFT", 40, -521)
    end

    for k,v in pairs(Private.WeeklyTables) do
        v:SetParent(parent)
    end
end

-- Expose simple API for future adjustments
Private.EnsureWeeklyTables = _ensureTables

Private.SetWeeklyTableLayout = function(name, opts)
    if Private.WeeklyTables and Private.WeeklyTables[name] and opts then
        local f = Private.WeeklyTables[name]
        local parent = f:GetParent()
        f:Hide()
        f:ClearAllPoints()
        -- recreate with new layout (returns new frame)
        Private.WeeklyTables[name] = CreateGrid(parent, Private.VersionedData[name], opts)
    end
end

-- Create tables when Blizzard_WeeklyRewards is available
if IsAddOnLoaded and IsAddOnLoaded("Blizzard_WeeklyRewards") then
    _ensureTables()
else
    -- wait for the addon to load
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, addonName)
        if event == "ADDON_LOADED" and addonName == "Blizzard_WeeklyRewards" then
            _ensureTables()
            self:UnregisterEvent("ADDON_LOADED")
            self:SetScript("OnEvent", nil)
        end
    end)
end


