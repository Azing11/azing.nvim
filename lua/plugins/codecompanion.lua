-- ~/.config/nvim/lua/plugins/codecompanion.lua
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      -- ========================================
      -- 关键修复：适配器放在 adapters.http 下
      -- ========================================
      adapters = {
        http = {
          -- 定义 LM Studio 适配器
          lmstudio = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "lmstudio",  -- 适配器名称
              env = {
                url = "http://localhost:1234",  -- LM Studio 默认端口
                -- chat_url = "/v1/chat/completions",  -- 可选：默认就是这个
                -- api_key = "not-needed",  -- 本地模型不需要
              },
              schema = {
                model = {
                  default = "local-model",  -- 模型名称，LM Studio中显示的
                },
                temperature = {
                  default = 0.2,
                },
                max_tokens = {
                  default = 2048,  -- RTX 3050 建议值
                },
              },
            })
          end,
        },
        -- 可选：隐藏预设适配器，只显示自定义的
        opts = {
          show_defaults = false,
        },
      },
      
      -- ========================================
      -- 策略配置：引用上面定义的适配器
      -- ========================================
      strategies = {
        chat = {
          adapter = "lmstudio",  -- 必须匹配上面的名称
        },
        inline = {
          adapter = "lmstudio",
        },
        cmd = {
          adapter = "lmstudio",
        },
      },
      
      -- ========================================
      -- 其他选项
      -- ========================================
      opts = {
        log_level = "DEBUG",  -- 调试用，稳定后改 INFO
      },
    })
  end,
  
  -- 快捷键
  keys = {
    { "<leader>a", "", desc = "+AI" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Chat" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
  },
}