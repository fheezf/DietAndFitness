class DietsController < ApplicationController
  before_action :set_diet, only: [:show, :edit, :update, :destroy, :toggle_favorito, :puntuacion]
  before_action :authenticate, except: [:index, :show, :nosotros, :muestra_dieta]

  # GET /diets
  # GET /diets.json
  def index
    if current_user
      if params[:user_id] != nil
        @diets = Diet.favoritos(params[:user_id])
      else
        @diets = Diet.favoritos('nil')
      end
    else
      @diets = Diet.all
    end
  end

  def puntuacion
     if params[:flag] == "suma"
        @diet.punctuation = @diet.punctuation + 1
     else
        @diet.punctuation = @diet.punctuation - 1
     end
     @diet.save
     respond_to do |format|
	  	        format.html {redirect_to :back} 
	  	        format.js
	   end
  end

  def muestra_dieta_favorito
      User.favoritos_dieta(params[:id]).each do |usu|
          if usu.id == current_user.id
            redirect_to "/minus.html", :layout => false and return
          end
      end
      redirect_to "/plus.html", :layout => false and return
  end

  def toggle_favorito
	  @user = User.favoritos_dieta(params[:id])
    count = 0
    if @user.length == 0
            @diet.diets_users << current_user
            respond_to do |format|
	  	        format.html {redirect_to :back} and return
	  	        format.js
	          end

 	
    end
    @user.each do |var|
      if current_user == var
	  	         @diet.diets_users.delete(current_user)
               break

      else
         if count == @user.length - 1
              @diet.diets_users << current_user
              break

         else
            count = count + 1
         end
      end
    end
    respond_to do |format|
	  	format.html {redirect_to :back} and return
	  	format.js
	  end
  end

  # GET /diets/1
  # GET /diets/1.json
  def show
  end

  # GET /diets/new
  def new
    @diet = Diet.new
  end

  # GET /diets/1/edit
  def edit
    @edit = current_user.diets.find_by_id(params[:id])
    redirect_to root_path, alert: "operación no autorizada" unless @edit
  end

  # POST /diets
  # POST /diets.json
  def create
     @diet = current_user.diets.new(diet_params)
     @diet.author = current_user.name + " " + current_user.surname
     foods = ""
     params[:foods].each do |food|
      foods = foods + food + "|"
     end
     foods = foods + "a"
     @diet.foods = foods

    respond_to do |format|
      if @diet.save
        format.html { redirect_to @diet, notice: 'Diet was successfully created.' }
        format.json { render :show, status: :created, location: @diet }
      else
        format.html { render :new }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diets/1
  # PATCH/PUT /diets/1.json
  def update
    @diet = current_user.diets.find_by_id(params[:id])
    foods = ""
     params[:foods].each do |food|
      foods = foods + food + "|"
     end
     foods = foods + "a"
     @diet.foods = foods
    respond_to do |format|
      if @diet.update(diet_params)
        format.html { redirect_to "/muestra_dieta.html", notice: 'Diet was successfully updated.' }
        format.json { render :show, status: :ok, location: @diet }
      else
        format.html { render :edit }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diets/1
  # DELETE /diets/1.json
  def destroy
    @diet = current_user.diets.find_by_id(params[:id])
    if @diet
      @diet.destroy
      respond_to do |format|
       format.html { redirect_to root_path, notice: 'Diet was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, alert: "operación no autorizada"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diet
      @diet = Diet.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diet_params
      params.require(:diet).permit(:title, :duration, :difficulty, :imagen, :description)
    end
end
