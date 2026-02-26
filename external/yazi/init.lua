require("git"):setup {
    order = 1500,
}

require("mime-ext.local"):setup {
    with_files = {
        -- makefile = "text/makefile",
    },

    with_exts = {
        -- mk = "text/makefile",
    },
}

require("folder-rules"):setup()


---{{ Show symlink in status bar
function Status:name()
    local h = self._current.hovered
    if not h then
        return ""
    end

    local linked = ""
    if h.link_to ~= nil then
        linked = " -> " .. tostring(h.link_to)
    end
    return ui.Line(" " .. h.name:gsub("\r", "?", 1) .. linked)
end

---}}



---{{ Show user/group of files in status bar
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
    end

    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
    }
end, 500, Status.RIGHT)
---}}



---{{ Show username and hostname in header
Header:children_add(function()
    if ya.target_family() ~= "unix" then
        return ui.Line {}
    end
    return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)
---}}



---{{ Custom Linemode, keymap bind run "linemode custom"
function Linemode:custom()
    local get_size = function()
        local size = self._file:size()
        if size then
            return ya.readable_size(size)
        else
            local folder = cx.active:history(self._file.url)
            return folder and #folder.files ~= 0 and tostring(#folder.files) or "-"
        end
    end

    local get_time = function()
        local time = (self._file.cha.mtime or 0) // 1
        if time == 0 then
            return "--/-- --:--"
        elseif os.date("%Y", time) == os.date("%Y") then
            return os.date("%m/%d %H:%M", time)
        else
            return os.date("%m/%d  %Y", time)
        end
    end

    local get_owner = function()
        local user = self._file.cha.uid and ya.user_name(self._file.cha.uid) or self._file.cha.uid
        local group = self._file.cha.gid and ya.group_name(self._file.cha.gid) or self._file.cha.gid
        return string.format("%s:%s", user or "-", group or "-")
    end

    local get_perm = function()
        return self._file.cha:perm() or ""
    end

    return ui.Line(string.format("%s %s %s %s", get_size(), get_time(), get_owner(), get_perm()))
end

---}}
