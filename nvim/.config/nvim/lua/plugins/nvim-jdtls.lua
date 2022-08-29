-- sudo pacman -S gradle jdk-openjdk maven npm
-- paru -S jdtls
-- git clone https://github.com/microsoft/java-debug
-- ./mvnw clean install
-- git clone https://github.com/microsoft/vscode-java-test.git
-- npm install && npm run build-plugin

local home = os.getenv('HOME')
local root_markers = {'gradlew', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

local jar           = vim.fn.glob("/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config  = '/usr/share/java/jdtls/config_linux'
local bundles       = {
        vim.fn.glob(home .. "/Programs/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
        vim.fn.glob(home .. "/Programs/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar"),
        vim.fn.glob(home .. "/Programs/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar"),
        vim.fn.glob(home .. "/Programs/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar"),
}

-- local workspace_dir = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. '/workspace'

local config = {
  cmd = {
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', jar,

    '-configuration', jdtls_config,

    '-data', workspace_dir
  },

  settings = {
    java = {}
  },

  init_options = {
        bundles = bundles
  },
}

config.on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

vim.cmd("command! DapJavaConfig lua require('jdtls.dap').setup_dap_main_class_configs()")
