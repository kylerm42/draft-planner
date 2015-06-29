class AdminController < ApplicationController
  def stats
    @stats = {
      user: {
        count: User.count,
        recentRegistered: User.where('created_at > ?', Time.zone.now - 24.hours).count,
        recentSignIn: User.where('current_sign_in_at > ?', Time.zone.now - 24.hours).count
      },
      collection: {
        count: Collection.count,
        recentCreated: Collection.where('created_at > ?', Time.zone.now - 24.hours).count,
        recentUpdated: Collection.joins(:sheets).where('sheets.updated_at > ?', Time.zone.now - 24.hours).uniq.count
      },
      tag: {
        count: Tag.count,
        recentCreated: Tag.where('created_at > ?', Time.zone.now - 24.hours).count,
        recentUpdated: Tag.where('updated_at > ?', Time.zone.now - 24.hours).count
      },
      player: {
        count: Player.count,
        recentCreated: Player.where('created_at > ?', Time.zone.now - 24.hours).count,
        recentUpdated: Player.where('updated_at > ?', Time.zone.now - 24.hours).count
      }
    }

    render json: @stats
  end
end
