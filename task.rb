# Write your Task class here

class Task
  attr_reader :id
  attr_accessor :title, :description, :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @description = attributes[:description]
    @title = attributes[:title]
    @done = attributes[:done]
  end

  def self.find(id)
    # Should return a Task instance
    result = DB.execute('SELECT * FROM tasks WHERE id = ?', id)
    hash = result[0]
    return nil if hash.nil?

    build_task(hash)
  end

  def self.all
    rows = DB.execute('SELECT * FROM tasks')
    rows.map do |row|
      build_task(row)
    end
  end

  def done?
    @done
  end

  def save
    done = @done ? 1 : 0
    if @id.nil?
      DB.execute("INSERT INTO tasks (description, title, done)
        values (?, ?, ?)", @description, @title, done)
      @id = DB.last_insert_row_id
    else
      DB.execute('UPDATE tasks SET description = ?, title = ?, done = ? WHERE id = ?',
                 @description, @title, done, @id)
    end
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id = ?', @id)
  end

  private

  def self.build_task(row)
    Task.new(
      id: row['id'],
      title: row['title'],
      description: row['description'],
      done: row['done'] == 1
    )
  end
end
