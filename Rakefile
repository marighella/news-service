n = namespace :test do
  require 'rake/testtask'

  Rake::TestTask.new(:functional) do |t|
    t.pattern = 'specs/functional/**/*_spec.rb'
    t.verbose = false
    t.warning = false
  end

  Rake::TestTask.new(:integration) do |t|
    t.pattern = 'specs/integration/**/*_spec.rb'
    t.verbose = false
    t.warning = false
  end
end

task :test => [n[:functional], n[:integration]]
task :default => n[:functional]
