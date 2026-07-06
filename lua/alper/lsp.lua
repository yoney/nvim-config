vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end,
})

vim.lsp.enable({ "clangd" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = function(desc)
      return { buffer = ev.buf, desc = desc }
    end

    -- Definitions & Declarations
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))

    -- References, Implementations, and Refactoring
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to references"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts("Rename symbol"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("LSP code action"))
  end,
})
