n = namespace :test do
  require 'rake/testtask'

  Rake::TestTask.new(:unit) do |t|
    t.pattern = 'specs/**/*_spec.rb'
    t.verbose = false
    t.warning = false
  end
end

task :test => [n[:unit]]
task :default => n[:unit]
