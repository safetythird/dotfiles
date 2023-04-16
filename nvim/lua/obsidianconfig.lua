require("obsidian").setup({
  dir = "~/Documents/wiki",
  completion = {
    nvim_cmp = true,
  },
  open_app_foreground = true,
  daily_notes = {
    folder = "Dailies",
  },
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    -- IDs look like "230415-foo-bar"
    return tostring(os.date("%y%m%d")) .. "-" .. suffix
  end
})
