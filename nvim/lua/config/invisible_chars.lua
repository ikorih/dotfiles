-- Highlight invisible/problematic Unicode characters so they don't slip into
-- source files unnoticed. Inline virtual text is required because some target
-- chars (e.g. U+2028) render at 0 display-width, so an hl_group alone is not
-- visible — there's no cell for the background color to land on.

local M = {}

local CODEPOINTS = {
  [0x00A0] = true, -- NBSP
  [0x1680] = true, -- OGHAM SPACE MARK
  [0x2028] = true, -- LINE SEPARATOR
  [0x2029] = true, -- PARAGRAPH SEPARATOR
  [0x202F] = true, -- NNBSP
  [0x205F] = true, -- MEDIUM MATH SPACE
  [0x2060] = true, -- WORD JOINER
  [0xFEFF] = true, -- BOM / ZWNBSP
}
for cp = 0x2000, 0x200F do CODEPOINTS[cp] = true end -- various spaces, ZW chars, bidi marks
for cp = 0x202A, 0x202E do CODEPOINTS[cp] = true end -- bidi overrides
for cp = 0x2066, 0x2069 do CODEPOINTS[cp] = true end -- bidi isolates

local NS = vim.api.nvim_create_namespace("InvisibleChars")

local function iter_codepoints(line, fn)
  local byte = 0
  for i = 0, vim.fn.strchars(line) - 1 do
    local cp = vim.fn.strgetchar(line, i)
    local len = #vim.fn.nr2char(cp)
    fn(i, byte, cp, len)
    byte = byte + len
  end
end

local function should_scan(buf)
  return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == ""
end

local function highlight_buffer(buf)
  if not should_scan(buf) then return end
  vim.api.nvim_buf_clear_namespace(buf, NS, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for lnum, line in ipairs(lines) do
    iter_codepoints(line, function(_, byte, cp, len)
      if CODEPOINTS[cp] then
        vim.api.nvim_buf_set_extmark(buf, NS, lnum - 1, byte, {
          end_col = byte + len,
          hl_group = "InvisibleChars",
          virt_text = { { string.format("<U+%04X>", cp), "InvisibleChars" } },
          virt_text_pos = "inline",
          priority = 200,
        })
      end
    end)
  end
end

local function scan_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local hits = {}
  for lnum, line in ipairs(lines) do
    iter_codepoints(line, function(i, _, cp, _)
      if
        cp > 127
        and (cp < 0x3040 or cp > 0x30FF) -- skip hiragana/katakana
        and (cp < 0x4E00 or cp > 0x9FFF) -- skip CJK unified ideographs
        and (cp < 0xFF00 or cp > 0xFFEF) -- skip fullwidth forms
      then
        hits[#hits + 1] = string.format("L%d C%d  U+%04X  %s", lnum, i + 1, cp, vim.fn.nr2char(cp))
      end
    end)
  end
  vim.notify(#hits == 0 and "No suspicious characters found" or table.concat(hits, "\n"))
end

function M.setup()
  vim.api.nvim_set_hl(0, "InvisibleChars", { bg = "#ff5f5f", fg = "#ffffff" })

  local group = vim.api.nvim_create_augroup("InvisibleChars", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = function(args) highlight_buffer(args.buf) end,
  })

  vim.api.nvim_create_user_command("ScanInvisible", scan_buffer, {
    desc = "List suspicious non-ASCII codepoints in the current buffer",
  })

  highlight_buffer(vim.api.nvim_get_current_buf())
end

return M
