class CreateRolesTable < ActiveRecord::Migration[8.1]
  def up
    execute <<-SQL
      CREATE TABLE roles (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL
      );
    SQL
  end

  def down
    execute "DROP TABLE roles;"
  end
end
