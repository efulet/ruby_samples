#!/usr/bin/env ruby
# encoding: utf-8

begin
  require 'rainbow'
  COLORS_ENABLED = true
rescue LoadError
  COLORS_ENABLED = false
end

VALID_TASKS = {
  "TODO" => /TODO[\s,:]+(\S.*)$/,
  "FIXME" => /FIX ?ME[\s,:]+(\S.*)$/,
  "CHANGED" => /CHANGED[\s,:]+(\S.*)$/,
  "NOTE" => /NOTE[\s,:]+(\S.*)$/
}

TODOS    = []
FIXMES   = []
CHANGEDS = []
NOTES    = []

def parse(file)
  File.open(file, 'r') do |f|
    line_number = 1
    while line = f.gets
      VALID_TASKS.each do |task_type, regex|
        result = line.match(regex)
        unless result.nil?

          task = {
            :file => file,
            :line_number => line_number,
            :task => result.to_a.last
          }

          if task_type == "TODO"
            TODOS << task
          elsif task_type == "FIXME"
            FIXMES << task
          elsif task_type == "CHANGED"
            CHANGEDS << task
          elsif task_type == "NOTE"
            NOTES << task
          end
        end
      end

      line_number += 1
    end
  end
end

# --------------------------------------------------------

def print_tasks
  unless TODOS.empty?
    puts "\nTODO:\n-----\n"
    TODOS.each do |todo|
      puts todo[:task]
      if COLORS_ENABLED
        puts "  line #{todo[:line_number]} in #{todo[:file]}".foreground(:black).bright
      else
        puts "  line #{todo[:line_number]} in #{todo[:file]}"
      end
    end
  end

  unless FIXMES.empty?
    puts "\nFIXME:\n------\n"
    FIXMES.each do |fixme|
      puts fixme[:task]
      if COLORS_ENABLED
        puts "  line #{fixme[:line_number]} in #{fixme[:file]}".foreground(:black).bright
      else
        puts "  line #{fixme[:line_number]} in #{fixme[:file]}"
      end
    end
  end

  unless CHANGEDS.empty?
    puts "\nCHANGED:\n--------\n"
    CHANGEDS.each do |changed|
      puts changed[:task]
      if COLORS_ENABLED
        puts "  line #{changed[:line_number]} in #{changed[:file]}".foreground(:black).bright
      else
        puts "  line #{changed[:line_number]} in #{changed[:file]}"
      end
    end
  end

  unless NOTES.empty?
    puts "\nNOTE:\n-----\n"
    NOTES.each do |note|
      puts note[:task]
      if COLORS_ENABLED
        puts "  line #{note[:line_number]} in #{note[:file]}".foreground(:black).bright
      else
        puts "  line #{note[:line_number]} in #{note[:file]}"
      end
    end
  end
end

# --------------------------------------------------------

argc = ARGV.length
if argc == 1
  arg = ARGV.first
  if File.directory?(arg)
    files = Dir["#{arg}/**/*.*"]

    files.each do |file|
      begin
        parse file if File.file?(file)
      rescue ArgumentError
      end
    end
  elsif File.file?(arg)
    parse arg
  end

  print_tasks
else
  if argc == 0
    message = "You need to path a directory as argument."
  elsif argc > 1
    message = "Too many arguments passed."
  end

  raise ArgumentError, message
end
