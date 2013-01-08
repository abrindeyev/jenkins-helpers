#!/usr/bin/env ruby

# Watches logfile for given pattern for specified amount of time
# Syntax: ./wait_for_line.rb path/to/log.file pattern_to_search timeout_in_seconds
# Return codes:
# 0 - pattern found within desired timeout
# 1 - timeout exceeded

f = File.open(ARGV[0],"r")

# Since this file exists and is growing, seek to the end of the most recent entry
f.seek(0,IO::SEEK_END)

started_at = Time.new
while Time.new - started_at < ARGV[2].to_i
  io =  f.gets
  exit 0 if io and io.match(ARGV[1])
  sleep 0.1
end
exit 1
