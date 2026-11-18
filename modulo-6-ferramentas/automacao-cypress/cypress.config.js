const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    // Este primeiro projeto não precisa de arquivo de suporte
    supportFile: false,
  },
})
