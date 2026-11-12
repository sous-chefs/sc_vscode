# frozen_string_literal: true

name 'sc_vscode'
default_source :supermarket
run_list 'test::default'
cookbook 'sc_vscode', path: '.'
cookbook 'test', path: 'test/cookbooks/test'
