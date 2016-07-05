# coding: utf-8

task(:clean) do
  require 'rake/clean'
# CLEAN.replace %w(.yardoc coverage doc log pkg)
end

desc 'Run Simplecov'
task :coverage => [:set_coverage_env, :test]

task :default => :test

desc 'Generate documentation'
task(:doc) do
  sh 'yard'
end

task(:gem) do
  require 'bundler/gem_tasks'
# Do something
end

task :set_coverage_env do
  ::ENV['COVERAGE'] = 'true'
end

task(:test) do
  require 'rake/testtask'
  Rake::TestTask.new(:test) do |t|
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
    t.warning = true
  end
end

namespace :doc do
  desc 'Generate documentation incrementally'
  task(:redoc) do
    sh 'yard -c'
  end

  desc 'List all undocumented methods and classes.'
  task(:undocumented) do
    command = 'yard --list --query'
    command << ' "object.docstring.blank?'
    command << ' && !(object.type == :method && object.is_alias?)"'
    sh command
  end
end

namespace :test do
  task(:clean) do
    ::Dir.glob('test/var/**/*'){|e| ::File.delete e}
  end
end

