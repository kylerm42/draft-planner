namespace :db do
  desc 'Rebuild the database with all migrations'
  task :rebuild do
    %w[drop create migrate test:prepare].each do |cmd|
      Rake::Task["db:#{cmd}"].invoke
    end
  end

  desc 'Remove all records from the database'
  task :truncate => :environment do
    DatabaseCleaner.clean_with :truncation
  end

  desc 'Remove all database records, then seed database'
  task :reseed do
    %w[truncate seed].each do |cmd|
      Rake::Task["db:#{cmd}"].invoke
    end
  end
end
