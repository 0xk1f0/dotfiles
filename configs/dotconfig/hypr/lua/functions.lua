local M = {}
local workspace_float_states = {}

function M.toggle_workspace_floating()
    local ws = hl.get_active_workspace()
    if not ws then return end
    local ws_id = tostring(ws.id)

    local should_float = not workspace_float_states[ws_id]
    workspace_float_states[ws_id] = should_float

    if should_float then
        hl.window_rule({
            name = "autofloat_" .. ws_id,
            match = { workspace = ws_id },
            float = true
        })
    else
        hl.window_rule({
            name = "autofloat_" .. ws_id,
            match = { workspace = ws_id },
            float = false
        })
    end

    local windows = hl.get_workspace_windows(ws)
    for _, window in ipairs(windows) do
        if window.floating ~= should_float then
            hl.dispatch(hl.dsp.window.float({ window = window, action = "toggle" }))
        end
    end
end

return M
