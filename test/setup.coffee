jsdom = require 'jsdom'

global.document or= jsdom.jsdom()
global.window or= global.document.createWindow()

HamlCoffee = require 'haml-coffee/src/haml-coffee'
fs = require 'fs'
CoffeeScript = require 'coffee-script'

require.extensions['.haml'] = (module, filename) ->
  # Largely copy from hem-haml-coffee
  contents = fs.readFileSync(filename).toString()
  compiler = new HamlCoffee {}
  compiler.parse(contents)
  template = compiler.precompile()
  template = CoffeeScript.compile(template)
  return module._compile("""module.exports = (function(data) {
    return (function() { return #{template};}).call(data);
  })""")
