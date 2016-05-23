module DietsHelper

    def fav(dieta)
      user = User.favoritos_dieta(dieta.id)
      if user.length == 0
         return "plus"
      end
      user.each do |var|
        if current_user == var
          return "minus"
        end
      end
		  return "plus"
	  end


end
