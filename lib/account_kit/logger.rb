module AccountKit
  extend self

  attr_writer :logger

  def logger
    @logger ||= Logger.new($stdout).tap do |log|
      log.progname = self.name
    end
  end
end
