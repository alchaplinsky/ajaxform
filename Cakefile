VERSION = "0.1.0"

{exec} = require "child_process"

task "build", ->
  exec "cat src/version.js | sed s/{VERSION}/#{VERSION}/ > ajaxform.js"
  exec "coffee -cp src/ajaxform.coffee >> ajaxform.js"
  
task "copy", ->
  exec "cp ajaxform.js build/ajaxform-#{VERSION}.js"