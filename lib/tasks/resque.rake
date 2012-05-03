require 'resque/tasks'
require 'resque_scheduler/tasks'

module ResqueWorker
  extend self

  def scheduler_or_worker?
    redis = Resque.redis
    if redis.setnx('scheduler_active', 'active')
     begin
       yield 'scheduler'
     ensure
       redis.del('scheduler_active')
     end
    else
     yield 'work'
    end
  end
end

task "resque:setup" => :environment
task "resque:scheduler_setup" => :environment


desc "Run Resque workers on Heroku"
task "jobs:work" => ["resque:setup", "resque:scheduler_setup"] do
  ENV['QUEUE'] = '*'
  ResqueWorker.scheduler_or_worker? {|which| Rake::Task["resque:#{which}"].invoke }

  require 'rpm_contrib' if Rails.env.production?
end


# see http://stackoverflow.com/questions/5880962/how-to-destroy-jobs-enqueued-by-resque-workers - old version
# see https://github.com/defunkt/resque/issues/49
# see http://redis.io/commands - new commands

namespace :resque do
  desc "Clear pending tasks"
  task :clear => :environment do
    queues = Resque.queues
    queues.each do |queue_name|
      puts "Clearing #{queue_name}..."
      Resque.redis.del "queue:#{queue_name}"
    end
    
    puts "Clearing delayed..." # in case of scheduler - doesn't break if no scheduler module is installed
    Resque.redis.keys("delayed:*").each do |key|
      Resque.redis.del "#{key}"
    end
    Resque.redis.del "delayed_queue_schedule"
    
    puts "Clearing stats..."
    Resque.redis.set "stat:failed", 0 
    Resque.redis.set "stat:processed", 0
  end
end