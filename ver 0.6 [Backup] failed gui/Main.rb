#!/usr/bin/env ruby
require 'YAML'
#using 'shoes' for the gui
Shoes.app do

$console = stack
$console.hide

def start
$console.append { inscription "version 0.3" }
if_file = File.file?("movieData.yml")
if if_file == false
	$console.append { inscription 'data file not found.' }
	$console.append { inscription 'creating data file...' }
	File.new("movieData.yml", 'w+')
	$console.append { inscription 'data file created!' }
else
	$console.append { inscription 'data file found...' }
end
$movies = YAML::load(File.read('movieData.yml'))
$console.append { inscription 'data file loaded!' }
file_zero = File.zero?("movieData.yml")
	if file_zero == true
	$movies = {:default => 1}
	puts '~~~~~~~~~~~'
	puts "No data was found movieData.yml so a default key and value has been made,"
	puts "please add a movie to the list before deleting the 'default' movie."
	puts "this program will not function without a default 'key' and 'value'"
	puts '~~~~~~~~~~~'
end
end

def add
	Shoes.app do
		title = edit_line text = 'Insert movie'
		button "Enter" do
			if $movies[title.text.to_sym].nil?
				 status = list_box items: ["Watched", "Watching", "Want to Watch", "Stalled/Dropped"]
				 button 'enter' do
		case
		when status == 'Watched'
			$movies[title.to_sym] = status.text
			puts '%s has been added as Watched.' % [title]
			close()
		when status == 'Watching'
			$movies[title.to_sym] = status.text
			puts '%s has been added as Watching.' % [title]
			close()
		when status == 'Want to Watch'
			$movies[title.to_sym] = status.text
			puts '%s has been added as Want to Watch.' % [title]
			close()
		when status == 'Stalled/Dropped'
			$movies[title.to_sym] = status.text
			puts '%s has been added as Stalled/Dropped.' % [title]
			close()
		else 
			$console.append { inscription 'error, did you input a number 1-4?' }
		end
	end
 	  else
 		 $console.append { inscription 'That movie already exist' }
 	  end
 	end
end
end

def list
	Shoes.app do
	$movies.each {|movie, status| 
		if status == 1 or status == 'Watched'
			status = 'Watched'
		end
		if status == 2 or status == 'Watching'
			status = 'Watching'
		end
		if status == 3 or status == 'Want to Watch'
		status = 'Want to Watch'
		end
		if status == 4 or status == 'Stalled/Dropped'
			status = 'Stalled/Dropped'
		end
		para "%s : %s \n" % [movie, status]}
end
end

def change
puts 'What movie do you want to update?'
	title = gets.chomp
	if $movies[title.to_sym].nil? == false
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
		$movies[title.to_sym] = status.to_i
		puts '%s has been updated as Watched.' % [title]
		main()
	when status == '2'
		$movies[title.to_sym] = status.to_i
		puts '%s has been updated as Watching.' % [title]
		main()
	when status == '3'
		$movies[title.to_sym] = status.to_i
		puts '%s has been updated as Want to Watch.' % [title]
		main()
	when status == '4'
		$movies[title.to_sym] = status.to_i
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
	if $movies[title.to_sym].nil?
		puts 'Movie not found'
	else
		$movies.delete(title.to_sym)
		puts '%s has been removed' % [title]
	end
end

def exit
	$console.append { inscription "Saving..." }
	File.write('movieData.yml', YAML.dump($movies))
	$console.append { inscription "Save complete!" }
	close()
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
			$movies_sorted = $movies.sort_by {|title, status| title}
			$movies = Hash[$movies_sorted.map {|key, value| [key, value]}]
			puts '$movies sorted by Title!'
			main()
		when 's'
			$movies_sorted = $movies.sort_by {|title, status| status}
			$movies = Hash[$movies_sorted.map {|key, value| [key, value]}]
			puts '$movies sorted by Status!'
			main()
		when 'back'
			main()
		else
			puts "Invalid Command, did you put 's' or 't'?"
		end
	end
end


#executing of code begins here
@badd = button "Add"
@blist = button "List"
@bchange = button "Change"
@bdelete = button "Delete"
@bsort = button "Sort"
@bexit = button "Save and Exit"
@btogcon = button "Toggle Console"

@badd.click { add }
@blist.click { @list.clear list }
@bexit.click { exit }
@btogcon.click { $console.toggle }
start
end