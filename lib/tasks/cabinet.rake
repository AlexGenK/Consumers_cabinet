namespace :cabinet do
  desc "Clear current consumption database"
  task clear_cur_consumption: :environment do
    CurrentConsumption.delete_all
  end
end
