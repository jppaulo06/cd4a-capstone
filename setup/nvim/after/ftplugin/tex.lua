vim.opt_local.spell = true
vim.opt_local.spelllang = vim.fn.expand("%:t:r") == "resumo" and "pt_br" or "en_us"
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.textwidth = 0
vim.opt_local.conceallevel = 0
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.swapfile = true

-- Move through screen lines when prose wraps, retaining numbered motions.
for _, key in ipairs({ "j", "k" }) do
  vim.keymap.set("n", key, function()
    return vim.v.count == 0 and "g" .. key or key
  end, { buffer = true, expr = true, silent = true })
end

local cmp = require("cmp")
cmp.setup.filetype("tex", {
  sources = cmp.config.sources({
    { name = "omni" }, -- VimTeX: citation keys, labels, commands, environments.
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
})

local ls = require("luasnip")
ls.add_snippets("tex", require("jppaulo.snippets.tex"), { key = "thesis-tex" })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_locally_jumpable() then
    ls.expand_or_jump()
  end
end, { buffer = true, desc = "Expand snippet / next field" })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.locally_jumpable(-1) then
    ls.jump(-1)
  end
end, { buffer = true, desc = "Previous snippet field" })
