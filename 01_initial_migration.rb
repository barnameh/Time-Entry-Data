require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection ( {
  adapter: 'sqlite3',
  database: 'dev.sqlite3'
  })


class InitialMigration < ActiveRecord::Migration[5.0]

  def up
    create_table :developers do |t|
      t.string :name
      t.string :email_address
      t.datetime :start_date
    end

    create_table :projects do |t|
      t.string :name
      t.datetime :start_date
      t.integer :client_id  #foreign key
    end

    create_join_table :developers, :projects

    create_table :groups do |t|
      t.string :name
    end

    create_join_table :developers, :groups

    create_table :industries do |t|
      t.string :name
    end

    create_table :clients do |t|
      t.string :name
      t.integer :industry_id
    end

    create_table :time_entries do |t|
      t.integer :developer_id
      t.integer :task_id
      t.datetime :date
      t.integer :length_in_second
    end

    create_table :tasks do |t|
      t.string :name
      t.integer :parent_project_id
      t.integer :parent_task_id
    end

    create_table :project_comments do |t|
      t.integer :developer_id
      t.integer :project_id
      t.string :comment
    end

    create_table :client_comments do |t|
      t.integer :developer_id
      t.integer :client_id
      t.string :comment
    end

    create_table :industry_comments do |t|
      t.integer :developer_id
      t.integer :industry_id
      t.string :comment
    end

  end

  def down
    drop_join_table :developers, :projects
    drop_join_table :developers, :groups
    drop_table :project_comments
    drop_table :client_comments
    drop_table :industry_comments
    drop_table :time_entries
    drop_table :clients
    drop_table :industries
    drop_table :groups
    drop_table :projects
    drop_table :developers
    derop_table :tasks
  end


end

begin
  InitialMigration.migrate(:down)
rescue
end

begin
  InitialMigration.migrate(:up)
rescue
end
