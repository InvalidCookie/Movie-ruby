require 'YAML'
movies = YAML::load( File.read('movieData.yml') )

puts "Welcome."
puts "version 0.1"
i = 0

until i > 1

	puts " "
	puts "What would you like to do?"
	puts "--Add"
	puts "--List"
	puts "--Change"
	puts "--Delete"
	puts "--Exit"

	choice = gets.chomp.downcase
	case choice
	when 'add'
		puts 'What movie would you like to add?'
		title = gets.chomp
	if movies[title.to_sym].nil?
		puts 'What is the status: Watching, watched, stalled?'
		status = gets.chomp
		movies[title.to_sym] = status.to_sym
		puts '%s has been added as %s.' % [title, status]
	else
		puts 'That movie already exist'
	end

	when 'list'
		movies.each {|movie, status| puts '%s : %s' % [movie, status]}

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
		puts 'Thanks for using!'
		exit
	
	else
		puts 'Error, unknown command'
	end
end
