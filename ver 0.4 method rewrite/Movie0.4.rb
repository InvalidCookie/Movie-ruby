#!/usr/bin/env ruby
require 'YAML'
puts "version 0.3"
if_file = File.file?("movieData.yml")
if if_file == false
	puts 'data file not found.'
	puts 'creating data file...'
	File.new("movieData.yml", 'w+')
	puts'data file created!'
else
	puts 'data file found...'
end
@movies = YAML::load(File.read('movieData.yml'))
puts 'data file loaded!'
file_zero = File.zero?("movieData.yml")
	if file_zero == true
	@movies = {:default => 1}
	puts '~~~~~~~~~~~'
	puts "No data was found movieData.yml so a default key and value has been made,"
	puts "please add a movie to the list before deleting the 'default' movie."
	puts "this program will not function without a default 'key' and 'value'"
	puts '~~~~~~~~~~~'
end

def save
	puts 'Saving...'
	File.write('movieData.yml', YAML.dump(@movies))
	puts 'Save successful!'
end

def add
puts 'What movie would you like to add? (type back to go back)'
		title = gets.chomp
			if title == 'back'
				main()
			end
			if @movies[title.to_sym].nil?
	while true
		puts 'What is the status: (type cancel to cancel'
		puts '1 = Watched'
		puts '2 = Watching'
		puts '3 = Want to watch' 
		puts '4 = Stalled/Dropped?'
		status = gets.chomp
		case
		when status == '1'
			@movies[title.to_sym] = status.to_i
			puts '%s has been added as Watched.' % [title]
			main()
		when status == '2'
			@movies[title.to_sym] = status.to_i
			puts '%s has been added as Watching.' % [title]
			main()
		when status == '3'
			@movies[title.to_sym] = status.to_i
			puts '%s has been added as Want to Watch.' % [title]
			main()
		when status == '4'
			@movies[title.to_sym] = status.to_i
			puts '%s has been added as Stalled/Dropped.' % [title]
			main()
		else 
			puts 'error, did you input a number 1-4?'
		end
	end
 	  else
 		  puts 'That movie already exist'
 	  end
end

def list
	@movies.each {|movie, status| 
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
end

def change
puts 'What movie do you want to update?'
	title = gets.chomp
	if @movies[title.to_sym].nil? == false
	while true
		puts 'What is the new status:'
		puts '1 = Watched'
		puts '2 = Watching'
		puts '3 = Want to watch' 
		puts '4 = Stalled/Dropped?'
		puts "put 'back' to back"
		status = gets.chomp
case
	when status == '1'
		@movies[title.to_sym] = status.to_i
		puts '%s has been updated as Watched.' % [title]
		main()
	when status == '2'
		@movies[title.to_sym] = status.to_i
		puts '%s has been updated as Watching.' % [title]
		main()
	when status == '3'
		@movies[title.to_sym] = status.to_i
		puts '%s has been updated as Want to Watch.' % [title]
		main()
	when status == '4'
		@movies[title.to_sym] = status.to_i
		puts '%s has been updated as Stalled/Dropped.' % [title]
		main()
	when status == 'back'
		main()
	else 
		puts 'error, did you input a number 1-4?'
	end
end
	else
		puts 'Movie not found'
	end
end
		
def delete
	puts 'What movie are you deleting?'
	title = gets.chomp
	if @movies[title.to_sym].nil?
		puts 'Movie not found'
	else
		@movies.delete(title.to_sym)
		puts '%s has been removed' % [title]
	end
end

def exit
	save()
	puts ""
	puts 'Thanks for using!'
	Process.exit
end

def sort
while true
		puts 'How would you like them sorted?'
		puts 'T = By title'
		puts 'S = By status'
		puts "or type 'back' to go back to the options"
		sort = gets.chomp.downcase
		case sort
		when 't'
			@movies_sorted = @movies.sort_by {|title, status| title}
			@movies = Hash[@movies_sorted.map {|key, value| [key, value]}]
			puts '@movies sorted by Title!'
			main()
		when 's'
			@movies_sorted = @movies.sort_by {|title, status| status}
			@movies = Hash[@movies_sorted.map {|key, value| [key, value]}]
			puts '@movies sorted by Status!'
			main()
		when 'back'
			main()
		else
			puts "Invalid Command, did you put 's' or 't'?"
		end
	end
end

def main
	while true
	puts " "
	puts "What would you like to do?"
	puts "--Add"
	puts "--List"
	puts "--Change"
	puts "--Delete"
	puts "--Exit (saves and exits)"
	puts "--Sort"

	choice = gets.chomp.downcase
	case choice
		when 'add'
			add()
		when 'list'
			list()
		when 'change'
			change()
		when 'delete'
				delete()
		when 'sort'
			sort()
		when 'exit'
			exit()
		else
			puts 'Error, unknown command'
		end
	end
end

main()
