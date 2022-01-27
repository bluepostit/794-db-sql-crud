require 'sqlite3'
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'

def display_task(task)
  if task.nil?
    puts '<empty task>'
  else
    box = task.done? ? '[x]' : '[ ]'
    puts "#{box} #{task.title} - #{task.description}"
  end
end

# TODO: CRUD some tasks

# 1. Implement the READ logic to find a given task (by its id)
task = Task.find(1)
display_task(task)


# 2. Implement the CREATE logic in a save instance method
new_task = Task.new(title: 'Enjoy your weekend', description: 'Get some rest')
new_task.save
puts "Task's id is: #{new_task.id}"

# 3. Implement the UPDATE logic in the same method
task = Task.find(1)
task.done = true
task.save

task = Task.find(1)
display_task(task)

# 4. Implement the READ logic to retrieve all tasks (what type of method is it?)
tasks = Task.all
tasks.each do |task|
  display_task(task)
end

# Implement the DESTROY logic on a task
task = Task.find(6)
task.destroy

task = Task.find(6)
p task
puts "Is it empty? #{task.nil?}"
