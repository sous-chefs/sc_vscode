# frozen_string_literal: true
title 'VScode should be installed'

describe command('code').exist? do
  it { should eq true }
end
