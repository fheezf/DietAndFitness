class FitnessesController < ApplicationController
  before_action :set_fitness, only: [:show, :edit, :update, :destroy, :toggle_favorito, :puntuacion]
  before_action :authenticate, except: [:index, :show, :muestra_ejercicio]

  # GET /fitnesses
  # GET /fitnesses.json
  def index
    if current_user
      if params[:user_id] != nil
        @fitnesses = Fitness.favoritos(params[:user_id])
      else
        @fitnesses = Fitness.favoritos('nil')
      end
    else
      @fitnesses = Fitness.all
    end
  end

  def puntuacion
     if params[:flag] == "suma"
        @fitness.punctuation = @fitness.punctuation + 1
     else
        @fitness.punctuation = @fitness.punctuation - 1
     end
     @fitness.save
     respond_to do |format|
	  	        format.html {redirect_to :back} 
	  	        format.js
	   end
  end

  def muestra_ejercicio_favorito
      User.favoritos_ejercicio(params[:id]).each do |usu|
          if usu.id == current_user.id
            redirect_to "/minus.html", :layout => false and return
          end
      end
      redirect_to "/plus.html", :layout => false and return
  end

  def toggle_favorito
	  @user = User.favoritos_ejercicio(params[:id])
    count = 0
    if @user.length == 0
            @fitness.fitnesses_users << current_user
            respond_to do |format|
	  	        format.html {redirect_to :back} and return
	  	        format.js
	          end

 	
    end
    @user.each do |var|
      if current_user == var
	  	         @fitness.fitnesses_users.delete(current_user)
               break

      else
         if count == @user.length - 1
              @fitness.fitnesses_users << current_user
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

  # GET /fitnesses/1
  # GET /fitnesses/1.json
  def show
  end

  # GET /fitnesses/new
  def new
    @fitness = Fitness.new
  end

  # GET /fitnesses/1/edit
  def edit
    @fitness = current_user.fitnesses.find_by_id(params[:id])
    redirect_to root_path, alert: "operación no autorizada" unless @fitness
  end

  # POST /fitnesses
  # POST /fitnesses.json
  def create
    @fitness = current_user.fitnesses.new(fitness_params)
    @fitness.author = current_user.name + " " + current_user.surname

    exercises = ""
     params[:exercises].each do |exercise|
      exercises = exercises + exercise + "|"
     end
     exercises = exercises + "a"
     @fitness.exercises = exercises

    respond_to do |format|
      if @fitness.save
        format.html { redirect_to @fitness, notice: 'Fitness was successfully created.' }
        format.json { render :show, status: :created, location: @fitness }
      else
        format.html { render :new }
        format.json { render json: @fitness.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fitnesses/1
  # PATCH/PUT /fitnesses/1.json
  def update
    @fitness = current_user.fitnesses.find_by_id(params[:id])

    exercises = ""
     params[:exercises].each do |exercise|
      exercises = exercises + exercise + "|"
     end
     exercises = exercises + "a"
     @fitness.exercises = exercises
    respond_to do |format|
      if @fitness.update(fitness_params)
        format.html { redirect_to "/muestra_ejercicio.html", notice: 'Fitness was successfully updated.' }
        format.json { render :show, status: :ok, location: @fitness }
      else
        format.html { render :edit }
        format.json { render json: @fitness.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fitnesses/1
  # DELETE /fitnesses/1.json
  def destroy
    @fitness = current_user.fitnesses.find_by_id(params[:id])
    if @fitness
     @fitness.destroy
     respond_to do |format|
        format.html { redirect_to root_path, notice: 'Fitness was successfully destroyed.' }
        format.json { head :no_content }
     end
   else
      redirect_to root_path, alert: "operación no autorizada"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitness
      @fitness = Fitness.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fitness_params
      params.require(:fitness).permit(:title, :duration, :difficulty, :imagen, :description)
    end
end
