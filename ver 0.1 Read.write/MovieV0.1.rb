#!/usr/bin/env ruby
#Import movieData.yml and saves as variable "movies"
require 'YAML'
movies = YAML::load( File.read('movieData.yml') )
#puts welcome text and version, sets variable "i" to 0 for until loop.
puts "Welcome."
puts "version 0.1"
i = 0
#infinite until loop, exits when "exit" command is entered.
until i > 1
#options that the user is promted with
	puts " "
	puts "What would you like to do?"
	puts "--Add"
	puts "--List"
	puts "--Change"
	puts "--Delete"
	puts "--Exit"
#gets users "choice" and downcases
	choice = gets.chomp.downcase
#case for the choice variable, goes through all the prompts
	case choice
#prompts user for a movie to add, checks if its already added and if so throws text and returns to main promp, if not prompts for "status", displays title and status have been added.
	when 'add'
		puts 'What movie would you like to add?'
		title = gets.chomp
	if movies[title.to_sym].nil?
		puts 'What is the status: Watching, watched, stalled, want to watch?' #plans to make inputing status more streamlined
		status = gets.chomp 
		movies[title.to_sym] = status.to_sym
		puts '%s has been added as %s.' % [title, status]
	else
		puts 'That movie already exist'
	end
#lists all movies and their status in the "movies" variable imported from movieData.yml and changed in the session.
	when 'list'
		movies.each {|movie, status| puts '%s : %s' % [movie, status]}
#prompts user for a movie to update, checks if "movies" variable, if the movie is not in the variable it throws text, if it is prompts for an updates status then updates status and displays change
	when 'change'
		puts 'What movie do you want to update?'
		title = gets.chomp
	if movies[title.to_sym].nil?
		puts 'Movie not found'
	else
		puts 'What is the new status: Watching, watched, stalled'
		status = gets.chomp
		movies[title.to_sym] = status.to_sym
		puts '#{title} has been updated as #{status}'
	end
#promps for movie to delete, checks if its in the "movies" variable, if not throws text and loops to beginning, if so removes movie from "movies" variable
	when 'delete'
		puts 'What movie are you deleting?'
		title = gets.chomp
		if movies[title.to_sym].nil?
			puts 'Movie not found'
		else
			movies.delete(title.to_sym)
			puts '%s has been removed' % [title]
	end
#writes "movies" variable to movieData.yml then terminates program
	when 'exit'
		File.write('movieData.yml', YAML.dump(movies))
		puts 'Thanks for using!'
		exit
#if no command matches throws error and loops to beginning
	else
		puts 'Error, unknown command'
	end
end
