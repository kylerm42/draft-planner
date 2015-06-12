class TagsController < ApplicationController

  private

    def permitted_params
      params.require(:tag).permit(:sheet_id, :player_id, :sleeper, :bust, :injury, :notes, :removed)
    end
end
