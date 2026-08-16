# frozen_string_literal: true

name 'sc_vscode'

run_list 'recipe[test::install]'

named_run_list :default, 'recipe[test::install]'

cookbook 'sc_vscode', path: '.'
cookbook 'test', path: './test/fixtures/cookbooks/test'
