task default: %w[lint spec test]

desc("Log warnings but only fail the build on correctness. To list correctness: `foodcritic -t correctness -t ~FC001 .`")
task :lint do
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new do |t|
    t.options = {
        :fail_tags => ['correctness'],
        :tags => ['~FC001']
    }
  end
  Rake::Task['foodcritic'].invoke
end

begin
  require 'rspec/core/rake_task'
  desc("Run all unit tests.")
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

desc("Run all test kitchen integration tests.")
task :test do
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  Rake::Task['kitchen:all'].invoke
end