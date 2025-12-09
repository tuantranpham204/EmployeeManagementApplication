class CreateUserRoleTable < ActiveRecord::Migration[8.1]
  def up
    execute <<-SQL
      CREATE TABLE user_role (
        user_id SERIAL NOT NULL,
        role_id SERIAL NOT NULL,
        PRIMARY KEY (user_id, role_id),
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE CASCADE ON UPDATE CASCADE ,
        FOREIGN KEY (role_id) REFERENCES roles (id)
            ON DELETE CASCADE ON UPDATE CASCADE
      );
    SQL
  end

  def down
    execute "DROP TABLE user_role;"
  end
end
