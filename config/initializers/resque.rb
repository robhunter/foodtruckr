require "resque"
require "resque/failure/multiple"
require "resque/failure/redis"
require 'resque_scheduler'

ENV["REDISTOGO_URL"] ||= "localhost:6379/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))

Resque.after_fork { ActiveRecord::Base.establish_connection if defined?(ActiveRecord) }

module Resque
  module Failure
    # Logs failure messages.
    class Logger < Base
      def save
        Rails.logger.error detailed
      end

      def detailed
        backtrace = exception.backtrace.map { |l| "  " + l }.join("\n") unless exception.backtrace.nil?
        <<-EOF
#{worker} failed processing #{queue}:
Payload:
#{payload.inspect.split("\n").map { |l| "  " + l }.join("\n")}
Exception:
  #{exception}
#{backtrace}
        EOF
      end
    end

    # Emails failure messages.
    # Note: uses Mail (default in Rails 3.0) not TMail (Rails 2.x).
    class Notifier < Logger
      def save
        text, subject = detailed, "[Error] #{queue}: #{exception}"
        ErrorMailer.error(Rails.configuration.application_errors, subject, text).deliver if Rails.env.production?
      end
    end

  end
end

Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Notifier]
Resque::Failure.backend = Resque::Failure::Multiple

