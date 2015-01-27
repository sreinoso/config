--[[
schedule.module
Displays calendars (current mont and as many previous and next month as you like - additional months are evenly divided betwen previous and next periods) with additional text displayed in every day cell.
Either it could be some short text message or colored background.
Data format of data/schedule-${year}-${month}.txt file (each months with it's own file):
day text
day text

eg.
1   9:00        # some event at 9:00 at first day
2   holiday     # holiday event at second day
3   x       # colored box at thrid day

See example files in data/ directory.

changelog:
v1.2.4  - (21.06.2012) moving box drawing function to functions part of One4All 
v1.2.3  - first public release
--]]

local modname = ...
local M = {}
_G[modname] = M
package.loaded[modname] = M



--[[
###############################################################################
###                              SETTINGS                                   ###
###############################################################################
--]]

local settings_table = {
    {   
        drawGrid            = false,    --draw helper grid (true) or don't (false)
        horizontal          = true,     --should graph be horizontaly (true) or verticaly (false) aligned
        date_align          = 'left',   --align of date number: 'left', 'right' or 'center'
        schedule_align          = 'right',  --align of schedule: 'left', 'right' or 'center'
        calendar_update         = 300,      --number of conky updates after which calendar will update
        numberOfMonth           = 3,        --number of month to include in graph
        cellSize            = 50,       --one day cell size both width and height (square cell)
        cellGapDivider          = 20,       --is used to calculate gap between of cels as "cellGap = cellSize / cellGapDivider"
        graphGapMultiplier      = 3,        --is used to calculate gap between of graphs as "graphGap = cellGap * graphGapMultiplier"
        corner_rG           = 10,       --rounding of graph corners in percents
        corner_rC           = 50,       --rounding of cell corners in percents
        startX              = 0,        --upper left corner x-axis start of graph
        startY              = 0,        --upper left corner y-axis start of graph
        color_G             = 0x000000, --graph shadow color
        alpha_G             = 0.7,      --graph shadow alpha
        color_C             = 0x00afff, --cell color
        alpha_C             = 0.5,      --cell alpha
        color_W             = 0x00ff00, --weekday color
        color_Sa            = 0xffff00, --saturday color
        color_Su            = 0xff0000, --sunday color
        color_M             = 0xffffff, --month and separation bar color
        color_N             = 0xff0000, --current day rim color
        alpha_N             = 1,        --current day rim alpha

        -- don't modyfi settings below

        sizeW               = 0,        --don't modyfi - it's no use to set this because it will be rewrited after start
        sizeH               = 0,        --don't modyfi - it's no use to set this because it will be rewrited after start
        sizeAll             = 0,        --don't modyfi - it's no use to set this because it will be rewrited after start
        cellGap             = 0,        --don't modyfi - it's no use to set this because it will be rewrited after start
        graphGap            = 0,        --don't modyfi - it's no use to set this because it will be rewrited after start
        _date               = os.date('*t'),    --don't modyfi
        _calendar           = {},           --don't modyfi
        isMondayFirtsDayOfTheWeek   = tonumber(one4all_main.os_capture('locale first_weekday','raw')) - 1,  --don't modyfi
    },
}

--[[
###############################################################################
###                           END OF SETTINGS                               ###
###############################################################################
--]]




function M.errors(t, _errorNo)
    local sizeW, sizeH = t.sizeW+t.startX, t.sizeH+t.startY
    if t.horizontal then sizeW = t.sizeAll+t.startX else sizeH = t.sizeAll+t.startY end

    local _errors = {
        "Check size error! Schedule graph " .. sizeW .. "x" .. sizeH .. " is bigger than Conky window " .. conky_window.width .. "x" .. conky_window.height .. " !!!",
        "Warning! Can't read one or all schedule text file",
    }

    print(_errors[_errorNo])
end

function M.check_size(t)
    t.cellGap = math.floor(t.cellSize/t.cellGapDivider)
    t.graphGap = math.floor(t.cellGap*t.graphGapMultiplier)
    t.sizeW = (t.cellSize + t.cellGap) * 7
    t.sizeH = math.floor(t.sizeW + t.cellSize * 0.5)
    if t.horizontal
        then
            t.sizeAll = t.sizeW * t.numberOfMonth + t.graphGap * (t.numberOfMonth -1)
            --print(t.sizeAll+t.startX, t.sizeH+t.startY)
            --print("Cell size: " .. t.cellSize , "Cell gap: " .. t.cellGap , "Size of 1 graph: " .. t.sizeW .. " x " .. t.sizeH, "Graph gap: " .. t.graphGap, "Size: " .. t.sizeAll .. " x " .. t.sizeH)
            if t.sizeAll + t.startX > conky_window.width or t.sizeH + t.startY > conky_window.height then return false else return true end
        else
            t.sizeAll = t.sizeH * t.numberOfMonth + t.graphGap * (t.numberOfMonth -1)
            --print(t.sizeAll+t.startY, t.sizeW+t.startX)
            --print("Cell size: " .. t.cellSize , "Cell gap: " .. t.cellGap , "Size of 1 graph: " .. t.sizeW .. " x " .. t.sizeH, "Graph gap: " .. t.graphGap, "Size: " .. t.sizeW .. " x " .. t.sizeAll)
            if t.sizeAll + t.startY > conky_window.height or t.sizeW + t.startX > conky_window.width then return false else return true end
        end
    end

    function M.setlocale()
        local _locale = os.setlocale(nil, 'ctype')
        os.setlocale(_locale, 'all')
    end

    function M.init_calendar(t)
        local _date, _tmp, dateMod, dateF, _t, _error = {}, {}, 0, , 0, 0
        _date.year, _date.month, _date.day = t._date.year, t._date.month-math.floor(t.numberOfMonth/2), 1
        if t.isMondayFirtsDayOfTheWeek == 1
            then dateMod, dateF = 0, "%u"
            else dateMod, dateF = 1, "%w"
            end
            for i=1, t.numberOfMonth, 1
                do
                    _t = 0
                    for j=1, 42, 1
                        do
                            if j < os.date(dateF, os.time(_date))+dateMod then _tmp[j] = { day = , schedule =  }; _t = j
                            elseif j == _date.day+_t then _tmp[j] = { day = os.date('%d', os.time(_date)), schedule =  }; _date.day = _date.day+1
                                if _date.day ~= tonumber(os.date('%d', os.time(_date))) then _date.day = _date.day-1 end
                            else _tmp[j] = { day = , schedule =  }
                            end
                        end
                        --print('/data/schedule-' .. _date.year .. "-" .. string.format('%02d', _date.month) .. '.txt')
                        if io.open(_conky_path .. '/data/schedule-' .. _date.year .. "-" .. string.format('%02d', _date.month) .. '.txt') then 
                            for l in io.lines(_conky_path .. '/data/schedule-' .. _date.year .. "-" .. string.format('%02d', _date.month) .. '.txt') do
                                local _day, _schedule = l:match '(%S+)%s+(%S+)'
                                if _day == nil then break end
                                local j=0
                                repeat
                                    j=j+1
                                until _tmp[j].day == string.format('%02d', _day)
                                _tmp[j].schedule = _schedule
                            end
                        else _error=2
                        end
                        t._calendar[i]=_tmp
                        _tmp = {}
                        _date.day=1
                        _date.month=_date.month+1
                    end
                    return _error
                end

                function M.align(textAlign, textSize, cellSize, cellGap)
                    if textAlign == 'center' then return cellGap/2 + cellSize/2 - textSize/2
                    elseif textAlign == 'left' then
                        if textSize > cellSize/2 - cellGap*2 then return cellGap*2
                        else return cellGap/2 + cellSize/2 - textSize end
                    else
                        if textSize > cellSize/2 - cellGap*2 then return cellGap/2 + cellSize - textSize - cellGap*2
                        else return cellGap/2 + cellSize/2 end
                    end
                end

                function M.draw_grid(t, modX, modY)
                    cairo_set_source_rgba(cr, 1, 1, 1, 0.5)
                    cairo_move_to(cr, t.startX+modX, t.startY+modY)
                    cairo_line_to(cr, t.startX+modX+t.sizeW, t.startY+modY)
                    cairo_line_to(cr, t.startX+modX+t.sizeW, t.startY+modY+t.sizeH)
                    cairo_line_to(cr, t.startX+modX, t.startY+modY+t.sizeH)
                    cairo_line_to(cr, t.startX+modX, t.startY+modY)
                    cairo_stroke(cr)
                    for i=1, 7, 1
                        do
                            cairo_move_to(cr, t.startX+modX+(t.cellSize+t.cellGap)*i, t.startY+modY)
                            cairo_line_to(cr, t.startX+modX+(t.cellSize+t.cellGap)*i, t.startY+modY+t.sizeH)
                            cairo_move_to(cr, t.startX+modX, t.startY+modY+(t.cellSize+t.cellGap)*i+t.cellSize*0.5)
                            cairo_line_to(cr, t.startX+modX+t.sizeW, t.startY+modY+(t.cellSize+t.cellGap)*i+t.cellSize*0.5)
                            cairo_stroke(cr)
                        end
                    end

                    function M.draw_graph(t)
                        local modX, modY, weekS, dateF = 0, 0, 0, ""
                        local _date, _week = {}, {}
                        _date.year = t._date.year
                        _date.month = t._date.month-math.floor(t.numberOfMonth/2)
                        _date.day = 1
                        if t.isMondayFirtsDayOfTheWeek == 1
                            then weekS, dateF, _week.day, _week.month, _week.year = 1, "%u", 1, 12, 1997
                            else weekS, dateF, _week.day, _week.month, _week.year = 0, "%w", 7, 12, 1997
                            end
                            if t.horizontal then modX = t.sizeW + t.graphGap else modY = t.sizeH + t.graphGap end
                            for i=0, t.numberOfMonth-1, 1
                                do
                                    -- draw shadow box and/or grid for every graph
                                    one4all_cairo.draw_box(cr, t.startX+(modX*i), t.startY+(modY*i), t.sizeW, t.sizeH, t.corner_rG, t.color_G, t.alpha_G)
                                    if t.drawGrid then M.draw_grid(t, modX*i, modY*i) end

                                    local extents = cairo_text_extents_t:create() -- initialize text_extents structure (generic, a must be for following functions)

                                    -- print month name
                                    cairo_select_font_face(cr, "DejaVu Sans Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
                                    cairo_set_font_size(cr, t.cellSize/2)
                                    local _text = os.date('%B', os.time(_date))
                                    cairo_text_extents(cr, _text, extents)
                                    cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_M, 1))
                                    cairo_move_to(cr, t.startX+modX*i+t.sizeW/2-extents.width/2, t.startY+modY*i+math.floor(t.cellSize/2)+t.cellGap*2)
                                    cairo_show_text(cr, _text)
                                    cairo_stroke(cr)
                                    _date.month = _date.month+1
                                    --]]

                                    -- print week days names
                                    cairo_select_font_face(cr, "DejaVu Sans Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
                                    cairo_set_font_size(cr, t.cellSize/2.8)
                                    for j=weekS, weekS+6, 1
                                        do
                                            _week.day = j
                                            local _text = os.date('%a', os.time(_week))
                                            cairo_text_extents(cr, _text, extents)
                                            cairo_move_to(cr, t.startX+modX*i+((t.cellSize+t.cellGap)*(j-weekS))+t.cellGap/2+t.cellSize/2-extents.width/2, t.startY+modY*i+t.cellSize+t.cellGap*2)
                                            if j==0 or j==7 then cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_Su, 1))
                                            elseif j==6 then cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_Sa, 1))
                                            else cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_W, 1))
                                            end
                                            cairo_show_text(cr, _text)
                                            cairo_stroke(cr)
                                        end
                                        --]]

                                        -- draw separation bar
                                        local _pat = cairo_pattern_create_linear(0, t.startY+modY*i+t.cellSize*1.5-t.cellGap/2-t.cellSize/5, 0, t.startY+modY*i+t.cellSize*1.5-t.cellGap/2)
                                        cairo_pattern_add_color_stop_rgba(_pat, 0, one4all_cairo.rgb2rgba(0x000000, 0.2))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.1, one4all_cairo.rgb2rgba(t.color_M, 0.2))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.3, one4all_cairo.rgb2rgba(t.color_M, 0.7))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.4, one4all_cairo.rgb2rgba(t.color_M, 0.9))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.5, one4all_cairo.rgb2rgba(t.color_M, 1))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.6, one4all_cairo.rgb2rgba(t.color_M, 0.9))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.7, one4all_cairo.rgb2rgba(t.color_M, 0.7))
                                        cairo_pattern_add_color_stop_rgba(_pat, 0.9, one4all_cairo.rgb2rgba(t.color_M, 0.2))
                                        cairo_pattern_add_color_stop_rgba(_pat, 1, one4all_cairo.rgb2rgba(0x000000, 0.2))
                                        cairo_set_source(cr, _pat)
                                        cairo_move_to(cr, t.startX+modX*i+t.cellGap*4, t.startY+modY*i+t.cellSize*1.5-t.cellGap/2-t.cellSize/10)
                                        cairo_line_to(cr, t.startX+modX*i+t.sizeW-t.cellGap*4, t.startY+modY*i+t.cellSize*1.5-t.cellGap/2-t.cellSize/10)
                                        cairo_set_line_width (cr, t.cellSize/5)
                                        cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
                                        cairo_stroke(cr)
                                        cairo_pattern_destroy(_pat)
                                        cairo_set_line_cap(cr, CAIRO_LINE_CAP_BUTT)
                                        cairo_set_line_width (cr, 1)
                                        --]]

                                        -- print schedule
                                        cairo_select_font_face(cr, "DejaVu Sans Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
                                        for j=1, 42, 1 do
                                            if j < 14 and t._calendar[i+1][j].day == nil then break end
                                            local _t_int, _t_frac = math.modf(j/7); if _t_int > 0 and _t_frac == 0 then _t_int = _t_int - 1 end
                                            if t._calendar[i+1][j].schedule == 'x' then
                                                one4all_cairo.draw_box(cr, t.startX+modX*i+(t.cellSize+t.cellGap)*(j-1-_t_int*7)+t.cellGap, t.startY+modY*i+t.cellSize*1.5+(t.cellSize+t.cellGap)*_t_int+t.cellGap*2, t.cellSize-t.cellGap, t.cellSize-t.cellGap, t.corner_rC, t.color_C, t.alpha_C)
                                            elseif t._calendar[i+1][j].schedule ~= nil then
                                                local _text = t._calendar[i+1][j].schedule
                                                local _div = 1
                                                repeat
                                                    cairo_set_font_size(cr, (t.cellSize/2.5)/_div)
                                                    cairo_text_extents(cr, _text, extents)
                                                    _div = _div + 0.2
                                                until extents.width < t.cellSize-t.cellGap*4
                                                local _position = M.align(t.schedule_align, extents.width, t.cellSize, t.cellGap)
                                                cairo_move_to(cr, t.startX+modX*i+(t.cellSize+t.cellGap)*(j-1-_t_int*7)+_position, t.startY+modY*i+t.cellSize*1.5+(t.cellSize+t.cellGap)*_t_int+t.cellGap+t.cellSize/2+extents.height+t.cellGap/2)
                                                cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_M, 1))
                                                cairo_show_text(cr, _text)
                                                cairo_stroke(cr)
                                            end
                                        end
                                        --]]

                                        -- print month days numbers
                                        cairo_select_font_face(cr, "DejaVu Sans Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
                                        cairo_set_font_size(cr, t.cellSize/3)
                                        --cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_M, 1))
                                        for j in pairs(t._calendar[i+1])
                                            do
                                                --print("Graph No.: " .. i, "Filed No.: " .. j, "Day: " .. t._calendar[i+1][j].day)
                                                if t._calendar[i+1][j] ~=  then
                                                    local _t_int, _t_frac = math.modf(j/7); if _t_int > 0 and _t_frac == 0 then _t_int = _t_int - 1 end
                                                    local _text = t._calendar[i+1][j].day
                                                    cairo_text_extents(cr, _text, extents)
                                                    local _position = M.align(t.date_align, extents.width, t.cellSize, t.cellGap)
                                                    if ( j-_t_int*7==1 and t.isMondayFirtsDayOfTheWeek~=1 ) or ( j-_t_int*7==7 and t.isMondayFirtsDayOfTheWeek==1 ) then cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_Su, 1))
                                                    elseif ( j-_t_int*7==6 and t.isMondayFirtsDayOfTheWeek==1 ) or ( j-_t_int*7==7 and t.isMondayFirtsDayOfTheWeek~=1 ) then cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_Sa, 1))
                                                    else cairo_set_source_rgba(cr, one4all_cairo.rgb2rgba(t.color_W, 1))
                                                    end
                                                    cairo_move_to(cr, t.startX+modX*i+(t.cellSize+t.cellGap)*(j-1-_t_int*7)+_position, t.startY+modY*i+t.cellSize*1.5+(t.cellSize+t.cellGap)*_t_int+t.cellGap+t.cellSize/2-t.cellGap/2)
                                                    cairo_show_text(cr, _text)
                                                    cairo_stroke(cr)
                                                end
                                            end
                                            --]]
                                        end

                                        -- draw rim
                                        local _nowGraph = math.floor(t.numberOfMonth/2)
                                        local _nowDay = os.date('%d'); --_nowDay = '30'
                                        local _nowCell = 0
                                        repeat
                                            _nowCell=_nowCell+1
                                        until _nowDay == t._calendar[_nowGraph+1][_nowCell].day
                                        local _t_int, _t_frac = math.modf(_nowCell/7); if _t_int > 0 and _t_frac == 0 then _t_int = _t_int - 1 end
                                        one4all_cairo.draw_box(cr, t.startX+modX*_nowGraph+(t.cellSize+t.cellGap)*(_nowCell-1-_t_int*7)+t.cellGap, t.startY+modY*_nowGraph+t.cellSize*1.5+(t.cellSize+t.cellGap)*_t_int+t.cellGap*2, t.cellSize-t.cellGap, t.cellSize-t.cellGap, t.corner_rC, t.color_N, t.alpha_N, true)
                                        --]]
                                    end

                                    function M.schedule(t)
                                        local _error = 0
                                        if not M.check_size(t) then return 1 end
                                        if t._calendar[1] == nil then _error = M.init_calendar(t); end
                                        local _upInt, _upFrac = math.modf(tonumber(conky_parse("${updates}"))/t.calendar_update)
                                        if _upFrac == 0 then t._date = os.date('*t'); _error = M.init_calendar(t); end
                                        M.draw_graph(t)
                                        return _error
                                    end



                                    M.setlocale()
                                    --[[
                                    ###############################################################################
                                    ###                            MODULE MAIN LOOP                             ###
                                    ###############################################################################
                                    --]]
                                    function M.main()
                                        for i in pairs(settings_table) do
                                            local _error = M.schedule(settings_table[i])
                                            if _error > 0 then M.errors(settings_table[i], _error); return end
                                        end
                                    end
