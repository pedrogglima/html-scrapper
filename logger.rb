class Logger
  ERROR = 1
  WARNING = 2
  INFO = 3

  @@log = File.open('log.txt', 'w')
  @@level = WARNING

  def self.error(msg)
    @@log.puts("#{timestamp} - #{msg}")
    @@log.flush
  end

  def self.warning(msg)
    @@log.puts("#{timestamp} - #{msg}") if @@level >= WARNING
    @@log.flush
  end

  def self.info(msg)
    @@log.puts("#{timestamp} - #{msg}") if @@level >= INFO
    @@log.flush
  end

  def self.level=(new_level)
    @@level = new_level
  end

  def self.level
    @@level
  end

  protected
  def self.timestamp(time_format = "%d/%m/%Y %H:%M")
    Time.now.strftime(time_format)
  end
end
