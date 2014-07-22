#!/usr/bin/env ruby

require 'YAML'
if_file = File.file?("movieData.yml")
if if_file == false
	puts 'data file not found.'
	puts 'creating data file...'
	File.new("movieData.yml", 'w+')
	puts'data file created!'
else
	puts 'data file found...'
end
movies = YAML::load(File.read('movieData.yml'))
puts 'data file loaded!'
file_zero = File.zero?("movieData.yml")
	if file_zero == true
	movies = {'default' => 1}
	puts '~~~~~~~~~~~'
	puts "No data was found movieData.yml so a default key and value has been made,"
	puts "please add a movie to the list before deleting the 'default' movie."
	puts "this program will not function without a default 'key' and 'value"
	puts '~~~~~~~~~~~'
end

i = 0
q = 0
z = 0
puts "version 0.2"

until i > 1
	puts " "
	puts "What would you like to do?"
	puts "--Add"
	puts "--List"
	puts "--Change"
	puts "--Delete"
	puts "--Exit"
	puts "--Sort (coming soon)"

	choice = gets.chomp.downcase
	case choice
	when 'add'
		puts 'What movie would you like to add?'
		title = gets.chomp
			if movies[title.to_sym].nil?
	begin
		puts 'What is the status:'
		puts '1 = Watched'
		puts '2 = Watching'
		puts '3 = Want to watch' 
		puts '4 = Stalled/Dropped?'
		status = gets.chomp
		case
		when status == '1'
			movies[title.to_sym] = status.to_i
			puts '%s has been added as Watched.' % [title]
			q += 2
		when status == '2'
			movies[title.to_sym] = status.to_i
			puts '%s has been added as Watching.' % [title]
			q += 2
		when status == '3'
			movies[title.to_sym] = status.to_i
			puts '%s has been added as Want to Watch.' % [title]
			q += 2
		when status == '4'
			movies[title.to_sym] = status.to_i
			puts '%s has been added as Stalled/Dropped.' % [title]
			q += 2
		else 
			puts 'error, did you input a number 1-4?'
		end
	end until q > 1
 	  else
 		  puts 'That movie already exist'
 	  end

	when 'list'
			movies.each {|movie, status| 
			if status == 1
				status = 'Watched'
			end
			if status == 2
				status = 'Watching'
			end
			if status == 3
				status = 'Want to Watch'
			end
			if status == 4
				status = 'Stalled/dropped'
			end
			puts '%s : %s' % [movie, status]}

	when 'change'
		puts 'What movie do you want to update?'
		title = gets.chomp
		if movies[title.to_sym].nil? == false
		begin
			puts 'What is the new status:'
			puts '1 = Watched'
			puts '2 = Watching'
			puts '3 = Want to watch' 
			puts '4 = Stalled/Dropped?'
			status = gets.chomp
	case
		when status == '1'
			movies[title.to_sym] = status.to_i
			puts '%s has been updated as Watched.' % [title]
			z += 2
		when status == '2'
			movies[title.to_sym] = status.to_i
			puts '%s has been updated as Watching.' % [title]
			z += 2
		when status == '3'
			movies[title.to_sym] = status.to_i
			puts '%s has been updated as Want to Watch.' % [title]
			z += 2
		when status == '4'
			movies[title.to_sym] = status.to_i
			puts '%s has been updated as Stalled/Dropped.' % [title]
			z += 2
		else 
			puts 'error, did you input a number 1-4?'
		end
	end until z > 1
			else
				puts 'Movie not found'
		  end

	when 'delete'
		puts 'What movie are you deleting?'
		title = gets.chomp
		if movies[title.to_sym].nil?
			puts 'Movie not found'
		else
			movies.delete(title.to_sym)
			puts '%s has been removed' % [title]
		end

	when 'exit'
		File.write('movieData.yml', YAML.dump(movies))
		puts ""
		puts 'Thanks for using!'
		exit
	
	else
		puts 'Error, unknown command'
	end
end
