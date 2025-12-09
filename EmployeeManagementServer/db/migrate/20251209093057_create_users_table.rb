class CreateUsersTable < ActiveRecord::Migration[8.1]
  def up
    execute <<-SQL
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    SQL
  end

  def down
    execute "DROP TABLE users;"
  end
end
