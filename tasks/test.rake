desc 'Runs all the tests'
task :test do
  sh 'rspec spec --order=random'
end
