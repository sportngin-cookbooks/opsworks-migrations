task default: %w[lint test]

# Log warnings but only fail the build on correctness issues.
# To list correctness: foodcritic -t correctness -t ~FC001 .
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

task :test do
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  Rake::Task['kitchen:all'].invoke
end