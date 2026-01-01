-- Radicale Theme for Neovim
-- Based on the Radical VS Code theme by DHedgecock
-- A dark theme for radical hacking inspired by retro futuristic design

-- Define the color palette
local colors = {
  -- Background Colors
  bg = "#141322",           -- PRIMARY_BACKGROUND (Editor, Panel)
  bg_dark = "#12111f",      -- DARK_BACKGROUND (Sidebar, Tabs, Status bar)
  bg_darker = "#100f1a",    -- ULTRA_BACKGROUND (Activity bar, Title bar)
  bg_light = "#1c1a30",     -- LIGHT_BACKGROUND (Input fields)
  bg_alt = "#1a1b46",       -- ANOTHER_BACKGROUND (Dropdowns)
  
  -- Foreground Colors
  fg = "#A8D2D4",           -- Main foreground
  fg_dim = "#94b4c4",       -- Dimmed foreground
  fg_bright = "#cff0e8",    -- Bright foreground
  
  -- Primary Accent Colors (Pinks)
  primary = "#ff428e",      -- PRIMARY (Pink)
  primary_hover = "#ff6ba6", -- PRIMARY_HOVER
  ultra = "#f52277",        -- ULTRA (Deep Pink)
  ultra_light = "#fda8bc",  -- PINKS[100]
  ultra_medium = "#FE8DA5", -- PINKS[200]
  ultra_dark = "#FB4293",   -- PINKS[500]
  
  -- Secondary Accent Colors (Teals/Cyans)
  secondary = "#a8ffef",    -- SECONDARY (Teal)
  secondary_hover = "#baffec", -- SECONDARY_HOVER
  cyan = "#7DD9E4",         -- Blue
  cyan_bright = "#84F9FE",  -- Bright Blue
  teal = "#A9FEF7",         -- TEALS[100]
  teal_light = "#A4FFE4",   -- TEALS[200]
  teal_bright = "#7AFFE2",  -- TEALS[300]
  
  -- Chartreuse (Yellow-Green)
  chartreuse = "#DFF959",   -- Main chartreuse
  chartreuse_light = "#E5FCA6", -- CHARTREUSES[100]
  chartreuse_medium = "#DFFD8E", -- CHARTREUSES[150]
  chartreuse_dark = "#DCFF7A",  -- CHARTREUSES[200]
  chartreuse_dim = "#B3E27C",   -- CHARTREUSES[300]
  
  -- Lavender/Purple
  lavender = "#cbbce7",      -- LAVENDERS[100]
  lavender_light = "#d9a3e0", -- LAVENDERS[200]
  lavender_dark = "#be8ce7",  -- LAVENDERS[300]
  purple = "#864df8",       -- RADVENDER
  vscode_purple = "#602976", -- VSCODE_PURPLE
  
  -- Gray Scale
  gray_100 = "#B4DAE9",     -- GRAY_100
  gray_150 = "#94b4c4",     -- GRAY_150
  gray_200 = "#75B7BB",     -- GRAY_200
  gray_300 = "#7c9c9e",     -- GRAY_300
  gray_400 = "#639196",     -- GRAY_400
  gray_500 = "#45898C",     -- GRAY_500
  
  -- Blue Scale
  blue_50 = "#EAFEFA",      -- BLUE_50
  blue_100 = "#d0fff4",     -- BLUE_100
  blue_125 = "#c9fdf1",     -- BLUE_125
  blue_175 = "#90b0b3",     -- BLUE_175
  blue_200 = "#7c9c9e",     -- BLUE_200
  blue_250 = "#415e6c",     -- BLUE_250
  
  -- Border Colors
  border = "#1A1B46",       -- BORDERS[100]
  border_light = "#242560", -- BORDERS[200]
  border_medium = "#1D1E7D", -- BORDERS[300]
  border_dark = "#8C2C56",  -- BORDERS[400]
  border_accent = "#FC0065", -- BORDERS[500]
  
  -- Status Colors
  info = "#93E0E3",         -- INFO
  warning = "#ffd000",      -- WARNING
  error = "#ff1767",        -- ERROR
  
  -- Git Colors
  git_added = "#a3ff57",    -- GIT_ADDED
  git_modified = "#ffb000", -- GIT_MODIFIED
  git_deleted = "#ff427b",  -- GIT_DELETED
  git_untracked = "#c8ff00", -- GIT_UNTRACKED
  git_ignored = "#415e6c",  -- GIT_IGNORED
  git_conflict = "#ff428a", -- GIT_CONFLICTING
  
  -- Highlight Colors
  highlight_current_line = "#d043cf", -- HIGHLIGHT_CURRENT_LINE
  highlight_range = "#fd43cd",        -- HIGHLIGHT_RANGE
  highlight_selection = "#874df8",    -- HIGHLIGHT_CURRENT_SELECTION
  highlight_match = "#9736c0",         -- HIGHLIGHT_MATCH
  highlight_addl_match = "#f179e1",     -- HIGHLIGHT_ADDL_MATCH
  highlight_read = "#ff5300",          -- HIGHLIGHT_READ_ACCESS
  highlight_write = "#efe900",         -- HIGHLIGHT_WRITE_ACCESS
  
  -- Search Colors
  search = "#874df8",        -- Search highlight
  inc_search = "#f179e1",   -- Incremental search
}

-- Set the background
vim.o.background = "dark"

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

-- Set the colorscheme name
vim.g.colors_name = "radicale"

-- Define highlight groups
local highlights = {
  -- Editor groups
  Normal = { fg = colors.fg, bg = colors.bg },
  NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
  FloatBorder = { fg = colors.border_accent, bg = colors.bg_dark },
  CursorLine = { bg = colors.bg_light },
  CursorLineNr = { fg = colors.primary, bg = colors.bg_light },
  ColorColumn = { bg = colors.bg_alt },
  CursorColumn = { bg = colors.bg_light },
  
  -- Selection and search
  Visual = { bg = colors.highlight_selection },
  VisualNOS = { bg = colors.highlight_selection },
  IncSearch = { fg = colors.bg, bg = colors.inc_search },
  Search = { fg = colors.bg, bg = colors.search },
  
  -- Fold and sign column
  Folded = { fg = colors.gray_400, bg = colors.bg_dark },
  FoldColumn = { fg = colors.gray_300, bg = colors.bg_dark },
  SignColumn = { fg = colors.gray_300, bg = colors.bg },
  
  -- Line numbers
  LineNr = { fg = colors.gray_400, bg = colors.bg },
  
  -- Window elements
  VertSplit = { fg = colors.border, bg = colors.bg },
  WinSeparator = { fg = colors.border, bg = colors.bg },
  
  -- Tab line
  TabLine = { fg = colors.gray_300, bg = colors.bg_dark },
  TabLineFill = { fg = colors.gray_300, bg = colors.bg_dark },
  TabLineSel = { fg = colors.fg_bright, bg = colors.primary },
  
  -- Status line
  StatusLine = { fg = colors.fg_bright, bg = colors.primary },
  StatusLineNC = { fg = colors.gray_300, bg = colors.bg_dark },
  
  -- Menu and popup
  Pmenu = { fg = colors.fg, bg = colors.bg_dark },
  PmenuSel = { fg = colors.bg, bg = colors.primary },
  PmenuSbar = { bg = colors.border_light },
  PmenuThumb = { bg = colors.primary },
  
  -- Wild menu
  WildMenu = { fg = colors.bg, bg = colors.primary },
  
  -- Misc
  Directory = { fg = colors.teal },
  Title = { fg = colors.primary },
  Question = { fg = colors.chartreuse },
  MoreMsg = { fg = colors.chartreuse },
  ModeMsg = { fg = colors.chartreuse },
  
  -- Error and warning
  ErrorMsg = { fg = colors.error },
  WarningMsg = { fg = colors.warning },
  
  -- Non-text
  NonText = { fg = colors.gray_400 },
  EndOfBuffer = { fg = colors.gray_400 },
  
  -- Conceal
  Conceal = { fg = colors.gray_500 },
  
  -- Whitespace
  Whitespace = { fg = colors.gray_500 },
  SpaceChar = { fg = colors.gray_500 },
  
-- Syntax highlighting
  Comment = { fg = colors.gray_500, italic = true },
  Constant = { fg = colors.chartreuse_light },
  String = { fg = colors.teal },
  Character = { fg = colors.teal_light },
  Number = { fg = colors.chartreuse },
  Boolean = { fg = colors.chartreuse_dim },
  Float = { fg = colors.chartreuse },
  
  Identifier = { fg = colors.fg },
  Function = { fg = colors.cyan_bright },
  
  Statement = { fg = colors.primary },
  Conditional = { fg = colors.ultra_dark },
  Repeat = { fg = colors.ultra_dark },
  Label = { fg = colors.primary },
  Operator = { fg = colors.ultra_medium },
  Keyword = { fg = colors.ultra_dark },
  Exception = { fg = colors.error },
  
  PreProc = { fg = colors.lavender },
  Include = { fg = colors.lavender },
  Define = { fg = colors.lavender },
  Macro = { fg = colors.lavender_light },
  PreCondit = { fg = colors.lavender },
  
  Type = { fg = colors.lavender_dark, italic = true },
  StorageClass = { fg = colors.ultra_medium },
  Structure = { fg = colors.lavender },
  Typedef = { fg = colors.lavender },
  
  Special = { fg = colors.chartreuse_medium },
  SpecialChar = { fg = colors.chartreuse_medium },
  Tag = { fg = colors.primary },
  Delimiter = { fg = colors.gray_300 },
  SpecialComment = { fg = colors.gray_400, italic = true },
  Debug = { fg = colors.error },
  
  Underlined = { fg = colors.primary, underline = true },
  Ignore = { fg = colors.gray_500 },
  Error = { fg = colors.error, bold = true, underline = true },
  Todo = { fg = colors.chartreuse, bold = true },
  
  -- Diff
  DiffAdd = { fg = colors.git_added, bg = colors.bg_alt },
  DiffChange = { fg = colors.git_modified, bg = colors.bg_alt },
  DiffDelete = { fg = colors.git_deleted, bg = colors.bg_alt },
  DiffText = { fg = colors.git_modified, bg = colors.bg_light },
  
  -- Spell
  SpellBad = { fg = colors.error, underline = true, sp = colors.error },
  SpellCap = { fg = colors.warning, underline = true, sp = colors.warning },
  SpellRare = { fg = colors.lavender, underline = true, sp = colors.lavender },
  SpellLocal = { fg = colors.chartreuse, underline = true, sp = colors.chartreuse },
  
  -- Message
  MessageWindow = { fg = colors.fg, bg = colors.bg_dark },
  PopupNotification = { fg = colors.fg, bg = colors.bg_dark },
  
  -- LSP
  LspReferenceText = { bg = colors.highlight_range },
  LspReferenceRead = { bg = colors.highlight_read },
  LspReferenceWrite = { bg = colors.highlight_write },
  LspSignatureActiveParameter = { fg = colors.primary, bold = true },
  
  -- Diagnostic
  DiagnosticError = { fg = colors.error },
  DiagnosticWarn = { fg = colors.warning },
  DiagnosticInfo = { fg = colors.info },
  DiagnosticHint = { fg = colors.chartreuse },
  DiagnosticUnderlineError = { underline = true, sp = colors.error },
  DiagnosticUnderlineWarn = { underline = true, sp = colors.warning },
  DiagnosticUnderlineInfo = { underline = true, sp = colors.info },
  DiagnosticUnderlineHint = { underline = true, sp = colors.chartreuse },
  
-- Treesitter (semantic highlighting)
  ["@keyword"] = { fg = colors.ultra_dark },
  ["@keyword.coroutine"] = { fg = colors.ultra },
  ["@keyword.function"] = { fg = colors.ultra_dark },
  ["@keyword.operator"] = { fg = colors.ultra_medium },
  ["@keyword.import"] = { fg = colors.lavender },
  ["@keyword.type"] = { fg = colors.ultra_medium },
  ["@keyword.modifier"] = { fg = colors.ultra_medium },
  ["@keyword.repeat"] = { fg = colors.ultra_dark },
  ["@keyword.return"] = { fg = colors.ultra },
  ["@keyword.debug"] = { fg = colors.error },
  ["@keyword.exception"] = { fg = colors.error },
  
  ["@keyword.conditional"] = { fg = colors.ultra_dark },
  ["@keyword.conditional.ternary"] = { fg = colors.ultra_medium },
  
  ["@keyword.directive"] = { fg = colors.lavender },
  ["@keyword.directive.define"] = { fg = colors.lavender },
  
  ["@punctuation.delimiter"] = { fg = colors.gray_300 },
  ["@punctuation.bracket"] = { fg = colors.gray_300 },
  ["@punctuation.special"] = { fg = colors.chartreuse_medium },
  
  ["@comment"] = { fg = colors.gray_500, italic = true },
  ["@comment.documentation"] = { fg = colors.gray_400, italic = true },
  
  ["@comment.error"] = { fg = colors.error, bold = true },
  ["@comment.warning"] = { fg = colors.warning, bold = true },
  ["@comment.todo"] = { fg = colors.chartreuse, bold = true },
  ["@comment.note"] = { fg = colors.info, bold = true },
  
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.underline"] = { underline = true },
  
  ["@markup.heading"] = { fg = colors.primary, bold = true },
  ["@markup.heading.1"] = { fg = colors.primary, bold = true },
  ["@markup.heading.2"] = { fg = colors.primary_hover, bold = true },
  ["@markup.heading.3"] = { fg = colors.ultra, bold = true },
  ["@markup.heading.4"] = { fg = colors.ultra_light, bold = true },
  ["@markup.heading.5"] = { fg = colors.ultra_medium, bold = true },
  ["@markup.heading.6"] = { fg = colors.ultra_dark, bold = true },
  
  ["@markup.quote"] = { fg = colors.chartreuse },
  ["@markup.math"] = { fg = colors.lavender },
  ["@markup.environment"] = { fg = colors.lavender },
  ["@markup.environment.name"] = { fg = colors.lavender_dark },
  
  ["@markup.link"] = { fg = colors.primary, underline = true },
  ["@markup.link.label"] = { fg = colors.cyan },
  ["@markup.link.url"] = { fg = colors.primary, underline = true },
  
  ["@markup.raw"] = { fg = colors.teal },
  ["@markup.raw.block"] = { fg = colors.teal, bg = colors.bg_dark },
  
  ["@markup.list"] = { fg = colors.primary },
  ["@markup.list.checked"] = { fg = colors.chartreuse },
  ["@markup.list.unchecked"] = { fg = colors.gray_400 },
  
  ["@diff.plus"] = { fg = colors.git_added },
  ["@diff.minus"] = { fg = colors.git_deleted },
  ["@diff.delta"] = { fg = colors.git_modified },
  
  ["@tag"] = { fg = colors.primary },
  ["@tag.attribute"] = { fg = colors.teal },
  ["@tag.delimiter"] = { fg = colors.gray_300 },
  
  -- Git
  GitSignsAdd = { fg = colors.git_added },
  GitSignsChange = { fg = colors.git_modified },
  GitSignsDelete = { fg = colors.git_deleted },
  GitSignsAddNr = { fg = colors.git_added },
  GitSignsChangeNr = { fg = colors.git_modified },
  GitSignsDeleteNr = { fg = colors.git_deleted },
  GitSignsAddLn = { bg = colors.git_added },
  GitSignsChangeLn = { bg = colors.git_modified },
  GitSignsDeleteLn = { bg = colors.git_deleted },
  
  -- Telescope
  TelescopeNormal = { fg = colors.fg, bg = colors.bg_dark },
  TelescopeBorder = { fg = colors.border_accent, bg = colors.bg_dark },
  TelescopeTitle = { fg = colors.primary, bg = colors.bg_dark },
  TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_light },
  TelescopePromptBorder = { fg = colors.primary, bg = colors.bg_light },
  TelescopePromptTitle = { fg = colors.bg_light, bg = colors.primary },
  TelescopeResultsNormal = { fg = colors.fg, bg = colors.bg_dark },
  TelescopeResultsBorder = { fg = colors.border, bg = colors.bg_dark },
  TelescopeResultsTitle = { fg = colors.bg_dark, bg = colors.bg_dark },
  TelescopeSelection = { fg = colors.bg, bg = colors.primary },
  TelescopeSelectionCaret = { fg = colors.ultra, bg = colors.primary },
  TelescopeMultiSelection = { fg = colors.chartreuse, bg = colors.bg_dark },
  TelescopeMatching = { fg = colors.ultra_medium, bold = true },
  
  -- Which key
  WhichKey = { fg = colors.primary },
  WhichKeyGroup = { fg = colors.lavender },
  WhichKeySeparator = { fg = colors.gray_400 },
  WhichKeyDesc = { fg = colors.teal },
  WhichKeyFloat = { fg = colors.fg, bg = colors.bg_dark },
  WhichKeyBorder = { fg = colors.border, bg = colors.bg_dark },
  
  -- CMP (completion)
  CmpNormal = { fg = colors.fg, bg = colors.bg_dark },
  CmpBorder = { fg = colors.border, bg = colors.bg_dark },
  CmpDocNormal = { fg = colors.fg, bg = colors.bg_dark },
  CmpDocBorder = { fg = colors.border, bg = colors.bg_dark },
  CmpItemAbbr = { fg = colors.fg },
  CmpItemAbbrDeprecated = { fg = colors.gray_400, strikethrough = true },
  CmpItemAbbrMatch = { fg = colors.primary, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = colors.ultra_medium, bold = true },
  CmpItemKind = { fg = colors.lavender },
  CmpItemMenu = { fg = colors.gray_400 },
  
  -- NvimTree
  NvimTreeNormal = { fg = colors.fg, bg = colors.bg_dark },
  NvimTreeNormalNC = { fg = colors.fg, bg = colors.bg_dark },
  NvimTreeRootFolder = { fg = colors.primary, bold = true },
  NvimTreeFolderName = { fg = colors.lavender_dark },
  NvimTreeFolderIcon = { fg = colors.primary },
  NvimTreeEmptyFolderName = { fg = colors.gray_400 },
  NvimTreeOpenedFolderName = { fg = colors.lavender, bold = true },
  NvimTreeFileName = { fg = colors.fg },
  NvimTreeFileIcon = { fg = colors.teal },
  NvimTreeExecFile = { fg = colors.chartreuse },
  NvimTreeOpenedFile = { fg = colors.cyan },
  NvimTreeSpecialFile = { fg = colors.primary, underline = true },
  NvimTreeIndentMarker = { fg = colors.gray_500 },
  NvimTreeGitDirty = { fg = colors.git_modified },
  NvimTreeGitStaged = { fg = colors.git_added },
  NvimTreeGitMerge = { fg = colors.git_conflict },
  NvimTreeGitRenamed = { fg = colors.lavender },
  NvimTreeGitNew = { fg = colors.git_added },
  NvimTreeGitDeleted = { fg = colors.git_deleted },
  NvimTreeGitIgnored = { fg = colors.git_ignored },
  NvimTreeWinSeparator = { fg = colors.border, bg = colors.bg_dark },
  NvimTreeCursorLine = { bg = colors.bg_light },
  NvimTreeCursorColumn = { bg = colors.bg_light },
  
  -- Indent blankline
  IndentBlanklineChar = { fg = colors.gray_500, nocombine = true },
  IndentBlanklineContextChar = { fg = colors.primary, nocombine = true },
  IndentBlanklineContextStart = { fg = colors.primary, underline = true, sp = colors.primary },
  IndentBlanklineContextSpaceChar = { fg = colors.gray_500, nocombine = true },
  
  -- Winbar
  WinBar = { fg = colors.gray_300, bg = colors.bg },
  WinBarNC = { fg = colors.gray_400, bg = colors.bg },
}

-- Apply highlights
for group, hl in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, hl)
end

-- Set terminal colors
vim.g.terminal_color_0 = "#30317D"   -- Black
vim.g.terminal_color_8 = "#391AB5"   -- Bright Black
vim.g.terminal_color_1 = "#FF5395"   -- Red
vim.g.terminal_color_9 = "#FF427B"   -- Bright Red
vim.g.terminal_color_2 = "#D8FF4E"   -- Green
vim.g.terminal_color_10 = "#C8FF00"  -- Bright Green
vim.g.terminal_color_3 = "#FFFC7E"   -- Yellow
vim.g.terminal_color_11 = "#F8D846"  -- Bright Yellow
vim.g.terminal_color_4 = "#7DD9E4"   -- Blue
vim.g.terminal_color_12 = "#84F9FE"  -- Bright Blue
vim.g.terminal_color_5 = "#fa61b8"   -- Magenta
vim.g.terminal_color_13 = "#d5358f"  -- Bright Magenta
vim.g.terminal_color_6 = "#A8FFEF"   -- Cyan
vim.g.terminal_color_14 = "#83FEE8"  -- Bright Cyan
vim.g.terminal_color_7 = "#cff0e8"   -- White
vim.g.terminal_color_15 = "#cbfff2"  -- Bright White

-- Terminal background and foreground
vim.g.terminal_background = colors.bg
vim.g.terminal_foreground = colors.fg