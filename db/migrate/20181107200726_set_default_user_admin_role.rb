class SetDefaultUserAdminRole < ActiveRecord::Migration[5.2]
  def change
    reversible do |change|
      change.up do
        @defuser=User.find_by(username: 'superadmin')
        if @defuser
          @defuser.admin_role = true
          @defuser.client_role = false
          @defuser.manager_role = false
          @defuser.save
        end
      end
    end
  end
end
