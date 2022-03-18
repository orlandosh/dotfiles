local pylint = require('lint.linters.pylint')
pylint.cmd = "poetry"
pylint.args = {
        'run', 'pylint', unpack(pylint.args)
}

require('lint').linters_by_ft = {
  python = {'pylint',}
}
