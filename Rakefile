require 'rake/clean'

Dir[File.expand_path('../tasks/*.rake', __FILE__)].each do |task|
  import(task)
end

task :default => :test
