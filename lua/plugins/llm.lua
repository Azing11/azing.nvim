-- ~/.config/nvim/lua/plugins/llm.lua
return {
  "Kurama622/llm.nvim",
  dependencies = { 
    "nvim-lua/plenary.nvim", 
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim", -- 可选：更好的Markdown渲染
  },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = function()
    require("llm").setup({
      -- ========================================
      -- LM Studio 配置（关键部分）
      -- ========================================
      url = "http://localhost:1234/v1/chat/completions",  -- LM Studio 默认端口
      model = "Qwen3.5-9B",  -- LM Studio中加载的模型名称
      api_type = "lmstudio",  -- 指定使用LM Studio适配器
      
      -- 本地模型不需要API Key，但插件需要这个字段
      fetch_key = function() return "NONE" end,
      
      -- 性能调优（针对RTX 3050）
      max_tokens = 2048,
      temperature = 0.2,
      timeout = 60,
      
      -- UI配置
      ui = {
        float = {
          border = "rounded",
          title = " LLM Chat ",
        },
      },
      
      -- 代码补全配置（Copilot式体验）
      completion = {
        enabled = true,
        -- 触发补全的延迟
        debounce = 300,
        -- 上下文行数
        context_lines = 50,
      },
    })
  end,
  
  -- 快捷键配置
  keys = {
    -- 打开/关闭聊天窗口
    { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "AI Chat" },
    -- 处理选中的文本（解释/优化/重构）
    { "<leader>as", mode = "v", "<cmd>LLMSelectedTextHandler<cr>", desc = "AI Selection" },
    -- AI工具菜单
    { "<leader>aa", mode = "n", "<cmd>LLMAppHandler<cr>", desc = "AI Actions" },
    -- 快速提问（无需打开聊天窗口）
    { "<leader>aq", mode = "n", "<cmd>LLMSelectedTextHandler ask<cr>", desc = "Quick Ask" },
  },
}