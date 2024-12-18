local group = vim.api.nvim_create_augroup("autosave", {})

local AutoSave = {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },
      },
      condition = nil,
      write_all_buffers = false,
      noautocmd = false,
      lockmarks = false,
      debounce_delay = 1000,
      debug = false,
    },
    config = function()
      require("auto-save").setup({
        enabled = true,
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost" },
          defer_save = { "InsertLeave", "TextChanged" },
          cancel_deferred_save = { "InsertEnter" },
        },
        debounce_delay = 1000,
        condition = nil,
      })

      -- Thêm thông báo tự động sau khi lưu
      -- vim.api.nvim_create_autocmd("BufWritePost", {
      --   callback = function()
      --     vim.notify("AutoSave: File has been saved", vim.log.levels.INFO, { title = "AutoSave" })
      --   end,
      -- })

      vim.api.nvim_create_autocmd("User", {
        pattern = "AutoSaveWritePost",
        group = group,
        callback = function(opts)
          if opts.data.saved_buffer ~= nil then
            local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
            -- vim.notify("AutoSave: saved " .. filename .. " at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO)
            vim.notify(
              "AutoSave: Saved at " .. vim.fn.strftime("%H:%M:%S"),
              vim.log.levels.INFO,
              { title = "AutoSave" }
            )
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "AutoSaveEnable",
        group = group,
        callback = function(opts)
          vim.notify("AutoSave enabled", vim.log.levels.INFO)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "AutoSaveDisable",
        group = group,
        callback = function(opts)
          vim.notify("AutoSave disabled", vim.log.levels.INFO)
        end,
      })
    end,
  },
}

return AutoSave
