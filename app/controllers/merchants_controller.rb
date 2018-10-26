class MerchantsController < ApplicationController

  def index
    # Because /merchants is meant to show users/merchants a list of merchants,
    # and also provide admins with links to show pages, it can't be addressed in
    # routes, so this action/view handles that instead.

    # TODO: Add admin branching logic to view

    @merchants = User.where(role: "merchant").order(:name)
  end

end
